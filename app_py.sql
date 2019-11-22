-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: app_py
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

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
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `body` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (2,'Istana: Stafsus Tak Harus Ketemu Jokowi, tapi Kerja 1x24 Jam','fadelnuariko','<p><img alt=\"\" src=\"https://akcdn.detik.net.id/community/media/visual/2019/10/21/5f4dcb94-3b9e-4d09-a3b6-5e0e2506a133_169.jpeg?w=780&amp;q=90\" style=\"height:200px; width:355px\" /></p>\r\n\r\n<p><strong>Jakarta</strong>&nbsp;- Presiden Joko Widodo (Jokowi) mengatakan para staf khususnya (<a href=\"https://www.detik.com/tag/stafsus-jokowi/?tag_from=tag_detail&amp;_ga=2.174997226.997504153.1574324701-1954140821.1570964903\">stafsus</a>) tidak harus bekerja penuh waktu atau full time di lingkungan Istana. Pihak Istana menepis anggapan kinerja stafsus akan setengah-setengah.<br />\r\n<br />\r\n&quot;Nggak dong (kerja setengah-setengah). Setiap stafsus itu boleh berikan masukan kepada presiden 1x24 jam, tapi tidak harus ketemu dengan presiden. Jadi kan nggak setengah-setengah, kami bekerja 1x24 jam,&quot; kata Stafsus Jokowi bidang komunikasi Fadjroel Rachman di Kompleks Istana Kepresidenan, Jakarta Pusat, Jumat (22/11/2019).</p>\r\n','2019-11-22 15:55:44'),(3,'1 Mahasiswa Tewas Akibat Tawuran, Universitas Nommensen: Pelaku Harus Dipecat','fadelnuariko','<p><img alt=\"\" src=\"https://akcdn.detik.net.id/community/media/visual/2019/11/22/a1942f3a-5dcc-4eaf-b3e6-fb58f87555d9_169.jpeg?w=780&amp;q=90\" style=\"height:200px; width:355px\" /></p>\r\n\r\n<p><strong>Medan</strong>&nbsp;-&nbsp;<a href=\"https://www.detik.com/tag/tawuran-mahasiswa/?tag_from=tag_detail&amp;_ga=2.70537560.997504153.1574324701-1954140821.1570964903\">Tawuran antarmahasiswa</a>&nbsp;menyebabkan satu orang tewas di Universitas HKBP Nommensen (UHN), Medan, Sumatera Utara. Pihak rektorat UHN menyatakan pelaku perusakan dan pidana harus ditindak.<br />\r\n<br />\r\n&quot;Yang melakukan perusakan dan pidana harus dipecat, harus tegas,&quot; ujar Wakil Rektor III Universitas HKBP Nommensen (UHN) Sindak Hutauruk saat dihubungi, Jumat (22/11/2019).</p>\r\n\r\n<p>Selain dipecat, lanjutnya, oknum yang terlibat tindak pidana dalam kericuhan tersebut harus diproses secara hukum. &quot;Pelaku tindak pidana haruss diproses ke polisi dan dipecat dari kampus,&quot; imbuhnya.<br />\r\n<br />\r\nLebih lanjut, Sindak mengatakan aktivitas kuliah di Universitas HKBP Nommensen diliburkan pascabentrok. &quot;Diliburkan, Selasa masuk,&quot; tuturnya.</p>\r\n\r\n<p>Seperti diketahui, tawuran antar mahasiswa terjadi Jumat Sore. Satu orang mahasiswa tewas dan satu lainnya mengalami luka.<br />\r\n<br />\r\n&quot;Kami mendengar tadi dari pihak Rektorat dan itu inisiatif dari Rektorat, untuk sementara meliburkan mahasiswanya,&quot; kata Kapolrestabes Medan Kombes Dadang Hartanto kepada wartawan di area kampus, Jalan Sutomo, Kota Medan, Sumatera Utara (Sumut), Jumat (22/11).<br />\r\n<br />\r\nDadang menyebutkan pihaknya sampai saat ini terus melakukan pengamanan untuk mencegah peristiwa susulan atas kejadian ini. &quot;Kami melakukan pengamanan, berkoordinasi dengan Rektorat untuk mencegah ada susulan kejadian ini,&quot; sebut Dadang.</p>\r\n','2019-11-22 16:06:06');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (9,'Fadel Nuariko','fadelnuariko@gmail.com','fadelnuariko','$5$rounds=535000$Gf7s73y7ZMOOLvvG$InYdv.6yrzylvsb5KGNw4C2OY/LmEt2iACHExZgZBu7','2019-11-21 16:12:39');
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

-- Dump completed on 2019-11-23  1:36:58
