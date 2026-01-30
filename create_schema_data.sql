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
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (1,'Gulshan-e-Iqbal','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,'Defence (DHA)','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,'Clifton','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,'Saddar','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,'North Nazimabad','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,'Nazimabad','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,'Liaquatabad','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,'Korangi','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(9,'Malir','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(10,'Landhi','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(11,'Orangi Town','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(12,'Surjani Town','Karachi',1,'2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `area_alias`
--

LOCK TABLES `area_alias` WRITE;
/*!40000 ALTER TABLE `area_alias` DISABLE KEYS */;
INSERT INTO `area_alias` VALUES (1,2,'DHA','2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,2,'Defence','2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,3,'Clifton Block 2','2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,4,'Saddar Bazaar','2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,5,'North Nazimabad Block A','2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,5,'North Nazimabad Block B','2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,1,'Gulshan Block 13','2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,1,'Gulshan Block 13D','2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `area_alias` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,'INV-2026-01-1-1',1,'paid',8,'2026-01-31',2000.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,'INV-2026-01-2-1',2,'paid',8,'2026-01-31',2400.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,'INV-2026-01-3-1',3,'paid',8,'2026-01-31',1600.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,'INV-2026-01-4-1',4,'paid',8,'2026-01-31',1760.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,'INV-2026-01-5-1',5,'paid',8,'2026-01-31',1920.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,'INV-2026-01-6-1',6,'paid',8,'2026-01-31',1600.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,'INV-2026-01-7-1',7,'paid',8,'2026-01-31',1680.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,'INV-2026-01-8-1',8,'paid',8,'2026-01-31',2240.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(9,'INV-2026-01-9-1',9,'paid',8,'2026-01-31',1440.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(10,'INV-2026-01-10-1',10,'paid',8,'2026-01-31',2800.00,NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `invoice_item`
--

LOCK TABLES `invoice_item` WRITE;
/*!40000 ALTER TABLE `invoice_item` DISABLE KEYS */;
INSERT INTO `invoice_item` VALUES (1,1,1,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,2500.00,'Gulshan-e-Iqbal','Defence (DHA)',250.00,'2026-01-30 03:15:56'),(2,1,11,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,1500.00,'Gulshan-e-Iqbal','Defence (DHA)',250.00,'2026-01-30 03:15:56'),(3,1,21,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,3000.00,'Gulshan-e-Iqbal','Clifton',250.00,'2026-01-30 03:15:56'),(4,1,31,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,NULL,'Gulshan-e-Iqbal','Defence (DHA)',250.00,'2026-01-30 03:15:56'),(5,1,41,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,800.00,'Gulshan-e-Iqbal','Gulshan-e-Iqbal',250.00,'2026-01-30 03:15:56'),(6,1,51,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,5000.00,'Gulshan-e-Iqbal','Defence (DHA)',250.00,'2026-01-30 03:15:56'),(7,1,61,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,1500.00,'Gulshan-e-Iqbal','Clifton',250.00,'2026-01-30 03:15:56'),(8,1,71,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,NULL,'Gulshan-e-Iqbal','Defence (DHA)',250.00,'2026-01-30 03:15:56'),(9,2,2,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,NULL,'Saddar','Gulshan-e-Iqbal',300.00,'2026-01-30 03:15:56'),(10,2,12,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,NULL,'Saddar','North Nazimabad',300.00,'2026-01-30 03:15:56'),(11,2,22,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,NULL,'Saddar','Gulshan-e-Iqbal',300.00,'2026-01-30 03:15:56'),(12,2,32,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,2000.00,'Saddar','North Nazimabad',300.00,'2026-01-30 03:15:56'),(13,2,42,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,3500.00,'Saddar','Clifton',300.00,'2026-01-30 03:15:56'),(14,2,52,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,NULL,'Saddar','Gulshan-e-Iqbal',300.00,'2026-01-30 03:15:56'),(15,2,62,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,NULL,'Saddar','North Nazimabad',300.00,'2026-01-30 03:15:56'),(16,2,72,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,50000.00,'Saddar','Clifton',300.00,'2026-01-30 03:15:56'),(17,3,3,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,800.00,'Clifton','North Nazimabad',200.00,'2026-01-30 03:15:56'),(18,3,13,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,1200.00,'Clifton','Gulshan-e-Iqbal',200.00,'2026-01-30 03:15:56'),(19,3,23,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,1100.00,'Clifton','North Nazimabad',200.00,'2026-01-30 03:15:56'),(20,3,33,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,700.00,'Clifton','Clifton',200.00,'2026-01-30 03:15:56'),(21,3,43,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,NULL,'Clifton','Defence (DHA)',200.00,'2026-01-30 03:15:56'),(22,3,53,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,1300.00,'Clifton','North Nazimabad',200.00,'2026-01-30 03:15:56'),(23,3,63,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,1000.00,'Clifton','Clifton',200.00,'2026-01-30 03:15:56'),(24,3,73,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,600.00,'Clifton','Defence (DHA)',200.00,'2026-01-30 03:15:56'),(25,4,4,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,NULL,'Defence (DHA)','Clifton',220.00,'2026-01-30 03:15:56'),(26,4,14,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,4000.00,'Defence (DHA)','Clifton',220.00,'2026-01-30 03:15:56'),(27,4,24,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,15000.00,'Defence (DHA)','Defence (DHA)',220.00,'2026-01-30 03:15:56'),(28,4,34,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,NULL,'Defence (DHA)','Saddar',220.00,'2026-01-30 03:15:56'),(29,4,44,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,4500.00,'Defence (DHA)','Saddar',220.00,'2026-01-30 03:15:56'),(30,4,54,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,3000.00,'Defence (DHA)','Clifton',220.00,'2026-01-30 03:15:56'),(31,4,64,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,12000.00,'Defence (DHA)','Defence (DHA)',220.00,'2026-01-30 03:15:56'),(32,4,74,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,NULL,'Defence (DHA)','Saddar',220.00,'2026-01-30 03:15:56'),(33,5,5,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,5000.00,'Gulshan-e-Iqbal','Defence (DHA)',240.00,'2026-01-30 03:15:56'),(34,5,15,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,NULL,'Gulshan-e-Iqbal','Saddar',240.00,'2026-01-30 03:15:56'),(35,5,25,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,NULL,'Gulshan-e-Iqbal','Clifton',240.00,'2026-01-30 03:15:56'),(36,5,35,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,3000.00,'Gulshan-e-Iqbal','Gulshan-e-Iqbal',240.00,'2026-01-30 03:15:56'),(37,5,45,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,3500.00,'Gulshan-e-Iqbal','North Nazimabad',240.00,'2026-01-30 03:15:56'),(38,5,55,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,2000.00,'Gulshan-e-Iqbal','Saddar',240.00,'2026-01-30 03:15:56'),(39,5,65,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,NULL,'Gulshan-e-Iqbal','Gulshan-e-Iqbal',240.00,'2026-01-30 03:15:56'),(40,5,75,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,1200.00,'Gulshan-e-Iqbal','North Nazimabad',240.00,'2026-01-30 03:15:56'),(41,6,6,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,1200.00,'Saddar','Nazimabad',200.00,'2026-01-30 03:15:56'),(42,6,16,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,900.00,'Saddar','Liaquatabad',200.00,'2026-01-30 03:15:56'),(43,6,26,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,3500.00,'Saddar','Gulshan-e-Iqbal',200.00,'2026-01-30 03:15:56'),(44,6,36,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,2500.00,'Saddar','Defence (DHA)',200.00,'2026-01-30 03:15:56'),(45,6,46,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,NULL,'Saddar','Gulshan-e-Iqbal',200.00,'2026-01-30 03:15:56'),(46,6,56,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,NULL,'Saddar','Liaquatabad',200.00,'2026-01-30 03:15:56'),(47,6,66,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,1800.00,'Saddar','Defence (DHA)',200.00,'2026-01-30 03:15:56'),(48,6,76,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,1500.00,'Saddar','Gulshan-e-Iqbal',200.00,'2026-01-30 03:15:56'),(49,7,7,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,NULL,'Clifton','Gulshan-e-Iqbal',210.00,'2026-01-30 03:15:56'),(50,7,17,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,3500.00,'Clifton','Defence (DHA)',210.00,'2026-01-30 03:15:56'),(51,7,27,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,5000.00,'Clifton','Defence (DHA)',210.00,'2026-01-30 03:15:56'),(52,7,37,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,NULL,'Clifton','Clifton',210.00,'2026-01-30 03:15:56'),(53,7,47,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,2500.00,'Clifton','Clifton',210.00,'2026-01-30 03:15:56'),(54,7,57,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,1800.00,'Clifton','Defence (DHA)',210.00,'2026-01-30 03:15:56'),(55,7,67,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,4500.00,'Clifton','Saddar',210.00,'2026-01-30 03:15:56'),(56,7,77,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,3000.00,'Clifton','Clifton',210.00,'2026-01-30 03:15:56'),(57,8,8,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,1800.00,'North Nazimabad','Defence (DHA)',280.00,'2026-01-30 03:15:56'),(58,8,18,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,NULL,'North Nazimabad','Gulshan-e-Iqbal',280.00,'2026-01-30 03:15:56'),(59,8,28,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,NULL,'North Nazimabad','Saddar',280.00,'2026-01-30 03:15:56'),(60,8,38,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,2000.00,'North Nazimabad','Liaquatabad',280.00,'2026-01-30 03:15:56'),(61,8,48,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,2200.00,'North Nazimabad','Defence (DHA)',280.00,'2026-01-30 03:15:56'),(62,8,58,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,3500.00,'North Nazimabad','Gulshan-e-Iqbal',280.00,'2026-01-30 03:15:56'),(63,8,68,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,NULL,'North Nazimabad','Liaquatabad',280.00,'2026-01-30 03:15:56'),(64,8,78,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,NULL,'North Nazimabad','Defence (DHA)',280.00,'2026-01-30 03:15:56'),(65,9,9,'2026-01-15','2026-01-15','2026-01-15',NULL,NULL,600.00,'Saddar','Liaquatabad',180.00,'2026-01-30 03:15:56'),(66,9,19,'2026-01-16','2026-01-16','2026-01-17',NULL,NULL,1000.00,'Saddar','Nazimabad',180.00,'2026-01-30 03:15:56'),(67,9,29,'2026-01-17','2026-01-17','2026-01-18',NULL,NULL,500.00,'Saddar','Liaquatabad',180.00,'2026-01-30 03:15:56'),(68,9,39,'2026-01-18','2026-01-18','2026-01-19',NULL,NULL,1500.00,'Saddar','Nazimabad',180.00,'2026-01-30 03:15:56'),(69,9,49,'2026-01-19','2026-01-19','2026-01-20',NULL,NULL,2500.00,'Saddar','Liaquatabad',180.00,'2026-01-30 03:15:56'),(70,9,59,'2026-01-20','2026-01-20','2026-01-21',NULL,NULL,NULL,'Saddar','Nazimabad',180.00,'2026-01-30 03:15:56'),(71,9,69,'2026-01-21','2026-01-21','2026-01-22',NULL,NULL,800.00,'Saddar','Nazimabad',180.00,'2026-01-30 03:15:56'),(72,9,79,'2026-01-22','2026-01-22','2026-01-23',NULL,NULL,700.00,'Saddar','Liaquatabad',180.00,'2026-01-30 03:15:56'),(73,10,10,'2026-01-16','2026-01-16','2026-01-16',NULL,NULL,NULL,'Korangi','Clifton',350.00,'2026-01-30 03:15:56'),(74,10,20,'2026-01-17','2026-01-17','2026-01-17',NULL,NULL,NULL,'Korangi','Clifton',350.00,'2026-01-30 03:15:56'),(75,10,30,'2026-01-18','2026-01-18','2026-01-18',NULL,NULL,8000.00,'Korangi','Gulshan-e-Iqbal',350.00,'2026-01-30 03:15:56'),(76,10,40,'2026-01-19','2026-01-19','2026-01-19',NULL,NULL,NULL,'Korangi','Defence (DHA)',350.00,'2026-01-30 03:15:56'),(77,10,50,'2026-01-20','2026-01-20','2026-01-20',NULL,NULL,NULL,'Korangi','Clifton',350.00,'2026-01-30 03:15:56'),(78,10,60,'2026-01-21','2026-01-21','2026-01-21',NULL,NULL,20000.00,'Korangi','Defence (DHA)',350.00,'2026-01-30 03:15:56'),(79,10,70,'2026-01-22','2026-01-22','2026-01-22',NULL,NULL,7000.00,'Korangi','Gulshan-e-Iqbal',350.00,'2026-01-30 03:15:56'),(80,10,80,'2026-01-23','2026-01-23','2026-01-23',NULL,NULL,6000.00,'Korangi','Clifton',350.00,'2026-01-30 03:15:56');
/*!40000 ALTER TABLE `invoice_item` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `invoice_payment_allocation`
--

LOCK TABLES `invoice_payment_allocation` WRITE;
/*!40000 ALTER TABLE `invoice_payment_allocation` DISABLE KEYS */;
INSERT INTO `invoice_payment_allocation` VALUES (1,1,1400.00),(2,2,1680.00),(3,3,1600.00),(4,4,1232.00),(5,5,1344.00),(6,6,1600.00),(7,7,1176.00),(8,8,1568.00),(9,9,1440.00),(10,10,1960.00);
/*!40000 ALTER TABLE `invoice_payment_allocation` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,1400.00,'2026-02-08','bank_transfer','2026-01-30 03:15:57'),(2,2,1680.00,'2026-02-09','bank_transfer','2026-01-30 03:15:57'),(3,3,1600.00,'2026-02-10','bank_transfer','2026-01-30 03:15:57'),(4,4,1232.00,'2026-02-11','bank_transfer','2026-01-30 03:15:57'),(5,5,1344.00,'2026-02-12','bank_transfer','2026-01-30 03:15:57'),(6,6,1600.00,'2026-02-13','cash','2026-01-30 03:15:57'),(7,7,1176.00,'2026-02-14','cash','2026-01-30 03:15:57'),(8,8,1568.00,'2026-02-15','cash','2026-01-30 03:15:57'),(9,9,1440.00,'2026-02-16','wallet','2026-01-30 03:15:57'),(10,10,1960.00,'2026-02-17','bank_transfer','2026-01-30 03:15:57');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `rider`
--

LOCK TABLES `rider` WRITE;
/*!40000 ALTER TABLE `rider` DISABLE KEYS */;
INSERT INTO `rider` VALUES (1,'Ahmed Ali Khan','ahmed.ali@rider.pk','hashed_password_1','0300-1111111',25000.00,120.00,15,'AAK','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,'Bilal Hassan','bilal.hassan@rider.pk','hashed_password_2','0301-2222222',25000.00,100.00,12,'BH','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,'Imran Younis','imran.younis@rider.pk','hashed_password_3','0302-3333333',25000.00,110.00,15,'IY','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,'Fahad Raza','fahad.raza@rider.pk','hashed_password_4','0303-4444444',25000.00,120.00,10,'FR','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,'Danish Mahmood','danish.mahmood@rider.pk','hashed_password_5','0304-5555555',25000.00,100.00,14,'DM','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,'Kamran Akram','kamran.akram@rider.pk','hashed_password_6','0305-6666666',25000.00,110.00,13,'KA','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,'Nadeem Iqbal','nadeem.iqbal@rider.pk','hashed_password_7','0306-7777777',25000.00,120.00,15,'NI','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,'Omer Farooq','omer.farooq@rider.pk','hashed_password_8','0307-8888888',25000.00,100.00,12,'OF','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(9,'Saad Malik','saad.malik@rider.pk','hashed_password_9','0308-9999999',25000.00,110.00,14,'SM','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(10,'Usman Sheikh','usman.sheikh@rider.pk','hashed_password_10','0309-0000000',25000.00,120.00,15,'US','online','approved',1,'2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `rider` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `rider_area`
--

LOCK TABLES `rider_area` WRITE;
/*!40000 ALTER TABLE `rider_area` DISABLE KEYS */;
INSERT INTO `rider_area` VALUES (2,1),(3,1),(7,1),(10,1),(1,2),(3,2),(7,2),(1,3),(3,3),(7,3),(10,3),(1,4),(8,4),(10,4),(2,5),(5,5),(6,5),(2,6),(5,6),(8,6),(5,7),(8,7),(4,8),(9,8),(4,9),(9,9),(4,10),(9,10),(6,11),(6,12);
/*!40000 ALTER TABLE `rider_area` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `rider_commission`
--

LOCK TABLES `rider_commission` WRITE;
/*!40000 ALTER TABLE `rider_commission` DISABLE KEYS */;
INSERT INTO `rider_commission` VALUES (1,2,90,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,3,1,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,3,3,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,3,4,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,3,5,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,3,7,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,3,11,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,3,13,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(9,3,14,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(10,3,15,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(11,3,17,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(12,3,21,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(13,3,23,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(14,3,24,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(15,3,25,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(16,3,27,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(17,3,31,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(18,3,33,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(19,3,34,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(20,3,35,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(21,3,37,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(22,3,41,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(23,3,43,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(24,3,44,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(25,3,45,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(26,3,47,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(27,3,51,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(28,3,53,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(29,3,54,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(30,3,55,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(31,3,57,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(32,3,61,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(33,3,63,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(34,3,64,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(35,3,65,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(36,3,67,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(37,3,71,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(38,3,73,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(39,3,74,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(40,3,75,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(41,3,77,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(42,3,81,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(43,3,83,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(44,3,84,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(45,3,85,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(46,3,87,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(47,3,91,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(48,3,93,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(49,3,94,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(50,3,95,NULL,'pickup',55.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(51,4,10,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(52,4,20,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(53,4,30,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(54,4,40,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(55,4,50,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(56,4,60,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(57,4,70,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(58,4,80,NULL,'pickup',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(59,5,8,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(60,5,18,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(61,5,28,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(62,5,38,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(63,5,48,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(64,5,58,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(65,5,68,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(66,5,78,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(67,5,88,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(68,8,2,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(69,8,6,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(70,8,9,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(71,8,12,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(72,8,16,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(73,8,19,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(74,8,22,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(75,8,26,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(76,8,29,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(77,8,32,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(78,8,36,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(79,8,39,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(80,8,42,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(81,8,46,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(82,8,49,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(83,8,52,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(84,8,56,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(85,8,59,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(86,8,62,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(87,8,66,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(88,8,69,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(89,8,72,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(90,8,76,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(91,8,79,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(92,8,82,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(93,8,86,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(94,8,89,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(95,8,92,NULL,'pickup',50.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(128,1,8,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(129,1,11,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(130,1,15,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(131,1,24,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(132,1,27,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(133,1,28,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(134,1,34,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(135,1,36,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(136,1,40,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(137,1,43,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(138,1,44,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(139,1,48,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(140,1,51,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(141,1,55,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(142,1,57,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(143,1,60,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(144,1,64,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(145,1,66,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(146,1,67,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(147,1,73,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(148,1,74,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(149,1,78,NULL,'delivery',120.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(150,2,2,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(151,2,7,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(152,2,13,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(153,2,18,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(154,2,22,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(155,2,26,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(156,2,30,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(157,2,35,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(158,2,41,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(159,2,46,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(160,2,52,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(161,2,58,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(162,2,65,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(163,2,70,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(164,2,76,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(165,3,1,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(166,3,4,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(167,3,5,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(168,3,10,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(169,3,14,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(170,3,17,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(171,3,20,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(172,3,21,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(173,3,25,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(174,3,31,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(175,3,33,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(176,3,37,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(177,3,42,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(178,3,47,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(179,3,50,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(180,3,54,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(181,3,61,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(182,3,63,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(183,3,71,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(184,3,72,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(185,3,77,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(186,3,80,NULL,'delivery',110.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(187,5,3,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(188,5,12,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(189,5,23,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(190,5,32,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(191,5,45,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(192,5,53,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(193,5,62,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(194,5,75,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(195,8,6,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(196,8,9,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(197,8,16,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(198,8,19,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(199,8,29,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(200,8,38,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(201,8,39,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(202,8,49,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(203,8,56,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(204,8,59,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(205,8,68,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(206,8,69,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(207,8,79,NULL,'delivery',100.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(255,3,91,NULL,'returned',66.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(256,5,92,NULL,'returned',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(257,1,93,NULL,'returned',72.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(258,1,94,NULL,'returned',72.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(259,2,95,NULL,'returned',60.00,'approved',NULL,'2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `rider_commission` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `rider_settlement`
--

LOCK TABLES `rider_settlement` WRITE;
/*!40000 ALTER TABLE `rider_settlement` DISABLE KEYS */;
INSERT INTO `rider_settlement` VALUES (1,'SETT-1-2026-W03',1,25800.00,'2026-01-20 21:00:00','bank_transfer','Pending','2026-01-30 03:15:57'),(2,'SETT-1-2026-W04',1,54400.00,'2026-01-24 18:00:00','bank_transfer','Verified','2026-01-30 03:15:57'),(3,'SETT-2-2026-W03',2,15700.00,'2026-01-20 20:00:00','bank_transfer','Verified','2026-01-30 03:15:57'),(4,'SETT-2-2026-W04',2,12800.00,'2026-01-24 21:00:00','bank_transfer','Pending','2026-01-30 03:15:57'),(5,'SETT-3-2026-W03',3,18700.00,'2026-01-20 18:00:00','bank_transfer','Pending','2026-01-30 03:15:57'),(6,'SETT-3-2026-W04',3,70500.00,'2026-01-25 15:00:00','bank_transfer','Verified','2026-01-30 03:15:57'),(7,'SETT-5-2026-W03',5,3900.00,'2026-01-20 17:00:00','bank_transfer','Verified','2026-01-30 03:15:57'),(8,'SETT-5-2026-W04',5,6000.00,'2026-01-24 20:00:00','wallet','Verified','2026-01-30 03:15:57'),(9,'SETT-8-2026-W03',8,6200.00,'2026-01-20 23:00:00','bank_transfer','Verified','2026-01-30 03:15:57'),(10,'SETT-8-2026-W04',8,5500.00,'2026-01-25 00:00:00','bank_transfer','Verified','2026-01-30 03:15:57');
/*!40000 ALTER TABLE `rider_settlement` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Same Day 24 Hours',12,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,'Next Day 48 Hours',24,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,'Standard 72 Hours',48,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,'Express 12 Hours',6,1,'2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
INSERT INTO `shipment` VALUES (1,1,2,'ORD-001','AWB-001','Fatima Ahmed','0300-5001001','Ladies kurta - Red - Size M','COD',2500.00,2500.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 45, Street 3, DHA Phase 5',1,2,1,3,'delivered',0,0,'2026-01-15 09:00:00','2026-01-30 03:15:56'),(2,2,1,'ORD-002','AWB-002','Hassan Ali','0321-5002002','Wireless Mouse','Prepaid',NULL,1500.00,'TechHub, Saddar','TechHub, Saddar','Flat 302, Block 13, Gulshan-e-Iqbal',4,1,4,2,'delivered',0,0,'2026-01-15 10:00:00','2026-01-30 03:15:56'),(3,3,2,'ORD-003','AWB-003','Ayesha Khan','0333-5003003','The Alchemist Book','COD',800.00,800.00,'BookMart, Clifton','BookMart, Clifton','Apartment 5B, North Nazimabad',3,5,3,5,'delivered',0,0,'2026-01-15 11:00:00','2026-01-30 03:15:56'),(4,4,2,'ORD-004','AWB-004','Salman Raza','0300-5004004','Kitchen Knife Set','Prepaid',NULL,3500.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 22, Clifton Block 2',2,3,2,3,'delivered',0,0,'2026-01-15 12:00:00','2026-01-30 03:15:56'),(5,5,1,'ORD-005','AWB-005','Imran Siddiqui','0322-5005005','Cricket Bat','COD',5000.00,5000.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','Villa 8, DHA Phase 6',1,2,1,3,'delivered',0,0,'2026-01-15 13:00:00','2026-01-30 03:15:56'),(6,6,2,'ORD-006','AWB-006','Nida Hussain','0301-5006006','Lipstick Set','COD',1200.00,1200.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 101, Nazimabad',4,6,4,8,'delivered',0,0,'2026-01-15 14:00:00','2026-01-30 03:15:56'),(7,7,2,'ORD-007','AWB-007','Zainab Malik','0321-5007007','Kids Toy Car','Prepaid',NULL,2000.00,'Kids World, Clifton','Kids World, Clifton','House 99, Gulshan Block 13',3,1,3,2,'delivered',0,0,'2026-01-15 15:00:00','2026-01-30 03:15:56'),(8,8,4,'ORD-008','AWB-008','Kamran Javed','0333-5008008','Organic Honey 1kg','COD',1800.00,1800.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 7, DHA Phase 4',5,2,5,1,'delivered',0,0,'2026-01-15 16:00:00','2026-01-30 03:15:56'),(9,9,2,'ORD-009','AWB-009','Farhan Sheikh','0300-5009009','Phone Case','COD',600.00,600.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 44, Liaquatabad',4,7,4,8,'delivered',0,0,'2026-01-15 17:00:00','2026-01-30 03:15:56'),(10,10,3,'ORD-010','AWB-010','Rabia Tariq','0322-5010010','Dining Table','Prepaid',NULL,25000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 101, Clifton',8,3,8,3,'delivered',0,0,'2026-01-16 09:00:00','2026-01-30 03:15:56'),(11,1,2,'ORD-011','AWB-011','Hina Aslam','0301-5011011','Embroidered Dupatta','COD',1500.00,1500.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','Flat 205, DHA Phase 2',1,2,1,1,'delivered',0,0,'2026-01-16 10:00:00','2026-01-30 03:15:56'),(12,2,1,'ORD-012','AWB-012','Adnan Farooq','0321-5012012','USB Cable','Prepaid',NULL,300.00,'TechHub, Saddar','TechHub, Saddar','House 77, North Nazimabad',4,5,4,5,'delivered',0,0,'2026-01-16 11:00:00','2026-01-30 03:15:56'),(13,3,2,'ORD-013','AWB-013','Sara Iqbal','0333-5013013','Business Management Book','COD',1200.00,1200.00,'BookMart, Clifton','BookMart, Clifton','Apartment 3C, Gulshan-e-Iqbal',3,1,3,2,'delivered',0,0,'2026-01-16 12:00:00','2026-01-30 03:15:56'),(14,4,2,'ORD-014','AWB-014','Waqas Ahmed','0300-5014014','Bedsheet Set','COD',4000.00,4000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 33, Clifton Block 8',2,3,2,3,'delivered',0,0,'2026-01-16 13:00:00','2026-01-30 03:15:56'),(15,5,2,'ORD-015','AWB-015','Bilal Aziz','0322-5015015','Football','Prepaid',NULL,2500.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 10, Saddar',1,4,1,1,'delivered',0,0,'2026-01-16 14:00:00','2026-01-30 03:15:56'),(16,6,2,'ORD-016','AWB-016','Amna Riaz','0301-5016016','Face Cream','COD',900.00,900.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 88, Liaquatabad',4,7,4,8,'delivered',0,0,'2026-01-16 15:00:00','2026-01-30 03:15:56'),(17,7,2,'ORD-017','AWB-017','Umer Khalid','0321-5017017','Remote Control Car','COD',3500.00,3500.00,'Kids World, Clifton','Kids World, Clifton','House 66, DHA Phase 5',3,2,3,3,'delivered',0,0,'2026-01-16 16:00:00','2026-01-30 03:15:56'),(18,8,1,'ORD-018','AWB-018','Sana Tariq','0333-5018018','Organic Dates 2kg','Prepaid',NULL,1600.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 12, Gulshan Block 13',5,1,5,2,'delivered',0,0,'2026-01-16 17:00:00','2026-01-30 03:15:56'),(19,9,2,'ORD-019','AWB-019','Kashif Mehmood','0300-5019019','Charger','COD',1000.00,1000.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 55, Nazimabad',4,6,4,8,'delivered',0,0,'2026-01-16 18:00:00','2026-01-30 03:15:56'),(20,10,3,'ORD-020','AWB-020','Mahira Khan','0322-5020020','Office Chair','Prepaid',NULL,12000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','Office 3, Clifton',8,3,8,3,'delivered',0,0,'2026-01-17 09:00:00','2026-01-30 03:15:56'),(21,1,2,'ORD-021','AWB-021','Nabeel Hassan','0301-5021021','Shawl','COD',3000.00,3000.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 88, Clifton',1,3,1,3,'delivered',0,0,'2026-01-17 10:00:00','2026-01-30 03:15:56'),(22,2,1,'ORD-022','AWB-022','Rehan Ali','0321-5022022','Keyboard','Prepaid',NULL,2500.00,'TechHub, Saddar','TechHub, Saddar','Flat 404, Gulshan-e-Iqbal',4,1,4,2,'delivered',0,0,'2026-01-17 11:00:00','2026-01-30 03:15:56'),(23,3,2,'ORD-023','AWB-023','Sadia Malik','0333-5023023','Psychology Book','COD',1100.00,1100.00,'BookMart, Clifton','BookMart, Clifton','Apartment 9A, North Nazimabad',3,5,3,5,'delivered',0,0,'2026-01-17 12:00:00','2026-01-30 03:15:56'),(24,4,2,'ORD-024','AWB-024','Tariq Jamil','0300-5024024','Microwave','COD',15000.00,15000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 77, DHA Phase 6',2,2,2,1,'delivered',0,0,'2026-01-17 13:00:00','2026-01-30 03:15:56'),(25,5,1,'ORD-025','AWB-025','Usman Akram','0322-5025025','Tennis Racket','Prepaid',NULL,4000.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','Villa 12, Clifton',1,3,1,3,'delivered',0,0,'2026-01-17 14:00:00','2026-01-30 03:15:56'),(26,6,2,'ORD-026','AWB-026','Zara Butt','0301-5026026','Hair Dryer','COD',3500.00,3500.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 202, Gulshan Block 13',4,1,4,2,'delivered',0,0,'2026-01-17 15:00:00','2026-01-30 03:15:56'),(27,7,2,'ORD-027','AWB-027','Ahmed Raza','0321-5027027','Lego Set','COD',5000.00,5000.00,'Kids World, Clifton','Kids World, Clifton','House 111, DHA Phase 4',3,2,3,1,'delivered',0,0,'2026-01-17 16:00:00','2026-01-30 03:15:56'),(28,8,4,'ORD-028','AWB-028','Farah Khan','0333-5028028','Organic Tea','Prepaid',NULL,1200.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 15, Saddar',5,4,5,1,'delivered',0,0,'2026-01-17 17:00:00','2026-01-30 03:15:56'),(29,9,2,'ORD-029','AWB-029','Hamza Sheikh','0300-5029029','Screen Protector','COD',500.00,500.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 22, Liaquatabad',4,7,4,8,'delivered',0,0,'2026-01-17 18:00:00','2026-01-30 03:15:56'),(30,10,3,'ORD-030','AWB-030','Irum Javed','0322-5030030','Bookshelf','COD',8000.00,8000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 55, Gulshan-e-Iqbal',8,1,8,2,'delivered',0,0,'2026-01-18 09:00:00','2026-01-30 03:15:56'),(31,1,2,'ORD-031','AWB-031','Junaid Ahmed','0301-5031031','Mens Shalwar Kameez','Prepaid',NULL,3500.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 99, DHA Phase 5',1,2,1,3,'delivered',0,0,'2026-01-18 10:00:00','2026-01-30 03:15:56'),(32,2,1,'ORD-032','AWB-032','Kiran Ali','0321-5032032','Laptop Stand','COD',2000.00,2000.00,'TechHub, Saddar','TechHub, Saddar','Flat 505, North Nazimabad',4,5,4,5,'delivered',0,0,'2026-01-18 11:00:00','2026-01-30 03:15:56'),(33,3,2,'ORD-033','AWB-033','Laiba Hassan','0333-5033033','Fiction Novel','COD',700.00,700.00,'BookMart, Clifton','BookMart, Clifton','Apartment 6B, Clifton',3,3,3,3,'delivered',0,0,'2026-01-18 12:00:00','2026-01-30 03:15:56'),(34,4,2,'ORD-034','AWB-034','Mohsin Raza','0300-5034034','Blender','Prepaid',NULL,6000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 44, Saddar',2,4,2,1,'delivered',0,0,'2026-01-18 13:00:00','2026-01-30 03:15:56'),(35,5,2,'ORD-035','AWB-035','Noman Akbar','0322-5035035','Badminton Set','COD',3000.00,3000.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 77, Gulshan Block 13',1,1,1,2,'delivered',0,0,'2026-01-18 14:00:00','2026-01-30 03:15:56'),(36,6,2,'ORD-036','AWB-036','Omer Latif','0301-5036036','Perfume','COD',2500.00,2500.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 303, DHA Phase 2',4,2,4,1,'delivered',0,0,'2026-01-18 15:00:00','2026-01-30 03:15:56'),(37,7,1,'ORD-037','AWB-037','Palwasha Khan','0321-5037037','Puzzle Game','Prepaid',NULL,1500.00,'Kids World, Clifton','Kids World, Clifton','House 33, Clifton Block 2',3,3,3,3,'delivered',0,0,'2026-01-18 16:00:00','2026-01-30 03:15:56'),(38,8,1,'ORD-038','AWB-038','Qasim Ali','0333-5038038','Organic Flour 5kg','COD',2000.00,2000.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 20, Liaquatabad',5,7,5,8,'delivered',0,0,'2026-01-18 17:00:00','2026-01-30 03:15:56'),(39,9,2,'ORD-039','AWB-039','Rida Sheikh','0300-5039039','Earphones','COD',1500.00,1500.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 88, Nazimabad',4,6,4,8,'delivered',0,0,'2026-01-18 18:00:00','2026-01-30 03:15:56'),(40,10,3,'ORD-040','AWB-040','Salma Tariq','0322-5040040','Computer Desk','Prepaid',NULL,10000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','Office 5, DHA',8,2,8,1,'delivered',0,0,'2026-01-19 09:00:00','2026-01-30 03:15:56'),(41,1,2,'ORD-041','AWB-041','Talha Ahmed','0301-5041041','Ladies Scarf','COD',800.00,800.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 22, Gulshan Block 13',1,1,1,2,'delivered',0,0,'2026-01-19 10:00:00','2026-01-30 03:15:56'),(42,2,1,'ORD-042','AWB-042','Umar Farooq','0321-5042042','Webcam','COD',3500.00,3500.00,'TechHub, Saddar','TechHub, Saddar','Flat 606, Clifton Block 2',4,3,4,3,'delivered',0,0,'2026-01-19 11:00:00','2026-01-30 03:15:56'),(43,3,2,'ORD-043','AWB-043','Warda Malik','0333-5043043','History Book','Prepaid',NULL,950.00,'BookMart, Clifton','BookMart, Clifton','Apartment 10C, DHA Phase 4',3,2,3,1,'delivered',0,0,'2026-01-19 12:00:00','2026-01-30 03:15:56'),(44,4,2,'ORD-044','AWB-044','Yasir Raza','0300-5044044','Toaster','COD',4500.00,4500.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 66, Saddar',2,4,2,1,'delivered',0,0,'2026-01-19 13:00:00','2026-01-30 03:15:56'),(45,5,1,'ORD-045','AWB-045','Zubair Akram','0322-5045045','Basketball','COD',3500.00,3500.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 44, North Nazimabad',1,5,1,5,'delivered',0,0,'2026-01-19 14:00:00','2026-01-30 03:15:56'),(46,6,2,'ORD-046','AWB-046','Aliya Butt','0301-5046046','Makeup Kit','Prepaid',NULL,4000.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 404, Gulshan-e-Iqbal',4,1,4,2,'delivered',0,0,'2026-01-19 15:00:00','2026-01-30 03:15:56'),(47,7,2,'ORD-047','AWB-047','Basit Raza','0321-5047047','Board Game','COD',2500.00,2500.00,'Kids World, Clifton','Kids World, Clifton','House 55, Clifton Block 8',3,3,3,3,'delivered',0,0,'2026-01-19 16:00:00','2026-01-30 03:15:56'),(48,8,4,'ORD-048','AWB-048','Chand Bibi','0333-5048048','Organic Olive Oil','COD',2200.00,2200.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 25, DHA Phase 5',5,2,5,1,'delivered',0,0,'2026-01-19 17:00:00','2026-01-30 03:15:56'),(49,9,2,'ORD-049','AWB-049','Danish Iqbal','0300-5049049','Power Bank','COD',2500.00,2500.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 11, Liaquatabad',4,7,4,8,'delivered',0,0,'2026-01-19 18:00:00','2026-01-30 03:15:56'),(50,10,3,'ORD-050','AWB-050','Erum Javed','0322-5050050','Sofa Set','Prepaid',NULL,45000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 101, Clifton',8,3,8,3,'delivered',0,0,'2026-01-20 09:00:00','2026-01-30 03:15:56'),(51,1,2,'ORD-051','AWB-051','Faizan Ahmed','0301-5051051','Mens Jacket','COD',5000.00,5000.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 33, DHA Phase 6',1,2,1,1,'delivered',0,0,'2026-01-20 10:00:00','2026-01-30 03:15:56'),(52,2,1,'ORD-052','AWB-052','Hiba Ali','0321-5052052','External HDD','Prepaid',NULL,6000.00,'TechHub, Saddar','TechHub, Saddar','Flat 707, Gulshan Block 13',4,1,4,2,'delivered',0,0,'2026-01-20 11:00:00','2026-01-30 03:15:56'),(53,3,2,'ORD-053','AWB-053','Irfan Hassan','0333-5053053','Science Book','COD',1300.00,1300.00,'BookMart, Clifton','BookMart, Clifton','Apartment 12D, North Nazimabad',3,5,3,5,'delivered',0,0,'2026-01-20 12:00:00','2026-01-30 03:15:56'),(54,4,2,'ORD-054','AWB-054','Junaid Raza','0300-5054054','Iron','COD',3000.00,3000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 88, Clifton Block 2',2,3,2,3,'delivered',0,0,'2026-01-20 13:00:00','2026-01-30 03:15:56'),(55,5,2,'ORD-055','AWB-055','Kashif Akbar','0322-5055055','Gym Bag','COD',2000.00,2000.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 99, Saddar',1,4,1,1,'delivered',0,0,'2026-01-20 14:00:00','2026-01-30 03:15:56'),(56,6,2,'ORD-056','AWB-056','Laiba Latif','0301-5056056','Nail Polish Set','Prepaid',NULL,1000.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 505, Liaquatabad',4,7,4,8,'delivered',0,0,'2026-01-20 15:00:00','2026-01-30 03:15:56'),(57,7,2,'ORD-057','AWB-057','Muneeb Khan','0321-5057057','Action Figure','COD',1800.00,1800.00,'Kids World, Clifton','Kids World, Clifton','House 77, DHA Phase 4',3,2,3,1,'delivered',0,0,'2026-01-20 16:00:00','2026-01-30 03:15:56'),(58,8,1,'ORD-058','AWB-058','Naila Ali','0333-5058058','Organic Rice 10kg','COD',3500.00,3500.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 30, Gulshan Block 13',5,1,5,2,'delivered',0,0,'2026-01-20 17:00:00','2026-01-30 03:15:56'),(59,9,2,'ORD-059','AWB-059','Omer Iqbal','0300-5059059','Bluetooth Speaker','Prepaid',NULL,4000.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 33, Nazimabad',4,6,4,8,'delivered',0,0,'2026-01-20 18:00:00','2026-01-30 03:15:56'),(60,10,3,'ORD-060','AWB-060','Palwasha Tariq','0322-5060060','Wardrobe','COD',20000.00,20000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 55, DHA Phase 5',8,2,8,1,'delivered',0,0,'2026-01-21 09:00:00','2026-01-30 03:15:56'),(61,1,2,'ORD-061','AWB-061','Qasim Ahmed','0301-5061061','Tie Set','COD',1500.00,1500.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 44, Clifton',1,3,1,3,'delivered',0,0,'2026-01-21 10:00:00','2026-01-30 03:15:56'),(62,2,1,'ORD-062','AWB-062','Rida Farooq','0321-5062062','Monitor','Prepaid',NULL,15000.00,'TechHub, Saddar','TechHub, Saddar','Flat 808, North Nazimabad',4,5,4,5,'delivered',0,0,'2026-01-21 11:00:00','2026-01-30 03:15:56'),(63,3,2,'ORD-063','AWB-063','Saad Malik','0333-5063063','Philosophy Book','COD',1000.00,1000.00,'BookMart, Clifton','BookMart, Clifton','Apartment 15E, Clifton Block 2',3,3,3,3,'delivered',0,0,'2026-01-21 12:00:00','2026-01-30 03:15:56'),(64,4,2,'ORD-064','AWB-064','Talha Raza','0300-5064064','Vacuum Cleaner','COD',12000.00,12000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 11, DHA Phase 6',2,2,2,1,'delivered',0,0,'2026-01-21 13:00:00','2026-01-30 03:15:56'),(65,5,1,'ORD-065','AWB-065','Usman Akram','0322-5065065','Volleyball','Prepaid',NULL,2000.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 66, Gulshan Block 13',1,1,1,2,'delivered',0,0,'2026-01-21 14:00:00','2026-01-30 03:15:56'),(66,6,2,'ORD-066','AWB-066','Warda Butt','0301-5066066','Shampoo Set','COD',1800.00,1800.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 606, DHA Phase 2',4,2,4,1,'delivered',0,0,'2026-01-21 15:00:00','2026-01-30 03:15:56'),(67,7,2,'ORD-067','AWB-067','Yasir Khan','0321-5067067','Doll House','COD',4500.00,4500.00,'Kids World, Clifton','Kids World, Clifton','House 22, Saddar',3,4,3,1,'delivered',0,0,'2026-01-21 16:00:00','2026-01-30 03:15:56'),(68,8,4,'ORD-068','AWB-068','Zainab Ali','0333-5068068','Organic Lentils 5kg','Prepaid',NULL,2500.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 35, Liaquatabad',5,7,5,8,'delivered',0,0,'2026-01-21 17:00:00','2026-01-30 03:15:56'),(69,9,2,'ORD-069','AWB-069','Adil Iqbal','0300-5069069','Tablet Case','COD',800.00,800.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 77, Nazimabad',4,6,4,8,'delivered',0,0,'2026-01-21 18:00:00','2026-01-30 03:15:56'),(70,10,3,'ORD-070','AWB-070','Basma Tariq','0322-5070070','Study Table','COD',7000.00,7000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 88, Gulshan-e-Iqbal',8,1,8,2,'delivered',0,0,'2026-01-22 09:00:00','2026-01-30 03:15:56'),(71,1,2,'ORD-071','AWB-071','Fizza Ahmed','0301-5071071','Ladies Handbag','Prepaid',NULL,3000.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 99, DHA Phase 5',1,2,1,3,'delivered',0,0,'2026-01-22 10:00:00','2026-01-30 03:15:56'),(72,2,1,'ORD-072','AWB-072','Hammad Farooq','0321-5072072','Graphic Card','COD',50000.00,50000.00,'TechHub, Saddar','TechHub, Saddar','Flat 909, Clifton Block 2',4,3,4,3,'delivered',0,0,'2026-01-22 11:00:00','2026-01-30 03:15:56'),(73,3,2,'ORD-073','AWB-073','Irum Hassan','0333-5073073','Poetry Book','COD',600.00,600.00,'BookMart, Clifton','BookMart, Clifton','Apartment 18F, DHA Phase 4',3,2,3,1,'delivered',0,0,'2026-01-22 12:00:00','2026-01-30 03:15:56'),(74,4,2,'ORD-074','AWB-074','Junaid Raza','0300-5074074','Air Fryer','Prepaid',NULL,8000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 55, Saddar',2,4,2,1,'delivered',0,0,'2026-01-22 13:00:00','2026-01-30 03:15:56'),(75,5,2,'ORD-075','AWB-075','Kamran Akbar','0322-5075075','Swimming Goggles','COD',1200.00,1200.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 33, North Nazimabad',1,5,1,5,'delivered',0,0,'2026-01-22 14:00:00','2026-01-30 03:15:56'),(76,6,2,'ORD-076','AWB-076','Laiba Latif','0301-5076076','Body Lotion','COD',1500.00,1500.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 707, Gulshan Block 13',4,1,4,2,'delivered',0,0,'2026-01-22 15:00:00','2026-01-30 03:15:56'),(77,7,1,'ORD-077','AWB-077','Mohsin Khan','0321-5077077','Robot Toy','COD',3000.00,3000.00,'Kids World, Clifton','Kids World, Clifton','House 44, Clifton Block 8',3,3,3,3,'delivered',0,0,'2026-01-22 16:00:00','2026-01-30 03:15:56'),(78,8,1,'ORD-078','AWB-078','Nida Ali','0333-5078078','Organic Pasta 2kg','Prepaid',NULL,1400.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 40, DHA Phase 5',5,2,5,1,'delivered',0,0,'2026-01-22 17:00:00','2026-01-30 03:15:56'),(79,9,2,'ORD-079','AWB-079','Omer Iqbal','0300-5079079','Car Charger','COD',700.00,700.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 99, Liaquatabad',4,7,4,8,'delivered',0,0,'2026-01-22 18:00:00','2026-01-30 03:15:56'),(80,10,3,'ORD-080','AWB-080','Rabia Tariq','0322-5080080','Center Table','COD',6000.00,6000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 11, Clifton',8,3,8,3,'delivered',0,0,'2026-01-23 09:00:00','2026-01-30 03:15:56'),(81,1,2,'ORD-081','AWB-081','Sana Butt','0301-5081081','Dress - Wrong Size','COD',4000.00,4000.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 22, DHA Phase 2',1,2,1,3,'return',0,0,'2026-01-23 10:00:00','2026-01-30 03:15:56'),(82,2,1,'ORD-082','AWB-082','Tariq Khan','0321-5082082','Laptop - Customer Refused','Prepaid',NULL,35000.00,'TechHub, Saddar','TechHub, Saddar','Flat 101, Gulshan-e-Iqbal',4,1,4,2,'return',0,0,'2026-01-23 11:00:00','2026-01-30 03:15:56'),(83,3,2,'ORD-083','AWB-083','Usman Hassan','0333-5083083','Book - Damaged','COD',1500.00,1500.00,'BookMart, Clifton','BookMart, Clifton','Apartment 20A, North Nazimabad',3,5,3,5,'return',0,0,'2026-01-23 12:00:00','2026-01-30 03:15:56'),(84,4,2,'ORD-084','AWB-084','Waqas Raza','0300-5084084','Juicer - Wrong Item','COD',5000.00,5000.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 77, Clifton Block 2',2,3,2,3,'return',0,0,'2026-01-23 13:00:00','2026-01-30 03:15:56'),(85,5,1,'ORD-085','AWB-085','Yasir Akbar','0322-5085085','Hockey Stick - Customer Not Available','COD',3500.00,3500.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 88, DHA Phase 6',1,2,1,1,'return',0,0,'2026-01-23 14:00:00','2026-01-30 03:15:56'),(86,6,2,'ORD-086','AWB-086','Zainab Latif','0301-5086086','Foundation - Wrong Shade','Prepaid',NULL,2500.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 202, Liaquatabad',4,7,4,8,'return',0,0,'2026-01-23 15:00:00','2026-01-30 03:15:56'),(87,7,2,'ORD-087','AWB-087','Ahmed Khan','0321-5087087','Bike - Incomplete Address','COD',6000.00,6000.00,'Kids World, Clifton','Kids World, Clifton','House Unknown, Saddar',3,4,3,1,'return',0,0,'2026-01-23 16:00:00','2026-01-30 03:15:56'),(88,8,4,'ORD-088','AWB-088','Bilal Ali','0333-5088088','Organic Juice - Customer Refused','COD',1800.00,1800.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 45, Gulshan Block 13',5,1,5,2,'return',0,0,'2026-01-23 17:00:00','2026-01-30 03:15:56'),(89,9,2,'ORD-089','AWB-089','Danish Iqbal','0300-5089089','Phone Holder - Not As Described','COD',1000.00,1000.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House 55, Nazimabad',4,6,4,8,'return',0,0,'2026-01-23 18:00:00','2026-01-30 03:15:56'),(90,10,3,'ORD-090','AWB-090','Erum Tariq','0322-5090090','Bed - Color Mismatch','COD',30000.00,30000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 44, DHA Phase 5',8,2,8,1,'return',0,0,'2026-01-24 09:00:00','2026-01-30 03:15:56'),(91,1,2,'ORD-091','AWB-091','Farhan Butt','0301-5091091','Shirt - Wrong Color','Prepaid',NULL,2000.00,'Shop 12, Zara Plaza, Gulshan-e-Iqbal','Shop 12, Zara Plaza, Gulshan-e-Iqbal','House 33, Clifton',1,3,1,3,'returned',0,0,'2026-01-24 10:00:00','2026-01-30 03:15:56'),(92,2,1,'ORD-092','AWB-092','Hiba Khan','0321-5092092','Headphones - Faulty','COD',4000.00,4000.00,'TechHub, Saddar','TechHub, Saddar','Flat 303, North Nazimabad',4,5,4,5,'returned',0,0,'2026-01-24 11:00:00','2026-01-30 03:15:56'),(93,3,2,'ORD-093','AWB-093','Imran Hassan','0333-5093093','Magazine - Wrong Issue','COD',500.00,500.00,'BookMart, Clifton','BookMart, Clifton','Apartment 25B, DHA Phase 4',3,2,3,1,'returned',0,0,'2026-01-24 12:00:00','2026-01-30 03:15:56'),(94,4,2,'ORD-094','AWB-094','Junaid Raza','0300-5094094','Fan - Not Working','Prepaid',NULL,3500.00,'HomeEssentials, DHA','HomeEssentials, DHA','House 99, Saddar',2,4,2,1,'returned',0,0,'2026-01-24 13:00:00','2026-01-30 03:15:56'),(95,5,2,'ORD-095','AWB-095','Kamran Akbar','0322-5095095','Dumbbells - Incomplete Set','COD',4500.00,4500.00,'Sports Arena, Gulshan','Sports Arena, Gulshan','House 22, Gulshan Block 13',1,1,1,2,'returned',0,0,'2026-01-24 14:00:00','2026-01-30 03:15:56'),(96,6,2,'ORD-096','AWB-096','Laiba Latif','0301-5096096','Skincare Set - Cancelled by Customer','COD',3000.00,3000.00,'Beauty Bliss, Saddar','Beauty Bliss, Saddar','Flat 404, DHA Phase 2',4,2,4,NULL,'cancelled',0,0,'2026-01-24 15:00:00','2026-01-30 03:15:56'),(97,7,1,'ORD-097','AWB-097','Mohsin Khan','0321-5097097','Toy Car - Out of Stock','Prepaid',NULL,2500.00,'Kids World, Clifton','Kids World, Clifton','House 66, Clifton Block 8',3,3,3,NULL,'cancelled',0,0,'2026-01-24 16:00:00','2026-01-30 03:15:56'),(98,8,1,'ORD-098','AWB-098','Nida Ali','0333-5098098','Organic Spices - Cancelled by Shipper','COD',1200.00,1200.00,'Organic Grocers, North Nazimabad','Organic Grocers, North Nazimabad','Apartment 50, Liaquatabad',5,7,5,NULL,'cancelled',0,0,'2026-01-24 17:00:00','2026-01-30 03:15:56'),(99,9,2,'ORD-099','AWB-099','Omer Iqbal','0300-5099099','Selfie Stick - Wrong Address','COD',900.00,900.00,'Mobile Acc Hub, Saddar','Mobile Acc Hub, Saddar','House Invalid, Nazimabad',4,6,4,NULL,'cancelled',0,0,'2026-01-24 18:00:00','2026-01-30 03:15:56'),(100,10,3,'ORD-100','AWB-100','Rabia Tariq','0322-5100100','Mirror - Cancelled by Customer','Prepaid',NULL,5000.00,'Furniture Factory, Korangi','Furniture Factory, Korangi','House 77, Gulshan-e-Iqbal',8,1,8,NULL,'cancelled',0,0,'2026-01-25 09:00:00','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `shipment_assignment`
--

LOCK TABLES `shipment_assignment` WRITE;
/*!40000 ALTER TABLE `shipment_assignment` DISABLE KEYS */;
INSERT INTO `shipment_assignment` VALUES (8,1,'delivery','2026-01-15 18:30:00'),(11,1,'delivery','2026-01-16 12:30:00'),(15,1,'delivery','2026-01-16 16:30:00'),(24,1,'delivery','2026-01-17 15:30:00'),(27,1,'delivery','2026-01-17 18:30:00'),(28,1,'delivery','2026-01-17 19:30:00'),(34,1,'delivery','2026-01-18 15:30:00'),(36,1,'delivery','2026-01-18 17:30:00'),(40,1,'delivery','2026-01-19 11:30:00'),(43,1,'delivery','2026-01-19 14:30:00'),(44,1,'delivery','2026-01-19 15:30:00'),(48,1,'delivery','2026-01-19 19:30:00'),(51,1,'delivery','2026-01-20 12:30:00'),(55,1,'delivery','2026-01-20 16:30:00'),(57,1,'delivery','2026-01-20 18:30:00'),(60,1,'delivery','2026-01-21 11:30:00'),(64,1,'delivery','2026-01-21 15:30:00'),(66,1,'delivery','2026-01-21 17:30:00'),(67,1,'delivery','2026-01-21 18:30:00'),(73,1,'delivery','2026-01-22 14:30:00'),(74,1,'delivery','2026-01-22 15:30:00'),(78,1,'delivery','2026-01-22 19:30:00'),(85,1,'return','2026-01-23 16:30:00'),(87,1,'return','2026-01-23 18:30:00'),(90,1,'return','2026-01-24 11:30:00'),(93,1,'return','2026-01-24 14:30:00'),(94,1,'return','2026-01-24 15:30:00'),(2,2,'delivery','2026-01-15 12:30:00'),(7,2,'delivery','2026-01-15 17:30:00'),(13,2,'delivery','2026-01-16 14:30:00'),(18,2,'delivery','2026-01-16 19:30:00'),(22,2,'delivery','2026-01-17 13:30:00'),(26,2,'delivery','2026-01-17 17:30:00'),(30,2,'delivery','2026-01-18 11:30:00'),(35,2,'delivery','2026-01-18 16:30:00'),(41,2,'delivery','2026-01-19 12:30:00'),(46,2,'delivery','2026-01-19 17:30:00'),(52,2,'delivery','2026-01-20 13:30:00'),(58,2,'delivery','2026-01-20 19:30:00'),(65,2,'delivery','2026-01-21 16:30:00'),(70,2,'delivery','2026-01-22 11:30:00'),(76,2,'delivery','2026-01-22 17:30:00'),(82,2,'return','2026-01-23 13:30:00'),(88,2,'return','2026-01-23 19:30:00'),(90,2,'pickup','2026-01-24 10:00:00'),(95,2,'return','2026-01-24 16:30:00'),(1,3,'delivery','2026-01-15 11:30:00'),(1,3,'pickup','2026-01-15 10:00:00'),(3,3,'pickup','2026-01-15 12:00:00'),(4,3,'delivery','2026-01-15 14:30:00'),(4,3,'pickup','2026-01-15 13:00:00'),(5,3,'delivery','2026-01-15 15:30:00'),(5,3,'pickup','2026-01-15 14:00:00'),(7,3,'pickup','2026-01-15 16:00:00'),(10,3,'delivery','2026-01-16 11:30:00'),(11,3,'pickup','2026-01-16 11:00:00'),(13,3,'pickup','2026-01-16 13:00:00'),(14,3,'delivery','2026-01-16 15:30:00'),(14,3,'pickup','2026-01-16 14:00:00'),(15,3,'pickup','2026-01-16 15:00:00'),(17,3,'delivery','2026-01-16 18:30:00'),(17,3,'pickup','2026-01-16 17:00:00'),(20,3,'delivery','2026-01-17 11:30:00'),(21,3,'delivery','2026-01-17 12:30:00'),(21,3,'pickup','2026-01-17 11:00:00'),(23,3,'pickup','2026-01-17 13:00:00'),(24,3,'pickup','2026-01-17 14:00:00'),(25,3,'delivery','2026-01-17 16:30:00'),(25,3,'pickup','2026-01-17 15:00:00'),(27,3,'pickup','2026-01-17 17:00:00'),(31,3,'delivery','2026-01-18 12:30:00'),(31,3,'pickup','2026-01-18 11:00:00'),(33,3,'delivery','2026-01-18 14:30:00'),(33,3,'pickup','2026-01-18 13:00:00'),(34,3,'pickup','2026-01-18 14:00:00'),(35,3,'pickup','2026-01-18 15:00:00'),(37,3,'delivery','2026-01-18 18:30:00'),(37,3,'pickup','2026-01-18 17:00:00'),(41,3,'pickup','2026-01-19 11:00:00'),(42,3,'delivery','2026-01-19 13:30:00'),(43,3,'pickup','2026-01-19 13:00:00'),(44,3,'pickup','2026-01-19 14:00:00'),(45,3,'pickup','2026-01-19 15:00:00'),(47,3,'delivery','2026-01-19 18:30:00'),(47,3,'pickup','2026-01-19 17:00:00'),(50,3,'delivery','2026-01-20 11:30:00'),(51,3,'pickup','2026-01-20 11:00:00'),(53,3,'pickup','2026-01-20 13:00:00'),(54,3,'delivery','2026-01-20 15:30:00'),(54,3,'pickup','2026-01-20 14:00:00'),(55,3,'pickup','2026-01-20 15:00:00'),(57,3,'pickup','2026-01-20 17:00:00'),(61,3,'delivery','2026-01-21 12:30:00'),(61,3,'pickup','2026-01-21 11:00:00'),(63,3,'delivery','2026-01-21 14:30:00'),(63,3,'pickup','2026-01-21 13:00:00'),(64,3,'pickup','2026-01-21 14:00:00'),(65,3,'pickup','2026-01-21 15:00:00'),(67,3,'pickup','2026-01-21 17:00:00'),(71,3,'delivery','2026-01-22 12:30:00'),(71,3,'pickup','2026-01-22 11:00:00'),(72,3,'delivery','2026-01-22 13:30:00'),(73,3,'pickup','2026-01-22 13:00:00'),(74,3,'pickup','2026-01-22 14:00:00'),(75,3,'pickup','2026-01-22 15:00:00'),(77,3,'delivery','2026-01-22 18:30:00'),(77,3,'pickup','2026-01-22 17:00:00'),(80,3,'delivery','2026-01-23 11:30:00'),(81,3,'pickup','2026-01-23 11:00:00'),(81,3,'return','2026-01-23 12:30:00'),(83,3,'pickup','2026-01-23 13:00:00'),(84,3,'pickup','2026-01-23 14:00:00'),(84,3,'return','2026-01-23 15:30:00'),(85,3,'pickup','2026-01-23 15:00:00'),(87,3,'pickup','2026-01-23 17:00:00'),(91,3,'pickup','2026-01-24 11:00:00'),(91,3,'return','2026-01-24 12:30:00'),(93,3,'pickup','2026-01-24 13:00:00'),(94,3,'pickup','2026-01-24 14:00:00'),(95,3,'pickup','2026-01-24 15:00:00'),(10,4,'pickup','2026-01-16 10:00:00'),(20,4,'pickup','2026-01-17 10:00:00'),(30,4,'pickup','2026-01-18 10:00:00'),(40,4,'pickup','2026-01-19 10:00:00'),(50,4,'pickup','2026-01-20 10:00:00'),(60,4,'pickup','2026-01-21 10:00:00'),(70,4,'pickup','2026-01-22 10:00:00'),(80,4,'pickup','2026-01-23 10:00:00'),(3,5,'delivery','2026-01-15 13:30:00'),(8,5,'pickup','2026-01-15 17:00:00'),(12,5,'delivery','2026-01-16 13:30:00'),(18,5,'pickup','2026-01-16 18:00:00'),(23,5,'delivery','2026-01-17 14:30:00'),(28,5,'pickup','2026-01-17 18:00:00'),(32,5,'delivery','2026-01-18 13:30:00'),(38,5,'pickup','2026-01-18 18:00:00'),(45,5,'delivery','2026-01-19 16:30:00'),(48,5,'pickup','2026-01-19 18:00:00'),(53,5,'delivery','2026-01-20 14:30:00'),(58,5,'pickup','2026-01-20 18:00:00'),(62,5,'delivery','2026-01-21 13:30:00'),(68,5,'pickup','2026-01-21 18:00:00'),(75,5,'delivery','2026-01-22 16:30:00'),(78,5,'pickup','2026-01-22 18:00:00'),(83,5,'return','2026-01-23 14:30:00'),(88,5,'pickup','2026-01-23 18:00:00'),(92,5,'return','2026-01-24 13:30:00'),(2,8,'pickup','2026-01-15 11:00:00'),(6,8,'delivery','2026-01-15 16:30:00'),(6,8,'pickup','2026-01-15 15:00:00'),(9,8,'delivery','2026-01-15 19:30:00'),(9,8,'pickup','2026-01-15 18:00:00'),(12,8,'pickup','2026-01-16 12:00:00'),(16,8,'delivery','2026-01-16 17:30:00'),(16,8,'pickup','2026-01-16 16:00:00'),(19,8,'delivery','2026-01-16 20:30:00'),(19,8,'pickup','2026-01-16 19:00:00'),(22,8,'pickup','2026-01-17 12:00:00'),(26,8,'pickup','2026-01-17 16:00:00'),(29,8,'delivery','2026-01-17 20:30:00'),(29,8,'pickup','2026-01-17 19:00:00'),(32,8,'pickup','2026-01-18 12:00:00'),(36,8,'pickup','2026-01-18 16:00:00'),(38,8,'delivery','2026-01-18 19:30:00'),(39,8,'delivery','2026-01-18 20:30:00'),(39,8,'pickup','2026-01-18 19:00:00'),(42,8,'pickup','2026-01-19 12:00:00'),(46,8,'pickup','2026-01-19 16:00:00'),(49,8,'delivery','2026-01-19 20:30:00'),(49,8,'pickup','2026-01-19 19:00:00'),(52,8,'pickup','2026-01-20 12:00:00'),(56,8,'delivery','2026-01-20 17:30:00'),(56,8,'pickup','2026-01-20 16:00:00'),(59,8,'delivery','2026-01-20 20:30:00'),(59,8,'pickup','2026-01-20 19:00:00'),(62,8,'pickup','2026-01-21 12:00:00'),(66,8,'pickup','2026-01-21 16:00:00'),(68,8,'delivery','2026-01-21 19:30:00'),(69,8,'delivery','2026-01-21 20:30:00'),(69,8,'pickup','2026-01-21 19:00:00'),(72,8,'pickup','2026-01-22 12:00:00'),(76,8,'pickup','2026-01-22 16:00:00'),(79,8,'delivery','2026-01-22 20:30:00'),(79,8,'pickup','2026-01-22 19:00:00'),(82,8,'pickup','2026-01-23 12:00:00'),(86,8,'pickup','2026-01-23 16:00:00'),(86,8,'return','2026-01-23 17:30:00'),(89,8,'pickup','2026-01-23 19:00:00'),(89,8,'return','2026-01-23 20:30:00'),(92,8,'pickup','2026-01-24 12:00:00');
/*!40000 ALTER TABLE `shipment_assignment` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `shipment_collection`
--

LOCK TABLES `shipment_collection` WRITE;
/*!40000 ALTER TABLE `shipment_collection` DISABLE KEYS */;
INSERT INTO `shipment_collection` VALUES (1,1,3,2500.00,'cash','2026-01-15 15:00:00',0,NULL,'2026-01-30 03:15:56'),(2,3,5,800.00,'cash','2026-01-15 17:00:00',0,NULL,'2026-01-30 03:15:56'),(3,5,3,5000.00,'cash','2026-01-15 19:00:00',0,NULL,'2026-01-30 03:15:56'),(4,6,8,1200.00,'cash','2026-01-15 20:00:00',0,NULL,'2026-01-30 03:15:56'),(5,8,1,1800.00,'cash','2026-01-15 22:00:00',0,NULL,'2026-01-30 03:15:56'),(6,9,8,600.00,'cash','2026-01-15 23:00:00',0,NULL,'2026-01-30 03:15:56'),(7,11,1,1500.00,'cash','2026-01-16 16:00:00',0,NULL,'2026-01-30 03:15:56'),(8,13,2,1200.00,'cash','2026-01-16 18:00:00',0,NULL,'2026-01-30 03:15:56'),(9,14,3,4000.00,'cash','2026-01-16 19:00:00',0,NULL,'2026-01-30 03:15:56'),(10,16,8,900.00,'cash','2026-01-16 21:00:00',0,NULL,'2026-01-30 03:15:56'),(11,17,3,3500.00,'cash','2026-01-16 22:00:00',0,NULL,'2026-01-30 03:15:56'),(12,19,8,1000.00,'cash','2026-01-17 00:00:00',0,NULL,'2026-01-30 03:15:56'),(13,21,3,3000.00,'cash','2026-01-17 16:00:00',0,NULL,'2026-01-30 03:15:56'),(14,23,5,1100.00,'cash','2026-01-17 18:00:00',0,NULL,'2026-01-30 03:15:56'),(15,24,1,15000.00,'cash','2026-01-17 19:00:00',0,NULL,'2026-01-30 03:15:56'),(16,26,2,3500.00,'cash','2026-01-17 21:00:00',0,NULL,'2026-01-30 03:15:56'),(17,27,1,5000.00,'cash','2026-01-17 22:00:00',0,NULL,'2026-01-30 03:15:56'),(18,29,8,500.00,'cash','2026-01-18 00:00:00',0,NULL,'2026-01-30 03:15:56'),(19,30,2,8000.00,'cash','2026-01-18 15:00:00',0,NULL,'2026-01-30 03:15:56'),(20,32,5,2000.00,'cash','2026-01-18 17:00:00',0,NULL,'2026-01-30 03:15:56'),(21,33,3,700.00,'cash','2026-01-18 18:00:00',0,NULL,'2026-01-30 03:15:56'),(22,35,2,3000.00,'cash','2026-01-18 20:00:00',0,NULL,'2026-01-30 03:15:56'),(23,36,1,2500.00,'cash','2026-01-18 21:00:00',0,NULL,'2026-01-30 03:15:56'),(24,38,8,2000.00,'cash','2026-01-18 23:00:00',0,NULL,'2026-01-30 03:15:56'),(25,39,8,1500.00,'cash','2026-01-19 00:00:00',0,NULL,'2026-01-30 03:15:56'),(26,41,2,800.00,'cash','2026-01-19 16:00:00',0,NULL,'2026-01-30 03:15:56'),(27,42,3,3500.00,'cash','2026-01-19 17:00:00',0,NULL,'2026-01-30 03:15:56'),(28,44,1,4500.00,'cash','2026-01-19 19:00:00',0,NULL,'2026-01-30 03:15:56'),(29,45,5,3500.00,'cash','2026-01-19 20:00:00',0,NULL,'2026-01-30 03:15:56'),(30,47,3,2500.00,'cash','2026-01-19 22:00:00',0,NULL,'2026-01-30 03:15:56'),(31,48,1,2200.00,'cash','2026-01-19 23:00:00',0,NULL,'2026-01-30 03:15:56'),(32,49,8,2500.00,'cash','2026-01-20 00:00:00',0,NULL,'2026-01-30 03:15:56'),(33,51,1,5000.00,'cash','2026-01-20 16:00:00',0,NULL,'2026-01-30 03:15:56'),(34,53,5,1300.00,'cash','2026-01-20 18:00:00',0,NULL,'2026-01-30 03:15:56'),(35,54,3,3000.00,'cash','2026-01-20 19:00:00',0,NULL,'2026-01-30 03:15:56'),(36,55,1,2000.00,'cash','2026-01-20 20:00:00',0,NULL,'2026-01-30 03:15:56'),(37,57,1,1800.00,'cash','2026-01-20 22:00:00',0,NULL,'2026-01-30 03:15:56'),(38,58,2,3500.00,'cash','2026-01-20 23:00:00',0,NULL,'2026-01-30 03:15:56'),(39,60,1,20000.00,'cash','2026-01-21 15:00:00',0,NULL,'2026-01-30 03:15:56'),(40,61,3,1500.00,'cash','2026-01-21 16:00:00',0,NULL,'2026-01-30 03:15:56'),(41,63,3,1000.00,'cash','2026-01-21 18:00:00',0,NULL,'2026-01-30 03:15:56'),(42,64,1,12000.00,'cash','2026-01-21 19:00:00',0,NULL,'2026-01-30 03:15:56'),(43,66,1,1800.00,'cash','2026-01-21 21:00:00',0,NULL,'2026-01-30 03:15:56'),(44,67,1,4500.00,'cash','2026-01-21 22:00:00',0,NULL,'2026-01-30 03:15:56'),(45,69,8,800.00,'cash','2026-01-22 00:00:00',0,NULL,'2026-01-30 03:15:56'),(46,70,2,7000.00,'cash','2026-01-22 15:00:00',0,NULL,'2026-01-30 03:15:56'),(47,72,3,50000.00,'cash','2026-01-22 17:00:00',0,NULL,'2026-01-30 03:15:56'),(48,73,1,600.00,'cash','2026-01-22 18:00:00',0,NULL,'2026-01-30 03:15:56'),(49,75,5,1200.00,'cash','2026-01-22 20:00:00',0,NULL,'2026-01-30 03:15:56'),(50,76,2,1500.00,'cash','2026-01-22 21:00:00',0,NULL,'2026-01-30 03:15:56'),(51,77,3,3000.00,'cash','2026-01-22 22:00:00',0,NULL,'2026-01-30 03:15:56'),(52,79,8,700.00,'cash','2026-01-23 00:00:00',0,NULL,'2026-01-30 03:15:56'),(53,80,3,6000.00,'cash','2026-01-23 15:00:00',0,NULL,'2026-01-30 03:15:56');
/*!40000 ALTER TABLE `shipment_collection` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `shipper`
--

LOCK TABLES `shipper` WRITE;
/*!40000 ALTER TABLE `shipper` DISABLE KEYS */;
INSERT INTO `shipper` VALUES (1,'Zara Fashion Store','orders@zarafashion.pk','0300-1234567',250.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,'TechHub Electronics','sales@techhub.pk','0321-9876543',300.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,'BookMart Pakistan','info@bookmart.pk','0333-5555555',200.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,'HomeEssentials Online','contact@homeessentials.pk','0300-7777777',220.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,'Sports Arena','orders@sportsarena.pk','0322-8888888',240.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,'Beauty Bliss','hello@beautybliss.pk','0301-9999999',200.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,'Kids World','support@kidsworld.pk','0321-1111111',210.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,'Organic Grocers','sales@organicgrocers.pk','0333-2222222',280.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(9,'Mobile Accessories Hub','info@mobileacc.pk','0300-3333333',180.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56'),(10,'Furniture Factory','orders@furniturefactory.pk','0322-4444444',350.00,'active','2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `shipper` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `shipper_service`
--

LOCK TABLES `shipper_service` WRITE;
/*!40000 ALTER TABLE `shipper_service` DISABLE KEYS */;
INSERT INTO `shipper_service` VALUES (1,1,1,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(2,1,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(3,1,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(4,2,1,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(5,2,4,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(6,3,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(7,3,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(8,4,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(9,4,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(10,5,1,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(11,5,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(12,6,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(13,6,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(14,7,1,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(15,7,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(16,7,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(17,8,1,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(18,8,4,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(19,9,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(20,9,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(21,10,3,1,'2026-01-30 03:15:56','2026-01-30 03:15:56'),(22,10,2,1,'2026-01-30 03:15:56','2026-01-30 03:15:56');
/*!40000 ALTER TABLE `shipper_service` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tracking_event`
--

LOCK TABLES `tracking_event` WRITE;
/*!40000 ALTER TABLE `tracking_event` DISABLE KEYS */;
INSERT INTO `tracking_event` VALUES (1,1,NULL,'booked',24.86070000,67.00110000,'Order created','2026-01-15 09:00:00'),(2,1,2,'picked',24.86070000,67.00110000,'Picked from shipper','2026-01-15 11:00:00'),(3,1,3,'delivered',24.81380000,67.06800000,'Delivered successfully','2026-01-15 16:00:00'),(4,2,NULL,'booked',24.86150000,67.00990000,'Order created','2026-01-15 10:00:00'),(5,2,2,'picked',24.86150000,67.00990000,'Picked from shipper','2026-01-15 11:30:00'),(6,2,2,'delivered',24.90560000,67.08220000,'Delivered successfully','2026-01-15 15:00:00'),(7,3,NULL,'booked',24.81380000,67.06800000,'Order created','2026-01-15 11:00:00'),(8,3,3,'picked',24.81380000,67.06800000,'Picked from shipper','2026-01-15 13:00:00'),(9,3,5,'delivered',24.92070000,67.08200000,'Delivered successfully','2026-01-15 17:00:00'),(10,4,NULL,'booked',24.81380000,67.06800000,'Order created','2026-01-15 12:00:00'),(11,4,1,'picked',24.81380000,67.06800000,'Picked from shipper','2026-01-15 13:30:00'),(12,4,3,'delivered',24.81380000,67.07000000,'Delivered successfully','2026-01-15 17:30:00'),(13,5,NULL,'booked',24.90560000,67.08220000,'Order created','2026-01-15 13:00:00'),(14,5,2,'picked',24.90560000,67.08220000,'Picked from shipper','2026-01-15 14:30:00'),(15,5,3,'delivered',24.81380000,67.06800000,'Delivered successfully','2026-01-15 18:00:00'),(16,6,NULL,'booked',NULL,NULL,'Order created','2026-01-15 14:00:00'),(17,6,8,'picked',NULL,NULL,'Picked from shipper','2026-01-15 15:30:00'),(18,6,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-15 19:00:00'),(19,7,NULL,'booked',NULL,NULL,'Order created','2026-01-15 15:00:00'),(20,7,2,'picked',NULL,NULL,'Picked from shipper','2026-01-15 16:30:00'),(21,7,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-15 20:00:00'),(22,8,NULL,'booked',NULL,NULL,'Order created','2026-01-15 16:00:00'),(23,8,5,'picked',NULL,NULL,'Picked from shipper','2026-01-15 17:30:00'),(24,8,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-15 21:00:00'),(25,9,NULL,'booked',NULL,NULL,'Order created','2026-01-15 17:00:00'),(26,9,8,'picked',NULL,NULL,'Picked from shipper','2026-01-15 18:30:00'),(27,9,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-15 22:00:00'),(28,10,NULL,'booked',NULL,NULL,'Order created','2026-01-16 09:00:00'),(29,10,4,'picked',NULL,NULL,'Picked from shipper','2026-01-16 10:30:00'),(30,10,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 14:00:00'),(31,11,NULL,'booked',NULL,NULL,'Order created','2026-01-16 10:00:00'),(32,12,NULL,'booked',NULL,NULL,'Order created','2026-01-16 11:00:00'),(33,13,NULL,'booked',NULL,NULL,'Order created','2026-01-16 12:00:00'),(34,14,NULL,'booked',NULL,NULL,'Order created','2026-01-16 13:00:00'),(35,15,NULL,'booked',NULL,NULL,'Order created','2026-01-16 14:00:00'),(36,16,NULL,'booked',NULL,NULL,'Order created','2026-01-16 15:00:00'),(37,17,NULL,'booked',NULL,NULL,'Order created','2026-01-16 16:00:00'),(38,18,NULL,'booked',NULL,NULL,'Order created','2026-01-16 17:00:00'),(39,19,NULL,'booked',NULL,NULL,'Order created','2026-01-16 18:00:00'),(40,20,NULL,'booked',NULL,NULL,'Order created','2026-01-17 09:00:00'),(41,21,NULL,'booked',NULL,NULL,'Order created','2026-01-17 10:00:00'),(42,22,NULL,'booked',NULL,NULL,'Order created','2026-01-17 11:00:00'),(43,23,NULL,'booked',NULL,NULL,'Order created','2026-01-17 12:00:00'),(44,24,NULL,'booked',NULL,NULL,'Order created','2026-01-17 13:00:00'),(45,25,NULL,'booked',NULL,NULL,'Order created','2026-01-17 14:00:00'),(46,26,NULL,'booked',NULL,NULL,'Order created','2026-01-17 15:00:00'),(47,27,NULL,'booked',NULL,NULL,'Order created','2026-01-17 16:00:00'),(48,28,NULL,'booked',NULL,NULL,'Order created','2026-01-17 17:00:00'),(49,29,NULL,'booked',NULL,NULL,'Order created','2026-01-17 18:00:00'),(50,30,NULL,'booked',NULL,NULL,'Order created','2026-01-18 09:00:00'),(51,31,NULL,'booked',NULL,NULL,'Order created','2026-01-18 10:00:00'),(52,32,NULL,'booked',NULL,NULL,'Order created','2026-01-18 11:00:00'),(53,33,NULL,'booked',NULL,NULL,'Order created','2026-01-18 12:00:00'),(54,34,NULL,'booked',NULL,NULL,'Order created','2026-01-18 13:00:00'),(55,35,NULL,'booked',NULL,NULL,'Order created','2026-01-18 14:00:00'),(56,36,NULL,'booked',NULL,NULL,'Order created','2026-01-18 15:00:00'),(57,37,NULL,'booked',NULL,NULL,'Order created','2026-01-18 16:00:00'),(58,38,NULL,'booked',NULL,NULL,'Order created','2026-01-18 17:00:00'),(59,39,NULL,'booked',NULL,NULL,'Order created','2026-01-18 18:00:00'),(60,40,NULL,'booked',NULL,NULL,'Order created','2026-01-19 09:00:00'),(61,41,NULL,'booked',NULL,NULL,'Order created','2026-01-19 10:00:00'),(62,42,NULL,'booked',NULL,NULL,'Order created','2026-01-19 11:00:00'),(63,43,NULL,'booked',NULL,NULL,'Order created','2026-01-19 12:00:00'),(64,44,NULL,'booked',NULL,NULL,'Order created','2026-01-19 13:00:00'),(65,45,NULL,'booked',NULL,NULL,'Order created','2026-01-19 14:00:00'),(66,46,NULL,'booked',NULL,NULL,'Order created','2026-01-19 15:00:00'),(67,47,NULL,'booked',NULL,NULL,'Order created','2026-01-19 16:00:00'),(68,48,NULL,'booked',NULL,NULL,'Order created','2026-01-19 17:00:00'),(69,49,NULL,'booked',NULL,NULL,'Order created','2026-01-19 18:00:00'),(70,50,NULL,'booked',NULL,NULL,'Order created','2026-01-20 09:00:00'),(71,51,NULL,'booked',NULL,NULL,'Order created','2026-01-20 10:00:00'),(72,52,NULL,'booked',NULL,NULL,'Order created','2026-01-20 11:00:00'),(73,53,NULL,'booked',NULL,NULL,'Order created','2026-01-20 12:00:00'),(74,54,NULL,'booked',NULL,NULL,'Order created','2026-01-20 13:00:00'),(75,55,NULL,'booked',NULL,NULL,'Order created','2026-01-20 14:00:00'),(76,56,NULL,'booked',NULL,NULL,'Order created','2026-01-20 15:00:00'),(77,57,NULL,'booked',NULL,NULL,'Order created','2026-01-20 16:00:00'),(78,58,NULL,'booked',NULL,NULL,'Order created','2026-01-20 17:00:00'),(79,59,NULL,'booked',NULL,NULL,'Order created','2026-01-20 18:00:00'),(80,60,NULL,'booked',NULL,NULL,'Order created','2026-01-21 09:00:00'),(81,61,NULL,'booked',NULL,NULL,'Order created','2026-01-21 10:00:00'),(82,62,NULL,'booked',NULL,NULL,'Order created','2026-01-21 11:00:00'),(83,63,NULL,'booked',NULL,NULL,'Order created','2026-01-21 12:00:00'),(84,64,NULL,'booked',NULL,NULL,'Order created','2026-01-21 13:00:00'),(85,65,NULL,'booked',NULL,NULL,'Order created','2026-01-21 14:00:00'),(86,66,NULL,'booked',NULL,NULL,'Order created','2026-01-21 15:00:00'),(87,67,NULL,'booked',NULL,NULL,'Order created','2026-01-21 16:00:00'),(88,68,NULL,'booked',NULL,NULL,'Order created','2026-01-21 17:00:00'),(89,69,NULL,'booked',NULL,NULL,'Order created','2026-01-21 18:00:00'),(90,70,NULL,'booked',NULL,NULL,'Order created','2026-01-22 09:00:00'),(91,71,NULL,'booked',NULL,NULL,'Order created','2026-01-22 10:00:00'),(92,72,NULL,'booked',NULL,NULL,'Order created','2026-01-22 11:00:00'),(93,73,NULL,'booked',NULL,NULL,'Order created','2026-01-22 12:00:00'),(94,74,NULL,'booked',NULL,NULL,'Order created','2026-01-22 13:00:00'),(95,75,NULL,'booked',NULL,NULL,'Order created','2026-01-22 14:00:00'),(96,76,NULL,'booked',NULL,NULL,'Order created','2026-01-22 15:00:00'),(97,77,NULL,'booked',NULL,NULL,'Order created','2026-01-22 16:00:00'),(98,78,NULL,'booked',NULL,NULL,'Order created','2026-01-22 17:00:00'),(99,79,NULL,'booked',NULL,NULL,'Order created','2026-01-22 18:00:00'),(100,80,NULL,'booked',NULL,NULL,'Order created','2026-01-23 09:00:00'),(158,11,3,'picked',NULL,NULL,'Picked from shipper','2026-01-16 12:00:00'),(159,12,5,'picked',NULL,NULL,'Picked from shipper','2026-01-16 13:00:00'),(160,13,3,'picked',NULL,NULL,'Picked from shipper','2026-01-16 14:00:00'),(161,14,3,'picked',NULL,NULL,'Picked from shipper','2026-01-16 15:00:00'),(162,15,2,'picked',NULL,NULL,'Picked from shipper','2026-01-16 16:00:00'),(163,16,5,'picked',NULL,NULL,'Picked from shipper','2026-01-16 17:00:00'),(164,17,3,'picked',NULL,NULL,'Picked from shipper','2026-01-16 18:00:00'),(165,18,3,'picked',NULL,NULL,'Picked from shipper','2026-01-16 19:00:00'),(166,19,5,'picked',NULL,NULL,'Picked from shipper','2026-01-16 20:00:00'),(167,20,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 11:00:00'),(168,21,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 12:00:00'),(169,22,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 13:00:00'),(170,23,5,'picked',NULL,NULL,'Picked from shipper','2026-01-17 14:00:00'),(171,24,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 15:00:00'),(172,25,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 16:00:00'),(173,26,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 17:00:00'),(174,27,3,'picked',NULL,NULL,'Picked from shipper','2026-01-17 18:00:00'),(175,28,2,'picked',NULL,NULL,'Picked from shipper','2026-01-17 19:00:00'),(176,29,5,'picked',NULL,NULL,'Picked from shipper','2026-01-17 20:00:00'),(177,30,3,'picked',NULL,NULL,'Picked from shipper','2026-01-18 11:00:00'),(178,31,3,'picked',NULL,NULL,'Picked from shipper','2026-01-18 12:00:00'),(179,32,5,'picked',NULL,NULL,'Picked from shipper','2026-01-18 13:00:00'),(180,33,3,'picked',NULL,NULL,'Picked from shipper','2026-01-18 14:00:00'),(181,34,2,'picked',NULL,NULL,'Picked from shipper','2026-01-18 15:00:00'),(182,35,3,'picked',NULL,NULL,'Picked from shipper','2026-01-18 16:00:00'),(183,36,3,'picked',NULL,NULL,'Picked from shipper','2026-01-18 17:00:00'),(184,37,3,'picked',NULL,NULL,'Picked from shipper','2026-01-18 18:00:00'),(185,38,5,'picked',NULL,NULL,'Picked from shipper','2026-01-18 19:00:00'),(186,39,5,'picked',NULL,NULL,'Picked from shipper','2026-01-18 20:00:00'),(187,40,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 11:00:00'),(188,41,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 12:00:00'),(189,42,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 13:00:00'),(190,43,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 14:00:00'),(191,44,2,'picked',NULL,NULL,'Picked from shipper','2026-01-19 15:00:00'),(192,45,5,'picked',NULL,NULL,'Picked from shipper','2026-01-19 16:00:00'),(193,46,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 17:00:00'),(194,47,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 18:00:00'),(195,48,3,'picked',NULL,NULL,'Picked from shipper','2026-01-19 19:00:00'),(196,49,5,'picked',NULL,NULL,'Picked from shipper','2026-01-19 20:00:00'),(197,50,3,'picked',NULL,NULL,'Picked from shipper','2026-01-20 11:00:00'),(198,51,3,'picked',NULL,NULL,'Picked from shipper','2026-01-20 12:00:00'),(199,52,3,'picked',NULL,NULL,'Picked from shipper','2026-01-20 13:00:00'),(200,53,5,'picked',NULL,NULL,'Picked from shipper','2026-01-20 14:00:00'),(201,54,3,'picked',NULL,NULL,'Picked from shipper','2026-01-20 15:00:00'),(202,55,2,'picked',NULL,NULL,'Picked from shipper','2026-01-20 16:00:00'),(203,56,5,'picked',NULL,NULL,'Picked from shipper','2026-01-20 17:00:00'),(204,57,3,'picked',NULL,NULL,'Picked from shipper','2026-01-20 18:00:00'),(205,58,3,'picked',NULL,NULL,'Picked from shipper','2026-01-20 19:00:00'),(206,59,5,'picked',NULL,NULL,'Picked from shipper','2026-01-20 20:00:00'),(207,60,3,'picked',NULL,NULL,'Picked from shipper','2026-01-21 11:00:00'),(208,61,3,'picked',NULL,NULL,'Picked from shipper','2026-01-21 12:00:00'),(209,62,5,'picked',NULL,NULL,'Picked from shipper','2026-01-21 13:00:00'),(210,63,3,'picked',NULL,NULL,'Picked from shipper','2026-01-21 14:00:00'),(211,64,3,'picked',NULL,NULL,'Picked from shipper','2026-01-21 15:00:00'),(212,65,3,'picked',NULL,NULL,'Picked from shipper','2026-01-21 16:00:00'),(213,66,3,'picked',NULL,NULL,'Picked from shipper','2026-01-21 17:00:00'),(214,67,2,'picked',NULL,NULL,'Picked from shipper','2026-01-21 18:00:00'),(215,68,5,'picked',NULL,NULL,'Picked from shipper','2026-01-21 19:00:00'),(216,69,5,'picked',NULL,NULL,'Picked from shipper','2026-01-21 20:00:00'),(217,70,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 11:00:00'),(218,71,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 12:00:00'),(219,72,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 13:00:00'),(220,73,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 14:00:00'),(221,74,2,'picked',NULL,NULL,'Picked from shipper','2026-01-22 15:00:00'),(222,75,5,'picked',NULL,NULL,'Picked from shipper','2026-01-22 16:00:00'),(223,76,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 17:00:00'),(224,77,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 18:00:00'),(225,78,3,'picked',NULL,NULL,'Picked from shipper','2026-01-22 19:00:00'),(226,79,5,'picked',NULL,NULL,'Picked from shipper','2026-01-22 20:00:00'),(227,80,3,'picked',NULL,NULL,'Picked from shipper','2026-01-23 11:00:00'),(285,11,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 16:00:00'),(286,12,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 17:00:00'),(287,13,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 18:00:00'),(288,14,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 19:00:00'),(289,15,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 20:00:00'),(290,16,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 21:00:00'),(291,17,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 22:00:00'),(292,18,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-16 23:00:00'),(293,19,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 00:00:00'),(294,20,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 15:00:00'),(295,21,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 16:00:00'),(296,22,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 17:00:00'),(297,23,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 18:00:00'),(298,24,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 19:00:00'),(299,25,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 20:00:00'),(300,26,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 21:00:00'),(301,27,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 22:00:00'),(302,28,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-17 23:00:00'),(303,29,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 00:00:00'),(304,30,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 15:00:00'),(305,31,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 16:00:00'),(306,32,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 17:00:00'),(307,33,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 18:00:00'),(308,34,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 19:00:00'),(309,35,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 20:00:00'),(310,36,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 21:00:00'),(311,37,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 22:00:00'),(312,38,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-18 23:00:00'),(313,39,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 00:00:00'),(314,40,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 15:00:00'),(315,41,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 16:00:00'),(316,42,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 17:00:00'),(317,43,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 18:00:00'),(318,44,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 19:00:00'),(319,45,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 20:00:00'),(320,46,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 21:00:00'),(321,47,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 22:00:00'),(322,48,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-19 23:00:00'),(323,49,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 00:00:00'),(324,50,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 15:00:00'),(325,51,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 16:00:00'),(326,52,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 17:00:00'),(327,53,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 18:00:00'),(328,54,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 19:00:00'),(329,55,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 20:00:00'),(330,56,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 21:00:00'),(331,57,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 22:00:00'),(332,58,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-20 23:00:00'),(333,59,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 00:00:00'),(334,60,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 15:00:00'),(335,61,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 16:00:00'),(336,62,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 17:00:00'),(337,63,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 18:00:00'),(338,64,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 19:00:00'),(339,65,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 20:00:00'),(340,66,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 21:00:00'),(341,67,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 22:00:00'),(342,68,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-21 23:00:00'),(343,69,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 00:00:00'),(344,70,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 15:00:00'),(345,71,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 16:00:00'),(346,72,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 17:00:00'),(347,73,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 18:00:00'),(348,74,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 19:00:00'),(349,75,5,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 20:00:00'),(350,76,2,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 21:00:00'),(351,77,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 22:00:00'),(352,78,1,'delivered',NULL,NULL,'Delivered successfully','2026-01-22 23:00:00'),(353,79,8,'delivered',NULL,NULL,'Delivered successfully','2026-01-23 00:00:00'),(354,80,3,'delivered',NULL,NULL,'Delivered successfully','2026-01-23 15:00:00'),(412,81,NULL,'booked',NULL,NULL,'Order created','2026-01-23 10:00:00'),(413,82,NULL,'booked',NULL,NULL,'Order created','2026-01-23 11:00:00'),(414,83,NULL,'booked',NULL,NULL,'Order created','2026-01-23 12:00:00'),(415,84,NULL,'booked',NULL,NULL,'Order created','2026-01-23 13:00:00'),(416,85,NULL,'booked',NULL,NULL,'Order created','2026-01-23 14:00:00'),(417,86,NULL,'booked',NULL,NULL,'Order created','2026-01-23 15:00:00'),(418,87,NULL,'booked',NULL,NULL,'Order created','2026-01-23 16:00:00'),(419,88,NULL,'booked',NULL,NULL,'Order created','2026-01-23 17:00:00'),(420,89,NULL,'booked',NULL,NULL,'Order created','2026-01-23 18:00:00'),(421,90,NULL,'booked',NULL,NULL,'Order created','2026-01-24 09:00:00'),(427,81,3,'picked',NULL,NULL,'Picked from shipper','2026-01-23 12:00:00'),(428,82,3,'picked',NULL,NULL,'Picked from shipper','2026-01-23 13:00:00'),(429,83,5,'picked',NULL,NULL,'Picked from shipper','2026-01-23 14:00:00'),(430,84,3,'picked',NULL,NULL,'Picked from shipper','2026-01-23 15:00:00'),(431,85,3,'picked',NULL,NULL,'Picked from shipper','2026-01-23 16:00:00'),(432,86,5,'picked',NULL,NULL,'Picked from shipper','2026-01-23 17:00:00'),(433,87,2,'picked',NULL,NULL,'Picked from shipper','2026-01-23 18:00:00'),(434,88,3,'picked',NULL,NULL,'Picked from shipper','2026-01-23 19:00:00'),(435,89,5,'picked',NULL,NULL,'Picked from shipper','2026-01-23 20:00:00'),(436,90,3,'picked',NULL,NULL,'Picked from shipper','2026-01-24 11:00:00'),(442,81,3,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 15:00:00'),(443,82,2,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 16:00:00'),(444,83,5,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 17:00:00'),(445,84,3,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 18:00:00'),(446,85,1,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 19:00:00'),(447,86,8,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 20:00:00'),(448,87,1,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 21:00:00'),(449,88,2,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 22:00:00'),(450,89,8,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-23 23:00:00'),(451,90,1,'return',NULL,NULL,'Customer refused delivery, returning to shipper','2026-01-24 14:00:00'),(457,91,NULL,'booked',NULL,NULL,'Order created','2026-01-24 10:00:00'),(458,92,NULL,'booked',NULL,NULL,'Order created','2026-01-24 11:00:00'),(459,93,NULL,'booked',NULL,NULL,'Order created','2026-01-24 12:00:00'),(460,94,NULL,'booked',NULL,NULL,'Order created','2026-01-24 13:00:00'),(461,95,NULL,'booked',NULL,NULL,'Order created','2026-01-24 14:00:00'),(464,91,3,'picked',NULL,NULL,'Picked from shipper','2026-01-24 12:00:00'),(465,92,5,'picked',NULL,NULL,'Picked from shipper','2026-01-24 13:00:00'),(466,93,3,'picked',NULL,NULL,'Picked from shipper','2026-01-24 14:00:00'),(467,94,2,'picked',NULL,NULL,'Picked from shipper','2026-01-24 15:00:00'),(468,95,3,'picked',NULL,NULL,'Picked from shipper','2026-01-24 16:00:00'),(471,91,3,'return',NULL,NULL,'Customer refused delivery','2026-01-24 15:00:00'),(472,92,5,'return',NULL,NULL,'Customer refused delivery','2026-01-24 16:00:00'),(473,93,1,'return',NULL,NULL,'Customer refused delivery','2026-01-24 17:00:00'),(474,94,1,'return',NULL,NULL,'Customer refused delivery','2026-01-24 18:00:00'),(475,95,2,'return',NULL,NULL,'Customer refused delivery','2026-01-24 19:00:00'),(478,91,3,'returned',NULL,NULL,'Successfully returned to shipper','2026-01-24 18:00:00'),(479,92,5,'returned',NULL,NULL,'Successfully returned to shipper','2026-01-24 19:00:00'),(480,93,1,'returned',NULL,NULL,'Successfully returned to shipper','2026-01-24 20:00:00'),(481,94,1,'returned',NULL,NULL,'Successfully returned to shipper','2026-01-24 21:00:00'),(482,95,2,'returned',NULL,NULL,'Successfully returned to shipper','2026-01-24 22:00:00'),(485,96,NULL,'booked',NULL,NULL,'Order created','2026-01-24 15:00:00'),(486,97,NULL,'booked',NULL,NULL,'Order created','2026-01-24 16:00:00'),(487,98,NULL,'booked',NULL,NULL,'Order created','2026-01-24 17:00:00'),(488,99,NULL,'booked',NULL,NULL,'Order created','2026-01-24 18:00:00'),(489,100,NULL,'booked',NULL,NULL,'Order created','2026-01-25 09:00:00'),(492,96,NULL,'cancelled',NULL,NULL,'Order cancelled before pickup','2026-01-24 16:00:00'),(493,97,NULL,'cancelled',NULL,NULL,'Order cancelled before pickup','2026-01-24 17:00:00'),(494,98,NULL,'cancelled',NULL,NULL,'Order cancelled before pickup','2026-01-24 18:00:00'),(495,99,NULL,'cancelled',NULL,NULL,'Order cancelled before pickup','2026-01-24 19:00:00'),(496,100,NULL,'cancelled',NULL,NULL,'Order cancelled before pickup','2026-01-25 10:00:00');
/*!40000 ALTER TABLE `tracking_event` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2026-01-30 23:36:05
