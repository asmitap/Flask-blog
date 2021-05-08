-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2021 at 08:59 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `thecoder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `message` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone`, `message`, `date`) VALUES
(1, 'admin', 'admin@gmail.com', '0987654321', 'hello from admin', '2021-04-29 13:09:43');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(20) NOT NULL,
  `title` text NOT NULL,
  `subtitle` varchar(100) NOT NULL,
  `content` varchar(500) NOT NULL,
  `slug` varchar(25) NOT NULL,
  `img_name` varchar(100) NOT NULL,
  `posted_by` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `subtitle`, `content`, `slug`, `img_name`, `posted_by`, `date`) VALUES
(1, 'Datas', 'Data is information', 'The Data in Data Science Before anything else, there is always data. Data is the foundation of data science; it is the material on which all the analyses are based. In the context of data science, there are two types of data: traditional, and big data.  Traditional data is data that is structured and stored in databases which analysts can manage from one computer; it is in table format, containing numeric or text values. Actually, the term “traditional” is something we are introducing for clarit', 'first-post', 'contact-bg.jpg', 'asmita', '2021-05-06 20:26:49'),
(2, 'Simple Mail Transfer Protocol', 'SMTP', 'SMTP stands for Simple Mail Transfer Protocol. SMTP is a set of communication guidelines that allow software to transmit an electronic mail over the internet is called Simple Mail Transfer Protocol. It is a program used for sending messages to other computer users based on e-mail addresses. It provides a mail exchange between users on the same or different computers, and it also supports: It can send a single message to one or more recipients. Sending message can include text, voice, video or gr', 'second-post', 'post-bg.jpg', 'asmita', '2021-05-06 20:28:37'),
(3, 'Machine Learning', 'ML', 'Machine learning (ML) is the study of computer algorithms that improve automatically through experience and by the use of data.[1] It is seen as a part of artificial intelligence. Machine learning algorithms build a model based on sample data, known as \"training data\", in order to make predictions or decisions without being explicitly programmed to do so.[2] Machine learning algorithms are used in a wide variety of applications, such as in medicine, email filtering, and computer vision, where it', 'third-post', 'contact-bg.jpg', 'asmita', '2021-05-06 20:29:53'),
(4, 'Computer', 'A machine', 'A computer is a machine that can be programmed to carry out sequences of arithmetic or logical operations automatically. Modern computers can perform generic sets of operations known as programs. These programs enable computers to perform a wide range of tasks. A computer system is a \"complete\" computer that includes the hardware, operating system (main software), and peripheral equipment needed and used for \"full\" operation. This term may also refer to a group of computers that are linked and f', 'fourth-post', 'about-bg.jpg', 'asmita', '2021-05-06 20:30:55'),
(5, 'Deep Learning', 'DL', 'Deep learning is an artificial intelligence (AI) function that imitates the workings of the human brain in processing data and creating patterns for use in decision making. Deep learning is a subset of machine learning in artificial intelligence that has networks capable of learning unsupervised from data that is unstructured or unlabeled. Also known as deep neural learning or deep neural network.', 'fifth-post', 'about-bg.jpg', 'asmita', '2021-05-06 20:31:47'),
(6, 'Probability and Statistics', 'stat', 'Probability and statistics, the branches of mathematics concerned with the laws governing random events, including the collection, analysis, interpretation, and display of numerical data. Probability has its origin in the study of gambling and insurance in the 17th century, and it is now an indispensable tool of both social and natural sciences. Statistics may be said to have its origin in census counts taken thousands of years ago; as a distinct scientific discipline, however, it was developed ', 'sixth post', 'home-bg.jpg', 'asmita', '2021-05-06 20:32:24'),
(7, 'Data Science', 'Data is information', 'Data science is an interdisciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from structured and unstructured data,[1][2] and apply knowledge and actionable insights from data across a broad range of application domains. Data science is related to data mining, machine learning and big data.', 'seventh-post', 'home-bg.jpg', 'asmita', '2021-05-06 20:33:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
