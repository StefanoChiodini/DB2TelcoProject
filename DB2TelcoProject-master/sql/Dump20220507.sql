CREATE DATABASE  IF NOT EXISTS `dbtest` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbtest`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: dbtest
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `AlertId` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) NOT NULL,
  `Date` date NOT NULL,
  `Hour` datetime NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `FailedOrderId` int NOT NULL,
  PRIMARY KEY (`AlertId`),
  KEY `UserId_idx` (`Username`),
  KEY `FailedOrderId_idx` (`FailedOrderId`),
  CONSTRAINT `FailedOrderId` FOREIGN KEY (`FailedOrderId`) REFERENCES `orders` (`OrderId`),
  CONSTRAINT `UserId` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (2,'insolvent1','2022-04-21','2022-04-21 13:05:09',222.84,'insolvent@mail.com',3);
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `averageoptperpkg`
--

DROP TABLE IF EXISTS `averageoptperpkg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `averageoptperpkg` (
  `PkgId` int NOT NULL,
  `Average` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`PkgId`),
  CONSTRAINT `PkgIdFk2` FOREIGN KEY (`PkgId`) REFERENCES `packages` (`Pkgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `averageoptperpkg`
--

LOCK TABLES `averageoptperpkg` WRITE;
/*!40000 ALTER TABLE `averageoptperpkg` DISABLE KEYS */;
INSERT INTO `averageoptperpkg` VALUES (1,0.00),(2,2.00);
/*!40000 ALTER TABLE `averageoptperpkg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connectedproducts`
--

DROP TABLE IF EXISTS `connectedproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectedproducts` (
  `PackageId` int NOT NULL,
  `ProductId` int NOT NULL,
  PRIMARY KEY (`PackageId`,`ProductId`),
  KEY `ProductId_idx` (`ProductId`),
  CONSTRAINT `PackageId` FOREIGN KEY (`PackageId`) REFERENCES `packages` (`Pkgid`),
  CONSTRAINT `ProductId` FOREIGN KEY (`ProductId`) REFERENCES `optionalproducts` (`ProdId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connectedproducts`
--

LOCK TABLES `connectedproducts` WRITE;
/*!40000 ALTER TABLE `connectedproducts` DISABLE KEYS */;
INSERT INTO `connectedproducts` VALUES (2,1),(1,2),(2,3),(1,5),(2,5);
/*!40000 ALTER TABLE `connectedproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixedinternetserv`
--

DROP TABLE IF EXISTS `fixedinternetserv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixedinternetserv` (
  `ServIdFI` int NOT NULL AUTO_INCREMENT,
  `GBs` int NOT NULL,
  `ExtraGBs` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ServIdFI`),
  CONSTRAINT `FixedInternetServicesId` FOREIGN KEY (`ServIdFI`) REFERENCES `services` (`ServId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='services sub-table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixedinternetserv`
--

LOCK TABLES `fixedinternetserv` WRITE;
/*!40000 ALTER TABLE `fixedinternetserv` DISABLE KEYS */;
INSERT INTO `fixedinternetserv` VALUES (2,1000,0.50),(3,500,0.12);
/*!40000 ALTER TABLE `fixedinternetserv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixedphoneserv`
--

DROP TABLE IF EXISTS `fixedphoneserv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixedphoneserv` (
  `ServIdFP` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ServIdFP`),
  CONSTRAINT `FixedPhoneServicesId` FOREIGN KEY (`ServIdFP`) REFERENCES `services` (`ServId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='services sub-table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixedphoneserv`
--

LOCK TABLES `fixedphoneserv` WRITE;
/*!40000 ALTER TABLE `fixedphoneserv` DISABLE KEYS */;
INSERT INTO `fixedphoneserv` VALUES (1),(4);
/*!40000 ALTER TABLE `fixedphoneserv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insolventusers`
--

DROP TABLE IF EXISTS `insolventusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insolventusers` (
  `userid` int NOT NULL,
  KEY `insolventuserfk` (`userid`),
  CONSTRAINT `insolventuserfk` FOREIGN KEY (`userid`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insolventusers`
--

LOCK TABLES `insolventusers` WRITE;
/*!40000 ALTER TABLE `insolventusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `insolventusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobileinternetserv`
--

DROP TABLE IF EXISTS `mobileinternetserv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobileinternetserv` (
  `ServIdMI` int NOT NULL AUTO_INCREMENT,
  `GBs` int NOT NULL,
  `ExtraGBs` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ServIdMI`),
  CONSTRAINT `MobileInternetServicesId` FOREIGN KEY (`ServIdMI`) REFERENCES `services` (`ServId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='services sub-table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobileinternetserv`
--

LOCK TABLES `mobileinternetserv` WRITE;
/*!40000 ALTER TABLE `mobileinternetserv` DISABLE KEYS */;
INSERT INTO `mobileinternetserv` VALUES (7,50,2.20),(8,20,0.75);
/*!40000 ALTER TABLE `mobileinternetserv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobilephoneserv`
--

DROP TABLE IF EXISTS `mobilephoneserv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobilephoneserv` (
  `ServIdMP` int NOT NULL AUTO_INCREMENT,
  `Minutes` int NOT NULL,
  `SMS` int NOT NULL,
  `ExtraMin` decimal(10,2) NOT NULL,
  `ExtraSMS` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ServIdMP`),
  CONSTRAINT `MobilePhoneServicesId` FOREIGN KEY (`ServIdMP`) REFERENCES `services` (`ServId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='services sub-table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobilephoneserv`
--

LOCK TABLES `mobilephoneserv` WRITE;
/*!40000 ALTER TABLE `mobilephoneserv` DISABLE KEYS */;
INSERT INTO `mobilephoneserv` VALUES (5,1000,1000,0.10,0.20),(6,2000,500,0.05,0.30);
/*!40000 ALTER TABLE `mobilephoneserv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optionalproducts`
--

DROP TABLE IF EXISTS `optionalproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optionalproducts` (
  `ProdId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `MonthlyFee` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ProdId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optionalproducts`
--

LOCK TABLES `optionalproducts` WRITE;
/*!40000 ALTER TABLE `optionalproducts` DISABLE KEYS */;
INSERT INTO `optionalproducts` VALUES (1,'UltraWideBroadBand',1.37),(2,'SlowerInternet',11.00),(3,'Antivirus',5.17),(4,'Firewall',2.19),(5,'Children Control',0.58);
/*!40000 ALTER TABLE `optionalproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optsales`
--

DROP TABLE IF EXISTS `optsales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optsales` (
  `OptProdId` int NOT NULL,
  `TotalValue` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`OptProdId`),
  CONSTRAINT `optprodfk0` FOREIGN KEY (`OptProdId`) REFERENCES `optionalproducts` (`ProdId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optsales`
--

LOCK TABLES `optsales` WRITE;
/*!40000 ALTER TABLE `optsales` DISABLE KEYS */;
INSERT INTO `optsales` VALUES (1,16.44),(2,132.00),(3,310.20),(4,0.00),(5,6.96);
/*!40000 ALTER TABLE `optsales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderId` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) NOT NULL,
  `PkgId` int NOT NULL,
  `ValidityPeriod` int NOT NULL,
  `TotalValue` decimal(10,2) NOT NULL,
  `StartDate` date NOT NULL,
  `Date` date NOT NULL,
  `Hour` datetime NOT NULL,
  `Paid` tinyint NOT NULL,
  `HasOpt` tinyint NOT NULL,
  `OptNumber` int NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `Username_idx` (`Username`),
  KEY `PkgId_idx` (`PkgId`),
  CONSTRAINT `PkgId` FOREIGN KEY (`PkgId`) REFERENCES `packages` (`Pkgid`) ON UPDATE CASCADE,
  CONSTRAINT `Username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'insolvent1',2,12,123.00,'2022-05-11','2022-05-11','2022-05-11 05:13:17',0,1,2),(2,'insolvent1',2,24,87.00,'2022-06-12','2022-06-12','2022-06-12 03:03:03',0,1,1),(3,'insolvent1',1,12,222.84,'2022-05-11','2022-04-21','2022-04-21 13:05:09',0,1,1),(4,'prova',2,12,263.40,'2022-05-28','2022-04-21','2022-04-21 15:10:50',1,1,2);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `Pkgid` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Service1Id` int NOT NULL,
  `Service2Id` int DEFAULT NULL,
  `Service3Id` int DEFAULT NULL,
  `Service4Id` int DEFAULT NULL,
  PRIMARY KEY (`Pkgid`),
  KEY `ServiceId2_idx` (`Service2Id`),
  KEY `ServiceId3_idx` (`Service3Id`),
  KEY `ServiceId4_idx` (`Service4Id`),
  KEY `ServiceId1` (`Service1Id`),
  CONSTRAINT `ServiceId1` FOREIGN KEY (`Service1Id`) REFERENCES `services` (`ServId`),
  CONSTRAINT `ServiceId2` FOREIGN KEY (`Service2Id`) REFERENCES `services` (`ServId`),
  CONSTRAINT `ServiceId3` FOREIGN KEY (`Service3Id`) REFERENCES `services` (`ServId`),
  CONSTRAINT `ServiceId4` FOREIGN KEY (`Service4Id`) REFERENCES `services` (`ServId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (1,'Package1',1,7,NULL,NULL),(2,'Package2',2,5,NULL,NULL);
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packagesprices`
--

DROP TABLE IF EXISTS `packagesprices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packagesprices` (
  `PackageId` int NOT NULL,
  `Period` int NOT NULL,
  `Value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PackageId`,`Period`),
  KEY `periodfk_idx` (`Period`),
  CONSTRAINT `packageidfk` FOREIGN KEY (`PackageId`) REFERENCES `packages` (`Pkgid`),
  CONSTRAINT `periodfk` FOREIGN KEY (`Period`) REFERENCES `validityperiod` (`Period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Join table between packages and validity period';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagesprices`
--

LOCK TABLES `packagesprices` WRITE;
/*!40000 ALTER TABLE `packagesprices` DISABLE KEYS */;
INSERT INTO `packagesprices` VALUES (1,12,17.99),(1,24,15.99),(1,36,14.99),(2,12,20.00),(2,24,19.00),(2,36,18.50);
/*!40000 ALTER TABLE `packagesprices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packagessold`
--

DROP TABLE IF EXISTS `packagessold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packagessold` (
  `PkgId` int NOT NULL,
  `Period` int NOT NULL,
  `Sales` int NOT NULL DEFAULT '0',
  KEY `PeriodFk1` (`Period`),
  KEY `PkgIdFK_idx` (`PkgId`),
  CONSTRAINT `PeriodFk1` FOREIGN KEY (`Period`) REFERENCES `validityperiod` (`Period`),
  CONSTRAINT `PkgIdFK` FOREIGN KEY (`PkgId`) REFERENCES `packages` (`Pkgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagessold`
--

LOCK TABLES `packagessold` WRITE;
/*!40000 ALTER TABLE `packagessold` DISABLE KEYS */;
INSERT INTO `packagessold` VALUES (2,12,1),(1,24,0),(1,12,0),(1,36,0),(2,24,0),(2,36,0);
/*!40000 ALTER TABLE `packagessold` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packagessoldwithopt`
--

DROP TABLE IF EXISTS `packagessoldwithopt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packagessoldwithopt` (
  `PkgId` int NOT NULL,
  `OptProduct` tinyint NOT NULL,
  `Sales` int NOT NULL,
  PRIMARY KEY (`PkgId`,`OptProduct`),
  CONSTRAINT `PkgIdfk1` FOREIGN KEY (`PkgId`) REFERENCES `packages` (`Pkgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagessoldwithopt`
--

LOCK TABLES `packagessoldwithopt` WRITE;
/*!40000 ALTER TABLE `packagessoldwithopt` DISABLE KEYS */;
INSERT INTO `packagessoldwithopt` VALUES (1,0,0),(1,1,0),(2,0,0),(2,1,1);
/*!40000 ALTER TABLE `packagessoldwithopt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selectedoptproducts`
--

DROP TABLE IF EXISTS `selectedoptproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selectedoptproducts` (
  `OrderId` int NOT NULL,
  `OptProductId` int NOT NULL,
  PRIMARY KEY (`OrderId`,`OptProductId`),
  KEY `OptProductId_idx` (`OptProductId`),
  KEY `OrderId_idx` (`OrderId`),
  CONSTRAINT `OptProductId` FOREIGN KEY (`OptProductId`) REFERENCES `optionalproducts` (`ProdId`),
  CONSTRAINT `OrderId` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selectedoptproducts`
--

LOCK TABLES `selectedoptproducts` WRITE;
/*!40000 ALTER TABLE `selectedoptproducts` DISABLE KEYS */;
INSERT INTO `selectedoptproducts` VALUES (4,1),(1,2),(2,2),(1,3),(3,5),(4,5);
/*!40000 ALTER TABLE `selectedoptproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `ServId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ServId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'FixedPhone1'),(2,'FixedInternet2'),(3,'FixedInternet2'),(4,'FixedPhone2'),(5,'MobilePhone1'),(6,'MobilePhone2'),(7,'MobileInternet1'),(8,'MobileInternet2');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suspendedorders`
--

DROP TABLE IF EXISTS `suspendedorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suspendedorders` (
  `OrderId` int NOT NULL,
  KEY `orderfk1_idx` (`OrderId`),
  CONSTRAINT `orderfk1` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suspendedorders`
--

LOCK TABLES `suspendedorders` WRITE;
/*!40000 ALTER TABLE `suspendedorders` DISABLE KEYS */;
/*!40000 ALTER TABLE `suspendedorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Username` varchar(16) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Password` varchar(25) NOT NULL,
  `Insolvent` tinyint NOT NULL,
  `Employee` tinyint NOT NULL,
  `UserId` int NOT NULL AUTO_INCREMENT,
  `FailedPayments` int NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Username_UNIQUE` (`Username`),
  UNIQUE KEY `UserId_UNIQUE` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('prova','prova@gmail.com','password',0,0,1,4),('prova1','prova1@gmail.com','password1',0,0,3,0),('employee1','employee@gmail.com','pwemp1',0,1,4,0),('insolvent1','insolvent@mail.com','insolvent',1,0,5,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validityperiod`
--

DROP TABLE IF EXISTS `validityperiod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validityperiod` (
  `Period` int NOT NULL,
  PRIMARY KEY (`Period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validityperiod`
--

LOCK TABLES `validityperiod` WRITE;
/*!40000 ALTER TABLE `validityperiod` DISABLE KEYS */;
INSERT INTO `validityperiod` VALUES (12),(24),(36);
/*!40000 ALTER TABLE `validityperiod` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-07 20:24:00
