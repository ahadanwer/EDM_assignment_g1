-- ADVANCED ANALYTICAL QUERIES

-- QUERY 1: Shipment Journey with Event Dates

SELECT 
  sh.id AS shipment_id,
  sh.order_no,
  shipper.name AS shipper_name,
  svc.name AS service_type,
  area.name AS delivery_area,
  sh.status AS current_status,
  CASE 
    WHEN sh.status = 'delivered' THEN 'Completed'
    WHEN sh.status IN ('picked', 'booked') THEN 'In Progress'
    WHEN sh.status = 'cancelled' THEN 'Cancelled'
    ELSE 'Returned'
  END AS status_category,
  sh.cod_amount,
  sh.package_value,
  (SELECT event_time FROM tracking_event WHERE shipment_id = sh.id AND status = 'booked' 
   ORDER BY event_time LIMIT 1) AS booked_date,
  (SELECT event_time FROM tracking_event WHERE shipment_id = sh.id AND status = 'picked'  
    ORDER BY event_time LIMIT 1) AS picked_date,
  (SELECT event_time FROM tracking_event WHERE shipment_id = sh.id AND status = 'delivered' 
   ORDER BY event_time LIMIT 1) AS delivered_date,
  (SELECT event_time FROM tracking_event   WHERE shipment_id = sh.id AND status = 'returned' 
   ORDER BY event_time LIMIT 1) AS returned_date,
  (SELECT event_time FROM tracking_event WHERE shipment_id = sh.id AND status = 'cancelled' 
   ORDER BY event_time LIMIT 1) AS cancelled_date,
   sh.created_at
FROM shipment sh
INNER JOIN shipper shipper ON sh.shipper_id = shipper.id
INNER JOIN service svc ON sh.service_id = svc.id
INNER JOIN area area ON sh.delivery_area_id = area.id
WHERE sh.created_at >= DATE_SUB('2026-01-25', INTERVAL 30 DAY)
ORDER BY sh.created_at DESC;



-- QUERY 2: Shipper Service Usage Analysis

SELECT 
  s.name AS shipper_name,
  svc.name AS service_type,
  COUNT(sh.id) AS total_orders,
  SUM(CASE WHEN sh.status = 'delivered' THEN 1 ELSE 0 END) AS successful_deliveries,
  ROUND(AVG(sh.package_value), 2) AS avg_package_value,
  ROUND((SUM(CASE WHEN sh.status = 'delivered' THEN 1 ELSE 0 END) * 100.0) / COUNT(sh.id), 2) AS success_rate_pct,
  CASE 
    WHEN COUNT(sh.id) > 8 THEN 'High Volume'
    WHEN COUNT(sh.id) > 5 THEN 'Medium Volume'
    ELSE 'Low Volume'
  END AS volume_category
FROM shipper s
INNER JOIN shipment sh ON s.id = sh.shipper_id
INNER JOIN service svc ON sh.service_id = svc.id
GROUP BY s.name, svc.name
HAVING total_orders >= 2
ORDER BY total_orders DESC;



-- QUERY 3: COD Collection Analysis

SELECT 
  r.name AS rider_name,
  a.name AS area_name,
  COUNT(sc.id) AS total_collections,
  SUM(sc.amount_collected) AS total_collected,
  ROUND(AVG(sc.amount_collected), 2) AS avg_collection,
  CASE 
    WHEN SUM(sc.amount_collected) > 50000 THEN 'Top Collector'
    WHEN SUM(sc.amount_collected) > 20000 THEN 'Good Collector'
    ELSE 'Average Collector'
  END AS performance_tier
FROM rider r
INNER JOIN shipment_collection sc ON r.id = sc.rider_id
INNER JOIN shipment sh ON sc.shipment_id = sh.id
INNER JOIN area a ON sh.delivery_area_id = a.id
GROUP BY r.name, a.name
HAVING total_collections >= 1
ORDER BY total_collected DESC;


-- QUERY 4: Daily Delivery Performance Trends with Moving Averages

