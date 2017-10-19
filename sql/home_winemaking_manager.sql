-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2017 at 02:42 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `home_winemaking_manager`
--
CREATE DATABASE IF NOT EXISTS `home_winemaking_manager` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `home_winemaking_manager`;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `EventID` int(11) NOT NULL,
  `EventTypeID` int(11) NOT NULL,
  `WineID` int(11) NOT NULL,
  `EventTimestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `eventtypes`
--

DROP TABLE IF EXISTS `eventtypes`;
CREATE TABLE `eventtypes` (
  `EventTypeID` int(11) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `Category` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `IngredientID` int(11) NOT NULL,
  `WineID` int(11) NOT NULL,
  `IngredientTypeID` int(11) NOT NULL,
  `Quantity` float NOT NULL,
  `Units` varchar(32) NOT NULL,
  `Cost` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ingredienttypes`
--

DROP TABLE IF EXISTS `ingredienttypes`;
CREATE TABLE `ingredienttypes` (
  `IngredientTypeID` int(11) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `Category` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `measurementenums`
--

DROP TABLE IF EXISTS `measurementenums`;
CREATE TABLE `measurementenums` (
  `MeasurementEnumsID` int(11) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `Abbreviation` varchar(16) NOT NULL,
  `Unit` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `measurementenums`
--

INSERT INTO `measurementenums` (`MeasurementEnumsID`, `Name`, `Abbreviation`, `Unit`) VALUES
(1, 'Specific Gravity', 'SG', 'ppg'),
(2, 'Titratable Acid', 'TA', 'g/L'),
(3, 'Sulfite', 'SO2', 'ppm'),
(4, 'Volume', 'Vol', 'gallons'),
(6, 'Potential of Hydrogen', 'pH', '');

-- --------------------------------------------------------

--
-- Table structure for table `measurements`
--

DROP TABLE IF EXISTS `measurements`;
CREATE TABLE `measurements` (
  `MeasurementID` int(11) NOT NULL,
  `WineID` int(11) NOT NULL,
  `MeasurementEnumsID` int(11) NOT NULL,
  `Timestamp` datetime NOT NULL,
  `Value` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wines`
--

DROP TABLE IF EXISTS `wines`;
CREATE TABLE `wines` (
  `WineID` int(11) NOT NULL,
  `Vintage` int(11) NOT NULL,
  `TastingNotes` varchar(1024) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `WineTypeID` int(11) NOT NULL,
  `Stage` enum('Recipe Design','Primary Fermentation','Secondary Fermentation','Aging','Bottled','Consumed') NOT NULL,
  `Inventory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wines`
--

INSERT INTO `wines` (`WineID`, `Vintage`, `TastingNotes`, `Name`, `WineTypeID`, `Stage`, `Inventory`) VALUES
(1, 2014, 'It tasted like grapes', 'Riesling', 1, 'Consumed', 0),
(2, 2015, 'Still grapes.', 'Riesling', 1, 'Consumed', 0);

-- --------------------------------------------------------

--
-- Table structure for table `winetypes`
--

DROP TABLE IF EXISTS `winetypes`;
CREATE TABLE `winetypes` (
  `WineTypeID` int(11) NOT NULL,
  `Type` varchar(256) NOT NULL,
  `Color` varchar(32) NOT NULL,
  `Notes` varchar(1024) NOT NULL,
  `TargetOG` float NOT NULL,
  `TargetFG` float NOT NULL,
  `TargetInitialTA` float NOT NULL,
  `TargetFinalTA` float NOT NULL,
  `TargetInitialPH` float NOT NULL,
  `TargetFinalPH` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `winetypes`
--

INSERT INTO `winetypes` (`WineTypeID`, `Type`, `Color`, `Notes`, `TargetOG`, `TargetFG`, `TargetInitialTA`, `TargetFinalTA`, `TargetInitialPH`, `TargetFinalPH`) VALUES
(1, 'Riesling', 'White', 'Riesling is a white grape variety which originated in the Rhine region of Germany. Riesling is an aromatic grape variety displaying flowery, almost perfumed, aromas as well as high acidity. It is used to make dry, semi-sweet, sweet, and sparkling white wines.', 1.091, 1, 9, 8, 3.1, 3.1),
(2, 'Chardonnay', 'White', 'The Chardonnay grape itself is very neutral, with many of the flavors commonly associated with the grape being derived from such influences as terroir and oak', 1.091, 1, 7, 6, 3.6, 3.6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`EventID`),
  ADD KEY `events_wineid` (`WineID`),
  ADD KEY `events_eventtypeid` (`EventTypeID`);

--
-- Indexes for table `eventtypes`
--
ALTER TABLE `eventtypes`
  ADD PRIMARY KEY (`EventTypeID`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`IngredientID`),
  ADD KEY `ingredients_ingredienttypeid` (`IngredientTypeID`),
  ADD KEY `WineID` (`WineID`);

--
-- Indexes for table `ingredienttypes`
--
ALTER TABLE `ingredienttypes`
  ADD PRIMARY KEY (`IngredientTypeID`);

--
-- Indexes for table `measurementenums`
--
ALTER TABLE `measurementenums`
  ADD PRIMARY KEY (`MeasurementEnumsID`);

--
-- Indexes for table `measurements`
--
ALTER TABLE `measurements`
  ADD PRIMARY KEY (`MeasurementID`),
  ADD KEY `measurements_wineid` (`WineID`),
  ADD KEY `measurements_measurementenumsid` (`MeasurementEnumsID`);

--
-- Indexes for table `wines`
--
ALTER TABLE `wines`
  ADD PRIMARY KEY (`WineID`),
  ADD KEY `WineTypeID` (`WineTypeID`);

--
-- Indexes for table `winetypes`
--
ALTER TABLE `winetypes`
  ADD PRIMARY KEY (`WineTypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `EventID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eventtypes`
--
ALTER TABLE `eventtypes`
  MODIFY `EventTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `IngredientID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredienttypes`
--
ALTER TABLE `ingredienttypes`
  MODIFY `IngredientTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `measurementenums`
--
ALTER TABLE `measurementenums`
  MODIFY `MeasurementEnumsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `measurements`
--
ALTER TABLE `measurements`
  MODIFY `MeasurementID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wines`
--
ALTER TABLE `wines`
  MODIFY `WineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `winetypes`
--
ALTER TABLE `winetypes`
  MODIFY `WineTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
