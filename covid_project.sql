-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2021 at 07:11 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `covid_project`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `st_distance_sphere` (`pt1` POINT, `pt2` POINT) RETURNS DOUBLE(10,2) RETURN 6371000 * 2 * ASIN(
    SQRT(
        POWER(SIN((ST_Y(pt2) - ST_Y(pt1)) * pi()/180 / 2), 2) +
        COS(ST_Y(pt1) * pi()/180 ) *
        COS(ST_Y(pt2) * pi()/180) *
        POWER(SIN((ST_X(pt2) - ST_X(pt1)) * pi()/180 / 2), 2)
    )
)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `group_no` int(10) UNSIGNED NOT NULL,
  `eligible_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`group_no`, `eligible_date`) VALUES
(1, '2021-04-01'),
(2, '2021-04-10'),
(3, '2021-04-20'),
(4, '2021-04-30'),
(5, '2021-05-10');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `group_no` int(10) UNSIGNED DEFAULT NULL,
  `patient_name` varchar(45) NOT NULL,
  `patient_ssn` varchar(9) NOT NULL,
  `patient_dob` date NOT NULL,
  `patient_phno` varchar(20) NOT NULL,
  `patient_email` varchar(45) NOT NULL,
  `patient_location` point NOT NULL,
  `patient_street` varchar(50) NOT NULL,
  `patient_city` varchar(20) NOT NULL,
  `patient_state` varchar(20) NOT NULL,
  `patient_zip` varchar(10) NOT NULL,
  `max_travel` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `user_name`, `group_no`, `patient_name`, `patient_ssn`, `patient_dob`, `patient_phno`, `patient_email`, `patient_location`, `patient_street`, `patient_city`, `patient_state`, `patient_zip`, `max_travel`) VALUES
(1, 'john10', 1, 'john wick', '541750898', '1996-12-23', '8574637465', 'john96@gmail.com', 0x00000000010100000000000000000049400000000000002c40, 'street1', 'city1', 'state1', '110001', 20),
(2, 'frodo11', 4, 'Frodo Bagginss', '645374635', '1999-12-07', '4353456351', 'frodo156@gmail.com', 0x00000000010100000000000000008049400000000000002e40, 'street2', 'city2', 'state2', '110002', 28),
(3, 'jack12', 2, 'NYC Hospitals', '745628485', '1996-11-05', '7453652718', 'jack96@gmail.com', 0x0000000001010000000000000000004a400000000000003040, 'street3', 'city3', 'state1', '110003', 35),
(4, 'alice13', 2, 'alice freeman', '453758473', '1996-05-16', '3682736481', 'alice96@gmail.com', 0x0000000001010000000000000000804a400000000000003140, 'street4', 'city4', 'state2', '110004', 25),
(5, 'dean14', 2, 'dean olsen', '653625378', '1995-02-12', '8473657847', 'dean96@gmail.com', 0x0000000001010000000000000000004b400000000000003240, 'street5', 'city5', 'state3', '110005', 15),
(6, 'adam15', 3, 'adam park', '768560898', '1994-11-23', '6546637465', 'adam15@gmail.com', 0x0000000001010000000000000000804b400000000000003340, 'street6', 'city6', 'state4', '110006', 20),
(7, 'travis16', 2, 'travis stone', '345674635', '1993-10-12', '8769273645', 'travis16@gmail.com', 0x0000000001010000000000000000004c400000000000003440, 'street7', 'city7', 'state4', '110007', 25),
(8, 'earl17', 4, 'earl clapton', '326728485', '1992-06-08', '7658902718', 'earl17@gmail.com', 0x0000000001010000000000000000804c400000000000003040, 'street8', 'city3', 'state5', '110008', 35),
(9, 'bob18', 3, 'bob simmons', '345158473', '1993-05-18', '4537736481', 'bob18@gmail.com', 0x0000000001010000000000000000804a400000000000003140, 'street9', 'city5', 'state2', '110010', 25),
(10, 'kenny19', 4, 'kenny scott', '215625378', '1991-07-12', '2356127847', 'kenny19@gmail.com', 0x0000000001010000000000000000004b400000000000003240, 'street10', 'city8', 'state3', '110021', 15),
(52, 'test1', NULL, 'Mike Tyson', '489368350', '1989-05-24', '8574658375', 'test1@gmail.com', 0x000000000101000000fd9f68c306564440ead6c633437d52c0, '781 Franklin Ave', 'Brooklyn', 'NY', '11238', 50),
(53, 'test2', NULL, 'Joe Jonas', '690055315', '2000-07-16', '8574654356', 'test2@gmail.com', 0x0000000001010000002da4b217c0554440e2276959527c52c0, '781 Eastern Pkwy', ' Brooklyn, NY', 'NY', '11213', 30);

-- --------------------------------------------------------

--
-- Table structure for table `patientavailability`
--

CREATE TABLE `patientavailability` (
  `patient_id` int(10) UNSIGNED NOT NULL,
  `week_day` int(10) UNSIGNED NOT NULL,
  `time_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patientavailability`
--

INSERT INTO `patientavailability` (`patient_id`, `week_day`, `time_id`) VALUES
(1, 0, 1),
(1, 0, 3),
(2, 1, 4),
(2, 2, 3),
(2, 2, 4),
(2, 2, 5),
(2, 2, 6),
(2, 3, 5),
(3, 1, 5),
(3, 4, 2),
(4, 1, 2),
(4, 2, 1),
(4, 4, 1),
(5, 3, 2),
(6, 2, 4),
(7, 2, 3),
(8, 6, 2),
(9, 4, 1),
(10, 2, 1),
(52, 3, 1),
(52, 3, 3),
(52, 3, 6),
(52, 4, 2),
(52, 4, 3),
(52, 4, 5),
(53, 3, 3),
(53, 3, 5),
(53, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `patientupload`
--

CREATE TABLE `patientupload` (
  `file_id` int(10) UNSIGNED NOT NULL,
  `patient_id` int(10) UNSIGNED NOT NULL,
  `file_pointer` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `patientupload`
--
DELIMITER $$
CREATE TRIGGER `group_assign` AFTER INSERT ON `patientupload` FOR EACH ROW begin
DECLARE age INT;
SELECT TIMESTAMPDIFF(YEAR, patient_dob, CURDATE()) INTO age
from patient
WHERE patient_id = NEW.patient_id;
    if (age > 60) then
        UPDATE patient set group_no = 1
        WHERE patient_id = NEW.patient_id;
    elseif (age <= 60) AND (age > 50)  then
        UPDATE patient set group_no = 2
        WHERE patient_id = NEW.patient_id;
    elseif (age <= 50) AND (age > 35)  then
        UPDATE patient set group_no = 3
        WHERE patient_id = NEW.patient_id;
    elseif (age <= 35) AND (age > 20)  then
        UPDATE patient set group_no = 4
        WHERE patient_id = NEW.patient_id;
    elseif (age <= 20)  then
        UPDATE patient set group_no = 5
        WHERE patient_id = NEW.patient_id;
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

CREATE TABLE `provider` (
  `provider_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `provider_name` varchar(45) NOT NULL,
  `provider_type` varchar(45) NOT NULL,
  `provider_phno` varchar(20) NOT NULL,
  `provider_email` varchar(20) NOT NULL,
  `provider_location` point NOT NULL,
  `provider_street` varchar(50) NOT NULL,
  `provider_city` varchar(20) NOT NULL,
  `provider_state` varchar(20) NOT NULL,
  `provider_zip` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` (`provider_id`, `user_name`, `provider_name`, `provider_type`, `provider_phno`, `provider_email`, `provider_location`, `provider_street`, `provider_city`, `provider_state`, `provider_zip`) VALUES
(1, 'mike96', 'Mike Hudson', 'doctor', '9847362736', 'mike96@gmail.com', 0x0000000001010000000e8d823bab0944404b581b6327e02c40, 'street11', 'city11', 'state1', '110011'),
(2, 'hosp1', 'Brooklyn Hospital', 'hospital', '2352617263', 'hosp1@gmail.com', 0x0000000001010000000e8d823bab8944404b581b6327e02e40, 'street12', 'city12', 'state2', '110012'),
(3, 'cityhosp2', 'NYC Hospital', 'hospital', '3546253648', 'nychosp@gmail.com', 0x0000000001010000000e8d823bab09454026ac8db113703040, 'street13', 'city13', 'state1', '110013'),
(4, 'dylan96', 'dylan sprouse', 'doctor', '4536276453', 'dylan96@gmail.com', 0x0000000001010000000e8d823bab89454026ac8db113703140, 'street14', 'city14', 'state3', '110014'),
(5, 'charlie96', 'charlie hunt', 'doctor', '1746352974', 'charlie96@gmail.com', 0x0000000001010000000e8d823bab09464026ac8db113703240, 'street15', 'city15', 'state2', '110015'),
(8, 'test3', 'New Hospital', 'hospital', '4564658375', 'test3@gmail.com', 0x00000000010100000078b306efab5544403c7f7fef5b7d52c0, '842 Franklin Ave', 'Brooklyn, NY', 'NY', '11225'),
(9, 'test4', 'Great Doctor', 'doctor', '8574658375', 'test4@gmail.com', 0x0000000001010000003198bf42e65544402ee411dc487d52c0, '341 Eastern Pkwy', 'Brooklyn, NY', 'NY', '11238');

-- --------------------------------------------------------

--
-- Table structure for table `timeslot`
--

CREATE TABLE `timeslot` (
  `time_id` int(10) UNSIGNED NOT NULL,
  `starttime` time NOT NULL,
  `endtime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `timeslot`
