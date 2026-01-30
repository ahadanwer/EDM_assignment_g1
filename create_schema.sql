CREATE DATABASE  IF NOT EXISTS `eda_logistics` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `eda_logistics`;
-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: eda_logistics
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_area_city` (`city`),
  KEY `idx_area_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Geographical zones for delivery operations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `area_alias`
--

DROP TABLE IF EXISTS `area_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area_alias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `area_id` bigint unsigned NOT NULL,
  `alias` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_area_alias` (`area_id`,`alias`),
  CONSTRAINT `fk_area_alias_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Alternative names for areas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipper_id` bigint unsigned NOT NULL,
  `status` enum('draft','issued','paid','cancelled') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'draft',
  `total_shipments` int unsigned NOT NULL DEFAULT '0',
  `issue_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_by` bigint unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_invoice_number` (`invoice_number`),
  KEY `idx_invoice_shipper` (`shipper_id`),
  KEY `idx_invoice_status` (`status`),
  CONSTRAINT `fk_invoice_shipper` FOREIGN KEY (`shipper_id`) REFERENCES `shipper` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Shipper billing invoices';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_item`
--

DROP TABLE IF EXISTS `invoice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint unsigned NOT NULL,
  `shipment_id` bigint unsigned NOT NULL,
  `booking_date` date DEFAULT NULL,
  `pickup_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `returned_date` date DEFAULT NULL,
  `cod_amount` decimal(12,2) DEFAULT NULL,
  `origin` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `destination` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `delivery_charges` decimal(12,2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_invoice_item` (`invoice_id`,`shipment_id`),
  KEY `idx_invoice_item_invoice` (`invoice_id`),
  KEY `idx_invoice_item_shipment` (`shipment_id`),
  CONSTRAINT `fk_invoice_item_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_invoice_item_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Line items for invoices';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_payment_allocation`
--

DROP TABLE IF EXISTS `invoice_payment_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_payment_allocation` (
  `invoice_id` bigint unsigned NOT NULL,
  `payment_id` bigint unsigned NOT NULL,
  `allocated_amount` decimal(12,2) NOT NULL,
  PRIMARY KEY (`invoice_id`,`payment_id`),
  KEY `idx_allocation_payment` (`payment_id`),
  CONSTRAINT `fk_invoice_payment_allocation_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_invoice_payment_allocation_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Allocation of payments to invoices';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipper_id` bigint unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` date NOT NULL,
  `method` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_payment_shipper` (`shipper_id`),
  KEY `idx_payment_date` (`payment_date`),
  CONSTRAINT `fk_payment_shipper` FOREIGN KEY (`shipper_id`) REFERENCES `shipper` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Payments received from shippers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rider`
--

DROP TABLE IF EXISTS `rider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rider` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `contact_number` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `basic_salary` decimal(10,2) DEFAULT NULL,
  `base_commission` decimal(10,2) NOT NULL DEFAULT '100.00',
  `package_capacity` int NOT NULL DEFAULT '10' COMMENT 'Max parcels per trip',
  `unique_symbol` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Rider identifier symbol',
  `availability_status` enum('offline','online','busy') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'offline',
  `account_status` enum('under_review','approved','rejected') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'under_review',
  `is_active` tinyint NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rider_email` (`email`),
  KEY `idx_rider_availability` (`availability_status`),
  KEY `idx_rider_account_status` (`account_status`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Delivery personnel';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rider_area`
--

DROP TABLE IF EXISTS `rider_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rider_area` (
  `rider_id` bigint unsigned NOT NULL,
  `area_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`rider_id`,`area_id`),
  KEY `idx_rider_area_area` (`area_id`),
  CONSTRAINT `fk_rider_area_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rider_area_rider` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Rider operational areas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rider_commission`
--

DROP TABLE IF EXISTS `rider_commission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rider_commission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rider_id` bigint unsigned NOT NULL,
  `shipment_id` bigint unsigned NOT NULL,
  `rider_settlement_id` bigint unsigned DEFAULT NULL,
  `commission_type` enum('pickup','delivery','return','returned','settlement_submitted') COLLATE utf8mb3_unicode_ci NOT NULL,
  `commission_amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','approved','paid','rejected') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
  `notes` text COLLATE utf8mb3_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rider_commission` (`rider_id`,`shipment_id`,`commission_type`),
  KEY `idx_commission_rider` (`rider_id`),
  KEY `idx_commission_shipment` (`shipment_id`),
  KEY `idx_commission_status` (`payment_status`),
  KEY `fk_rider_commission_settlement` (`rider_settlement_id`),
  CONSTRAINT `fk_rider_commission_rider` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rider_commission_settlement` FOREIGN KEY (`rider_settlement_id`) REFERENCES `rider_settlement` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_rider_commission_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Rider commission records';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `rider_productivity_metrics`
--

DROP TABLE IF EXISTS `rider_productivity_metrics`;
/*!50001 DROP VIEW IF EXISTS `rider_productivity_metrics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rider_productivity_metrics` AS SELECT 
 1 AS `rider_id`,
 1 AS `rider_name`,
 1 AS `email`,
 1 AS `availability_status`,
 1 AS `account_status`,
 1 AS `package_capacity`,
 1 AS `total_shipments_handled`,
 1 AS `pickups_performed`,
 1 AS `deliveries_performed`,
 1 AS `returns_performed`,
 1 AS `successful_deliveries`,
 1 AS `delivery_success_rate_pct`,
 1 AS `total_commissions_earned`,
 1 AS `avg_commission_per_shipment`,
 1 AS `operational_areas`,
 1 AS `area_coverage_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rider_settlement`
--

DROP TABLE IF EXISTS `rider_settlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rider_settlement` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `settlement_number` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `rider_id` bigint unsigned NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `settlement_date` datetime NOT NULL,
  `settlement_method` enum('cash','bank_transfer','wallet','other') COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` enum('Pending','Verified','Rejected') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Pending',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rider_settlement_number` (`settlement_number`),
  KEY `idx_settlement_rider` (`rider_id`),
  KEY `idx_settlement_status` (`status`),
  CONSTRAINT `fk_rider_settlement_rider` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Periodic rider financial settlements';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `tat_hours` int NOT NULL COMMENT 'Turn-around time in hours',
  `is_active` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_service_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Delivery service types (same-day, next-day, etc.)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipper_id` bigint unsigned NOT NULL,
  `service_id` bigint unsigned NOT NULL,
  `order_no` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `awb_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Air waybill tracking number',
  `consignee_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `consignee_phone_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `shipment_details` text COLLATE utf8mb3_unicode_ci,
  `payment_method` enum('COD','Prepaid') COLLATE utf8mb3_unicode_ci NOT NULL,
  `cod_amount` decimal(10,2) DEFAULT NULL,
  `package_value` decimal(10,2) DEFAULT NULL,
  `pickup_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `return_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `delivery_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `pickup_area_id` bigint unsigned DEFAULT NULL,
  `delivery_area_id` bigint unsigned DEFAULT NULL,
  `return_area_id` bigint unsigned DEFAULT NULL,
  `current_rider_id` bigint unsigned DEFAULT NULL,
  `status` enum('booked','picked','delivered','returned','return','cancelled') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'booked',
  `is_invoiced` tinyint NOT NULL DEFAULT '0',
  `is_settled` tinyint NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_shipment_order_no` (`order_no`),
  UNIQUE KEY `uq_shipment_awb` (`awb_number`),
  KEY `fk_shipment_shipper` (`shipper_id`),
  KEY `fk_shipment_service` (`service_id`),
  KEY `fk_shipment_pickup_area` (`pickup_area_id`),
  KEY `fk_shipment_delivery_area` (`delivery_area_id`),
  KEY `fk_shipment_return_area` (`return_area_id`),
  KEY `fk_shipment_current_rider` (`current_rider_id`),
  KEY `idx_shipment_created_date` (`created_at`),
  KEY `idx_shipment_covering` (`created_at`,`shipper_id`,`service_id`,`delivery_area_id`,`status`,`cod_amount`,`package_value`),
  CONSTRAINT `fk_shipment_current_rider` FOREIGN KEY (`current_rider_id`) REFERENCES `rider` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_shipment_delivery_area` FOREIGN KEY (`delivery_area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_shipment_pickup_area` FOREIGN KEY (`pickup_area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_shipment_return_area` FOREIGN KEY (`return_area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_shipment_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_shipment_shipper` FOREIGN KEY (`shipper_id`) REFERENCES `shipper` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Core shipment records';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipment_assignment`
--

DROP TABLE IF EXISTS `shipment_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment_assignment` (
  `shipment_id` bigint unsigned NOT NULL,
  `rider_id` bigint unsigned NOT NULL,
  `role` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL COMMENT 'pickup, delivery, or return',
  `assigned_at` datetime NOT NULL,
  PRIMARY KEY (`shipment_id`,`rider_id`,`role`,`assigned_at`),
  KEY `idx_assignment_rider` (`rider_id`),
  KEY `idx_assignment_shipment_time` (`shipment_id`,`assigned_at`),
  CONSTRAINT `fk_shipment_assignment_rider` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_shipment_assignment_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Tracks rider assignments per shipment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipment_collection`
--

DROP TABLE IF EXISTS `shipment_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment_collection` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipment_id` bigint unsigned NOT NULL,
  `rider_id` bigint unsigned NOT NULL,
  `amount_collected` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `collection_date` datetime NOT NULL,
  `settled` tinyint NOT NULL DEFAULT '0',
  `rider_settlement_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_shipment_collection_shipment` (`shipment_id`),
  KEY `idx_collection_rider` (`rider_id`),
  KEY `idx_collection_settled` (`settled`),
  KEY `fk_shipment_collection_settlement` (`rider_settlement_id`),
  CONSTRAINT `fk_shipment_collection_rider` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_shipment_collection_settlement` FOREIGN KEY (`rider_settlement_id`) REFERENCES `rider_settlement` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_shipment_collection_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='COD collections by riders';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper`
--

DROP TABLE IF EXISTS `shipper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `contact_number` varchar(30) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_charge` decimal(10,2) NOT NULL DEFAULT '200.00',
  `status` enum('pending','active','suspended') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Merchants/customers who create shipments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `shipper_performance_summary`
--

DROP TABLE IF EXISTS `shipper_performance_summary`;
/*!50001 DROP VIEW IF EXISTS `shipper_performance_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `shipper_performance_summary` AS SELECT 
 1 AS `shipper_id`,
 1 AS `shipper_name`,
 1 AS `email`,
 1 AS `shipper_status`,
 1 AS `total_shipments`,
 1 AS `delivered_count`,
 1 AS `pending_pickup_count`,
 1 AS `in_transit_count`,
 1 AS `return_pending_count`,
 1 AS `returned_count`,
 1 AS `cancelled_count`,
 1 AS `delivery_success_rate_pct`,
 1 AS `total_cod_amount`,
 1 AS `collected_cod_amount`,
 1 AS `total_package_value`,
 1 AS `per_shipment_base_charge`,
 1 AS `estimated_charges`,
 1 AS `last_shipment_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shipper_service`
--

DROP TABLE IF EXISTS `shipper_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper_service` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipper_id` bigint unsigned NOT NULL,
  `service_id` bigint unsigned NOT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  `subscribed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_shipper_service` (`shipper_id`,`service_id`),
  KEY `idx_shipper_service_shipper` (`shipper_id`),
  KEY `idx_shipper_service_service` (`service_id`),
  CONSTRAINT `fk_shipper_service_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_shipper_service_shipper` FOREIGN KEY (`shipper_id`) REFERENCES `shipper` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Shipper subscriptions to services';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tracking_event`
--

DROP TABLE IF EXISTS `tracking_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracking_event` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipment_id` bigint unsigned NOT NULL,
  `rider_id` bigint unsigned DEFAULT NULL,
  `status` enum('booked','picked','delivered','returned','return','cancelled') COLLATE utf8mb3_unicode_ci NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `notes` text COLLATE utf8mb3_unicode_ci,
  `event_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tracking_shipment` (`shipment_id`),
  KEY `fk_tracking_event_rider` (`rider_id`),
  KEY `idx_tracking_event_status_lookup` (`shipment_id`,`status`,`event_time`),
  CONSTRAINT `fk_tracking_event_rider` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_tracking_event_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Shipment status change audit trail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `rider_productivity_metrics`
--

/*!50001 DROP VIEW IF EXISTS `rider_productivity_metrics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`janam_root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `rider_productivity_metrics` AS select `r`.`id` AS `rider_id`,`r`.`name` AS `rider_name`,`r`.`email` AS `email`,`r`.`availability_status` AS `availability_status`,`r`.`account_status` AS `account_status`,`r`.`package_capacity` AS `package_capacity`,count(distinct `sa`.`shipment_id`) AS `total_shipments_handled`,count(distinct (case when (`sa`.`role` = 'pickup') then `sa`.`shipment_id` end)) AS `pickups_performed`,count(distinct (case when (`sa`.`role` = 'delivery') then `sa`.`shipment_id` end)) AS `deliveries_performed`,count(distinct (case when (`sa`.`role` = 'return') then `sa`.`shipment_id` end)) AS `returns_performed`,count(distinct (case when ((`sh`.`status` = 'delivered') and (`sa`.`role` = 'delivery')) then `sa`.`shipment_id` end)) AS `successful_deliveries`,round(((count(distinct (case when ((`sh`.`status` = 'delivered') and (`sa`.`role` = 'delivery')) then `sa`.`shipment_id` end)) * 100.0) / nullif(count(distinct (case when (`sa`.`role` = 'delivery') then `sa`.`shipment_id` end)),0)),2) AS `delivery_success_rate_pct`,coalesce((select sum(`rc2`.`commission_amount`) from `rider_commission` `rc2` where ((`rc2`.`rider_id` = `r`.`id`) and (`rc2`.`payment_status` in ('approved','paid')))),0) AS `total_commissions_earned`,round((coalesce((select sum(`rc2`.`commission_amount`) from `rider_commission` `rc2` where ((`rc2`.`rider_id` = `r`.`id`) and (`rc2`.`payment_status` in ('approved','paid')))),0) / nullif(count(distinct `sa`.`shipment_id`),0)),2) AS `avg_commission_per_shipment`,group_concat(distinct `a`.`name` order by `a`.`name` ASC separator ', ') AS `operational_areas`,count(distinct `ra`.`area_id`) AS `area_coverage_count` from ((((`rider` `r` left join `rider_area` `ra` on((`r`.`id` = `ra`.`rider_id`))) left join `area` `a` on((`ra`.`area_id` = `a`.`id`))) left join `shipment_assignment` `sa` on((`r`.`id` = `sa`.`rider_id`))) left join `shipment` `sh` on((`sa`.`shipment_id` = `sh`.`id`))) group by `r`.`id`,`r`.`name`,`r`.`email`,`r`.`availability_status`,`r`.`account_status`,`r`.`package_capacity` order by `total_shipments_handled` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `shipper_performance_summary`
--

/*!50001 DROP VIEW IF EXISTS `shipper_performance_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`janam_root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `shipper_performance_summary` AS select `s`.`id` AS `shipper_id`,`s`.`name` AS `shipper_name`,`s`.`email` AS `email`,`s`.`status` AS `shipper_status`,count(`sh`.`id`) AS `total_shipments`,sum((case when (`sh`.`status` = 'delivered') then 1 else 0 end)) AS `delivered_count`,sum((case when (`sh`.`status` = 'booked') then 1 else 0 end)) AS `pending_pickup_count`,sum((case when (`sh`.`status` = 'picked') then 1 else 0 end)) AS `in_transit_count`,sum((case when (`sh`.`status` = 'return') then 1 else 0 end)) AS `return_pending_count`,sum((case when (`sh`.`status` = 'returned') then 1 else 0 end)) AS `returned_count`,sum((case when (`sh`.`status` = 'cancelled') then 1 else 0 end)) AS `cancelled_count`,round(((sum((case when (`sh`.`status` = 'delivered') then 1 else 0 end)) * 100.0) / nullif(count(`sh`.`id`),0)),2) AS `delivery_success_rate_pct`,sum((case when (`sh`.`payment_method` = 'COD') then `sh`.`cod_amount` else 0 end)) AS `total_cod_amount`,sum((case when ((`sh`.`payment_method` = 'COD') and (`sh`.`status` = 'delivered')) then `sh`.`cod_amount` else 0 end)) AS `collected_cod_amount`,sum(`sh`.`package_value`) AS `total_package_value`,`s`.`base_charge` AS `per_shipment_base_charge`,(count(`sh`.`id`) * `s`.`base_charge`) AS `estimated_charges`,max(`sh`.`created_at`) AS `last_shipment_date` from (`shipper` `s` left join `shipment` `sh` on((`s`.`id` = `sh`.`shipper_id`))) group by `s`.`id`,`s`.`name`,`s`.`email`,`s`.`status`,`s`.`base_charge` order by `total_shipments` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-30 23:34:42
