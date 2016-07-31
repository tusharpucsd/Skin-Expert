-- MySQL dump 10.13  Distrib 5.1.69, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: skin_experts
-- ------------------------------------------------------
-- Server version	5.1.69-0ubuntu0.10.04.1

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
-- Table structure for table `address_city`
--

DROP TABLE IF EXISTS `address_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_city_state_id_250a7880_uniq` (`state_id`,`name`),
  KEY `address_city_5654bf12` (`state_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_city`
--

LOCK TABLES `address_city` WRITE;
/*!40000 ALTER TABLE `address_city` DISABLE KEYS */;
INSERT INTO `address_city` VALUES (1,1,'Mumbai'),(2,1,'Mumbai (Maharashtra)'),(3,2,'Mumbai'),(4,3,''),(5,4,'Atlanta'),(6,1,'pune'),(7,5,'sdg'),(8,6,'Pune');
/*!40000 ALTER TABLE `address_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_country`
--

DROP TABLE IF EXISTS `address_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `dial_code` varchar(200),
  `code` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=484 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_country`
--

LOCK TABLES `address_country` WRITE;
/*!40000 ALTER TABLE `address_country` DISABLE KEYS */;
INSERT INTO `address_country` VALUES (310,'Georgia','+995','GE'),(309,'Gambia','+220','GM'),(308,'Gabon','+241','GA'),(307,'French Polynesia','+689','PF'),(306,'French Guiana','+594','GF'),(305,'France','+33','FR'),(304,'Finland','+358','FI'),(303,'Fiji','+679','FJ'),(302,'Faroe Islands','+298','FO'),(301,'Ethiopia','+251','ET'),(300,'Estonia','+372','EE'),(299,'Eritrea','+291','ER'),(298,'Equatorial Guinea','+240','GQ'),(297,'El Salvador','+503','SV'),(296,'Egypt','+20','EG'),(295,'Ecuador','+593','EC'),(294,'Dominican Republic','+1 849','DO'),(293,'Dominica','+1 767','DM'),(292,'Djibouti','+253','DJ'),(291,'Denmark','+45','DK'),(290,'Czech Republic','+420','CZ'),(289,'Cyprus','+537','CY'),(288,'Cuba','+53','CU'),(287,'Croatia','+385','HR'),(286,'Costa Rica','+506','CR'),(285,'Cook Islands','+682','CK'),(284,'Congo','+242','CG'),(283,'Comoros','+269','KM'),(282,'Colombia','+57','CO'),(281,'Christmas Island','+61','CX'),(280,'China','+86','CN'),(279,'Chile','+56','CL'),(278,'Chad','+235','TD'),(277,'Central African Republic','+236','CF'),(276,'Cayman Islands','+ 345','KY'),(275,'Cape Verde','+238','CV'),(274,'Canada','+1','CA'),(273,'Cameroon','+237','CM'),(272,'Cambodia','+855','KH'),(271,'Burundi','+257','BI'),(270,'Burkina Faso','+226','BF'),(269,'Bulgaria','+359','BG'),(268,'British Indian Ocean Territory','+246','IO'),(267,'Brazil','+55','BR'),(266,'Botswana','+267','BW'),(265,'Bosnia and Herzegovina','+387','BA'),(264,'Bhutan','+975','BT'),(263,'Bermuda','+1 441','BM'),(262,'Benin','+229','BJ'),(261,'Belize','+501','BZ'),(260,'Belgium','+32','BE'),(259,'Belarus','+375','BY'),(258,'Barbados','+1 246','BB'),(257,'Bangladesh','+880','BD'),(256,'Bahrain','+973','BH'),(255,'Bahamas','+1 242','BS'),(254,'Azerbaijan','+994','AZ'),(253,'Austria','+43','AT'),(252,'Australia','+61','AU'),(251,'Aruba','+297','AW'),(250,'Armenia','+374','AM'),(249,'Argentina','+54','AR'),(248,'Antigua and Barbuda','+1268','AG'),(247,'Anguilla','+1 264','AI'),(246,'Angola','+244','AO'),(245,'Andorra','+376','AD'),(244,'AmericanSamoa','+1 684','AS'),(243,'Algeria','+213','DZ'),(242,'Albania','+355','AL'),(241,'Afghanistan','+93','AF'),(390,'Puerto Rico','+1 939','PR'),(389,'Portugal','+351','PT'),(388,'Poland','+48','PL'),(387,'Philippines','+63','PH'),(386,'Peru','+51','PE'),(385,'Paraguay','+595','PY'),(384,'Papua New Guinea','+675','PG'),(383,'Panama','+507','PA'),(382,'Palau','+680','PW'),(381,'Pakistan','+92','PK'),(380,'Oman','+968','OM'),(379,'Norway','+47','NO'),(378,'Northern Mariana Islands','+1 670','MP'),(377,'Norfolk Island','+672','NF'),(376,'Niue','+683','NU'),(375,'Nigeria','+234','NG'),(374,'Niger','+227','NE'),(373,'Nicaragua','+505','NI'),(372,'New Zealand','+64','NZ'),(371,'New Caledonia','+687','NC'),(370,'Netherlands Antilles','+599','AN'),(369,'Netherlands','+31','NL'),(368,'Nepal','+977','NP'),(367,'Nauru','+674','NR'),(366,'Namibia','+264','NA'),(365,'Myanmar','+95','MM'),(364,'Morocco','+212','MA'),(363,'Montserrat','+1664','MS'),(362,'Montenegro','+382','ME'),(361,'Mongolia','+976','MN'),(360,'Monaco','+377','MC'),(359,'Mexico','+52','MX'),(358,'Mayotte','+262','YT'),(357,'Mauritius','+230','MU'),(356,'Mauritania','+222','MR'),(355,'Martinique','+596','MQ'),(354,'Marshall Islands','+692','MH'),(353,'Malta','+356','MT'),(352,'Mali','+223','ML'),(351,'Maldives','+960','MV'),(350,'Malaysia','+60','MY'),(349,'Malawi','+265','MW'),(348,'Madagascar','+261','MG'),(347,'Luxembourg','+352','LU'),(346,'Lithuania','+370','LT'),(345,'Liechtenstein','+423','LI'),(344,'Liberia','+231','LR'),(343,'Lesotho','+266','LS'),(342,'Lebanon','+961','LB'),(341,'Latvia','+371','LV'),(340,'Kyrgyzstan','+996','KG'),(339,'Kuwait','+965','KW'),(338,'Kiribati','+686','KI'),(337,'Kenya','+254','KE'),(336,'Kazakhstan','+7 7','KZ'),(335,'Jordan','+962','JO'),(334,'Japan','+81','JP'),(333,'Jamaica','+1 876','JM'),(332,'Italy','+39','IT'),(331,'Israel','+972','IL'),(330,'Ireland','+353','IE'),(329,'Iraq','+964','IQ'),(328,'Indonesia','+62','ID'),(327,'India','+91','IN'),(326,'Iceland','+354','IS'),(325,'Hungary','+36','HU'),(324,'Honduras','+504','HN'),(323,'Haiti','+509','HT'),(322,'Guyana','+595','GY'),(321,'Guinea-Bissau','+245','GW'),(320,'Guinea','+224','GN'),(319,'Guatemala','+502','GT'),(318,'Guam','+1 671','GU'),(317,'Guadeloupe','+590','GP'),(316,'Grenada','+1 473','GD'),(315,'Greenland','+299','GL'),(314,'Greece','+30','GR'),(313,'Gibraltar','+350','GI'),(312,'Ghana','+233','GH'),(311,'Germany','+49','DE'),(391,'Qatar','+974','QA'),(392,'Romania','+40','RO'),(393,'Rwanda','+250','RW'),(394,'Samoa','+685','WS'),(395,'San Marino','+378','SM'),(396,'Saudi Arabia','+966','SA'),(397,'Senegal','+221','SN'),(398,'Serbia','+381','RS'),(399,'Seychelles','+248','SC'),(400,'Sierra Leone','+232','SL'),(401,'Singapore','+65','SG'),(402,'Slovakia','+421','SK'),(403,'Slovenia','+386','SI'),(404,'Solomon Islands','+677','SB'),(405,'South Africa','+27','ZA'),(406,'South Georgia and the South Sandwich Islands','+500','GS'),(407,'Spain','+34','ES'),(408,'Sri Lanka','+94','LK'),(409,'Sudan','+249','SD'),(410,'Suriname','+597','SR'),(411,'Swaziland','+268','SZ'),(412,'Sweden','+46','SE'),(413,'Switzerland','+41','CH'),(414,'Tajikistan','+992','TJ'),(415,'Thailand','+66','TH'),(416,'Togo','+228','TG'),(417,'Tokelau','+690','TK'),(418,'Tonga','+676','TO'),(419,'Trinidad and Tobago','+1 868','TT'),(420,'Tunisia','+216','TN'),(421,'Turkey','+90','TR'),(422,'Turkmenistan','+993','TM'),(423,'Turks and Caicos Islands','+1 649','TC'),(424,'Tuvalu','+688','TV'),(425,'Uganda','+256','UG'),(426,'Ukraine','+380','UA'),(427,'United Arab Emirates','+971','AE'),(428,'United Kingdom','+44','GB'),(429,'United States','+1','US'),(430,'Uruguay','+598','UY'),(431,'Uzbekistan','+998','UZ'),(432,'Vanuatu','+678','VU'),(433,'Wallis and Futuna','+681','WF'),(434,'Yemen','+967','YE'),(435,'Zambia','+260','ZM'),(436,'Zimbabwe','+263','ZW'),(437,'land Islands','','AX'),(438,'Antarctica',NULL,'AQ'),(439,'Bolivia, Plurinational State of','+591','BO'),(440,'Brunei Darussalam','+673','BN'),(441,'Cocos (Keeling) Islands','+61','CC'),(442,'Congo, The Democratic Republic of the','+243','CD'),(443,'Cote d\'Ivoire','+225','CI'),(444,'Falkland Islands (Malvinas)','+500','FK'),(445,'Guernsey','+44','GG'),(446,'Holy See (Vatican City State)','+379','VA'),(447,'Hong Kong','+852','HK'),(448,'Iran, Islamic Republic of','+98','IR'),(449,'Isle of Man','+44','IM'),(450,'Jersey','+44','JE'),(451,'Korea, Democratic People\'s Republic of','+850','KP'),(452,'Korea, Republic of','+82','KR'),(453,'Lao People\'s Democratic Republic','+856','LA'),(454,'Libyan Arab Jamahiriya','+218','LY'),(455,'Macao','+853','MO'),(456,'Macedonia, The Former Yugoslav Republic of','+389','MK'),(457,'Micronesia, Federated States of','+691','FM'),(458,'Moldova, Republic of','+373','MD'),(459,'Mozambique','+258','MZ'),(460,'Palestinian Territory, Occupied','+970','PS'),(461,'Pitcairn','+872','PN'),(462,'Réunion','+262','RE'),(463,'Russia','+7','RU'),(464,'Saint Barthélemy','+590','BL'),(465,'Saint Helena, Ascension and Tristan Da Cunha','+290','SH'),(466,'Saint Kitts and Nevis','+1 869','KN'),(467,'Saint Lucia','+1 758','LC'),(468,'Saint Martin','+590','MF'),(469,'Saint Pierre and Miquelon','+508','PM'),(470,'Saint Vincent and the Grenadines','+1 784','VC'),(471,'Sao Tome and Principe','+239','ST'),(472,'Somalia','+252','SO'),(473,'Svalbard and Jan Mayen','+47','SJ'),(474,'Syrian Arab Republic','+963','SY'),(475,'Taiwan, Province of China','+886','TW'),(476,'Tanzania, United Republic of','+255','TZ'),(477,'Timor-Leste','+670','TL'),(478,'Venezuela, Bolivarian Republic of','+58','VE'),(479,'Viet Nam','+84','VN'),(480,'Virgin Islands, British','+1 284','VG'),(481,'Virgin Islands, U.S.','+1 340','VI'),(482,'USA',NULL,''),(483,'cf',NULL,'');
/*!40000 ALTER TABLE `address_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_state`
--

DROP TABLE IF EXISTS `address_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_state_country_id_1fa8520_uniq` (`country_id`,`name`),
  KEY `address_state_d860be3c` (`country_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_state`
--

LOCK TABLES `address_state` WRITE;
/*!40000 ALTER TABLE `address_state` DISABLE KEYS */;
INSERT INTO `address_state` VALUES (1,327,'Maharashtra'),(2,328,'Maharashtra'),(3,327,''),(4,482,'Atlanta'),(5,483,'Maharashtra'),(6,327,'dlskdskl');
/*!40000 ALTER TABLE `address_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add migration history',8,'add_migrationhistory'),(23,'Can change migration history',8,'change_migrationhistory'),(24,'Can delete migration history',8,'delete_migrationhistory'),(25,'Can add log action',9,'add_logaction'),(26,'Can change log action',9,'change_logaction'),(27,'Can delete log action',9,'delete_logaction'),(28,'Can add log item',10,'add_logitem'),(29,'Can change log item',10,'change_logitem'),(30,'Can delete log item',10,'delete_logitem'),(31,'Can add role',11,'add_role'),(32,'Can change role',11,'change_role'),(33,'Can delete role',11,'delete_role'),(34,'Can add user profile',12,'add_userprofile'),(35,'Can change user profile',12,'change_userprofile'),(36,'Can delete user profile',12,'delete_userprofile'),(37,'Can add patient',13,'add_patient'),(38,'Can change patient',13,'change_patient'),(39,'Can delete patient',13,'delete_patient'),(40,'Can add episode',14,'add_episode'),(41,'Can change episode',14,'change_episode'),(42,'Can delete episode',14,'delete_episode'),(43,'Can add task',15,'add_task'),(44,'Can change task',15,'change_task'),(45,'Can delete task',15,'delete_task'),(46,'Can add query',16,'add_query'),(47,'Can change query',16,'change_query'),(48,'Can delete query',16,'delete_query'),(49,'Can add job',17,'add_job'),(50,'Can change job',17,'change_job'),(51,'Can delete job',17,'delete_job'),(52,'Can add occurrence',18,'add_occurrence'),(53,'Can change occurrence',18,'change_occurrence'),(54,'Can delete occurrence',18,'delete_occurrence'),(55,'Can add country',19,'add_country'),(56,'Can change country',19,'change_country'),(57,'Can delete country',19,'delete_country'),(58,'Can add state',20,'add_state'),(59,'Can change state',20,'change_state'),(60,'Can delete state',20,'delete_state'),(61,'Can add city',21,'add_city'),(62,'Can change city',21,'change_city'),(63,'Can delete city',21,'delete_city');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$TvD4s19LUkqf$jwszjLyMRvjTUMP2Y/prXvESGOSarO5dndvlhk3X5CY=','2014-03-07 06:46:19',1,'admin','Pradnya','Mhatre','pradnyam@leotechnosoft.net',1,1,'2014-01-10 06:30:35'),(6,'pbkdf2_sha256$10000$rfx6B2CZHCF9$v8nBRYq+SfZGL09sO79Qhc9jNYIYbWVTJwjrtYgrSXo=','2014-02-05 14:20:09',0,'v2','v2','v2','Pradnya@gmail.com',0,1,'2014-01-14 10:35:28'),(5,'pbkdf2_sha256$10000$7nC9bCGQLD9S$elE5NSjf7kH0phjoz9teUgD4TVdOjUzyDZd5UaH7ku4=','2014-01-16 10:19:08',0,'gauravk','Gaurav','K','pradnyam@leotechnosoft.net',0,1,'2014-01-13 14:23:25'),(7,'pbkdf2_sha256$10000$mtVhzr1vF5QZ$V0q/NDIoKXLQ+bGiBmlqvUb+xxuW35SB3iiAwkCT/AU=','2014-03-07 07:30:51',0,'vivek','Vivek','Joshi','vivekj@leotechnosoft.net',0,1,'2014-01-14 13:11:12'),(19,'pbkdf2_sha256$10000$7lxZ8NKs1UY8$wiVQi6pLJItRvAwpCuNB383RmcZg2sXSHOy5oI4Ywks=','2014-01-16 10:27:19',0,'sumegha','Sumegha','R','pradnyam@leotechnosoft.net',0,1,'2014-01-16 10:27:19'),(29,'pbkdf2_sha256$10000$aKQn4VRUh47c$pjjLEoEfhATGvMdENH1AUMOCBpkZ+rIEfyO8IQF3wuE=','2014-03-06 08:15:48',0,'phani','phani','verma','phani@leotechnosoft.net',0,1,'2014-03-06 08:15:48'),(18,'pbkdf2_sha256$10000$CyYOnSdQiAdj$w/vdcmFpycIf+tZj/aONle3H5XAuUPOQHmXZ5251fOo=','2014-03-07 06:46:40',0,'ankit','Ankit','Agarwal','pradnyam@leotechnosoft.net',0,1,'2014-01-15 07:33:05'),(20,'','2014-01-18 09:56:09',0,'Patient test','P Test','Testfgct gdsbb frdeggg yfddrfh','harshadaw@leotechnosoft.net',0,1,'2014-01-18 09:56:09'),(21,'pbkdf2_sha256$10000$O00k835pNEjY$apIvh7hPi27Q9+fYGK7aRfPUw1/EG/afa/SB7CInOF0=','2014-01-18 09:56:39',0,'Patient test1','P Test','tyurty','harshadaw@leotechnosoft.net',0,1,'2014-01-18 09:56:39'),(22,'pbkdf2_sha256$10000$8GfVxNQXtTxD$su6gcEKGiZrJtakrvRt96G1f6NiMUE0Yk9uLX3jkFME=','2014-01-20 12:42:39',0,'Ratan','Ratan','T','harshadaw@leotechnosoft.net',0,1,'2014-01-20 12:06:39'),(30,'pbkdf2_sha256$10000$A018DDoXOsBY$H6zjPMRgv4mP1saOiHAhvSdFpGRRtktXi96g5iWIQ3c=','2014-03-06 08:35:57',0,'phaani','phani','verma','phani@leotechnosoft.net',0,1,'2014-03-06 08:35:57'),(28,'pbkdf2_sha256$10000$nJvrirnaB6fs$+wYEG7AkWrk6a03rXEkg918W3AngHJYm26fEGi/CoXw=','2014-02-25 10:09:49',0,'tushar','Tushar','P','tusharp@leotechnosoft.net',0,1,'2014-02-25 10:09:49'),(31,'pbkdf2_sha256$10000$BWlmDX088qgw$m8jKE66NgvLBJDbK2F8fBcKYZl1FfHMFrsCf0zgB7Og=','2014-03-06 09:55:39',0,'phaniv','phani','varma','phaniv@leotechnosoft.net',0,1,'2014-03-06 09:55:39');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `availability_occurrence`
--

DROP TABLE IF EXISTS `availability_occurrence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `availability_occurrence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `availability_occurrence_doctor_id_31736df2_uniq` (`doctor_id`,`date`),
  KEY `availability_occurrence_72821be1` (`doctor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability_occurrence`
--

LOCK TABLES `availability_occurrence` WRITE;
/*!40000 ALTER TABLE `availability_occurrence` DISABLE KEYS */;
INSERT INTO `availability_occurrence` VALUES (34,14,'2014-02-07'),(33,14,'2014-02-14'),(32,14,'2014-01-29'),(31,14,'2014-01-28'),(30,14,'2014-01-27'),(29,14,'2014-01-26'),(28,14,'2014-01-25'),(27,14,'2014-01-30'),(26,14,'2014-01-22'),(25,14,'2014-01-24'),(24,14,'2014-01-23'),(23,14,'2014-02-13'),(22,14,'2014-01-31'),(21,14,'2014-01-21'),(20,14,'2014-01-20'),(19,14,'2014-01-19'),(18,14,'2014-01-18'),(35,14,'2014-02-08'),(36,14,'2014-02-09'),(37,14,'2014-02-10'),(38,14,'2014-02-11'),(39,14,'2014-02-12'),(40,14,'2014-09-11'),(41,14,'2014-02-15'),(42,14,'2014-02-22'),(43,14,'2014-02-23'),(44,14,'2014-02-24'),(45,14,'2014-02-25'),(46,14,'2014-02-26'),(47,14,'2014-02-27'),(48,14,'2014-02-28'),(49,14,'2014-03-01'),(50,14,'2014-03-02'),(51,14,'2014-03-03'),(52,14,'2014-03-04'),(53,14,'2014-03-05'),(54,14,'2014-03-06'),(55,14,'2014-03-07'),(56,14,'2014-09-24'),(57,14,'2014-09-25'),(58,14,'2014-09-26'),(59,14,'2014-09-27'),(60,14,'2014-09-28'),(61,14,'2014-09-29'),(62,14,'2014-09-30'),(63,14,'2015-02-01'),(64,14,'2015-02-02'),(65,14,'2015-02-03'),(66,14,'2015-02-04'),(67,14,'2015-02-05'),(68,14,'2015-02-06'),(69,14,'2015-02-07'),(70,14,'2015-02-08'),(71,14,'2015-02-09'),(72,14,'2015-02-10'),(73,14,'2015-02-11'),(74,14,'2015-02-12'),(75,14,'2015-02-13'),(76,14,'2015-02-14'),(77,14,'2015-02-15'),(78,14,'2015-02-16'),(79,14,'2015-02-17'),(80,14,'2015-02-18'),(81,14,'2015-02-19'),(82,14,'2015-02-20'),(83,14,'2015-02-21'),(84,14,'2015-02-22'),(85,14,'2015-02-23'),(86,14,'2015-02-24'),(87,14,'2015-02-25'),(88,14,'2015-02-26'),(89,14,'2015-02-27'),(90,14,'2015-02-28'),(91,14,'2014-03-10'),(92,14,'2014-03-08'),(93,14,'2014-03-11'),(94,14,'2014-03-12');
/*!40000 ALTER TABLE `availability_occurrence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=339 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-01-10 06:33:12',1,11,'1','Doctor',1,''),(2,'2014-01-10 06:33:22',1,11,'2','Call center operative',1,''),(3,'2014-01-10 06:33:34',1,11,'3','Management Team',1,''),(4,'2014-01-10 06:33:41',1,11,'4','System Administrator',1,''),(5,'2014-01-10 07:19:15',1,19,'3','Algeria',3,''),(6,'2014-01-10 07:19:15',1,19,'2','Albania',3,''),(7,'2014-01-10 07:19:15',1,19,'1','Afghanistan',3,''),(8,'2014-01-10 07:19:41',1,19,'43','China',3,''),(9,'2014-01-10 07:19:41',1,19,'42','Chile',3,''),(10,'2014-01-10 07:19:41',1,19,'41','Chad',3,''),(11,'2014-01-10 07:19:41',1,19,'40','Central african republic',3,''),(12,'2014-01-10 07:19:41',1,19,'39','Cayman islands',3,''),(13,'2014-01-10 07:19:41',1,19,'38','Cape verde',3,''),(14,'2014-01-10 07:19:41',1,19,'37','Canada',3,''),(15,'2014-01-10 07:19:41',1,19,'36','Cameroon',3,''),(16,'2014-01-10 07:19:41',1,19,'35','Cambodia',3,''),(17,'2014-01-10 07:19:41',1,19,'34','Burundi',3,''),(18,'2014-01-10 07:19:41',1,19,'33','Burkina faso',3,''),(19,'2014-01-10 07:19:41',1,19,'32','Bulgaria',3,''),(20,'2014-01-10 07:19:41',1,19,'31','British indian ocean territory',3,''),(21,'2014-01-10 07:19:41',1,19,'30','Brazil',3,''),(22,'2014-01-10 07:19:41',1,19,'29','Botswana',3,''),(23,'2014-01-10 07:19:41',1,19,'28','Bosnia and herzegovina',3,''),(24,'2014-01-10 07:19:41',1,19,'27','Bhutan',3,''),(25,'2014-01-10 07:19:41',1,19,'26','Bermuda',3,''),(26,'2014-01-10 07:19:41',1,19,'25','Benin',3,''),(27,'2014-01-10 07:19:41',1,19,'24','Belize',3,''),(28,'2014-01-10 07:19:41',1,19,'23','Belgium',3,''),(29,'2014-01-10 07:19:41',1,19,'22','Belarus',3,''),(30,'2014-01-10 07:19:41',1,19,'21','Barbados',3,''),(31,'2014-01-10 07:19:41',1,19,'20','Bangladesh',3,''),(32,'2014-01-10 07:19:41',1,19,'19','Bahrain',3,''),(33,'2014-01-10 07:19:41',1,19,'18','Bahamas',3,''),(34,'2014-01-10 07:19:41',1,19,'17','Azerbaijan',3,''),(35,'2014-01-10 07:19:41',1,19,'16','Austria',3,''),(36,'2014-01-10 07:19:41',1,19,'15','Australia',3,''),(37,'2014-01-10 07:19:41',1,19,'14','Aruba',3,''),(38,'2014-01-10 07:19:41',1,19,'13','Armenia',3,''),(39,'2014-01-10 07:19:41',1,19,'12','Argentina',3,''),(40,'2014-01-10 07:19:41',1,19,'11','Antigua and barbuda',3,''),(41,'2014-01-10 07:19:41',1,19,'10','Anguilla',3,''),(42,'2014-01-10 07:19:41',1,19,'9','Angola',3,''),(43,'2014-01-10 07:19:41',1,19,'8','Andorra',3,''),(44,'2014-01-10 07:19:41',1,19,'7','Americansamoa',3,''),(45,'2014-01-10 07:19:41',1,19,'6','Algeria',3,''),(46,'2014-01-10 07:19:41',1,19,'5','Albania',3,''),(47,'2014-01-10 07:19:41',1,19,'4','Afghanistan',3,''),(48,'2014-01-10 07:22:49',1,19,'240','Land islands',3,''),(49,'2014-01-10 07:22:49',1,19,'239','Zimbabwe',3,''),(50,'2014-01-10 07:22:49',1,19,'238','Zambia',3,''),(51,'2014-01-10 07:22:49',1,19,'237','Yemen',3,''),(52,'2014-01-10 07:22:49',1,19,'236','Wallis and futuna',3,''),(53,'2014-01-10 07:22:49',1,19,'235','Vanuatu',3,''),(54,'2014-01-10 07:22:49',1,19,'234','Uzbekistan',3,''),(55,'2014-01-10 07:22:49',1,19,'233','Uruguay',3,''),(56,'2014-01-10 07:22:49',1,19,'232','United states',3,''),(57,'2014-01-10 07:22:49',1,19,'231','United kingdom',3,''),(58,'2014-01-10 07:22:49',1,19,'230','United arab emirates',3,''),(59,'2014-01-10 07:22:49',1,19,'229','Ukraine',3,''),(60,'2014-01-10 07:22:49',1,19,'228','Uganda',3,''),(61,'2014-01-10 07:22:49',1,19,'227','Tuvalu',3,''),(62,'2014-01-10 07:22:49',1,19,'226','Turks and caicos islands',3,''),(63,'2014-01-10 07:22:49',1,19,'225','Turkmenistan',3,''),(64,'2014-01-10 07:22:49',1,19,'224','Turkey',3,''),(65,'2014-01-10 07:22:49',1,19,'223','Tunisia',3,''),(66,'2014-01-10 07:22:49',1,19,'222','Trinidad and tobago',3,''),(67,'2014-01-10 07:22:49',1,19,'221','Tonga',3,''),(68,'2014-01-10 07:22:49',1,19,'220','Tokelau',3,''),(69,'2014-01-10 07:22:49',1,19,'219','Togo',3,''),(70,'2014-01-10 07:22:49',1,19,'218','Thailand',3,''),(71,'2014-01-10 07:22:49',1,19,'217','Tajikistan',3,''),(72,'2014-01-10 07:22:49',1,19,'216','Switzerland',3,''),(73,'2014-01-10 07:22:49',1,19,'215','Sweden',3,''),(74,'2014-01-10 07:22:49',1,19,'214','Swaziland',3,''),(75,'2014-01-10 07:22:49',1,19,'213','Suriname',3,''),(76,'2014-01-10 07:22:49',1,19,'212','Sudan',3,''),(77,'2014-01-10 07:22:49',1,19,'211','Sri lanka',3,''),(78,'2014-01-10 07:22:49',1,19,'210','Spain',3,''),(79,'2014-01-10 07:22:49',1,19,'209','South georgia and the south sandwich islands',3,''),(80,'2014-01-10 07:22:49',1,19,'208','South africa',3,''),(81,'2014-01-10 07:22:49',1,19,'207','Solomon islands',3,''),(82,'2014-01-10 07:22:49',1,19,'206','Slovenia',3,''),(83,'2014-01-10 07:22:49',1,19,'205','Slovakia',3,''),(84,'2014-01-10 07:22:49',1,19,'204','Singapore',3,''),(85,'2014-01-10 07:22:49',1,19,'203','Sierra leone',3,''),(86,'2014-01-10 07:22:49',1,19,'202','Seychelles',3,''),(87,'2014-01-10 07:22:49',1,19,'201','Serbia',3,''),(88,'2014-01-10 07:22:49',1,19,'200','Senegal',3,''),(89,'2014-01-10 07:22:49',1,19,'199','Saudi arabia',3,''),(90,'2014-01-10 07:22:49',1,19,'198','San marino',3,''),(91,'2014-01-10 07:22:49',1,19,'197','Samoa',3,''),(92,'2014-01-10 07:22:49',1,19,'196','Rwanda',3,''),(93,'2014-01-10 07:22:49',1,19,'195','Romania',3,''),(94,'2014-01-10 07:22:49',1,19,'194','Qatar',3,''),(95,'2014-01-10 07:22:49',1,19,'193','Puerto rico',3,''),(96,'2014-01-10 07:22:49',1,19,'192','Portugal',3,''),(97,'2014-01-10 07:22:49',1,19,'191','Poland',3,''),(98,'2014-01-10 07:22:49',1,19,'190','Philippines',3,''),(99,'2014-01-10 07:22:49',1,19,'189','Peru',3,''),(100,'2014-01-10 07:22:49',1,19,'188','Paraguay',3,''),(101,'2014-01-10 07:22:49',1,19,'187','Papua new guinea',3,''),(102,'2014-01-10 07:22:49',1,19,'186','Panama',3,''),(103,'2014-01-10 07:22:49',1,19,'185','Palau',3,''),(104,'2014-01-10 07:22:49',1,19,'184','Pakistan',3,''),(105,'2014-01-10 07:22:49',1,19,'183','Oman',3,''),(106,'2014-01-10 07:22:49',1,19,'182','Norway',3,''),(107,'2014-01-10 07:22:49',1,19,'181','Northern mariana islands',3,''),(108,'2014-01-10 07:22:49',1,19,'180','Norfolk island',3,''),(109,'2014-01-10 07:22:49',1,19,'179','Niue',3,''),(110,'2014-01-10 07:22:49',1,19,'178','Nigeria',3,''),(111,'2014-01-10 07:22:49',1,19,'177','Niger',3,''),(112,'2014-01-10 07:22:49',1,19,'176','Nicaragua',3,''),(113,'2014-01-10 07:22:49',1,19,'175','New zealand',3,''),(114,'2014-01-10 07:22:49',1,19,'174','New caledonia',3,''),(115,'2014-01-10 07:22:49',1,19,'173','Netherlands antilles',3,''),(116,'2014-01-10 07:22:49',1,19,'172','Netherlands',3,''),(117,'2014-01-10 07:22:49',1,19,'171','Nepal',3,''),(118,'2014-01-10 07:22:49',1,19,'170','Nauru',3,''),(119,'2014-01-10 07:22:49',1,19,'169','Namibia',3,''),(120,'2014-01-10 07:22:49',1,19,'168','Myanmar',3,''),(121,'2014-01-10 07:22:49',1,19,'167','Morocco',3,''),(122,'2014-01-10 07:22:49',1,19,'166','Montserrat',3,''),(123,'2014-01-10 07:22:49',1,19,'165','Montenegro',3,''),(124,'2014-01-10 07:22:49',1,19,'164','Mongolia',3,''),(125,'2014-01-10 07:22:49',1,19,'163','Monaco',3,''),(126,'2014-01-10 07:22:49',1,19,'162','Mexico',3,''),(127,'2014-01-10 07:22:49',1,19,'161','Mayotte',3,''),(128,'2014-01-10 07:22:49',1,19,'160','Mauritius',3,''),(129,'2014-01-10 07:22:49',1,19,'159','Mauritania',3,''),(130,'2014-01-10 07:22:49',1,19,'158','Martinique',3,''),(131,'2014-01-10 07:22:49',1,19,'157','Marshall islands',3,''),(132,'2014-01-10 07:22:49',1,19,'156','Malta',3,''),(133,'2014-01-10 07:22:49',1,19,'155','Mali',3,''),(134,'2014-01-10 07:22:49',1,19,'154','Maldives',3,''),(135,'2014-01-10 07:22:49',1,19,'153','Malaysia',3,''),(136,'2014-01-10 07:22:49',1,19,'152','Malawi',3,''),(137,'2014-01-10 07:22:49',1,19,'151','Madagascar',3,''),(138,'2014-01-10 07:22:49',1,19,'150','Luxembourg',3,''),(139,'2014-01-10 07:22:49',1,19,'149','Lithuania',3,''),(140,'2014-01-10 07:22:49',1,19,'148','Liechtenstein',3,''),(141,'2014-01-10 07:22:49',1,19,'147','Liberia',3,''),(142,'2014-01-10 07:22:49',1,19,'146','Lesotho',3,''),(143,'2014-01-10 07:22:49',1,19,'145','Lebanon',3,''),(144,'2014-01-10 07:22:49',1,19,'144','Latvia',3,''),(145,'2014-01-10 07:22:49',1,19,'143','Kyrgyzstan',3,''),(146,'2014-01-10 07:22:49',1,19,'142','Kuwait',3,''),(147,'2014-01-10 07:22:49',1,19,'141','Kiribati',3,''),(148,'2014-01-10 07:22:55',1,19,'140','Kenya',3,''),(149,'2014-01-10 07:22:55',1,19,'139','Kazakhstan',3,''),(150,'2014-01-10 07:22:55',1,19,'138','Jordan',3,''),(151,'2014-01-10 07:22:55',1,19,'137','Japan',3,''),(152,'2014-01-10 07:22:55',1,19,'136','Jamaica',3,''),(153,'2014-01-10 07:22:55',1,19,'135','Italy',3,''),(154,'2014-01-10 07:22:55',1,19,'134','Israel',3,''),(155,'2014-01-10 07:22:55',1,19,'133','Ireland',3,''),(156,'2014-01-10 07:22:55',1,19,'132','Iraq',3,''),(157,'2014-01-10 07:22:55',1,19,'131','Indonesia',3,''),(158,'2014-01-10 07:22:55',1,19,'130','India',3,''),(159,'2014-01-10 07:22:55',1,19,'129','Iceland',3,''),(160,'2014-01-10 07:22:55',1,19,'128','Hungary',3,''),(161,'2014-01-10 07:22:55',1,19,'127','Honduras',3,''),(162,'2014-01-10 07:22:55',1,19,'126','Haiti',3,''),(163,'2014-01-10 07:22:55',1,19,'125','Guyana',3,''),(164,'2014-01-10 07:22:55',1,19,'124','Guinea-bissau',3,''),(165,'2014-01-10 07:22:55',1,19,'123','Guinea',3,''),(166,'2014-01-10 07:22:55',1,19,'122','Guatemala',3,''),(167,'2014-01-10 07:22:55',1,19,'121','Guam',3,''),(168,'2014-01-10 07:22:55',1,19,'120','Guadeloupe',3,''),(169,'2014-01-10 07:22:55',1,19,'119','Grenada',3,''),(170,'2014-01-10 07:22:55',1,19,'118','Greenland',3,''),(171,'2014-01-10 07:22:55',1,19,'117','Greece',3,''),(172,'2014-01-10 07:22:55',1,19,'116','Gibraltar',3,''),(173,'2014-01-10 07:22:55',1,19,'115','Ghana',3,''),(174,'2014-01-10 07:22:55',1,19,'114','Germany',3,''),(175,'2014-01-10 07:22:55',1,19,'113','Georgia',3,''),(176,'2014-01-10 07:22:55',1,19,'112','Gambia',3,''),(177,'2014-01-10 07:22:55',1,19,'111','Gabon',3,''),(178,'2014-01-10 07:22:55',1,19,'110','French polynesia',3,''),(179,'2014-01-10 07:22:55',1,19,'109','French guiana',3,''),(180,'2014-01-10 07:22:55',1,19,'108','France',3,''),(181,'2014-01-10 07:22:55',1,19,'107','Finland',3,''),(182,'2014-01-10 07:22:55',1,19,'106','Fiji',3,''),(183,'2014-01-10 07:22:55',1,19,'105','Faroe islands',3,''),(184,'2014-01-10 07:22:55',1,19,'104','Ethiopia',3,''),(185,'2014-01-10 07:22:55',1,19,'103','Estonia',3,''),(186,'2014-01-10 07:22:55',1,19,'102','Eritrea',3,''),(187,'2014-01-10 07:22:55',1,19,'101','Equatorial guinea',3,''),(188,'2014-01-10 07:22:55',1,19,'100','El salvador',3,''),(189,'2014-01-10 07:22:55',1,19,'99','Egypt',3,''),(190,'2014-01-10 07:22:55',1,19,'98','Ecuador',3,''),(191,'2014-01-10 07:22:55',1,19,'97','Dominican republic',3,''),(192,'2014-01-10 07:22:55',1,19,'96','Dominica',3,''),(193,'2014-01-10 07:22:55',1,19,'95','Djibouti',3,''),(194,'2014-01-10 07:22:55',1,19,'94','Denmark',3,''),(195,'2014-01-10 07:22:55',1,19,'93','Czech republic',3,''),(196,'2014-01-10 07:22:55',1,19,'92','Cyprus',3,''),(197,'2014-01-10 07:22:55',1,19,'91','Cuba',3,''),(198,'2014-01-10 07:22:55',1,19,'90','Croatia',3,''),(199,'2014-01-10 07:22:55',1,19,'89','Costa rica',3,''),(200,'2014-01-10 07:22:55',1,19,'88','Cook islands',3,''),(201,'2014-01-10 07:22:55',1,19,'87','Congo',3,''),(202,'2014-01-10 07:22:55',1,19,'86','Comoros',3,''),(203,'2014-01-10 07:22:55',1,19,'85','Colombia',3,''),(204,'2014-01-10 07:22:55',1,19,'84','Christmas island',3,''),(205,'2014-01-10 07:22:55',1,19,'83','China',3,''),(206,'2014-01-10 07:22:55',1,19,'82','Chile',3,''),(207,'2014-01-10 07:22:55',1,19,'81','Chad',3,''),(208,'2014-01-10 07:22:55',1,19,'80','Central african republic',3,''),(209,'2014-01-10 07:22:55',1,19,'79','Cayman islands',3,''),(210,'2014-01-10 07:22:55',1,19,'78','Cape verde',3,''),(211,'2014-01-10 07:22:55',1,19,'77','Canada',3,''),(212,'2014-01-10 07:22:55',1,19,'76','Cameroon',3,''),(213,'2014-01-10 07:22:55',1,19,'75','Cambodia',3,''),(214,'2014-01-10 07:22:55',1,19,'74','Burundi',3,''),(215,'2014-01-10 07:22:55',1,19,'73','Burkina faso',3,''),(216,'2014-01-10 07:22:55',1,19,'72','Bulgaria',3,''),(217,'2014-01-10 07:22:55',1,19,'71','British indian ocean territory',3,''),(218,'2014-01-10 07:22:55',1,19,'70','Brazil',3,''),(219,'2014-01-10 07:22:55',1,19,'69','Botswana',3,''),(220,'2014-01-10 07:22:55',1,19,'68','Bosnia and herzegovina',3,''),(221,'2014-01-10 07:22:55',1,19,'67','Bhutan',3,''),(222,'2014-01-10 07:22:55',1,19,'66','Bermuda',3,''),(223,'2014-01-10 07:22:55',1,19,'65','Benin',3,''),(224,'2014-01-10 07:22:55',1,19,'64','Belize',3,''),(225,'2014-01-10 07:22:55',1,19,'63','Belgium',3,''),(226,'2014-01-10 07:22:55',1,19,'62','Belarus',3,''),(227,'2014-01-10 07:22:55',1,19,'61','Barbados',3,''),(228,'2014-01-10 07:22:55',1,19,'60','Bangladesh',3,''),(229,'2014-01-10 07:22:55',1,19,'59','Bahrain',3,''),(230,'2014-01-10 07:22:55',1,19,'58','Bahamas',3,''),(231,'2014-01-10 07:22:55',1,19,'57','Azerbaijan',3,''),(232,'2014-01-10 07:22:55',1,19,'56','Austria',3,''),(233,'2014-01-10 07:22:55',1,19,'55','Australia',3,''),(234,'2014-01-10 07:22:55',1,19,'54','Aruba',3,''),(235,'2014-01-10 07:22:55',1,19,'53','Armenia',3,''),(236,'2014-01-10 07:22:55',1,19,'52','Argentina',3,''),(237,'2014-01-10 07:22:55',1,19,'51','Antigua and barbuda',3,''),(238,'2014-01-10 07:22:55',1,19,'50','Anguilla',3,''),(239,'2014-01-10 07:22:55',1,19,'49','Angola',3,''),(240,'2014-01-10 07:22:55',1,19,'48','Andorra',3,''),(241,'2014-01-10 07:22:55',1,19,'47','Americansamoa',3,''),(242,'2014-01-10 07:22:55',1,19,'46','Algeria',3,''),(243,'2014-01-10 07:22:55',1,19,'45','Albania',3,''),(244,'2014-01-10 07:22:55',1,19,'44','Afghanistan',3,''),(245,'2014-01-10 07:28:37',1,20,'1','Maharashtra',1,''),(246,'2014-01-10 07:28:42',1,21,'1','Mumbai (Maharashtra)',1,''),(247,'2014-01-10 07:28:45',1,3,'1','admin',2,'Changed password. Added user profile \"Admin\".'),(248,'2014-01-13 06:48:55',1,3,'1','admin',2,'Changed password, first_name and last_name.'),(249,'2014-01-13 14:21:41',1,3,'2','gaurav',3,''),(250,'2014-01-13 14:21:41',1,3,'3','gauravk',3,''),(251,'2014-01-13 14:23:15',1,13,'1','gauravk',3,''),(252,'2014-01-13 14:23:23',1,3,'4','gauravk',3,''),(253,'2014-01-13 14:33:45',1,13,'2','gauravk',2,'Changed is_activated.'),(254,'2014-01-14 10:40:26',1,13,'3','v2',2,'Changed is_activated.'),(255,'2014-01-14 13:12:08',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',1,''),(256,'2014-01-14 13:12:30',1,14,'2','gauravk-2014-01-14T18:42:17+05:30',1,''),(257,'2014-01-14 13:13:00',1,17,'1','Job object',1,''),(258,'2014-01-14 13:13:55',1,17,'2','Job object',1,''),(259,'2014-01-15 07:16:52',1,3,'9','anup',3,''),(260,'2014-01-15 07:16:52',1,3,'8','anupd',3,''),(261,'2014-01-15 07:21:30',1,3,'11','ankit',3,''),(262,'2014-01-15 07:22:32',1,3,'12','ankit',3,''),(263,'2014-01-15 07:24:07',1,3,'13','ankit',3,''),(264,'2014-01-15 07:25:51',1,3,'14','ankit',3,''),(265,'2014-01-15 07:28:08',1,3,'15','ankit',3,''),(266,'2014-01-15 07:32:03',1,3,'16','ankit',3,''),(267,'2014-01-15 07:33:01',1,3,'17','ankit',3,''),(268,'2014-01-15 12:42:29',1,15,'1','Task object',1,''),(269,'2014-01-15 12:42:46',1,15,'2','Task object',1,''),(270,'2014-01-15 12:59:23',1,15,'2','Task object',2,'Changed completion_date.'),(271,'2014-01-15 12:59:52',1,15,'2','Task object',2,'Changed completion_date.'),(272,'2014-01-15 13:00:24',1,14,'2','gauravk-2014-01-14T18:42:17+05:30',2,'Changed completion_date.'),(273,'2014-01-15 13:00:40',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',2,'Changed completion_date.'),(274,'2014-01-15 13:00:53',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',2,'Changed completion_date.'),(275,'2014-01-15 13:01:06',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',2,'Changed completion_date.'),(276,'2014-01-15 13:01:32',1,15,'1','Task object',2,'Changed completion_date and status.'),(277,'2014-01-15 13:11:03',1,17,'1','Job object',3,''),(278,'2014-01-15 13:12:44',1,14,'2','gauravk-2014-01-14T18:42:17+05:30',2,'Changed actual_completion_date.'),(279,'2014-01-15 13:14:57',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',2,'No fields changed.'),(280,'2014-01-15 13:15:36',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',2,'Changed completion_date.'),(281,'2014-01-15 13:16:27',1,14,'1','gauravk-2014-01-14T18:41:52+05:30',2,'Changed completion_date.'),(282,'2014-01-15 13:16:49',1,15,'2','Task object',2,'Changed completion_date.'),(283,'2014-01-15 13:17:00',1,15,'1','Task object',2,'No fields changed.'),(284,'2014-01-15 13:17:27',1,14,'2','gauravk-2014-01-14T18:42:17+05:30',2,'Changed completion_date.'),(285,'2014-01-16 09:44:32',1,18,'17','Ankit: 2014-01-31',3,''),(286,'2014-01-16 09:44:32',1,18,'16','Ankit: 2014-01-30',3,''),(287,'2014-01-16 09:44:32',1,18,'15','Ankit: 2014-01-29',3,''),(288,'2014-01-16 09:44:32',1,18,'14','Ankit: 2014-01-28',3,''),(289,'2014-01-16 09:44:32',1,18,'13','Ankit: 2014-01-27',3,''),(290,'2014-01-16 09:44:32',1,18,'12','Ankit: 2014-01-26',3,''),(291,'2014-01-16 09:44:32',1,18,'11','Ankit: 2014-01-25',3,''),(292,'2014-01-16 09:44:32',1,18,'10','Ankit: 2014-01-24',3,''),(293,'2014-01-16 09:44:32',1,18,'9','Ankit: 2014-01-23',3,''),(294,'2014-01-16 09:44:32',1,18,'8','Ankit: 2014-01-22',3,''),(295,'2014-01-16 09:44:32',1,18,'7','Ankit: 2014-01-21',3,''),(296,'2014-01-16 09:44:32',1,18,'6','Ankit: 2014-01-20',3,''),(297,'2014-01-16 09:44:32',1,18,'5','Ankit: 2014-01-19',3,''),(298,'2014-01-16 09:44:32',1,18,'4','Ankit: 2014-01-18',3,''),(299,'2014-01-16 09:44:32',1,18,'3','Ankit: 2014-01-17',3,''),(300,'2014-01-16 09:44:32',1,18,'2','Ankit: 2014-01-16',3,''),(301,'2014-01-16 09:44:32',1,18,'1','Ankit: 2014-01-15',3,''),(302,'2014-01-16 10:26:45',1,15,'6','Task object',2,'No fields changed.'),(303,'2014-01-16 10:27:19',1,3,'19','sumegha',1,''),(304,'2014-01-20 06:55:33',1,14,'14','gauravk-2014-01-20T12:25:19+05:30',1,''),(305,'2014-01-20 06:56:03',1,15,'8','Task object',1,''),(306,'2014-01-23 10:15:27',1,17,'8','Job object',2,'Changed status and actual_completed_date.'),(307,'2014-01-23 10:15:46',1,17,'8','Job object',2,'Changed actual_completed_date.'),(308,'2014-01-27 10:46:43',1,14,'19','v2-2014-01-22T15:13:24+05:30',2,'Changed actual_completion_date.'),(309,'2014-01-27 10:46:51',1,14,'18','v2-2014-01-22T15:13:03+05:30',2,'Changed actual_completion_date.'),(310,'2014-01-27 10:47:00',1,14,'17','v2-2014-01-22T15:11:44+05:30',2,'Changed actual_completion_date.'),(311,'2014-01-27 10:47:13',1,14,'16','v2-2014-01-22T15:11:20+05:30',2,'Changed actual_completion_date.'),(312,'2014-01-27 10:47:27',1,14,'15','v2-2014-01-22T15:10:08+05:30',2,'Changed actual_completion_date.'),(313,'2014-01-27 10:47:45',1,14,'13','gauravk-2014-01-16T16:53:06+05:30',2,'Changed actual_completion_date.'),(314,'2014-01-28 06:31:03',1,14,'3','v2-2014-01-16T14:23:40+05:30',2,'Changed actual_completion_date and status.'),(315,'2014-01-28 06:31:27',1,14,'3','v2-2014-01-16T14:23:40+05:30',2,'Changed actual_completion_date.'),(316,'2014-01-28 06:32:07',1,14,'2','gauravk-2014-01-14T18:42:17+05:30',2,'Changed completion_date.'),(317,'2014-01-28 06:34:40',1,15,'1','Task object',2,'Changed status.'),(318,'2014-01-28 06:35:49',1,14,'3','v2-2014-01-14T14:23:40+05:30',2,'Changed submitted_at and actual_completion_date.'),(319,'2014-01-28 06:35:57',1,15,'3','Task object',2,'Changed completion_date.'),(320,'2014-01-28 06:57:23',1,15,'3','Task object',2,'Changed completion_date.'),(321,'2014-01-28 06:57:30',1,14,'7','v2-2014-01-16T14:53:43+05:30',2,'Changed actual_completion_date.'),(322,'2014-01-28 06:58:53',1,14,'10','v2-2014-01-16T15:18:44+05:30',2,'Changed actual_completion_date and status.'),(323,'2014-01-28 06:58:58',1,15,'4','Task object',2,'Changed completion_date.'),(324,'2014-01-28 06:59:33',1,15,'4','Task object',2,'Changed status.'),(325,'2014-01-28 14:21:01',1,14,'3','v2-2014-01-01T14:23:40+05:30',2,'Changed submitted_at.'),(326,'2014-01-28 14:21:20',1,14,'3','v2-2014-01-01T14:23:40+05:30',2,'No fields changed.'),(327,'2014-01-28 14:22:52',1,14,'2','gauravk-2014-01-01T18:42:17+05:30',2,'Changed submitted_at.'),(328,'2014-01-28 14:27:43',1,14,'2','gauravk-2014-01-01T18:42:17+05:30',2,'Changed actual_completion_date.'),(329,'2014-02-06 11:27:02',1,17,'2','Job object',2,'Changed call_date, summary, completion_date and actual_completed_date.'),(330,'2014-02-06 11:35:50',1,17,'7','Job object',2,'Changed completion_date.'),(331,'2014-02-06 11:39:23',1,17,'2','Job object',2,'No fields changed.'),(332,'2014-02-06 11:39:58',1,17,'3','Job object',2,'Changed call_date, completion_date and actual_completed_date.'),(333,'2014-02-06 11:40:03',1,17,'3','Job object',2,'Changed status.'),(334,'2014-02-06 11:40:05',1,17,'3','Job object',2,'No fields changed.'),(335,'2014-02-25 09:51:28',1,3,'23','jensen',3,''),(336,'2014-02-25 09:51:28',1,3,'24','jensens',3,''),(337,'2014-02-25 10:08:16',1,3,'27','tushar',3,''),(338,'2014-02-27 14:57:01',1,3,'1','admin',2,'Changed password.');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'migration history','south','migrationhistory'),(9,'log action','object_log','logaction'),(10,'log item','object_log','logitem'),(11,'role','users','role'),(12,'user profile','users','userprofile'),(13,'patient','patients','patient'),(14,'episode','patients','episode'),(15,'task','patients','task'),(16,'query','tasks','query'),(17,'job','tasks','job'),(18,'occurrence','availability','occurrence'),(19,'country','address','country'),(20,'state','address','state'),(21,'city','address','city');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('fce9xqyo86s15ww3eq8bb0s3ihwi1cjx','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-01-30 09:32:23'),('ri5bcvmkks3u88s1x4tdr0143d6t3tat','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-24 06:32:46'),('15cs67lrvfx27u47jq9wfr9n90c1skq6','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-24 10:08:11'),('7xoka3s6794zfg2siofqn4lqxpap4ibi','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-24 06:32:59'),('e64mpltcktfa1ntjf08eoklxuvrx81fp','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-24 09:11:59'),('yolk1elzu1h8s9dr8s118quw8v9veh0s','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-24 10:08:24'),('u7hs2m3at90fa8druk15v1jcarrk9rk5','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-24 10:09:40'),('4ev6kk7lr8utyzoe3hnl2tv4s4hakcba','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-27 06:40:43'),('3k83agpfco38mxjrmahsp2zwyrldf1ao','NTM5YjQ5ZjgwODBmM2ZmY2RmZGU4ZGZkM2E3ZjFjN2Q2MGYyY2MyODp7InBhc3Njb2RlIjoiZ2k4eG95ajNkdiIsInVzZXJuYW1lIjoiZ2F1cmF2ayIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=','2014-01-27 14:34:10'),('dxnsgxugnaashgcbz2x79rruyb2hu5pq','NjhlZWM4NDE5NDcyNzUxMjY5Mjk3ZmFiMDY3MDkxYTYxZjAzMDkzNTp7InBhc3Njb2RlIjoiZ2k4eG95ajNkdiIsInVzZXJuYW1lIjoiZ2F1cmF2ayIsIl9hdXRoX3VzZXJfaWQiOjUsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-01-29 09:47:07'),('l98bpcid9jxocqr13orypkykenelhrnz','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-02-01 05:55:44'),('swl89wsstomej9m6q02yr6fbho8cwh3a','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-30 06:48:50'),('4zdfw73hi1jjn51o8n4emib16i3wpb5j','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-10 10:14:05'),('pjim0fjnk7vto6rcj7jhyujkd41q9q0w','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-30 06:51:46'),('lh1cmazdcs2w68cmkbb0o8aadp3qhf5p','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-05 13:21:53'),('gyhsgiytjthp4g5bq9m8qtcif5kdhf6h','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-30 07:03:03'),('nn0yfn9z3p5v9aii119d5ghh3w7m2zsz','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-30 06:46:17'),('26r7k8fktsk5zyar92xqyyy3uao0c95d','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-05 09:44:18'),('45detkhpl7fmhpj9xhljxc1r1dlh6xev','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-01-30 09:23:08'),('d4oscwlcvybhq5gya5h358hbfb2mn9nw','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-29 13:12:06'),('pikmospaqfexuv531aklc6ni4ichwpmz','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-01-30 09:22:52'),('juzr5xd8d2dbzou5f713xlw47mjux43t','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-01-30 10:46:00'),('vmlo456e48v9fehjsij67symc6oe2w3z','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-30 10:26:40'),('1far9wh8sebilvwxqmr5c0p2tgpzwwu4','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-02-01 06:08:50'),('8xuswh2r7by5gtggk6hdon9ivdryxazg','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-01 05:54:40'),('a4p2c2idx6x6mwfosmj43epj6ip67oeq','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-02-01 07:02:05'),('8mq3zjuddnmsqnot86jowngi1blpctz3','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-02-01 07:31:08'),('5zthheehq6yyjgew1x8wkqw3xromcpc7','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-01 07:29:37'),('pvqnt3p3ip6n6h8a3491pg5a05f1ibc5','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-01 10:30:56'),('iwm0h37nxmgsh8a7p17ebtdg7zvevft8','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-01 07:41:49'),('6hgcmwtkw2kr587kfd9sxb65p3uoad0t','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-03 06:13:20'),('80j7pqp05smuyd3xvqnaog3g8qi4yr6l','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-01 10:30:18'),('564rvx6gqvv968d8uz586q3b32zavkw9','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-02-01 10:45:29'),('24047uw8tu9ghx49fi2pu4o5c7zjh820','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-03 11:22:16'),('l3m3smjko0irya88oq2ab962j9hmd9gd','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-03 06:52:43'),('qr6dmyvqp2a75t7zkr8qqr01aue342w0','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-02-03 09:43:45'),('l6uvbnykwhxe0x0qk1l7db2abdleg28w','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-03 11:29:46'),('8b7xurohvx4qibn5m6tknp5t91j7wt0r','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-03 12:21:13'),('ucpvbxms8umjtfqjwpftwj2p4asqp38y','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-05 06:21:07'),('1rqyg4jrw1czr4zc35zhxvyen6nxng9k','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-03 13:06:58'),('aylljl9w8nyqelwqjesl7dc90t75fdxq','ZjRlOTUwYTAyMzgyZTJiZmMyYWU1OGQ1MTVkNDIwZDBmNTM4NWM3NDp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2lkIjo2LCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2014-02-05 08:00:14'),('2calznpsip0tl68a0yw2xwenadl5pc48','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 11:19:48'),('yyc0bhrl7ecorouw1akbkm4k0rcjkda4','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-12 11:24:30'),('nqm5iacvq0xfh7h31wtzlbhgjohctukf','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-06 09:38:56'),('t0m5irez15l0ovxckvifu1z16188drvz','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-13 08:35:39'),('h4scwm14nuxp6sqv90rw2ab6gofy4ei6','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-13 06:34:45'),('nfs190qniewne5y4ia6o3clkade7gybf','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-15 11:12:04'),('fv31ee5ncabul6o4asezens35r0lby9n','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-18 14:48:32'),('3vj20yizmw3fpnxtad3yptmnkok1vbsr','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-18 14:50:44'),('mxic8t9iupnf2yeid8ogm9km8qvuz249','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-18 14:53:19'),('n42ejvn0dubb9un1qph4udevdjd54c2n','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:27:55'),('1nwox6shqhcbtq12lq6ogqr7do71grez','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:30:16'),('w72r8nyp6b1gjdm8ug79y2g0jiekxi6f','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:31:49'),('pd38rbltazpqkie7oasmnyeu47ljc0hz','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:38:03'),('jb5ipppao9ue5i6fvixbetpn4jfxhmrn','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:47:48'),('85bdzi13t9kp3qvs5kthv1rr35kevg7b','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:50:47'),('u0hwvvfwzx6tz47o5wujhecaup1f3bri','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:54:15'),('7pbv7lm1zf4iqkoubkfv4t3dt9jyxbej','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:57:07'),('r4rtg7a437ultrfrv0o8vkz7qqtydxtz','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 07:59:03'),('c1vzefv9nvdpmflz217nnifhnw8sm25i','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 08:01:10'),('6ywqbjrhpz0uor86712nezcgpn9x3sfr','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 11:38:19'),('f6wr2uoyrzkgbt2kwx6w4zti4qrn9pl9','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 11:35:25'),('snbh7r1bugn478oj70j9guvy7uta26uj','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 11:45:08'),('3q5id06q1203wwv6724kqlhon2kmx2xs','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 12:25:15'),('l4fjzgw4c897deft3kuu95yqkaynosai','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 12:52:08'),('jh1t4n2gmkc68gf9rj5q8n34dy1izd7f','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 12:59:40'),('f2hn5s95i83itsf11hxcsfqkmk3s8gtk','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 12:56:06'),('jko94zypfjqi4sxpx8axfxot45setlcr','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 13:04:23'),('mi89g8wam2tfaayjdw55ygn5kja0dywv','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 13:05:06'),('cj5de6n2ez9h8wncs7pauinw6ewrzamr','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 14:16:35'),('k50v8yz4q1lcieklu9drg3lvvb0cc1bn','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-19 14:27:39'),('87o5wnrwe87w7paxnvt6f905bpudugpa','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-20 07:14:24'),('yys95g5cog8w0mcfm9stiyfa1w7inp9v','NTI3NTkxYTNhYjJlMzQ1N2UwZjUwYzI3ZmU5ZTE3YTA0MTdiNWIyYjp7InBhc3Njb2RlIjoibW9lYmU3c3hjcSIsInVzZXJuYW1lIjoidjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjZ9','2014-02-19 14:20:09'),('tsrco4wcjt17imeb8m320pjfqcidmfta','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-11 10:18:55'),('11odrcryiow7399otz2vel8gqp332o2a','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-20 11:41:59'),('ls3rdqw41y7q840k6ia0d1a46b0ppwkx','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-03-12 06:17:40'),('mvvhr3p37z9gr09vw7ds3t1eufxo1106','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-02-20 13:05:52'),('ue1ttjjxh00bmtrar90pcsjnqdmguy83','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-20 13:32:58'),('1r3zxmcyzh7qg6hsy976o6ycbav4jd7e','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-11 10:24:44'),('gq07kv4rt1mgtxft5lzcl53xhkxgjyc2','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-11 09:37:41'),('wgc4i03dskwr7wkzaag48aunbepcxumf','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-02-20 12:07:43'),('1a5w9wyztu6yac6hd59qixx68ejhukr7','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-03-12 06:01:56'),('jt63dgtri7r4b4x57pwxjxwn28bwy076','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-03-12 06:17:40'),('e59x5bpwx17ivrbo8pj3s5s1rr1gfog1','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-12 09:41:06'),('yum1f15suxdig0rkmi6gbkv5iwwfpf3u','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-12 11:11:11'),('q8jc16ba58oh5nfo18nihzpvwaxcmvtr','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-19 09:18:38'),('rdhf5gwt85n27upb1xqb5mhyyx3hjd05','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-03-19 09:09:45'),('k3j2s7d0i08uygvdyd9v4e5j1qqv567z','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-14 10:38:43'),('q3hda7ssovutp8n145iohgr1613rgyyg','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-14 09:36:32'),('2tb899m1sjmti12wigtswm6xjrgyj1k4','YmYxNzFkODlkMDRhMWI2MzZlYzZhMzY3ZjFlYzRiYjUzMDQ0MTA3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6N30=','2014-03-13 14:59:38'),('4huvfeiicz87wtqjthky3rzlx6q6314w','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-03-21 06:00:29'),('bctw3yblhig6fgfrc4xp2io3dhca5i7z','YmYxNzFkODlkMDRhMWI2MzZlYzZhMzY3ZjFlYzRiYjUzMDQ0MTA3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6N30=','2014-03-21 05:30:02'),('id79j3nnmg7swjk4e73ocrglb60qm6pt','NzI3NWY3N2UzZTJmOGJjNjRiN2E2MjE1MmU2OTljYTM5MGVjZmM3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-03-20 12:57:51'),('qji9n0tf4mqqmbnqnvgn87fsgh1y0vdb','NzBiOWVmYzQwYTU3MDcwYzc2ODFkMDVkMmQ4ODU3MjczM2EyMGIxZTp7fQ==','2014-03-20 13:27:03'),('80odvo9dno7lh7nalliy6y33e94cgdnu','NGRlZWZlOWI1MDdmNTQxMDdlMTdmYTFlMTMzNzAyMzExMmExNTdkNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTh9','2014-03-19 13:02:49'),('grxbq39j88uhcl9xjiauuj81xfg2vqv1','YmYxNzFkODlkMDRhMWI2MzZlYzZhMzY3ZjFlYzRiYjUzMDQ0MTA3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6N30=','2014-03-21 07:30:51');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_log_logaction`
--

DROP TABLE IF EXISTS `object_log_logaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_log_logaction` (
  `name` varchar(128) NOT NULL,
  `template` varchar(128) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `template` (`template`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_log_logaction`
--

LOCK TABLES `object_log_logaction` WRITE;
/*!40000 ALTER TABLE `object_log_logaction` DISABLE KEYS */;
INSERT INTO `object_log_logaction` VALUES ('EDIT','object_log/edit.html'),('CREATE','log.html'),('DELETE','object_log/delete.html');
/*!40000 ALTER TABLE `object_log_logaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_log_logitem`
--

DROP TABLE IF EXISTS `object_log_logitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_log_logitem` (
  `timestamp` datetime NOT NULL,
  `object_id3` int(10) unsigned DEFAULT NULL,
  `object_id2` int(10) unsigned DEFAULT NULL,
  `object_id1` int(10) unsigned DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `action_id` varchar(128) NOT NULL,
  `object_type1_id` int(11) DEFAULT NULL,
  `object_type2_id` int(11) DEFAULT NULL,
  `object_type3_id` int(11) DEFAULT NULL,
  `serialized_data` longtext,
  PRIMARY KEY (`id`),
  KEY `object_log_logitem_6340c63c` (`user_id`),
  KEY `object_log_logitem_e7c54ddc` (`action_id`),
  KEY `object_log_logitem_762ebdee` (`object_type1_id`),
  KEY `object_log_logitem_359a730d` (`object_type2_id`),
  KEY `object_log_logitem_3f68f82c` (`object_type3_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_log_logitem`
--

LOCK TABLES `object_log_logitem` WRITE;
/*!40000 ALTER TABLE `object_log_logitem` DISABLE KEYS */;
INSERT INTO `object_log_logitem` VALUES ('2014-01-13 08:30:15',NULL,NULL,1,1,1,'EDIT',3,NULL,NULL,'{\"object1_str\": \"admin\"}'),('2014-01-13 08:37:20',NULL,NULL,1,2,1,'EDIT',3,NULL,NULL,'{\"object1_str\": \"admin\"}'),('2014-01-13 10:43:05',NULL,NULL,1,3,1,'EDIT',3,NULL,NULL,'{\"object1_str\": \"admin\"}'),('2014-01-13 10:45:50',NULL,NULL,1,4,1,'EDIT',3,NULL,NULL,'{\"object1_str\": \"admin\"}'),('2014-01-13 10:45:57',NULL,NULL,1,5,1,'EDIT',3,NULL,NULL,'{\"object1_str\": \"admin\"}'),('2014-01-13 10:46:02',NULL,NULL,1,6,1,'EDIT',3,NULL,NULL,'{\"object1_str\": \"admin\"}'),('2014-01-13 14:21:47',NULL,NULL,1,7,1,'CREATE',3,NULL,NULL,'{\"msg\": \"create Patient account for Gaurav\"}'),('2014-01-13 14:23:25',NULL,NULL,1,8,1,'CREATE',3,NULL,NULL,'{\"msg\": \"create Patient account for Gaurav\"}'),('2014-01-14 10:35:28',NULL,NULL,1,9,1,'CREATE',3,NULL,NULL,'{\"msg\": \"create Patient account for V2\"}'),('2014-01-14 13:11:12',NULL,NULL,5,10,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Vivek with role Call center operative\"}'),('2014-01-15 07:17:02',NULL,NULL,6,11,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Anup with role Call center operative\"}'),('2014-01-15 07:20:51',NULL,NULL,7,12,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:21:33',NULL,NULL,8,13,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:22:38',NULL,NULL,9,14,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:24:20',NULL,NULL,10,15,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:25:54',NULL,NULL,11,16,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:28:18',NULL,NULL,12,17,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:32:06',NULL,NULL,13,18,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 07:33:06',NULL,NULL,14,19,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ankit with role Doctor\"}'),('2014-01-15 12:46:36',NULL,NULL,14,20,18,'EDIT',12,NULL,NULL,'{\"object1_str\": \"Ankit\"}'),('2014-01-18 05:50:29',NULL,NULL,15,21,1,'EDIT',12,NULL,NULL,'{\"object1_str\": \"Sumegha\"}'),('2014-01-18 09:56:40',NULL,NULL,1,22,1,'CREATE',3,NULL,NULL,'{\"msg\": \"create Patient account for P test\"}'),('2014-01-18 11:11:24',NULL,NULL,14,23,18,'EDIT',12,NULL,NULL,'{\"object1_str\": \"Ankit\"}'),('2014-01-18 11:12:33',NULL,NULL,14,24,18,'EDIT',12,NULL,NULL,'{\"object1_str\": \"Ankit\"}'),('2014-01-20 12:06:40',NULL,NULL,17,25,1,'CREATE',12,NULL,NULL,'{\"msg\": \"created account successfully for Ratan with role Call center operative\"}'),('2014-01-29 11:41:12',NULL,NULL,14,26,1,'EDIT',12,NULL,NULL,'{\"object1_str\": \"Ankit\"}');
/*!40000 ALTER TABLE `object_log_logitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients_episode`
--

DROP TABLE IF EXISTS `patients_episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients_episode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `image1` varchar(100) DEFAULT NULL,
  `image2` varchar(100) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `actual_completion_date` date DEFAULT NULL,
  `feedback` longtext,
  `episode_no` varchar(90) DEFAULT NULL,
  `comments` longtext,
  `status` varchar(128) DEFAULT NULL,
  `smokes` tinyint(1) NOT NULL,
  `alcohol` tinyint(1) NOT NULL,
  `allergies` longtext,
  `prev_disease` longtext,
  `current_medication` longtext,
  `family_history` longtext,
  `alcohol_quantity` varchar(255),
  `smoke_frequency` varchar(255),
  `other_disease` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `episode_no` (`episode_no`),
  KEY `patients_episode_1fe1df59` (`patient_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients_episode`
--

LOCK TABLES `patients_episode` WRITE;
/*!40000 ALTER TABLE `patients_episode` DISABLE KEYS */;
INSERT INTO `patients_episode` VALUES (1,2,'uploads/Screenshot-1.png','uploads/Screenshot-1_1.png','2014-01-14 13:11:52','2014-01-16','2014-01-15','weqweqe','EP1401001','','visit',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,'uploads/main-qimg-02bb0d3fd2f19bbd9c55bfa1de024898.jpg','uploads/main-qimg-02bb0d3fd2f19bbd9c55bfa1de024898_1.jpg','2014-01-01 13:12:17','2014-01-16','2014-01-17','','EP1401002','','visit',0,0,'','','','','','',''),(3,3,'uploads/v1_1.png','','2014-01-01 08:53:40','2014-01-18','2014-01-15','','EP1401003','Add any additional info here..','visit',0,0,'','','','','','',''),(4,3,'uploads/g11.png','uploads/g22.png','2014-01-16 09:04:09','2014-01-18',NULL,NULL,'EP1401004','Add any additional info here..',NULL,0,0,'','','','','','',''),(5,3,'uploads/v1_2.png','','2014-01-16 09:18:19','2014-01-18',NULL,NULL,'EP1401005','Add any additional info here..',NULL,0,0,'','','','','','',''),(6,3,'uploads/v1_3.png','','2014-01-16 09:22:21','2014-01-18',NULL,NULL,'EP1401006','Add any additional info here..',NULL,0,0,'','','','','','',''),(7,3,'uploads/v1_4.png','','2014-01-16 09:23:43','2014-01-18','2014-01-16','ghgjhfgjhfjhf','EP1401007','Add any additional info here..','inprogress',0,0,'','','','','','',''),(8,3,'uploads/g11_1.png','uploads/g22_1.png','2014-01-16 09:46:55','2014-01-18',NULL,NULL,'EP1401008','Test',NULL,0,0,'sffsf','sffsf','sfsdf','sdfs','','',''),(9,3,'uploads/g11_2.png','uploads/g22_2.png','2014-01-16 09:47:43','2014-01-18',NULL,NULL,'EP1401009','Test',NULL,0,0,'sffsf','sffsf','sfsdf','sdfs','','',''),(10,3,'uploads/g11_3.png','uploads/g22_3.png','2014-01-16 09:48:44','2014-01-18','2014-01-17','','EP1401010','Test','inprogress',0,0,'sffsf','sffsf','sfsdf','sdfs','','',''),(11,3,'uploads/2014/01/16/g11.png','uploads/2014/01/16/g22.png','2014-01-16 09:54:21','2014-01-18','2014-02-25','qweqwe','EP1401011','Xya','completed',0,0,'sffsf','sffsf','sfsdf','sdfs','','',''),(12,2,'uploads/2014/01/16/g11_1.png','uploads/2014/01/16/g22_1.png','2014-01-16 10:19:27','2014-01-18','2014-01-18','Advice and urgent refferal','EP1401012','Add any additional info here..','visit',1,1,'terter','tester','ert','ertert','120','Frequent','N.A.'),(13,2,'uploads/2014/01/16/g11_2.png','uploads/2014/01/16/g22_2.png','2014-01-16 11:23:06','2014-01-18','2014-01-27','','EP1401013','Test','nodoctor',1,1,'terter','tester','ert','ertert','120','Frequent','N.A.'),(14,2,'uploads/2014/01/20/32.gif','uploads/2014/01/20/32_1.gif','2014-01-20 06:55:19','2014-01-22','2014-01-21','werwer','EP1401014','ewrwer','visit',0,0,'errr','','','','','',''),(15,3,'uploads/2014/01/22/v1.png','','2014-01-22 09:40:08','2014-01-24','2014-03-06','dfhdfh','EP1401015','Add any additional info here..','completed',1,1,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(16,3,'uploads/2014/01/22/g11.png','uploads/2014/01/22/g22.png','2014-01-22 09:41:20','2014-01-24','2014-03-05','sunburg','EP1401016','Add any additional info here..','completed',1,1,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(17,3,'uploads/2014/01/22/v1_1.png','','2014-01-22 09:41:44','2014-01-24','2014-03-06','etgegwdh','EP1401017','Add any additional info here..','visit',1,1,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(18,3,'uploads/2014/01/22/v1_2.png','','2014-01-22 09:43:03','2014-01-24','2014-02-27','ertert','EP1401018','Add any additional info here..','completed',1,1,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(19,3,'uploads/2014/01/22/v1_3.png','','2014-01-22 09:43:24','2014-01-24','2014-02-25','sdsf','EP1401019','Add any additional info here..','completed',1,1,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(20,3,'uploads/2014/02/05/g11.png','uploads/2014/02/05/g22.png','2014-02-05 07:43:11','2014-02-07','2014-03-07','ewrwr','EP1402001','Fhfb','visit',0,0,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(21,3,'uploads/2014/02/05/v1.png','','2014-02-05 07:48:49','2014-02-07',NULL,NULL,'EP1402002','Add any additional info here..','assigned',0,0,'No allergy','No disease','nothing','No history','daily','daily','No disease'),(22,3,'uploads/2014/02/05/v1_1.png','','2014-02-05 13:24:10','2014-02-07',NULL,NULL,'EP1402003','New test 1','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(23,3,'uploads/2014/02/05/g11_1.png','uploads/2014/02/05/g22_1.png','2014-02-05 13:25:26','2014-02-07',NULL,NULL,'EP1402004','Confusing','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(24,3,'uploads/2014/02/05/g11_2.png','uploads/2014/02/05/g22_2.png','2014-02-05 13:27:45','2014-02-07',NULL,NULL,'EP1402005','Vkcj','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(25,3,'uploads/2014/02/05/g11_3.png','uploads/2014/02/05/g22_3.png','2014-02-05 13:38:09','2014-02-07',NULL,NULL,'EP1402006','Add','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(26,3,'uploads/2014/02/05/g11_4.png','uploads/2014/02/05/g22_4.png','2014-02-05 13:38:48','2014-02-07',NULL,NULL,'EP1402007','Add','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(27,3,'uploads/2014/02/05/g11_5.png','uploads/2014/02/05/g22_5.png','2014-02-05 13:50:58','2014-02-07',NULL,NULL,'EP1402008','Info','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(28,3,'uploads/2014/02/05/g11_6.png','uploads/2014/02/05/g22_6.png','2014-02-05 13:51:28','2014-02-07',NULL,NULL,'EP1402009','Info','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(29,3,'uploads/2014/02/05/g11_7.png','uploads/2014/02/05/g22_7.png','2014-02-05 13:56:24','2014-02-07',NULL,NULL,'EP1402010','Two keys images with option 2 is selected','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease'),(30,3,'uploads/2014/02/05/g11_8.png','uploads/2014/02/05/g22_8.png','2014-02-05 14:22:56','2014-02-07',NULL,NULL,'EP1402011','Add any additional info here..','assigned',0,0,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease');
/*!40000 ALTER TABLE `patients_episode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients_patient`
--

DROP TABLE IF EXISTS `patients_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `dob` date NOT NULL,
  `code` varchar(10) NOT NULL,
  `ethnic_origin` varchar(255) DEFAULT NULL,
  `smokes` tinyint(1) NOT NULL,
  `alcohol` tinyint(1) NOT NULL,
  `allergies` longtext,
  `prev_disease` longtext,
  `current_medication` longtext,
  `family_history` longtext,
  `alcohol_quantity` varchar(255) DEFAULT NULL,
  `smoke_frequency` varchar(255) DEFAULT NULL,
  `other_disease` longtext,
  `is_activated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_id` (`profile_id`),
  KEY `patients_patient_09bb5fb3` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients_patient`
--

LOCK TABLES `patients_patient` WRITE;
/*!40000 ALTER TABLE `patients_patient` DISABLE KEYS */;
INSERT INTO `patients_patient` VALUES (2,3,'1987-11-27','gi8xoyj3dv','1',1,1,'terter','tester','ert','ertert','120','Frequent','N.A.',1),(3,4,'2014-01-13','moebe7sxcq','Americans',1,1,'No allergy','No disease','nothing nothing nothing','No history','daily','daily','No disease',1),(4,16,'1999-01-13','1etv9car47','Arab',0,0,'','','','','','',NULL,0),(7,24,'1985-03-06','x45qe5e36y','0',1,0,NULL,NULL,NULL,NULL,'not much','not much',NULL,0),(8,25,'1985-03-06','3d2acjggd8','3',1,0,NULL,NULL,NULL,NULL,'not much','not much',NULL,0),(9,26,'1986-03-04','y3nqb9wy4k','8',0,0,NULL,NULL,NULL,NULL,'','',NULL,0);
/*!40000 ALTER TABLE `patients_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients_task`
--

DROP TABLE IF EXISTS `patients_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `episode_id` int(11) NOT NULL,
  `assigned_to_id` int(11) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `ratings` int(11) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `status` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patients_task_5e14deb8` (`episode_id`),
  KEY `patients_task_6ff6d830` (`assigned_to_id`),
  KEY `patients_task_0c98d849` (`created_by_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients_task`
--

LOCK TABLES `patients_task` WRITE;
/*!40000 ALTER TABLE `patients_task` DISABLE KEYS */;
INSERT INTO `patients_task` VALUES (1,2,14,NULL,2,'2014-01-15','visit'),(2,1,14,NULL,2,'2014-01-15','visit'),(3,7,14,NULL,2,'2014-01-16','inprogress'),(4,10,14,NULL,2,'2014-01-17','visit'),(5,11,14,NULL,2,'2014-01-18','completed'),(6,12,14,NULL,2,'2014-01-18','visit'),(7,13,15,NULL,2,'2014-01-18','assigned'),(14,20,14,NULL,2,'2014-02-09','visit'),(8,14,15,NULL,2,'2014-01-21','visit'),(9,15,14,NULL,2,'2014-01-26','completed'),(10,16,14,NULL,2,'2014-01-26','completed'),(11,17,14,NULL,2,'2014-01-26','visit'),(12,18,14,NULL,2,'2014-01-26','completed'),(13,19,14,NULL,2,'2014-01-26','completed'),(15,21,14,NULL,2,'2014-02-09','assigned'),(16,22,14,NULL,2,'2014-02-09','assigned'),(17,23,14,NULL,2,'2014-02-09','assigned'),(18,24,14,NULL,2,'2014-02-09','assigned'),(19,25,14,NULL,2,'2014-02-09','assigned'),(20,26,14,NULL,2,'2014-02-09','assigned'),(21,27,14,NULL,2,'2014-02-09','assigned'),(22,28,14,NULL,2,'2014-02-09','assigned'),(23,29,14,NULL,2,'2014-02-09','assigned'),(24,30,14,NULL,2,'2014-02-09','assigned');
/*!40000 ALTER TABLE `patients_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'object_log','0001_version_0_5','2014-01-10 06:30:49'),(2,'object_log','0002_version_0_6','2014-01-10 06:30:49'),(3,'object_log','0003_version_0_6_rebuild_log_cache','2014-01-10 06:30:49'),(4,'users','0001_initial','2014-01-10 06:32:09'),(5,'patients','0001_initial','2014-01-10 06:32:10'),(6,'tasks','0001_initial','2014-01-10 06:32:10'),(7,'availability','0001_initial','2014-01-10 06:32:10'),(8,'address','0001_initial','2014-01-10 06:32:11'),(9,'address','0002_auto__del_field_country_code__add_field_country_dial_code','2014-01-10 07:06:59'),(10,'address','0003_auto__add_field_country_code','2014-01-10 07:08:34'),(11,'address','0004_auto__chg_field_country_dial_code','2014-01-10 07:16:23'),(12,'address','0005_auto__del_unique_country_dial_code','2014-01-10 07:20:13'),(13,'address','0006_auto__chg_field_country_dial_code','2014-01-10 07:22:34'),(14,'users','0002_auto__add_field_userprofile_mobile_code__add_field_userprofile_phone_c','2014-01-14 14:06:25'),(15,'users','0003_auto__chg_field_userprofile_phone_code__chg_field_userprofile_mobile_c','2014-01-15 07:16:08'),(16,'tasks','0002_auto__add_field_job_call_date__add_field_job_summary__add_field_job_co','2014-01-15 13:04:09'),(17,'tasks','0003_auto__chg_field_job_summary','2014-01-15 13:04:09'),(18,'patients','0002_auto__add_field_episode_smokes__add_field_episode_alcohol__add_field_e','2014-01-16 06:46:02');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_job`
--

DROP TABLE IF EXISTS `tasks_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `episode_no` varchar(90) NOT NULL,
  `assigned_to_id` int(11) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `comments` longtext NOT NULL,
  `submitted_at` date DEFAULT NULL,
  `action` varchar(128) DEFAULT NULL,
  `call_date` date,
  `summary` longtext,
  `completion_date` date,
  `actual_completed_date` date,
  PRIMARY KEY (`id`),
  KEY `tasks_job_6ff6d830` (`assigned_to_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_job`
--

LOCK TABLES `tasks_job` WRITE;
/*!40000 ALTER TABLE `tasks_job` DISABLE KEYS */;
INSERT INTO `tasks_job` VALUES (4,'EP1401010',5,'d','No doctor available till 2014-01-18, contact Patient','2014-01-16','p','2014-01-29','adasd','2014-01-18',NULL),(2,'EP1401002',5,'d','ttset','2014-01-14','p','2014-02-06','5tertertrt','2014-02-13','2014-02-06'),(3,'EP1401001',5,'d','weqweqe','2014-01-15','c','2014-02-06','dgdfg','2014-02-13','2014-02-06'),(5,'EP1401011',5,'d','No doctor available till 2014-01-18, contact Patient','2014-01-16','p','2014-02-06','erwerer','2014-01-18','2014-02-06'),(10,'EP1402001',5,'a','ewrwr','2014-03-07','c',NULL,NULL,'2014-03-09',NULL),(9,'EP1401017',17,'a','etgegwdh','2014-03-06','c',NULL,NULL,'2014-03-08',NULL);
/*!40000 ALTER TABLE `tasks_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_query`
--

DROP TABLE IF EXISTS `tasks_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks_query` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `episode_no` varchar(90) NOT NULL,
  `feedback` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_query`
--

LOCK TABLES `tasks_query` WRITE;
/*!40000 ALTER TABLE `tasks_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_role`
--

DROP TABLE IF EXISTS `users_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_role`
--

LOCK TABLES `users_role` WRITE;
/*!40000 ALTER TABLE `users_role` DISABLE KEYS */;
INSERT INTO `users_role` VALUES (1,'doctor','Doctor'),(2,'callcenter','Call center operative'),(3,'mgmtteam','Management Team'),(4,'sysadmin','System Administrator');
/*!40000 ALTER TABLE `users_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `address` longtext,
  `street` varchar(255) DEFAULT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `mobile_code` smallint(5) unsigned,
  `phone_code` smallint(5) unsigned,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `users_userprofile_278213e1` (`role_id`),
  KEY `users_userprofile_b376980e` (`city_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
INSERT INTO `users_userprofile` VALUES (1,1,3,'8149173158',NULL,'','','',1,'124',429,437),(3,5,NULL,'8149173158','235235','23123','drdf','fsfsf',1,'234235',437,437),(4,6,NULL,'57656756',NULL,'','','',4,'411048',11,11),(5,7,2,'2126461246','34124124','werwer','terwer','werwer',1,'1324',11,11),(14,18,1,NULL,'234234','dfasf','fsdfsdf','sdfdf',1,'12313',437,437),(15,19,1,NULL,'235235','','','',1,'123123',438,438),(16,21,NULL,'4785478541','14523652','','','',4,'36985',NULL,NULL),(17,22,2,'4545453434','8787878787','Atlanta','La bella street','Flower point',5,'89563',NULL,NULL),(23,28,NULL,NULL,'235235','','','',4,'344441',437,429),(24,29,NULL,NULL,NULL,NULL,NULL,NULL,6,'123456',NULL,NULL),(25,30,NULL,NULL,NULL,NULL,NULL,NULL,7,'123456',NULL,NULL),(26,31,NULL,NULL,NULL,NULL,NULL,NULL,8,'344342',NULL,NULL);
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-14 16:16:00