--

INSERT INTO `timeslot` (`time_id`, `starttime`, `endtime`) VALUES
(1, '08:00:00', '10:00:00'),
(2, '10:00:00', '12:00:00'),
(3, '12:00:00', '14:00:00'),
(4, '14:00:00', '16:00:00'),
(5, '16:00:00', '18:00:00'),
(6, '18:00:00', '20:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_name` varchar(45) NOT NULL,
  `passwordhash` varchar(255) NOT NULL,
  `user_type` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_name`, `passwordhash`, `user_type`) VALUES
('adam15', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('alice13', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('bob18', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('charlie96', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'provider'),
('cityhosp2', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'provider'),
('dean14', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('dylan96', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'provider'),
('earl17', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('frodo11', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('hosp1', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'provider'),
('jack12', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('john10', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('kenny19', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient'),
('mike96', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'provider'),
('test1', '$2y$10$g232AnYdC8gkHsplz/iAAeIZeyaEB6qtxOQyg/dcxhUChhjUiwBRC', 'patient'),
('test2', '$2y$10$hqw9bNncVBVg36iFPB/aku4HnlzwleXykzwrfZtU5zk2S3clPFH3i', 'patient'),
('test3', '$2y$10$Zqmr4ybu6nop62GkhkrzK.mqw6pqRT2jcjJj9FEuOHEzf2I0XY10O', 'provider'),
('test4', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'provider'),
('travis16', '$2y$10$o7R144Z7o8iHiU1kfvIXYeEii/7Q3.a5W9GPZUnDs7I0t5JeGoehq', 'patient');

-- --------------------------------------------------------

--
-- Table structure for table `vaccineappointment`
--

CREATE TABLE `vaccineappointment` (
  `appoint_id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(10) UNSIGNED NOT NULL,
  `appoint_date` date NOT NULL,
  `appoint_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vaccineappointment`
--

INSERT INTO `vaccineappointment` (`appoint_id`, `provider_id`, `appoint_date`, `appoint_time`) VALUES
(1, 1, '2021-04-15', '08:38:00'),
(2, 1, '2021-04-16', '08:30:00'),
(3, 2, '2021-04-22', '09:30:00'),
(4, 3, '2021-04-25', '11:30:00'),
(5, 3, '2021-04-25', '11:30:00'),
(6, 3, '2021-04-27', '11:30:00'),
(7, 2, '2021-04-30', '13:30:00'),
(8, 5, '2021-05-01', '16:30:00'),
(9, 4, '2021-05-01', '11:50:00'),
(10, 5, '2021-05-02', '16:30:00'),
(11, 2, '2021-05-03', '12:00:00'),
(12, 3, '2021-05-08', '12:00:00'),
(13, 5, '2021-05-10', '13:30:00'),
(14, 4, '2021-05-12', '16:30:00'),
(15, 5, '2021-05-15', '18:30:00'),
(16, 1, '2021-05-20', '10:00:00'),
(17, 3, '2021-05-07', '20:24:00'),
(18, 3, '2021-05-13', '20:33:00'),
(19, 3, '2021-05-18', '10:32:00'),
(20, 3, '2021-05-11', '11:32:00'),
(21, 8, '2021-05-21', '15:20:00'),
(24, 8, '2021-05-20', '14:39:00'),
(25, 8, '2021-05-20', '15:39:00'),
(26, 9, '2021-05-20', '11:11:00'),
(27, 9, '2021-05-20', '10:11:00'),
(28, 8, '2021-05-20', '14:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `vaccineoffer`
--

CREATE TABLE `vaccineoffer` (
  `patient_id` int(10) UNSIGNED NOT NULL,
  `appoint_id` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','accepted','declined','cancelled','no-show','completed','expired') DEFAULT NULL,
  `offer_date` datetime NOT NULL,
  `reply_date` datetime DEFAULT NULL,
  `deadline_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vaccineoffer`
--

INSERT INTO `vaccineoffer` (`patient_id`, `appoint_id`, `status`, `offer_date`, `reply_date`, `deadline_date`) VALUES
(1, 1, 'expired', '2021-04-04 08:30:00', '2021-05-03 20:08:30', '2021-04-08 20:00:00'),
(1, 7, 'accepted', '2021-04-22 09:30:00', '2021-05-03 20:08:28', '2021-04-23 20:00:00'),
(2, 1, 'cancelled', '2021-04-07 08:30:00', '2021-05-18 12:05:41', '2021-04-09 20:00:00'),
(2, 2, 'cancelled', '2021-04-10 08:30:00', '2021-05-18 12:06:17', '2021-04-12 20:00:00'),
(2, 3, 'expired', '2021-04-11 09:30:00', '2021-05-17 19:39:06', '2021-04-12 20:00:00'),
(2, 4, 'declined', '2021-04-19 08:30:00', '2021-05-03 20:08:23', '2021-04-22 20:00:00'),
(2, 12, 'cancelled', '2021-06-19 08:30:00', '2021-05-15 23:05:46', '2021-06-22 20:00:00'),
(3, 2, 'no-show', '2021-04-14 08:30:00', '2021-04-15 16:30:00', '2021-04-16 20:00:00'),
(3, 3, 'completed', '2021-04-16 08:30:00', '2021-04-17 16:30:00', '2021-04-18 20:00:00'),
(4, 5, 'no-show', '2021-04-20 08:30:00', '2021-04-21 09:30:00', '2021-04-22 20:00:00'),
(4, 6, 'expired', '2021-04-22 08:30:00', '2021-04-23 08:30:00', '2021-04-24 20:00:00'),
(4, 7, 'completed', '2021-04-24 08:30:00', '2021-04-25 11:30:00', '2021-04-26 20:00:00'),
(5, 4, 'accepted', '2021-04-18 08:30:00', '2021-04-19 13:30:00', '2021-04-20 20:00:00'),
(5, 8, 'expired', '2021-04-20 08:30:00', '2021-05-10 20:08:21', '2021-04-30 20:00:00'),
(6, 7, 'cancelled', '2021-04-20 08:30:00', '2021-04-21 16:30:00', '2021-04-30 20:00:00'),
(6, 9, 'cancelled', '2021-04-23 08:30:00', '2021-04-23 16:30:00', '2021-04-30 20:00:00'),
(6, 10, 'accepted', '2021-04-25 08:30:00', '2021-04-27 16:30:00', '2021-04-30 20:00:00'),
(8, 2, 'no-show', '2021-04-11 08:30:00', '2021-04-12 12:30:00', '2021-04-13 20:00:00'),
(8, 11, 'cancelled', '2021-04-26 10:00:00', '2021-04-27 08:30:00', '2021-05-01 20:00:00'),
(8, 12, 'cancelled', '2021-04-27 10:30:00', '2021-04-27 11:30:00', '2021-05-01 20:00:00'),
(8, 13, 'cancelled', '2021-04-27 13:30:00', '2021-04-27 16:30:00', '2021-05-01 20:00:00'),
(8, 14, 'cancelled', '2021-04-28 08:30:00', '2021-04-28 13:30:00', '2021-05-03 20:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`group_no`),
  ADD UNIQUE KEY `group_no_UNIQUE` (`group_no`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `patient_id_UNIQUE` (`patient_id`);

--
-- Indexes for table `patientavailability`
--
ALTER TABLE `patientavailability`
  ADD PRIMARY KEY (`patient_id`,`week_day`,`time_id`),
  ADD KEY `pa_time_id` (`time_id`);

--
-- Indexes for table `patientupload`
--
ALTER TABLE `patientupload`
  ADD PRIMARY KEY (`file_id`),
  ADD UNIQUE KEY `file_id_UNIQUE` (`file_id`),
  ADD KEY `upload_patient` (`patient_id`);

--
-- Indexes for table `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`provider_id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `provider_id_UNIQUE` (`provider_id`);

--
-- Indexes for table `timeslot`
--
ALTER TABLE `timeslot`
  ADD PRIMARY KEY (`time_id`),
  ADD UNIQUE KEY `time_id_UNIQUE` (`time_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_name`),
  ADD UNIQUE KEY `user_name_UNIQUE` (`user_name`);

--
-- Indexes for table `vaccineappointment`
--
ALTER TABLE `vaccineappointment`
  ADD PRIMARY KEY (`appoint_id`),
  ADD UNIQUE KEY `appoint_id_UNIQUE` (`appoint_id`),
  ADD KEY `va_provider` (`provider_id`);

--
-- Indexes for table `vaccineoffer`
--
ALTER TABLE `vaccineoffer`
  ADD PRIMARY KEY (`patient_id`,`appoint_id`),
  ADD KEY `vo_appoint_id` (`appoint_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `patientupload`
--
ALTER TABLE `patientupload`
  MODIFY `file_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `provider`
--
ALTER TABLE `provider`
  MODIFY `provider_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `vaccineappointment`
--
ALTER TABLE `vaccineappointment`
  MODIFY `appoint_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_user` FOREIGN KEY (`user_name`) REFERENCES `user` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patientavailability`
--
ALTER TABLE `patientavailability`
  ADD CONSTRAINT `pa_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pa_time_id` FOREIGN KEY (`time_id`) REFERENCES `timeslot` (`time_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patientupload`
--
ALTER TABLE `patientupload`
  ADD CONSTRAINT `upload_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `provider`
--
ALTER TABLE `provider`
  ADD CONSTRAINT `provider_user` FOREIGN KEY (`user_name`) REFERENCES `user` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vaccineappointment`
--
ALTER TABLE `vaccineappointment`
  ADD CONSTRAINT `va_provider` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vaccineoffer`
--
ALTER TABLE `vaccineoffer`
  ADD CONSTRAINT `vo_appoint_id` FOREIGN KEY (`appoint_id`) REFERENCES `vaccineappointment` (`appoint_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vo_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `check_offer` ON SCHEDULE EVERY 1 MINUTE STARTS NOW() ON COMPLETION NOT PRESERVE ENABLE DO UPDATE vaccineoffer
	SET status = "expired"
	WHERE status = "pending" and deadline_date < NOW()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
