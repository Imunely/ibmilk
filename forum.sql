-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: localhost    Database: forum
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(30) NOT NULL,
  `passwd` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (9,'milk','$2y$10$XA5ZSii/PZjWdaFXzwDQGOvK94Pp7onf6L74eepsK6AZHfwdVDiJ6');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answ`
--

DROP TABLE IF EXISTS `answ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answ` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `dateup` datetime DEFAULT NULL,
  `about` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `answ_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `answ_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answ`
--

LOCK TABLES `answ` WRITE;
/*!40000 ALTER TABLE `answ` DISABLE KEYS */;
INSERT INTO `answ` VALUES (25,36,12,'2022-02-13 09:02:24','у тебя ошибка на 10 строке. Ждешь результат callable, но в 20 массив'),(26,37,12,'2022-02-13 09:02:32','<small class=\"text-muted\">\r\n$controller = $this->container->get($controller); // загнали экземпляр класса в контейнер и получили его<br>\r\nreturn [$controller, $action];\r\n</small>\r\n<br>\r\nкак-то так :)'),(27,39,13,'2022-02-13 09:02:57','А у них много вариантов?<br>\r\nРазобрать согласно заранее созданному словарю.<br>\r\nПример<br>\r\nhttps://www.yaplakal.com/forum2/topic308421.html'),(28,40,13,'2022-02-13 07:02:14','Я считаю следует начать с того, чтобы открыть google.com и начать изучать mysql.');
/*!40000 ALTER TABLE `answ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `postd` datetime DEFAULT NULL,
  `header` text,
  `about` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (12,35,'2022-02-13 09:02:59','Можно ли внедрять сам контейнер при автовайринге?','Суть такая: я использую контейнер в режиме автовайринга и мне нужно в резольвере внедрить контейнер, чтобы помещать в него хендлеры для последующей поддержки автовайринга уже в них: <br>\r\nPHP: <br>\r\n<small class=\"text-muted\">\r\nclass Resolver { <br>\r\nprivate Container $container;<br>\r\npublic function __construct(Container $container) { <br>\r\n$this->container = $container; <br>\r\n} <br>\r\npublic function resolve(string|array $handler): callable {<br>\r\n if (is_string($handler)) { <br>\r\nreturn $this->container->get($handler); <br>\r\n} <br>\r\n[$controller, $action] = $handler; <br>\r\n$controller = $this->container->get($controller); <br>\r\n</small>\r\n<br>\r\nЕсли я просто вот так буду использовать этот класс, то получается я внедряю пустой контейнер (новый его экземпляр) - это правильно? Или мне нужно в автосборщике контейнера указать: <br>\r\nPHP: <br>\r\n<small class=\"text-muted\">\r\nreturn [ Resolver::class => fn($container) => new Resolver($container) ];\r\n</small>\r\n<br>\r\nТо есть правильно ли внедрять контейнер при автовайринге или нужно СУЩЕСТВУЮЩИЙ ЕГО экземпляр передать в нужное место? <br>\r\n p.s. в контейнере пока не очень понимаю, гоняю пока разный код с его использованием, чтобы вникнуть на практике.'),(13,38,'2022-02-13 09:02:45','Как скормить PHP слишком \"человеческие\" данные?','Приветствую всех. Мне необходимо создать функционал, предоставляющий студенту ачивки за некие достижения, вроде: \"10 заданий выполнены на 10 баллов\", \"доля оценок выше 9 больше 90%\", \"сдано с первого раза\" и любая другая (или почти любая), которая может быть придумана менеджером. Я ломаю голову, как эти ачивки динамически в админке создавать, как хранить в бд само условие ачивки, по какой идее в коде их обрабатывать, когда наступает условие достижения ачивки? <br>\r\nМожет как-то динамически триггеры бд создавать из php, но как превращать человеческое \"10 заданий выполнены на 10 баллов\" в SQL?<br>\r\nЗа любые идеи буду признателен.<br>\r\nСпасибо!');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `DATEUP` datetime DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `file` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (35,'Milk','2022-02-13 09:02:59','Айтишник','/public/file/img/164474531912.jpeg'),(36,'Tisa','2022-02-13 09:02:24','Специалист','/public/file/img/1644745464three.jpeg'),(37,'Nagibator228','2022-02-13 09:02:32','Ибешник','/public/file/img/1644745652four.jpeg'),(38,'Anaksagor','2022-02-13 09:02:45','Нович0к','/public/file/img/1644746025two.png'),(39,'Drunkenmunky','2022-02-13 09:02:57','Преподаватель','/public/file/img/1644746397favicon.png'),(40,'Sergay','2022-02-13 07:02:14','Домосед','/public/file/img/16447795941644745464three.jpeg'),(45,'efwerff','2022-02-14 09:47:33','wfewf',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-14 21:20:39
