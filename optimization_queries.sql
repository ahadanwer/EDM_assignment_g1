
-- Orignal Query 1 SQL -> Shipment Journey with Event Dates
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



-- Optimization 1 --> Adding Index for date filtering on shipment
CREATE INDEX idx_shipment_created_date ON shipment(created_at);
CREATE INDEX idx_tracking_event_status_lookup 
  ON tracking_event(shipment_id, status, event_time);
CREATE INDEX idx_shipment_covering ON shipment(
  created_at, shipper_id, service_id, delivery_area_id, 
  status, cod_amount, package_value
);




-- Optimization 2 --> Restructure SQL Optimized Query
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
  MIN(CASE WHEN te.status = 'booked' THEN te.event_time END) AS booked_date,
  MIN(CASE WHEN te.status = 'picked' THEN te.event_time END) AS picked_date,
  MIN(CASE WHEN te.status = 'delivered' THEN te.event_time END) AS delivered_date,
  MIN(CASE WHEN te.status = 'returned' THEN te.event_time END) AS returned_date,
  MIN(CASE WHEN te.status = 'cancelled' THEN te.event_time END) AS cancelled_date,
  sh.created_at
FROM shipment sh
JOIN shipper shipper ON sh.shipper_id = shipper.id
JOIN service svc ON sh.service_id = svc.id
JOIN area area ON sh.delivery_area_id = area.id
LEFT JOIN tracking_event te ON te.shipment_id = sh.id
 AND te.status IN ('booked','picked','delivered','returned','cancelled')
WHERE sh.created_at >= DATE_SUB('2026-01-25', INTERVAL 30 DAY)
GROUP BY 
  sh.id, sh.order_no, shipper.name, svc.name, area.name, sh.status, 
  sh.cod_amount, sh.package_value, sh.created_at
ORDER BY sh.created_at DESC;