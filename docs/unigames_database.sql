-- Dump MySQL 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Hôte : localhost    Database: unigames
-- ------------------------------------------------------
-- Version du serveur	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Structure de la table pour `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `disciplines`
--

DROP TABLE IF EXISTS `disciplines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_joueurs_par_equipe` int NOT NULL,
  `icone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `disciplines`
--

LOCK TABLES `disciplines` WRITE;
/*!40000 ALTER TABLE `disciplines` DISABLE KEYS */;
INSERT INTO `disciplines` VALUES (1,'Football',11,NULL,'Football ├á 11 joueurs','2026-05-08 16:15:37','2026-05-08 16:15:37'),(2,'Basketball',5,NULL,'Basketball ├á 5 joueurs','2026-05-08 16:15:37','2026-05-08 16:15:37'),(3,'Volleyball',6,NULL,'Volleyball ├á 6 joueurs','2026-05-08 16:15:37','2026-05-08 16:15:37'),(4,'Handball',7,NULL,'Handball ├á 7 joueurs','2026-05-08 16:15:37','2026-05-08 16:15:37'),(5,'Athl├®tisme',4,NULL,'Relais 4x100m et courses individuelles','2026-05-08 16:15:37','2026-05-08 16:15:37');
/*!40000 ALTER TABLE `disciplines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `editions`
--

DROP TABLE IF EXISTS `editions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `lieu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `statut` enum('a_venir','en_cours','terminee') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a_venir',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `editions`
--

LOCK TABLES `editions` WRITE;
/*!40000 ALTER TABLE `editions` DISABLE KEYS */;
INSERT INTO `editions` VALUES (2,'Jeux Universitaires 2025','2025-05-01','2025-05-15','Campus Principal',NULL,'terminee','2026-05-08 16:28:04','2026-05-08 16:28:04'),(3,'Jeux Universitaires 2026','2026-05-01','2026-05-20','Complexe Sportif Olembe','La plus grande comp├®tition universitaire avec une participation record.','terminee','2026-06-05 22:58:21','2026-06-05 22:58:21');
/*!40000 ALTER TABLE `editions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `equipes`
--

DROP TABLE IF EXISTS `equipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `faculte_id` bigint unsigned NOT NULL,
  `discipline_id` bigint unsigned NOT NULL,
  `edition_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `equipes_faculte_id_discipline_id_edition_id_unique` (`faculte_id`,`discipline_id`,`edition_id`),
  KEY `equipes_discipline_id_foreign` (`discipline_id`),
  KEY `equipes_edition_id_foreign` (`edition_id`),
  CONSTRAINT `equipes_discipline_id_foreign` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`) ON DELETE CASCADE,
  CONSTRAINT `equipes_edition_id_foreign` FOREIGN KEY (`edition_id`) REFERENCES `editions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `equipes_faculte_id_foreign` FOREIGN KEY (`faculte_id`) REFERENCES `facultes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `equipes`
--

LOCK TABLES `equipes` WRITE;
/*!40000 ALTER TABLE `equipes` DISABLE KEYS */;
INSERT INTO `equipes` VALUES (13,'├ëquipe Universit├® - D1',11,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(14,'├ëquipe IST - D1',12,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(15,'├ëquipe ISMGB - D1',13,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(16,'├ëquipe Universit├® - D1',14,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(17,'├ëquipe ISAV - D1',15,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(18,'├ëquipe ISIC - D1',16,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(19,'├ëquipe Institut - D1',17,1,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(20,'├ëquipe ├ëcole - D1',18,1,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(21,'├ëquipe Universit├® - D2',11,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(22,'├ëquipe IST - D2',12,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(23,'├ëquipe ISMGB - D2',13,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(24,'├ëquipe Universit├® - D2',14,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(25,'├ëquipe ISAV - D2',15,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(26,'├ëquipe ISIC - D2',16,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(27,'├ëquipe Institut - D2',17,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(28,'├ëquipe ├ëcole - D2',18,2,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(29,'├ëquipe Universit├® - D3',11,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(30,'├ëquipe IST - D3',12,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(31,'├ëquipe ISMGB - D3',13,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(32,'├ëquipe Universit├® - D3',14,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(33,'├ëquipe ISAV - D3',15,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(34,'├ëquipe ISIC - D3',16,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(35,'├ëquipe Institut - D3',17,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(36,'├ëquipe ├ëcole - D3',18,3,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(37,'├ëquipe Universit├® - D4',11,4,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(38,'├ëquipe IST - D4',12,4,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(39,'├ëquipe ISMGB - D4',13,4,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(40,'├ëquipe Universit├® - D4',14,4,3,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(41,'├ëquipe ISAV - D4',15,4,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(42,'├ëquipe ISIC - D4',16,4,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(43,'├ëquipe Institut - D4',17,4,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(44,'├ëquipe ├ëcole - D4',18,4,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(45,'├ëquipe Universit├® - D5',11,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(46,'├ëquipe IST - D5',12,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(47,'├ëquipe ISMGB - D5',13,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(48,'├ëquipe Universit├® - D5',14,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(49,'├ëquipe ISAV - D5',15,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(50,'├ëquipe ISIC - D5',16,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(51,'├ëquipe Institut - D5',17,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(52,'├ëquipe ├ëcole - D5',18,5,3,'2026-06-05 22:58:23','2026-06-05 22:58:23');
/*!40000 ALTER TABLE `equipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `facultes`
--

DROP TABLE IF EXISTS `facultes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `universite` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `edition_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facultes_edition_id_foreign` (`edition_id`),
  CONSTRAINT `facultes_edition_id_foreign` FOREIGN KEY (`edition_id`) REFERENCES `editions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `facultes`
--

LOCK TABLES `facultes` WRITE;
/*!40000 ALTER TABLE `facultes` DISABLE KEYS */;
INSERT INTO `facultes` VALUES (7,'UGANC (Gamal Abdel Nasser)','Conakry',NULL,2,'2026-05-08 16:28:04','2026-05-08 16:28:04'),(8,'UGLCS (Sonfonia)','Conakry',NULL,2,'2026-05-08 16:28:04','2026-05-08 16:28:04'),(9,'Universit├® Julius Nyerere','Kankan',NULL,2,'2026-05-08 16:28:04','2026-05-08 16:28:04'),(10,'Universit├® de Kindia','Kindia',NULL,2,'2026-05-08 16:28:04','2026-05-08 16:28:04'),(11,'Universit├® de Lab├®','Lab├®',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(12,'IST (Institut Sup. de Tech)','Mamou',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(13,'ISMGB (Mines et G├®ologie)','Bok├®',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(14,'Universit├® Nongo','Conakry',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(15,'ISAV (Agro-V├®t├®rinaire)','Faranah',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(16,'ISIC (Info & Com)','Kountia',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(17,'Institut National de la Jeunesse et des Sports (INJS)','Universit├® F├®d├®rale',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(18,'├ëcole Normale Sup├®rieure (ENS)','Universit├® F├®d├®rale',NULL,3,'2026-06-05 22:58:21','2026-06-05 22:58:21');
/*!40000 ALTER TABLE `facultes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `joueurs`
--

DROP TABLE IF EXISTS `joueurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `joueurs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexe` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_maillot` int DEFAULT NULL,
  `poste` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buts` int NOT NULL DEFAULT '0',
  `equipe_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `joueurs_equipe_id_foreign` (`equipe_id`),
  CONSTRAINT `joueurs_equipe_id_foreign` FOREIGN KEY (`equipe_id`) REFERENCES `equipes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `joueurs`
--

LOCK TABLES `joueurs` WRITE;
/*!40000 ALTER TABLE `joueurs` DISABLE KEYS */;
INSERT INTO `joueurs` VALUES (70,'CONDE','Oumar','M',1,NULL,0,13,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(71,'BARRY','Binta','F',2,NULL,1,13,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(72,'SOW','Alpha','M',3,NULL,0,13,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(73,'CAMARA','Ousmane','M',4,NULL,2,13,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(74,'CAMARA','Aissatou','F',5,NULL,1,13,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(75,'DIALLO','Oumou','F',6,NULL,2,13,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(76,'CAMARA','Cheick','M',1,NULL,4,14,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(77,'MARA','Amadou','M',2,NULL,3,14,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(78,'BARRY','Alhassane','M',3,NULL,4,14,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(79,'SOW','Karim','M',4,NULL,2,14,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(80,'BARRY','Salmatou','F',5,NULL,3,14,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(81,'TOURE','Alhassane','M',6,NULL,4,14,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(82,'MARA','Alhassane','M',1,NULL,3,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(83,'BAH','Karim','M',2,NULL,5,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(84,'KOUROUMA','Ibrahima','M',3,NULL,2,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(85,'SOUMAH','Aminata','F',4,NULL,3,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(86,'BARRY','Ibrahima','M',5,NULL,3,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(87,'TOURE','Fode','M',6,NULL,0,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(88,'KOUROUMA','Ousmane','M',7,NULL,1,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(89,'DIABATE','Rouguiatou','F',8,NULL,1,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(90,'SYLLA','Fode','M',9,NULL,2,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(91,'BAH','Amadou','M',10,NULL,0,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(92,'KEITA','Lansana','M',11,NULL,5,15,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(93,'BAH','Ibrahima','M',1,NULL,1,16,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(94,'TOURE','Salifou','M',2,NULL,4,16,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(95,'KOUROUMA','Karim','M',3,NULL,5,16,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(96,'TRAORE','Oumar','M',4,NULL,2,16,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(97,'CONDE','Mabinty','F',5,NULL,1,16,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(98,'KOUROUMA','Mamadou','M',6,NULL,2,16,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(99,'CONDE','Alpha','M',1,NULL,3,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(100,'FOFANA','Mariam','F',2,NULL,1,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(101,'BARRY','Aissatou','F',3,NULL,4,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(102,'BANGOURA','Sekou','M',4,NULL,0,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(103,'CAMARA','Souleymane','M',5,NULL,0,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(104,'SOUMAH','Mamadou','M',6,NULL,1,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(105,'SOW','Ousmane','M',7,NULL,5,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(106,'BANGOURA','Ibrahima','M',8,NULL,3,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(107,'TOURE','Fode','M',9,NULL,4,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(108,'BARRY','Alhassane','M',10,NULL,2,17,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(109,'KEITA','Moussa','M',1,NULL,0,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(110,'KOUROUMA','Kadiatou','F',2,NULL,4,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(111,'CISSE','Alpha','M',3,NULL,0,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(112,'KOUROUMA','Fode','M',4,NULL,1,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(113,'CAMARA','Mamadou','M',5,NULL,2,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(114,'KOUROUMA','Oumar','M',6,NULL,3,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(115,'KEITA','Amadou','M',7,NULL,5,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(116,'MARA','Aminata','F',8,NULL,1,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(117,'KANTE','Sekou','M',9,NULL,1,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(118,'TRAORE','Fode','M',10,NULL,2,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(119,'TRAORE','Alhassane','M',11,NULL,4,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(120,'DIALLO','Fode','M',12,NULL,4,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(121,'BARRY','Lansana','M',13,NULL,4,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(122,'DIABATE','Salifou','M',14,NULL,2,18,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(123,'CONDE','Aboubacar','M',1,NULL,1,19,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(124,'SOW','Mabinty','F',2,NULL,2,19,'2026-06-05 22:58:21','2026-06-05 22:58:21'),(125,'BANGOURA','Souleymane','M',3,NULL,1,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(126,'BANGOURA','Amadou','M',4,NULL,5,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(127,'TRAORE','Salmatou','F',5,NULL,0,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(128,'DIALLO','Kadiatou','F',6,NULL,5,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(129,'CAMARA','Ibrahima','M',7,NULL,1,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(130,'BARRY','Alseny','M',8,NULL,5,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(131,'SYLLA','Lansana','M',9,NULL,5,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(132,'BARRY','Mamadou','M',10,NULL,1,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(133,'CISSE','Oumar','M',11,NULL,1,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(134,'KANTE','Salifou','M',12,NULL,4,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(135,'KOUROUMA','Lansana','M',13,NULL,1,19,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(138,'CAMARA','Ousmane','M',3,NULL,2,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(139,'SYLLA','Alseny','M',4,NULL,4,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(140,'BANGOURA','Cheick','M',5,NULL,5,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(141,'TRAORE','Moussa','M',6,NULL,3,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(142,'BAH','Karim','M',7,NULL,5,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(143,'CISSE','Cheick','M',8,NULL,2,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(144,'KEITA','Alpha','M',9,NULL,0,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(145,'KEITA','Oumar','M',10,NULL,0,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(146,'KOUROUMA','Aboubacar','M',11,NULL,1,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(147,'KOUROUMA','Ousmane','M',12,NULL,5,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(148,'CAMARA','Oumar','M',13,NULL,0,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(149,'DIABATE','Salifou','M',14,NULL,5,20,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(150,'CONDE','Ibrahima','M',1,NULL,2,21,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(151,'CONDE','Aminata','F',2,NULL,2,21,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(152,'KOUROUMA','Ousmane','M',3,NULL,2,21,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(153,'KANTE','Alpha','M',4,NULL,5,21,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(154,'MARA','Oumou','F',5,NULL,5,21,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(155,'DIABATE','Sekou','M',6,NULL,1,21,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(156,'KANTE','Souleymane','M',1,NULL,1,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(157,'CISSE','Sekou','M',2,NULL,5,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(158,'FOFANA','Ibrahima','M',3,NULL,0,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(159,'KANTE','Fode','M',4,NULL,2,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(160,'SYLLA','Sekou','M',5,NULL,0,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(161,'DIABATE','Alpha','M',6,NULL,5,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(162,'MARA','Oumou','F',7,NULL,3,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(163,'TRAORE','Djenabou','F',8,NULL,3,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(164,'SYLLA','Salifou','M',9,NULL,2,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(165,'KEITA','Mariam','F',10,NULL,0,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(166,'SOW','Kadiatou','F',11,NULL,1,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(167,'CISSE','Moussa','M',12,NULL,0,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(168,'TOURE','Oumar','M',13,NULL,1,22,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(169,'CONDE','Oumar','M',1,NULL,3,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(170,'BAH','Moussa','M',2,NULL,5,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(171,'KANTE','Alhassane','M',3,NULL,5,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(172,'DIALLO','Salifou','M',4,NULL,5,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(173,'KOUROUMA','Mamadou','M',5,NULL,5,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(174,'FOFANA','Salifou','M',6,NULL,2,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(175,'KANTE','Sekou','M',7,NULL,2,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(176,'BANGOURA','Amadou','M',8,NULL,1,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(177,'BANGOURA','Sekou','M',9,NULL,2,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(178,'TOURE','Oumar','M',10,NULL,4,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(179,'SYLLA','Cheick','M',11,NULL,0,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(180,'CISSE','Fatoumata','F',12,NULL,4,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(181,'BANGOURA','Djenabou','F',13,NULL,0,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(182,'MARA','Salifou','M',14,NULL,4,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(183,'CAMARA','Alhassane','M',15,NULL,1,23,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(184,'CONDE','Fode','M',1,NULL,0,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(185,'CAMARA','Karim','M',2,NULL,2,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(186,'CAMARA','Alpha','M',3,NULL,1,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(187,'BANGOURA','Aminata','F',4,NULL,5,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(188,'TOURE','Ousmane','M',5,NULL,4,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(189,'KOUROUMA','Aboubacar','M',6,NULL,5,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(190,'CAMARA','Sekou','M',7,NULL,0,24,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(191,'KOUROUMA','Alseny','M',1,NULL,5,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(192,'TOURE','Djenabou','F',2,NULL,0,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(193,'CISSE','Aminata','F',3,NULL,5,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(194,'CONDE','Karim','M',4,NULL,4,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(195,'SYLLA','Ousmane','M',5,NULL,5,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(196,'BANGOURA','Djenabou','F',6,NULL,5,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(197,'BARRY','Souleymane','M',7,NULL,4,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(198,'KEITA','Fode','M',8,NULL,4,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(199,'TRAORE','Mamadou','M',9,NULL,1,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(200,'FOFANA','Ousmane','M',10,NULL,5,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(201,'BARRY','Lansana','M',11,NULL,0,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(202,'SOUMAH','Lansana','M',12,NULL,1,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(203,'MARA','Fode','M',13,NULL,3,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(204,'MARA','Karim','M',14,NULL,2,25,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(205,'CONDE','Karim','M',1,NULL,3,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(206,'CONDE','Moussa','M',2,NULL,0,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(207,'TRAORE','Mamadou','M',3,NULL,1,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(208,'SOW','Cheick','M',4,NULL,1,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(209,'SYLLA','Ousmane','M',5,NULL,2,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(210,'SOUMAH','Fode','M',6,NULL,4,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(211,'BAH','Salifou','M',7,NULL,1,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(212,'TRAORE','Amadou','M',8,NULL,2,26,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(213,'CAMARA','Moussa','M',1,NULL,4,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(214,'CONDE','Hawa','F',2,NULL,0,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(215,'SOW','Ibrahima','M',3,NULL,3,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(216,'BANGOURA','Alhassane','M',4,NULL,4,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(217,'BANGOURA','Alpha','M',5,NULL,4,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(218,'DIALLO','Sekou','M',6,NULL,0,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(219,'BARRY','Alseny','M',7,NULL,4,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(220,'BARRY','Kadiatou','F',8,NULL,1,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(221,'DIALLO','Ibrahima','M',9,NULL,2,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(222,'KEITA','Binta','F',10,NULL,5,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(223,'CONDE','Alhassane','M',11,NULL,5,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(224,'MARA','Alhassane','M',12,NULL,2,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(225,'FOFANA','Aboubacar','M',13,NULL,1,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(226,'TOURE','Salmatou','F',14,NULL,2,27,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(227,'FOFANA','Mariam','F',1,NULL,2,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(228,'SOUMAH','Sekou','M',2,NULL,1,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(229,'DIABATE','Cheick','M',3,NULL,1,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(230,'CONDE','Hawa','F',4,NULL,0,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(231,'CAMARA','Alhassane','M',5,NULL,3,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(232,'SOUMAH','Lansana','M',6,NULL,5,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(233,'CISSE','Oumar','M',7,NULL,2,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(234,'TRAORE','Ibrahima','M',8,NULL,3,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(235,'KEITA','Souleymane','M',9,NULL,3,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(236,'CAMARA','Alseny','M',10,NULL,0,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(237,'BANGOURA','Alseny','M',11,NULL,0,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(238,'SOUMAH','Salifou','M',12,NULL,5,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(239,'KANTE','Souleymane','M',13,NULL,3,28,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(240,'KEITA','Sekou','M',1,NULL,1,29,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(241,'CAMARA','Mariam','F',2,NULL,4,29,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(242,'TOURE','Souleymane','M',3,NULL,0,29,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(243,'BARRY','Ibrahima','M',4,NULL,1,29,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(244,'TRAORE','Hawa','F',5,NULL,2,29,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(245,'KEITA','Fode','M',6,NULL,1,29,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(246,'CONDE','Moussa','M',1,NULL,3,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(247,'KEITA','Aboubacar','M',2,NULL,0,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(248,'KOUROUMA','Karim','M',3,NULL,3,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(249,'SOW','Aminata','F',4,NULL,1,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(250,'CAMARA','Oumar','M',5,NULL,2,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(251,'MARA','Karim','M',6,NULL,4,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(252,'CONDE','Lansana','M',7,NULL,4,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(253,'KEITA','Mamadou','M',8,NULL,4,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(254,'BARRY','Aboubacar','M',9,NULL,2,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(255,'BARRY','Salifou','M',10,NULL,3,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(256,'CONDE','Alhassane','M',11,NULL,1,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(257,'CISSE','Cheick','M',12,NULL,5,30,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(258,'CAMARA','Oumou','F',1,NULL,1,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(259,'BANGOURA','Fatoumata','F',2,NULL,5,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(260,'CONDE','Mabinty','F',3,NULL,3,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(261,'CONDE','Ousmane','M',4,NULL,1,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(262,'CONDE','Lansana','M',5,NULL,3,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(263,'BANGOURA','Fode','M',6,NULL,0,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(264,'TRAORE','Aissatou','F',7,NULL,5,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(265,'MARA','Aminata','F',8,NULL,5,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(266,'TOURE','Souleymane','M',9,NULL,0,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(267,'SOUMAH','Alpha','M',10,NULL,4,31,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(268,'KOUROUMA','Oumou','F',1,NULL,0,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(269,'DIABATE','Mamadou','M',2,NULL,0,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(270,'DIALLO','Rouguiatou','F',3,NULL,4,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(271,'CISSE','Oumou','F',4,NULL,3,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(272,'SOUMAH','Moussa','M',5,NULL,4,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(273,'DIABATE','Moussa','M',6,NULL,1,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(274,'BANGOURA','Salifou','M',7,NULL,1,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(275,'CAMARA','Aissatou','F',8,NULL,3,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(276,'SYLLA','Salifou','M',9,NULL,2,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(277,'KANTE','Sekou','M',10,NULL,2,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(278,'SOUMAH','Hawa','F',11,NULL,3,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(279,'TOURE','Amadou','M',12,NULL,3,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(280,'CONDE','Mamadou','M',13,NULL,5,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(281,'BANGOURA','Hawa','F',14,NULL,0,32,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(282,'CISSE','Amadou','M',1,NULL,3,33,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(283,'DIABATE','Rouguiatou','F',2,NULL,5,33,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(284,'BARRY','Salifou','M',3,NULL,0,33,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(285,'BANGOURA','Cheick','M',4,NULL,4,33,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(286,'CAMARA','Fode','M',5,NULL,0,33,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(287,'MARA','Alpha','M',1,NULL,4,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(288,'SOW','Aboubacar','M',2,NULL,5,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(289,'BAH','Moussa','M',3,NULL,4,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(290,'KEITA','Ousmane','M',4,NULL,0,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(291,'MARA','Ibrahima','M',5,NULL,0,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(292,'KANTE','Djenabou','F',6,NULL,5,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(293,'BANGOURA','Salmatou','F',7,NULL,2,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(294,'BARRY','Cheick','M',8,NULL,2,34,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(295,'SOW','Lansana','M',1,NULL,4,35,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(296,'BARRY','Oumar','M',2,NULL,2,35,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(297,'BANGOURA','Souleymane','M',3,NULL,0,35,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(298,'DIALLO','Mamadou','M',4,NULL,2,35,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(299,'TRAORE','Ousmane','M',5,NULL,4,35,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(300,'KANTE','Alpha','M',1,NULL,3,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(301,'TRAORE','Salifou','M',2,NULL,0,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(302,'CISSE','Mabinty','F',3,NULL,4,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(303,'BAH','Lansana','M',4,NULL,0,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(304,'BANGOURA','Salifou','M',5,NULL,2,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(305,'BANGOURA','Aboubacar','M',6,NULL,2,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(306,'BARRY','Salifou','M',7,NULL,4,36,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(307,'BAH','Salifou','M',1,NULL,2,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(308,'BANGOURA','Hawa','F',2,NULL,5,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(309,'BARRY','Salifou','M',3,NULL,0,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(310,'DIABATE','Aboubacar','M',4,NULL,0,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(311,'DIABATE','Mamadou','M',5,NULL,4,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(312,'TRAORE','Ousmane','M',6,NULL,2,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(313,'KANTE','Cheick','M',7,NULL,5,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(314,'CONDE','Alseny','M',8,NULL,5,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(315,'SYLLA','Oumar','M',9,NULL,3,37,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(316,'KOUROUMA','Rouguiatou','F',1,NULL,2,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(317,'BANGOURA','Salifou','M',2,NULL,4,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(318,'BARRY','Cheick','M',3,NULL,4,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(319,'BARRY','Oumar','M',4,NULL,3,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(320,'KEITA','Souleymane','M',5,NULL,3,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(321,'KEITA','Djenabou','F',6,NULL,3,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(322,'BAH','Salifou','M',7,NULL,5,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(323,'SYLLA','Oumou','F',8,NULL,2,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(324,'BAH','Fode','M',9,NULL,4,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(325,'MARA','Oumar','M',10,NULL,3,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(326,'BANGOURA','Souleymane','M',11,NULL,4,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(327,'TOURE','Alhassane','M',12,NULL,1,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(328,'CONDE','Ibrahima','M',13,NULL,3,38,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(329,'SYLLA','Mamadou','M',1,NULL,1,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(330,'SOW','Souleymane','M',2,NULL,2,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(331,'FOFANA','Ibrahima','M',3,NULL,3,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(332,'FOFANA','Sekou','M',4,NULL,0,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(333,'FOFANA','Ibrahima','M',5,NULL,3,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(334,'DIABATE','Karim','M',6,NULL,4,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(335,'CONDE','Ibrahima','M',7,NULL,0,39,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(336,'CONDE','Alpha','M',1,NULL,2,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(337,'TRAORE','Oumar','M',2,NULL,0,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(338,'SOUMAH','Aboubacar','M',3,NULL,2,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(339,'KOUROUMA','Mamadou','M',4,NULL,0,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(340,'SOUMAH','Rouguiatou','F',5,NULL,2,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(341,'CAMARA','Oumar','M',6,NULL,4,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(342,'BAH','Mamadou','M',7,NULL,5,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(343,'CONDE','Oumou','F',8,NULL,4,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(344,'SOW','Oumou','F',9,NULL,0,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(345,'SYLLA','Salmatou','F',10,NULL,1,40,'2026-06-05 22:58:22','2026-06-05 22:58:22'),(346,'FOFANA','Lansana','M',11,NULL,2,40,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(347,'BARRY','Salifou','M',12,NULL,1,40,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(348,'BAH','Lansana','M',13,NULL,2,40,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(349,'TOURE','Kadiatou','F',1,NULL,2,41,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(350,'CAMARA','Oumar','M',2,NULL,5,41,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(351,'BANGOURA','Salifou','M',3,NULL,5,41,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(352,'TOURE','Moussa','M',4,NULL,5,41,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(353,'BANGOURA','Amadou','M',5,NULL,5,41,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(354,'SOUMAH','Moussa','M',6,NULL,4,41,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(355,'KEITA','Lansana','M',1,NULL,5,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(356,'TRAORE','Aissatou','F',2,NULL,5,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(357,'CONDE','Mamadou','M',3,NULL,4,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(358,'SOW','Ibrahima','M',4,NULL,5,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(359,'SOW','Mabinty','F',5,NULL,2,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(360,'FOFANA','Salifou','M',6,NULL,4,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(361,'KOUROUMA','Alhassane','M',7,NULL,1,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(362,'BAH','Alhassane','M',8,NULL,0,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(363,'SOW','Aissatou','F',9,NULL,3,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(364,'BARRY','Karim','M',10,NULL,0,42,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(365,'CISSE','Aminata','F',1,NULL,0,43,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(366,'BANGOURA','Cheick','M',2,NULL,5,43,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(367,'MARA','Mamadou','M',3,NULL,1,43,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(368,'KOUROUMA','Aissatou','F',4,NULL,4,43,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(369,'BANGOURA','Souleymane','M',5,NULL,5,43,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(370,'KANTE','Souleymane','M',6,NULL,4,43,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(371,'BANGOURA','Aissatou','F',1,NULL,3,44,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(372,'FOFANA','Binta','F',2,NULL,4,44,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(373,'TRAORE','Moussa','M',3,NULL,5,44,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(374,'BARRY','Salifou','M',4,NULL,0,44,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(375,'FOFANA','Lansana','M',5,NULL,0,44,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(376,'TOURE','Ousmane','M',6,NULL,0,44,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(377,'SOW','Aminata','F',1,NULL,0,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(378,'BARRY','Aboubacar','M',2,NULL,0,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(379,'KOUROUMA','Ibrahima','M',3,NULL,2,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(380,'TRAORE','Lansana','M',4,NULL,4,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(381,'FOFANA','Aminata','F',5,NULL,1,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(382,'DIALLO','Lansana','M',6,NULL,2,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(383,'DIABATE','Souleymane','M',7,NULL,2,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(384,'TOURE','Salmatou','F',8,NULL,4,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(385,'FOFANA','Alpha','M',9,NULL,3,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(386,'DIABATE','Moussa','M',10,NULL,4,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(387,'FOFANA','Alhassane','M',11,NULL,3,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(388,'CONDE','Sekou','M',12,NULL,1,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(389,'BAH','Karim','M',13,NULL,1,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(390,'CAMARA','Aboubacar','M',14,NULL,4,45,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(391,'KOUROUMA','Amadou','M',1,NULL,2,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(392,'CAMARA','Cheick','M',2,NULL,0,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(393,'CISSE','Sekou','M',3,NULL,2,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(394,'DIABATE','Oumou','F',4,NULL,5,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(395,'KOUROUMA','Cheick','M',5,NULL,5,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(396,'CAMARA','Souleymane','M',6,NULL,5,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(397,'BARRY','Ibrahima','M',7,NULL,0,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(398,'DIALLO','Mamadou','M',8,NULL,1,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(399,'BARRY','Mamadou','M',9,NULL,3,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(400,'KANTE','Oumar','M',10,NULL,0,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(401,'SOUMAH','Alpha','M',11,NULL,0,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(402,'MARA','Amadou','M',12,NULL,5,46,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(403,'MARA','Cheick','M',1,NULL,1,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(404,'KANTE','Souleymane','M',2,NULL,3,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(405,'CISSE','Lansana','M',3,NULL,2,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(406,'CISSE','Fode','M',4,NULL,3,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(407,'SOUMAH','Alseny','M',5,NULL,0,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(408,'TRAORE','Mamadou','M',6,NULL,3,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(409,'KOUROUMA','Sekou','M',7,NULL,1,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(410,'CAMARA','Souleymane','M',8,NULL,1,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(411,'SYLLA','Alseny','M',9,NULL,5,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(412,'SOW','Lansana','M',10,NULL,2,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(413,'DIABATE','Mamadou','M',11,NULL,0,47,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(414,'BAH','Alseny','M',1,NULL,4,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(415,'KEITA','Alhassane','M',2,NULL,1,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(416,'FOFANA','Alpha','M',3,NULL,3,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(417,'SOW','Salifou','M',4,NULL,0,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(418,'MARA','Amadou','M',5,NULL,1,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(419,'KEITA','Mamadou','M',6,NULL,5,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(420,'CAMARA','Aminata','F',7,NULL,2,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(421,'KEITA','Salmatou','F',8,NULL,5,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(422,'BANGOURA','Amadou','M',9,NULL,4,48,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(423,'CAMARA','Mamadou','M',1,NULL,1,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(424,'FOFANA','Mariam','F',2,NULL,3,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(425,'CONDE','Djenabou','F',3,NULL,1,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(426,'BAH','Souleymane','M',4,NULL,3,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(427,'KOUROUMA','Oumar','M',5,NULL,2,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(428,'TRAORE','Cheick','M',6,NULL,3,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(429,'KEITA','Aminata','F',7,NULL,1,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(430,'FOFANA','Fode','M',8,NULL,1,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(431,'KOUROUMA','Cheick','M',9,NULL,5,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(432,'DIALLO','Moussa','M',10,NULL,5,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(433,'FOFANA','Ousmane','M',11,NULL,2,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(434,'CAMARA','Lansana','M',12,NULL,0,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(435,'DIALLO','Alhassane','M',13,NULL,1,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(436,'BARRY','Aminata','F',14,NULL,3,49,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(437,'CAMARA','Ibrahima','M',1,NULL,3,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(438,'BAH','Souleymane','M',2,NULL,2,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(439,'DIALLO','Lansana','M',3,NULL,5,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(440,'CISSE','Souleymane','M',4,NULL,3,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(441,'DIABATE','Ousmane','M',5,NULL,3,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(442,'KEITA','Amadou','M',6,NULL,0,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(443,'BARRY','Alseny','M',7,NULL,0,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(444,'SOW','Cheick','M',8,NULL,3,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(445,'KEITA','Amadou','M',9,NULL,3,50,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(446,'KANTE','Ibrahima','M',1,NULL,3,51,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(447,'BANGOURA','Amadou','M',2,NULL,5,51,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(448,'BANGOURA','Moussa','M',3,NULL,3,51,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(449,'SYLLA','Fode','M',4,NULL,0,51,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(450,'FOFANA','Amadou','M',5,NULL,0,51,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(451,'BAH','Moussa','M',6,NULL,0,51,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(452,'CONDE','Salifou','M',1,NULL,1,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(453,'BARRY','Alhassane','M',2,NULL,5,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(454,'BANGOURA','Fode','M',3,NULL,1,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(455,'TOURE','Aboubacar','M',4,NULL,5,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(456,'MARA','Amadou','M',5,NULL,0,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(457,'MARA','Fode','M',6,NULL,1,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(458,'FOFANA','Karim','M',7,NULL,5,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(459,'KEITA','Souleymane','M',8,NULL,2,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(460,'BANGOURA','Mariam','F',9,NULL,2,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(461,'DIABATE','Lansana','M',10,NULL,5,52,'2026-06-05 22:58:23','2026-06-05 22:58:23'),(462,'SOW','Alpha','M',11,NULL,0,17,'2026-06-05 23:26:23','2026-06-05 23:26:23'),(463,'SOW','Ousmane','M',11,NULL,0,21,'2026-06-05 23:27:16','2026-06-05 23:27:16'),(464,'Camara','Jacob','M',11,NULL,0,52,'2026-06-06 00:20:51','2026-06-06 00:20:51');
/*!40000 ALTER TABLE `joueurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `matchs`
--

DROP TABLE IF EXISTS `matchs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matchs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `equipe_a_id` bigint unsigned NOT NULL,
  `equipe_b_id` bigint unsigned NOT NULL,
  `discipline_id` bigint unsigned NOT NULL,
  `edition_id` bigint unsigned NOT NULL,
  `date_match` datetime NOT NULL,
  `lieu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phase` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Poules',
  `score_a` int DEFAULT NULL,
  `score_b` int DEFAULT NULL,
  `buteurs` json DEFAULT NULL,
  `statut` enum('planifie','en_cours','joue') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'planifie',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `matchs_equipe_a_id_foreign` (`equipe_a_id`),
  KEY `matchs_equipe_b_id_foreign` (`equipe_b_id`),
  KEY `matchs_discipline_id_foreign` (`discipline_id`),
  KEY `matchs_edition_id_foreign` (`edition_id`),
  CONSTRAINT `matchs_discipline_id_foreign` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matchs_edition_id_foreign` FOREIGN KEY (`edition_id`) REFERENCES `editions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matchs_equipe_a_id_foreign` FOREIGN KEY (`equipe_a_id`) REFERENCES `equipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matchs_equipe_b_id_foreign` FOREIGN KEY (`equipe_b_id`) REFERENCES `equipes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `matchs`
--

LOCK TABLES `matchs` WRITE;
/*!40000 ALTER TABLE `matchs` DISABLE KEYS */;
INSERT INTO `matchs` VALUES (9,18,15,1,3,'2026-05-30 22:58:23','Terrain 3','Poules',0,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(10,20,13,1,3,'2026-05-30 22:58:23','Terrain 5','Poules',0,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(11,14,15,1,3,'2026-05-28 22:58:23','Terrain 1','Poules',4,4,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(12,13,20,1,3,'2026-05-28 22:58:23','Terrain 5','Poules',4,4,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(13,19,16,1,3,'2026-05-26 22:58:23','Terrain 3','Poules',1,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(14,20,16,1,3,'2026-05-26 22:58:23','Terrain 5','Poules',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(15,16,20,1,3,'2026-05-31 22:58:23','Terrain 5','Poules',4,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(16,15,14,1,3,'2026-05-27 22:58:23','Terrain 2','Poules',0,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(17,19,18,1,3,'2026-05-28 22:58:23','Terrain 3','Poules',1,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(18,16,19,1,3,'2026-05-29 22:58:23','Terrain 2','Poules',0,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(19,14,13,1,3,'2026-06-04 22:58:23','Terrain 2','Poules',2,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(20,20,18,1,3,'2026-05-30 22:58:23','Terrain 1','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(21,13,14,1,3,'2026-06-07 22:58:23','Stade Principal','Demi',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(23,21,24,2,3,'2026-05-30 22:58:23','Terrain 3','Poules',3,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(24,25,22,2,3,'2026-05-31 22:58:23','Terrain 4','Poules',3,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(25,27,25,2,3,'2026-05-31 22:58:23','Terrain 3','Poules',0,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(26,27,23,2,3,'2026-05-30 22:58:23','Terrain 1','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(27,21,27,2,3,'2026-05-31 22:58:23','Terrain 3','Poules',4,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(28,27,28,2,3,'2026-05-29 22:58:23','Terrain 4','Poules',1,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(29,21,23,2,3,'2026-05-28 22:58:23','Terrain 5','Poules',2,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(30,24,21,2,3,'2026-05-30 22:58:23','Terrain 5','Poules',3,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(31,22,21,2,3,'2026-06-03 22:58:23','Terrain 5','Poules',4,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(32,22,26,2,3,'2026-05-28 22:58:23','Terrain 1','Poules',1,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(33,22,28,2,3,'2026-05-26 22:58:23','Terrain 2','Poules',2,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(34,21,22,2,3,'2026-06-07 22:58:23','Stade Principal','Demi',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(35,23,24,2,3,'2026-06-10 22:58:23','Stade Principal','Finale',5,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(36,30,34,3,3,'2026-06-03 22:58:23','Terrain 4','Poules',2,4,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(37,31,35,3,3,'2026-06-01 22:58:23','Terrain 3','Poules',3,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(38,30,36,3,3,'2026-05-28 22:58:23','Terrain 4','Poules',0,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(39,32,36,3,3,'2026-05-28 22:58:23','Terrain 1','Poules',1,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(40,32,34,3,3,'2026-05-26 22:58:23','Terrain 2','Poules',3,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(41,29,35,3,3,'2026-05-31 22:58:23','Terrain 5','Poules',4,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(42,34,36,3,3,'2026-05-28 22:58:23','Terrain 3','Poules',3,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(43,31,35,3,3,'2026-05-27 22:58:23','Terrain 5','Poules',2,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(44,31,33,3,3,'2026-06-03 22:58:23','Terrain 4','Poules',3,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(45,31,34,3,3,'2026-05-31 22:58:23','Terrain 5','Poules',2,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(46,34,30,3,3,'2026-06-04 22:58:23','Terrain 3','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(47,31,36,3,3,'2026-05-31 22:58:23','Terrain 4','Poules',4,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(48,29,30,3,3,'2026-06-07 22:58:23','Stade Principal','Demi',3,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(49,31,32,3,3,'2026-06-10 22:58:23','Stade Principal','Finale',3,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(50,41,43,4,3,'2026-05-31 22:58:23','Terrain 2','Poules',1,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(51,44,42,4,3,'2026-05-29 22:58:23','Terrain 4','Poules',4,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(52,40,38,4,3,'2026-05-30 22:58:23','Terrain 5','Poules',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(53,38,42,4,3,'2026-06-02 22:58:23','Terrain 3','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(54,39,40,4,3,'2026-05-31 22:58:23','Terrain 3','Poules',3,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(55,41,38,4,3,'2026-05-26 22:58:23','Terrain 1','Poules',4,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(56,42,38,4,3,'2026-06-04 22:58:23','Terrain 3','Poules',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(57,38,43,4,3,'2026-05-26 22:58:23','Terrain 1','Poules',0,4,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(58,43,42,4,3,'2026-06-01 22:58:23','Terrain 2','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(59,38,37,4,3,'2026-06-03 22:58:23','Terrain 4','Poules',0,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(60,44,42,4,3,'2026-06-01 22:58:23','Terrain 2','Poules',2,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(61,42,41,4,3,'2026-06-01 22:58:23','Terrain 1','Poules',4,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(62,37,38,4,3,'2026-06-07 22:58:23','Stade Principal','Demi',4,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(63,39,40,4,3,'2026-06-10 22:58:23','Stade Principal','Finale',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(64,52,50,5,3,'2026-06-04 22:58:23','Terrain 3','Poules',1,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(65,45,48,5,3,'2026-06-02 22:58:23','Terrain 2','Poules',0,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(66,52,45,5,3,'2026-05-31 22:58:23','Terrain 4','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(67,49,47,5,3,'2026-06-01 22:58:23','Terrain 1','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(68,45,47,5,3,'2026-05-27 22:58:23','Terrain 3','Poules',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(69,51,50,5,3,'2026-05-28 22:58:23','Terrain 2','Poules',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(70,45,52,5,3,'2026-05-26 22:58:23','Terrain 1','Poules',4,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(71,52,51,5,3,'2026-06-01 22:58:23','Terrain 3','Poules',3,1,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(72,52,50,5,3,'2026-06-03 22:58:23','Terrain 2','Poules',1,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(73,48,46,5,3,'2026-05-28 22:58:23','Terrain 1','Poules',2,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(74,50,45,5,3,'2026-05-27 22:58:23','Terrain 2','Poules',1,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(75,48,52,5,3,'2026-06-01 22:58:23','Terrain 4','Poules',4,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(76,48,46,5,3,'2026-05-29 22:58:23','Terrain 5','Poules',2,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(77,49,52,5,3,'2026-05-29 22:58:23','Terrain 2','Poules',3,2,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(78,50,48,5,3,'2026-06-01 22:58:23','Terrain 4','Poules',1,4,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(79,45,46,5,3,'2026-06-07 22:58:23','Stade Principal','Demi',4,0,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23'),(80,47,48,5,3,'2026-06-10 22:58:23','Stade Principal','Finale',3,3,'{\"equipe_a\": [], \"equipe_b\": []}','joue','2026-06-05 22:58:23','2026-06-05 22:58:23');
/*!40000 ALTER TABLE `matchs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_05_04_000001_create_editions_table',1),(5,'2026_05_04_000002_create_facultes_table',1),(6,'2026_05_04_000003_create_disciplines_table',1),(7,'2026_05_04_000004_create_equipes_table',1),(8,'2026_05_04_000005_create_joueurs_table',1),(9,'2026_05_04_000006_create_matchs_table',1),(10,'2026_05_05_130135_add_buteurs_to_matchs_table',1),(11,'2026_05_05_135148_add_role_to_users_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('G4mF1GYOHdAhSREhudi3eipzemwr5CWsJay0zHc1',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0','eyJfdG9rZW4iOiIzdk9YQWlTcTFaV2Z5UDBVaE9oN3R0ck80ZXdXYW9RTHUzQkdFeEZ4IiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvbG9jYWxob3N0OjgwMDFcL2Rhc2hib2FyZCIsInJvdXRlIjoiZGFzaGJvYXJkIn0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoxLCJzZWxlY3RlZF9lZGl0aW9uX2lkIjoiMyJ9',1780705524);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Structure de la table pour `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'staff',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Déchargement des données de la table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alseny camara','admin@unigames.gn','admin',NULL,'$2y$12$lMyyGt5qkCAyTgfLgQ2IUOkdgThFuhysSl9hsux5EliWFuuTewMOq',NULL,'2026-05-08 16:15:37','2026-06-05 23:48:05'),(2,'johnny','fccam@gmail.com','staff',NULL,'$2y$12$Y2CoBDxAEdRWTsLvdCDw4e0SsyfMucCVLqIThvUHBVN2b69s85doa',NULL,'2026-06-05 23:43:40','2026-06-05 23:43:40'),(3,'jonnes','jonnesam@gmail.com','viewer',NULL,'$2y$12$TQh8SKs2FkU6z1GaRCDUz.dYXBf.4V/CCwm8wNFOarBkxYQ3AFRte',NULL,'2026-06-05 23:44:40','2026-06-05 23:55:24');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-06  1:46:13
