-- MySQL dump 10.15  Distrib 10.0.15-MariaDB, for Win64 (x86)
--
-- Host: localhost    Database: itsm_default
-- ------------------------------------------------------
-- Server version	10.0.15-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `call`
--

DROP TABLE IF EXISTS `call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY_ID` int(11) NOT NULL,
  `USER` varchar(50) DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `CONTENTS` varchar(1000) NOT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `START_DT` varchar(12) DEFAULT NULL,
  `END_DT` varchar(12) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT 'Y',
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_CALL_CATEGORY1_idx` (`CATEGORY_ID`),
  CONSTRAINT `fk_CALL_CATEGORY1` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `category` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call`
--

LOCK TABLES `call` WRITE;
/*!40000 ALTER TABLE `call` DISABLE KEYS */;
INSERT INTO `call` VALUES (1,5,'임광규',15,'관련 내역 조사','20150105004645','201501050046','201501070046','Y','admin',NULL,NULL);
/*!40000 ALTER TABLE `call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SERVICE_ID` int(11) NOT NULL,
  `NAME` varchar(100) NOT NULL COMMENT 'INFRA ID',
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT 'Y',
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_SCOPE_INFRA_SCOPE1_idx` (`SERVICE_ID`),
  CONSTRAINT `fk_SCOPE_INFRA_SCOPE1` FOREIGN KEY (`SERVICE_ID`) REFERENCES `service` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,1,'요청','20150105004454',NULL,'Y','admin',NULL),(2,1,'변경','20150105004454',NULL,'Y','admin',NULL),(3,1,'장애','20150105004454',NULL,'Y','admin',NULL),(4,1,'기타','20150105004500',NULL,'Y','admin',NULL),(5,2,'TTA ','20150105004516',NULL,'Y','admin',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change`
--

DROP TABLE IF EXISTS `change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change` (
  `REQ_CODE` char(14) NOT NULL,
  `WORK_ST` varchar(14) NOT NULL,
  `WORK_ET` varchar(14) NOT NULL,
  `SERVICE_STOP_TIME` int(6) DEFAULT NULL,
  `CHANGE_LOG` varchar(1000) DEFAULT NULL,
  `WORK_PLAN` varchar(2000) DEFAULT NULL,
  `RESTORE_PLAN` varchar(1000) DEFAULT NULL,
  `REASON` varchar(2000) DEFAULT NULL,
  `EFFECT` varchar(1000) DEFAULT NULL,
  `RESULT` varchar(1000) DEFAULT NULL,
  `SUCCESS` char(1) DEFAULT 'Y',
  `CAB` varchar(1000) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`REQ_CODE`),
  KEY `fk_CHANGE_PROCESS1` (`REQ_CODE`),
  CONSTRAINT `fk_CHANGE_PROCESS1` FOREIGN KEY (`REQ_CODE`) REFERENCES `process` (`REQ_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change`
--

LOCK TABLES `change` WRITE;
/*!40000 ALTER TABLE `change` DISABLE KEYS */;
/*!40000 ALTER TABLE `change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code`
--

DROP TABLE IF EXISTS `code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code` (
  `CODE` char(4) NOT NULL COMMENT '코드',
  `CODE_MASTER` char(4) NOT NULL COMMENT '코드마스터',
  `NAME` varchar(45) NOT NULL COMMENT '코드명',
  `REGISTER_DT` varchar(14) DEFAULT NULL COMMENT '등록일',
  `MODIFY_DT` varchar(14) DEFAULT NULL COMMENT '수정일',
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  KEY `fk_CODE_CODE_MASTER_idx` (`CODE_MASTER`),
  CONSTRAINT `fk_CODE_CODE_MASTER` FOREIGN KEY (`CODE_MASTER`) REFERENCES `code_master` (`CODE_MASTER`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code`
--

LOCK TABLES `code` WRITE;
/*!40000 ALTER TABLE `code` DISABLE KEYS */;
INSERT INTO `code` VALUES ('E001','EMGC','1등급','20140601234922',NULL,NULL,NULL),('E002','EMGC','2등급','20140601234922',NULL,NULL,NULL),('E003','EMGC','3등급','20140601234922',NULL,NULL,NULL),('E004','EMGC','4등급','20140601234923',NULL,NULL,NULL),('E005','EMGC','5등급','20140601234923',NULL,NULL,NULL),('EV00','EVTY','접수-처리','20140901143552',NULL,'admin',NULL),('EV01','EVTY','서비스','20140609135508',NULL,NULL,NULL),('EV02','EVTY','변경','20140609135508',NULL,NULL,NULL),('EV03','EVTY','장애','20140609135508',NULL,NULL,NULL),('EW01','EWCD','변경작업','20140620110455',NULL,NULL,NULL),('EW02','EWCD','예방점검','20140620110455',NULL,NULL,NULL),('EW03','EWCD','기타','20140620110455',NULL,NULL,NULL),('H101','HWSW','HW[서버]','20140821124051',NULL,'admin',NULL),('H102','HWSW','HW[네트워크]','20140821124051',NULL,'admin',NULL),('H103','HWSW','HW[스토리지]','20140821124051',NULL,'admin',NULL),('H201','HWSW','SW[시스템]','20140821124051',NULL,'admin',NULL),('H202','HWSW','SW[응용]','20140821124051',NULL,'admin',NULL),('H203','HWSW','SW[DBMS]','20140821124052',NULL,'admin',NULL),('L001','LICE','FREE 라이센스','20140604211559',NULL,NULL,NULL),('L002','LICE','상용 라이센스','20140604211559',NULL,NULL,NULL),('L003','LICE','자체개발','20140704140749',NULL,NULL,NULL),('O001','OSSW','WINDOWS','20140604211559',NULL,NULL,NULL),('O002','OSSW','LINUX','20140604211559',NULL,NULL,NULL),('P001','PBLM','문제등록','20140623170304',NULL,NULL,NULL),('P002','PBLM','근본원인도출','20140623170304',NULL,NULL,NULL),('P003','PBLM','해결방안실행','20140623170304',NULL,NULL,NULL),('P004','PBLM','모니터링','20140623170304',NULL,NULL,NULL),('P005','PBLM','문제종료','20140623170304',NULL,NULL,NULL),('R001','RANK','사원','20140424110612',NULL,NULL,NULL),('R002','RANK','대리','20140424110612',NULL,NULL,NULL),('R003','RANK','과장','20140424110612',NULL,NULL,NULL),('R004','RANK','차장','20140424110612',NULL,NULL,NULL),('R005','RANK','부장','20140424110612',NULL,NULL,NULL),('R006','RANK','이사','20140424110612',NULL,NULL,NULL),('R007','RANK','사장','20140424110612',NULL,NULL,NULL),('S001','SVST','운영','20140604211559','20140626174144',NULL,NULL),('S002','SVST','테스트','20140604234506','20140626174235',NULL,NULL),('S003','SVST','개발','20140626174235',NULL,NULL,NULL),('VC01','VACA','연차휴가','20140811092746',NULL,'admin',NULL),('VC02','VACA','하계휴가','20140811092746',NULL,'admin',NULL),('VC03','VACA','사상휴가','20140811092746',NULL,'admin',NULL),('VC04','VACA','경조휴가','20140811092747',NULL,'admin',NULL),('VC05','VACA','봉사활동','20140811092747',NULL,'admin',NULL),('VC06','VACA','출장','20140811092747',NULL,'admin',NULL),('VC07','VACA','교육','20140811092747',NULL,'admin',NULL),('VC08','VACA','훈련','20140811092747',NULL,'admin',NULL),('VC09','VACA','기타','20140811092747',NULL,'admin',NULL);
/*!40000 ALTER TABLE `code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_master`
--

DROP TABLE IF EXISTS `code_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_master` (
  `CODE_MASTER` char(4) NOT NULL COMMENT '코드 마스터',
  `NAME` varchar(45) DEFAULT NULL COMMENT '코드 마스터 명',
  `REGISTER_DT` varchar(14) DEFAULT NULL COMMENT '등록일',
  `MODIFY_DT` varchar(14) DEFAULT NULL COMMENT '수정일',
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CODE_MASTER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_master`
--

LOCK TABLES `code_master` WRITE;
/*!40000 ALTER TABLE `code_master` DISABLE KEYS */;
INSERT INTO `code_master` VALUES ('EMGC','긴급 코드','20140601234811',NULL,NULL,NULL),('EVTY','이벤트 타입 코드','20140609135158',NULL,NULL,NULL),('EWCD','외부업체 작업 코드','20140620110316',NULL,NULL,NULL),('HWSW','시설 구분 코드','20140604211359',NULL,NULL,NULL),('LICE','라이센스 코드','20140604211359',NULL,NULL,NULL),('OSSW','OS 정보 코드','20140604211359',NULL,NULL,NULL),('PBLM','문제처리상세이력 코드','20140623170136',NULL,NULL,NULL),('RANK','직급 코드','20140424110409',NULL,NULL,NULL),('SVST','서비스 상태 코드','20140604211359',NULL,NULL,NULL),('VACA','휴가 코드','20140811092539',NULL,'admin',NULL);
/*!40000 ALTER TABLE `code_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMPANY_NAME` varchar(45) DEFAULT NULL,
  `WORKER` varchar(45) DEFAULT NULL,
  `TEL` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'LAHUMAN','임광규','01084214440','lahuman@daum.net','20150105003635',NULL,'admin',NULL);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `COMPANY_ID` int(11) NOT NULL,
  `START_DT` varchar(8) NOT NULL,
  `END_DT` varchar(8) NOT NULL,
  `CONTRACT_INFO` varchar(200) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  KEY `fk_CONTRACT_COMPANY1_idx` (`COMPANY_ID`),
  CONSTRAINT `fk_CONTRACT_COMPANY1` FOREIGN KEY (`COMPANY_ID`) REFERENCES `company` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `effect_range`
--

DROP TABLE IF EXISTS `effect_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `effect_range` (
  `REQ_CODE` char(14) NOT NULL,
  `INFRA_ID` int(11) NOT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  KEY `fk_EFFECT_RANGE_INFRASTRUCTURE1_idx` (`INFRA_ID`),
  KEY `fk_EFFECT_RANGE_PROCESS1` (`REQ_CODE`),
  CONSTRAINT `fk_EFFECT_RANGE_INFRASTRUCTURE1` FOREIGN KEY (`INFRA_ID`) REFERENCES `infrastructure` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EFFECT_RANGE_PROCESS1` FOREIGN KEY (`REQ_CODE`) REFERENCES `process` (`REQ_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `effect_range`
--

LOCK TABLES `effect_range` WRITE;
/*!40000 ALTER TABLE `effect_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `effect_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `REQ_CODE` char(14) NOT NULL,
  `CATEGORY_ID` int(11) NOT NULL,
  `REQ_DT` varchar(12) NOT NULL,
  `USER` varchar(50) NOT NULL,
  `REQ_TITLE` varchar(200) DEFAULT NULL,
  `EMERGENCY_CODE` char(4) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `USER_TEL` varchar(15) DEFAULT NULL,
  `SETTLE` char(1) DEFAULT 'N',
  `HELPDESK` char(1) DEFAULT 'N',
  `FTP` char(1) DEFAULT 'N',
  `USE_YN` char(1) DEFAULT 'Y',
  `FILE_NAME` varchar(100) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`REQ_CODE`),
  KEY `fk_EVENT_CATEGORY1_idx` (`CATEGORY_ID`),
  CONSTRAINT `fk_EVENT_CATEGORY1` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `category` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES ('201501-001',1,'201501050046','임광규','테스트를 위한 내역 추가','E003','20150105004614','010','N','N','N','Y',NULL,'admin',NULL,NULL);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!50001 DROP VIEW IF EXISTS `event_log`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `event_log` (
  `REQ_CODE` tinyint NOT NULL,
  `TITLE` tinyint NOT NULL,
  `infra_id` tinyint NOT NULL,
  `proc_type` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `external_work`
--

DROP TABLE IF EXISTS `external_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_work` (
  `ID` char(13) NOT NULL,
  `WORK_CODE` char(4) NOT NULL,
  `COMPANY_ID` int(11) NOT NULL,
  `WORK_NAME` varchar(400) DEFAULT NULL,
  `WORKER` varchar(20) DEFAULT NULL,
  `USER` varchar(20) DEFAULT NULL,
  `MANAGER_ID` int(11) DEFAULT NULL,
  `WORK_ST` varchar(12) DEFAULT NULL,
  `WORK_ET` varchar(12) DEFAULT NULL,
  `INFRA_ID` varchar(50) DEFAULT NULL,
  `SUCCESS` char(1) DEFAULT 'Y',
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT 'Y',
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_work`
--

LOCK TABLES `external_work` WRITE;
/*!40000 ALTER TABLE `external_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holiday_date`
--

DROP TABLE IF EXISTS `holiday_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holiday_date` (
  `HOLIDAY` varchar(8) NOT NULL,
  `DATE_NAME` varchar(45) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`HOLIDAY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holiday_date`
--

LOCK TABLES `holiday_date` WRITE;
/*!40000 ALTER TABLE `holiday_date` DISABLE KEYS */;
INSERT INTO `holiday_date` VALUES ('20150101','신년','20150105004528','admin',NULL,NULL);
/*!40000 ALTER TABLE `holiday_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_join`
--

DROP TABLE IF EXISTS `infra_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infra_join` (
  `INFRA_ID` int(11) NOT NULL,
  `JOIN_ID` int(11) NOT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  KEY `fk_INFRA_JOIN_INFRASTRUCTURE1_idx` (`INFRA_ID`),
  CONSTRAINT `fk_INFRA_JOIN_INFRASTRUCTURE1` FOREIGN KEY (`INFRA_ID`) REFERENCES `infrastructure` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_join`
--

LOCK TABLES `infra_join` WRITE;
/*!40000 ALTER TABLE `infra_join` DISABLE KEYS */;
INSERT INTO `infra_join` VALUES (1,3,'20150105004332',NULL),(2,3,'20150105004340',NULL);
/*!40000 ALTER TABLE `infra_join` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infrastructure`
--

DROP TABLE IF EXISTS `infrastructure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infrastructure` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DIVISION` char(4) NOT NULL COMMENT 'CODE JOIN',
  `RESOURCE_NUM` varchar(40) NOT NULL,
  `EMERGENCY_TYPE` char(4) DEFAULT NULL COMMENT 'CODE JOIN',
  `INSTALL_DT` varchar(14) DEFAULT NULL,
  `OFFER_USER` varchar(50) DEFAULT NULL COMMENT 'USER JOIN',
  `SERVICE_STATUS` char(4) DEFAULT NULL COMMENT 'CODE JOIN',
  `USE_TITLE` varchar(100) DEFAULT NULL,
  `MARK_ID` int(11) DEFAULT NULL COMMENT 'COMPANY JOIN',
  `LICENSE` char(4) DEFAULT NULL COMMENT 'CODE JOIN',
  `LICENSE_COUNT` int(11) DEFAULT NULL,
  `ADJUNCTION` varchar(100) DEFAULT NULL,
  `COMPANY_ID` int(11) DEFAULT NULL COMMENT 'COMPANY JOIN',
  `MODEL_NAME` varchar(45) DEFAULT NULL,
  `SERIAL_NO` varchar(100) DEFAULT NULL,
  `HOST_NAME` varchar(45) DEFAULT NULL,
  `IP_ADDRESS` varchar(15) DEFAULT NULL,
  `REAL_LOCATION` varchar(100) DEFAULT NULL,
  `CPU` varchar(100) DEFAULT NULL,
  `MEMORY` varchar(45) DEFAULT NULL,
  `INSIDE_DISK` varchar(45) DEFAULT NULL,
  `OUTSIDE_DISK` varchar(45) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `OWN_GROUP` varchar(50) DEFAULT NULL,
  `OS` varchar(45) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infrastructure`
--

LOCK TABLES `infrastructure` WRITE;
/*!40000 ALTER TABLE `infrastructure` DISABLE KEYS */;
INSERT INTO `infrastructure` VALUES (1,'H101','HW-001','E001','20130101','임광규','S002','LINUX-PC',2,NULL,NULL,'',1,'PC','','lahuman.pe.kr','123','서울','123','4G','10G','','20150105003912','20150105004210','LAHUMAN','LINUX','admin','admin'),(2,'H203','DBMS-001','E001','20150101','임광규','S002','MariaDB',15,'',1,'',1,'MARIADB 10','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'20150105004036','20150105004103','LAHUMAN','','admin','admin'),(3,'H202','SW-110','E001','20150101','임광규','S002','DOC4SM',2,'L002',1,'',1,'1.0','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'20150105004149',NULL,'LAHUMAN','','admin',NULL),(4,'H103','NAS-001','E001','20150101','임광규','S002','NAS-DOC4SM',2,NULL,NULL,'',1,'NAS','','LAHUMAN.PE.KR','204','서울','좋은놈','10G','10000G','','20150105004321',NULL,'LAHUMAN','LINUX','admin',NULL);
/*!40000 ALTER TABLE `infrastructure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(200) DEFAULT NULL,
  `MEET_DT` varchar(8) DEFAULT NULL,
  `STIME` varchar(4) DEFAULT NULL,
  `ETIME` varchar(4) DEFAULT NULL,
  `LOCATION` varchar(100) DEFAULT NULL,
  `KMA_USER` varchar(1000) DEFAULT NULL,
  `COMPANY_USER` varchar(1000) DEFAULT NULL,
  `CONTENTS` varchar(2000) DEFAULT NULL,
  `ETC` varchar(1000) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT 'Y',
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obstacle`
--

DROP TABLE IF EXISTS `obstacle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obstacle` (
  `REQ_CODE` char(14) NOT NULL,
  `OBSTACLE_ST` varchar(12) DEFAULT NULL,
  `OBSTACLE_ET` varchar(12) DEFAULT NULL,
  `SERVICE_OBSTACLE_TIME` int(6) DEFAULT NULL,
  `FIRST_ACTION` varchar(1000) DEFAULT NULL,
  `CAUSE` varchar(2000) DEFAULT NULL,
  `PHENOMENON` varchar(2000) DEFAULT NULL,
  `AFTER_ACTION` varchar(2000) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  `PROBLEM` char(1) DEFAULT 'N',
  PRIMARY KEY (`REQ_CODE`),
  KEY `fk_OBSTACLE_PROCESS1` (`REQ_CODE`),
  CONSTRAINT `fk_OBSTACLE_PROCESS1` FOREIGN KEY (`REQ_CODE`) REFERENCES `process` (`REQ_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obstacle`
--

LOCK TABLES `obstacle` WRITE;
/*!40000 ALTER TABLE `obstacle` DISABLE KEYS */;
/*!40000 ALTER TABLE `obstacle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ST` varchar(12) DEFAULT NULL,
  `PROBLEM_ET` varchar(12) DEFAULT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `STATUS` char(1) DEFAULT 'N',
  `EMERGENCY` char(4) DEFAULT NULL,
  `SERVICE_EFFECT` char(1) DEFAULT 'N',
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_relation`
--

DROP TABLE IF EXISTS `problem_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem_relation` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROBLEM_ID` int(11) NOT NULL COMMENT 'id',
  `EVENT_REQ_CODE` char(14) NOT NULL COMMENT '이벤트 ID',
  `CONDITION` char(4) DEFAULT NULL,
  `CONTENTS` varchar(1000) DEFAULT NULL,
  `ETC` varchar(200) DEFAULT NULL COMMENT '특이사항',
  `PROC_DT` varchar(12) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PROBLEM_RELATION_PROBLEM1_idx` (`PROBLEM_ID`),
  KEY `fk_PROBLEM_RELATION_EVENT1_idx` (`EVENT_REQ_CODE`),
  CONSTRAINT `fk_PROBLEM_RELATION_EVENT1` FOREIGN KEY (`EVENT_REQ_CODE`) REFERENCES `event` (`REQ_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROBLEM_RELATION_PROBLEM1` FOREIGN KEY (`PROBLEM_ID`) REFERENCES `problem` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_relation`
--

LOCK TABLES `problem_relation` WRITE;
/*!40000 ALTER TABLE `problem_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process`
--

DROP TABLE IF EXISTS `process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process` (
  `REQ_CODE` char(14) NOT NULL,
  `PROC_TYPE` char(4) NOT NULL,
  `RECEIPT_DT` varchar(14) NOT NULL,
  `PROC_USER` int(11) NOT NULL,
  `SCHEDULE_DT` varchar(14) NOT NULL,
  `COMPLETE_DT` varchar(14) DEFAULT NULL,
  `SPEND_TIME` int(6) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `PROCESS_RT` varchar(1000) DEFAULT NULL,
  `INFRA_ID` varchar(50) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  `REQ_TYPE` char(1) DEFAULT 'S',
  PRIMARY KEY (`REQ_CODE`),
  KEY `fk_PROCESS_EVENT1_idx` (`REQ_CODE`),
  CONSTRAINT `fk_PROCESS_EVENT1` FOREIGN KEY (`REQ_CODE`) REFERENCES `event` (`REQ_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process`
--

LOCK TABLES `process` WRITE;
/*!40000 ALTER TABLE `process` DISABLE KEYS */;
/*!40000 ALTER TABLE `process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `PROGRAM_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PROGRAM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (1,'로그인 & 로그아웃 & 기타 공통'),(2,'사용자'),(3,'관리자'),(4,'');
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_role`
--

DROP TABLE IF EXISTS `program_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_role` (
  `ROLE_ID` int(10) unsigned NOT NULL,
  `PROGRAM_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`PROGRAM_ID`),
  KEY `R_5` (`PROGRAM_ID`),
  CONSTRAINT `program_role_ibfk_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ROLE_ID`),
  CONSTRAINT `program_role_ibfk_2` FOREIGN KEY (`PROGRAM_ID`) REFERENCES `program` (`PROGRAM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_role`
--

LOCK TABLES `program_role` WRITE;
/*!40000 ALTER TABLE `program_role` DISABLE KEYS */;
INSERT INTO `program_role` VALUES (1,2),(2,3),(3,1),(4,4);
/*!40000 ALTER TABLE `program_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `ROLE_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `DESCRIPTION` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_USER','사용자'),(2,'ROLE_ADMIN','관리자'),(3,'ROLE_ANONYMOUS','모든 사람'),(4,'ROLE_REQUESTER','');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  `USER_ID` int(10) NOT NULL,
  `USER` varchar(50) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `USE_YN` char(1) NOT NULL DEFAULT 'Y',
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'DOC4SM 테스트',2,'모두','20150105004427',NULL,'Y','admin',NULL),(2,'ITIL TOOL',15,'모두','20150105004427',NULL,'Y','admin',NULL);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_os`
--

DROP TABLE IF EXISTS `support_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_os` (
  `INFRA_ID` int(11) NOT NULL,
  `OS_CODE` char(4) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  KEY `fk_SUPPORT_OS_INFRASTRUCTURE1_idx` (`INFRA_ID`),
  CONSTRAINT `fk_SUPPORT_OS_INFRASTRUCTURE1` FOREIGN KEY (`INFRA_ID`) REFERENCES `infrastructure` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_os`
--

LOCK TABLES `support_os` WRITE;
/*!40000 ALTER TABLE `support_os` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_os` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_repository`
--

DROP TABLE IF EXISTS `url_repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_repository` (
  `PROGRAM_ID` int(10) unsigned NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `URL_PATH` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  `LEVEL` int(4) unsigned NOT NULL DEFAULT '1',
  KEY `R_3` (`PROGRAM_ID`),
  CONSTRAINT `url_repository_ibfk_1` FOREIGN KEY (`PROGRAM_ID`) REFERENCES `program` (`PROGRAM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_repository`
--

LOCK TABLES `url_repository` WRITE;
/*!40000 ALTER TABLE `url_repository` DISABLE KEYS */;
INSERT INTO `url_repository` VALUES (2,'사용자','/**',NULL,2000),(3,'관리자','/admin',NULL,1000),(3,'관리자','/admin/**',NULL,1000),(1,'로그인 성공 이후 페이지','/basics.do',NULL,1),(1,'로그인','/login',NULL,1),(1,'로그인실패','/login/failed**',NULL,1),(1,'로그인 화면','/login/form**',NULL,1),(1,'로그인 팝업 화면','/login/pop/form**',NULL,1),(1,'로그아웃','/logout',NULL,1),(3,'','/**',NULL,2000),(4,'','/**',NULL,2000),(2,'','/user/**',NULL,1000),(4,'','/requester/**',NULL,1000);
/*!40000 ALTER TABLE `url_repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `USER_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `LOGIN_ID` varchar(50) NOT NULL,
  `PASSWORD` varchar(200) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `POSITION` char(4) NOT NULL,
  `ENABLED` tinyint(1) NOT NULL,
  `TEL` varchar(12) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `COMPANY_ID` int(11) DEFAULT NULL,
  `CHARGE_WORK` varchar(20) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`,`ENABLED`),
  UNIQUE KEY `LOGIN_ID_UNIQUE` (`LOGIN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'admin','1000:3e8cba5167f90d4de2b8bb702edcabffa125e28a40cbf934:d13ea3f42a821ad8986e1390095f881b8487b8eaf4b62789','관리자','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,'doc4sm','1000:5bc38a60317b341a756493ab33e1fa2a3dc0fd1b434fd77c:7524b971987ef9bcf4ce184f9cf16caf233347a16da4e597','테스터','R001',1,'010','lahuman',1,'테스트','20150105003723',NULL,'admin',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `ROLE_ID` int(10) unsigned NOT NULL,
  `USER_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `R_2` (`ROLE_ID`),
  KEY `fk_user_role_user1_idx` (`USER_ID`),
  CONSTRAINT `fk_user_role_user1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,2),(1,15),(2,2);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacation`
--

DROP TABLE IF EXISTS `vacation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacation` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VACATION_USER` int(10) DEFAULT NULL,
  `AGENT_USER` int(10) DEFAULT NULL,
  `START_DT` varchar(8) DEFAULT NULL,
  `END_DT` varchar(8) DEFAULT NULL,
  `VACATION_KIND` char(4) DEFAULT NULL,
  `DETAIL` varchar(200) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT 'Y',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacation`
--

LOCK TABLES `vacation` WRITE;
/*!40000 ALTER TABLE `vacation` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `INFRA_ID` int(11) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(100) DEFAULT NULL,
  `SVN_INFO` varchar(100) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_VERSION_INFRASTRUCTURE1_idx` (`INFRA_ID`),
  CONSTRAINT `fk_VERSION_INFRASTRUCTURE1` FOREIGN KEY (`INFRA_ID`) REFERENCES `infrastructure` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version_info`
--

DROP TABLE IF EXISTS `version_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_info` (
  `KIND_CD` char(1) NOT NULL DEFAULT 'I',
  `ID` varchar(13) NOT NULL,
  `SVN_VERSION` int(10) NOT NULL,
  `VERSION` varchar(10) DEFAULT NULL,
  `AUTHOR` varchar(20) DEFAULT NULL,
  `REGISTER_DT` varchar(14) DEFAULT NULL,
  `MODIFY_DT` varchar(14) DEFAULT NULL,
  `REGISTER_ID` varchar(50) DEFAULT NULL,
  `MODIFY_ID` varchar(50) DEFAULT NULL,
  UNIQUE KEY `VERSION_UNIQUE` (`ID`,`SVN_VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version_info`
--

LOCK TABLES `version_info` WRITE;
/*!40000 ALTER TABLE `version_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `version_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `event_log`
--

/*!50001 DROP TABLE IF EXISTS `event_log`*/;
/*!50001 DROP VIEW IF EXISTS `event_log`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`doc4sm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `event_log` AS select `e`.`REQ_CODE` AS `REQ_CODE`,concat('[REQ-',`e`.`REQ_CODE`,'] ',`e`.`REQ_TITLE`) AS `TITLE`,`p`.`INFRA_ID` AS `infra_id`,`p`.`PROC_TYPE` AS `proc_type` from (`process` `p` left join `event` `e` on(((`p`.`REQ_CODE` = `e`.`REQ_CODE`) and (`e`.`USE_YN` = 'Y')))) */;
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

-- Dump completed on 2015-01-05  0:51:41
