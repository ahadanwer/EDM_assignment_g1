
-- VIEWS

-- VIEW 1: SHIPPER PERFORMANCE SUMMARY

CREATE OR REPLACE VIEW shipper_performance_summary AS
SELECT 
  s.id AS shipper_id,
  s.name AS shipper_name,
  s.email,
  s.status AS shipper_status,
  COUNT(sh.id) AS total_shipments,
  SUM(CASE WHEN sh.status = 'delivered' THEN 1 ELSE 0 END) AS delivered_count,
  SUM(CASE WHEN sh.status = 'booked' THEN 1 ELSE 0 END) AS pending_pickup_count,
  SUM(CASE WHEN sh.status = 'picked' THEN 1 ELSE 0 END) AS in_transit_count,
  SUM(CASE WHEN sh.status = 'return' THEN 1 ELSE 0 END) AS return_pending_count,
  SUM(CASE WHEN sh.status = 'returned' THEN 1 ELSE 0 END) AS returned_count,
  SUM(CASE WHEN sh.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_count,
  ROUND((SUM(CASE WHEN sh.status = 'delivered' THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(sh.id), 0), 2) AS delivery_success_rate_pct,
  SUM(CASE WHEN sh.payment_method = 'COD' THEN sh.cod_amount ELSE 0 END) AS total_cod_amount,
  SUM(CASE WHEN sh.payment_method = 'COD' AND sh.status = 'delivered' THEN sh.cod_amount ELSE 0 END) AS collected_cod_amount,
  SUM(sh.package_value) AS total_package_value,
  s.base_charge AS per_shipment_base_charge,
  (COUNT(sh.id) * s.base_charge) AS estimated_charges,
  MAX(sh.created_at) AS last_shipment_date
FROM shipper s
LEFT JOIN shipment sh ON s.id = sh.shipper_id
GROUP BY s.id, s.name, s.email, s.status, s.base_charge
ORDER BY total_shipments DESC;


-- VIEW 1: TEST SHIPPER PERFORMANCE SUMMARY
SELECT * FROM shipper_performance_summary LIMIT 5;



-- VIEW 2: RIDER PRODUCTIVITY METRICS

CREATE OR REPLACE VIEW rider_productivity_metrics AS
SELECT 
  r.id AS rider_id,
  r.name AS rider_name,
  r.email,
  r.availability_status,
  r.account_status,
  r.package_capacity,
  COUNT(DISTINCT sa.shipment_id) AS total_shipments_handled,
  COUNT(DISTINCT CASE WHEN sa.role = 'pickup' THEN sa.shipment_id END) AS pickups_performed,
  COUNT(DISTINCT CASE WHEN sa.role = 'delivery' THEN sa.shipment_id END) AS deliveries_performed,
  COUNT(DISTINCT CASE WHEN sa.role = 'return' THEN sa.shipment_id END) AS returns_performed,
  COUNT(DISTINCT CASE WHEN sh.status = 'delivered' AND sa.role = 'delivery' THEN sa.shipment_id END) AS successful_deliveries,
  ROUND((COUNT(DISTINCT CASE WHEN sh.status = 'delivered' AND sa.role = 'delivery' THEN sa.shipment_id END) * 100.0) 
  / NULLIF(COUNT(DISTINCT CASE WHEN sa.role = 'delivery' THEN sa.shipment_id END), 0),2 ) 
  AS delivery_success_rate_pct,
  COALESCE((SELECT SUM(rc2.commission_amount) FROM rider_commission rc2 
            WHERE rc2.rider_id = r.id AND rc2.payment_status IN ('approved', 'paid')), 0
  ) AS total_commissions_earned,
  ROUND(
    COALESCE((SELECT SUM(rc2.commission_amount) FROM rider_commission rc2 
              WHERE rc2.rider_id = r.id AND rc2.payment_status IN ('approved', 'paid')), 0) / 
    NULLIF(COUNT(DISTINCT sa.shipment_id), 0),2
  ) AS avg_commission_per_shipment,
  GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') AS operational_areas,
  COUNT(DISTINCT ra.area_id) AS area_coverage_count
FROM rider r
LEFT JOIN rider_area ra ON r.id = ra.rider_id
LEFT JOIN area a ON ra.area_id = a.id
LEFT JOIN shipment_assignment sa ON r.id = sa.rider_id
LEFT JOIN shipment sh ON sa.shipment_id = sh.id
GROUP BY r.id, r.name, r.email, r.availability_status, r.account_status, r.package_capacity
ORDER BY total_shipments_handled DESC;

-- Test View 2
SELECT * FROM rider_productivity_metrics LIMIT 5;










-- FUNCTION: Calculate Rider Commission

DELIMITER //

DROP FUNCTION IF EXISTS calculate_rider_commission//

CREATE FUNCTION calculate_rider_commission(
  p_rider_id BIGINT UNSIGNED,
  p_commission_type ENUM('pickup','delivery','return','returned')
) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_base_commission DECIMAL(10,2);
  DECLARE v_calculated_commission DECIMAL(10,2);
  
  -- Retrieve rider's base commission rate
  SELECT base_commission INTO v_base_commission
  FROM rider
  WHERE id = p_rider_id;
  
  -- Apply multipliers based on commission type
  CASE p_commission_type
    WHEN 'pickup' THEN 
      SET v_calculated_commission = v_base_commission * 0.50;
    WHEN 'delivery' THEN 
      SET v_calculated_commission = v_base_commission * 1.00;
    WHEN 'return' THEN 
      SET v_calculated_commission = v_base_commission * 0.75;
    WHEN 'returned' THEN 
      SET v_calculated_commission = v_base_commission * 0.60;
    ELSE 
      SET v_calculated_commission = 0.00;
  END CASE;
  
  RETURN v_calculated_commission;
END//

DELIMITER ;

-- Test function
SELECT calculate_rider_commission(1, 'delivery') AS delivery_commission;
SELECT calculate_rider_commission(2, 'pickup') AS pickup_commission;

-- PROCEDURE: Update Rider Commission

DELIMITER //

DROP PROCEDURE IF EXISTS update_rider_commission//

CREATE PROCEDURE update_rider_commission(
  IN p_shipment_id BIGINT UNSIGNED,
  IN p_rider_id BIGINT UNSIGNED,
  IN p_commission_type VARCHAR(20)
)
BEGIN
  DECLARE v_commission_amount DECIMAL(10,2);
  
  -- Calculate commission using the function
  SET v_commission_amount = calculate_rider_commission(p_rider_id, p_commission_type);
  
  -- Insert or update commission
  INSERT INTO rider_commission (rider_id, shipment_id, commission_type, commission_amount, payment_status)
  VALUES (p_rider_id, p_shipment_id, p_commission_type, v_commission_amount, 'pending')
  ON DUPLICATE KEY UPDATE 
    commission_amount = v_commission_amount,
    updated_at = NOW();
    
  SELECT CONCAT('Commission of ', v_commission_amount, ' updated for rider ', p_rider_id) AS message;
END//

DELIMITER ;

-- Test procedure
CALL update_rider_commission(5, 1, 'delivery');