WITH daily_stats AS (
  SELECT 
    DATE(sh.created_at) AS delivery_date,
    COUNT(sh.id) AS total_shipments,
    SUM(CASE WHEN sh.status = 'delivered' THEN 1 ELSE 0 END) AS successful_deliveries,
    SUM(CASE WHEN sh.status = 'returned' THEN 1 ELSE 0 END) AS returned_shipments,
    SUM(CASE WHEN sh.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_shipments,
    ROUND(AVG(sh.package_value), 2) AS avg_package_value,
    SUM(CASE WHEN sh.payment_method = 'COD' THEN sh.cod_amount ELSE 0 END) AS total_cod_collected,
    COUNT(DISTINCT sh.shipper_id) AS active_shippers,
    COUNT(DISTINCT sh.current_rider_id) AS active_riders,
    -- Calculate average delivery time for delivered shipments
    ROUND(AVG(
      CASE WHEN sh.status = 'delivered' THEN
        TIMESTAMPDIFF(HOUR, 
          (SELECT MIN(event_time) FROM tracking_event WHERE shipment_id = sh.id AND status = 'booked'),
          (SELECT MAX(event_time) FROM tracking_event WHERE shipment_id = sh.id AND status = 'delivered')
        )
      END
    ), 2) AS avg_delivery_hours
  FROM shipment sh
  WHERE sh.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
  GROUP BY DATE(sh.created_at)
)
SELECT 
  delivery_date,
  total_shipments,
  successful_deliveries,
  returned_shipments,
  cancelled_shipments,
  ROUND((successful_deliveries * 100.0) / total_shipments, 2) AS success_rate_pct,
  avg_package_value,
  total_cod_collected,
  active_shippers,
  active_riders,
  avg_delivery_hours,
  -- Window functions for trend analysis
  ROW_NUMBER() OVER (ORDER BY delivery_date DESC) AS day_rank,
  LAG(successful_deliveries, 1) OVER (ORDER BY delivery_date) AS prev_day_deliveries,
  successful_deliveries - LAG(successful_deliveries, 1) OVER (ORDER BY delivery_date) AS delivery_change,
  -- 3-day moving average for smoothing daily fluctuations
  ROUND(AVG(successful_deliveries) OVER (
    ORDER BY delivery_date 
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ), 2) AS moving_avg_3day,
  -- 7-day moving average for weekly trend
  ROUND(AVG(successful_deliveries) OVER (
    ORDER BY delivery_date 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ), 2) AS moving_avg_7day,
  -- Performance classification based on success rate
  CASE 
    WHEN (successful_deliveries * 100.0) / total_shipments >= 85 THEN 'Excellent'
    WHEN (successful_deliveries * 100.0) / total_shipments >= 75 THEN 'Good'
    WHEN (successful_deliveries * 100.0) / total_shipments >= 60 THEN 'Fair'
    ELSE 'Needs Improvement'
  END AS daily_performance_rating
FROM daily_stats
ORDER BY delivery_date DESC


-- QUERY 5: Payment vs Invoice Analysis

SELECT 
  s.name AS shipper_name,
  s.email AS shipper_email,
  COUNT(DISTINCT i.id) AS total_invoices,
  COUNT(DISTINCT p.id) AS total_payments,
  COALESCE(SUM(i.total_amount), 0) AS invoiced_amount,
  COALESCE(SUM(p.amount), 0) AS paid_amount,
  COALESCE(SUM(i.total_amount), 0) - COALESCE(SUM(p.amount), 0) AS outstanding_balance,
  CASE 
    WHEN COALESCE(SUM(i.total_amount), 0) = COALESCE(SUM(p.amount), 0) THEN 'Fully Paid'
    WHEN COALESCE(SUM(p.amount), 0) > 0 THEN 'Partial Payment'
    ELSE 'No Payment'
  END AS payment_status
FROM shipper s
LEFT JOIN shipment sh ON s.id = sh.shipper_id
LEFT JOIN invoice i ON s.id = i.shipper_id
LEFT JOIN payment p ON s.id = p.shipper_id
LEFT JOIN invoice_payment_allocation ipa ON i.id = ipa.invoice_id AND p.id = ipa.payment_id
WHERE s.status = 'active'
GROUP BY s.name, s.email
HAVING total_invoices > 0
ORDER BY outstanding_balance DESC;