-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2020 at 10:30 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airlines2`
--

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `AIRPORT-CODE` char(3) NOT NULL,
  `BOOKING-OFFICE` varchar(20) NOT NULL,
  `AIRPORT-TAX` double NOT NULL,
  `country_countryname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='pena';

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`AIRPORT-CODE`, `BOOKING-OFFICE`, `AIRPORT-TAX`, `country_countryname`) VALUES
('CDG', 'Paris', 18, 'France'),
('CGN', 'Bonn', 2, 'Germany'),
('EDI', 'Edinburgh', 3, 'United Kingdom'),
('FCO', 'Rome', 7, 'Italy'),
('JFK', 'New York', 12, 'USA'),
('LCY', 'London', 9, 'United Kingdom'),
('NAP', 'Napoli', 1, 'Italy'),
('NCE', 'Nice', 4, 'France'),
('ORD', 'Chicago', 8, 'USA'),
('TXL', 'Berlin', 5, 'Germany'),
('YUL', 'Montreal', 2, 'Canada'),
('YYZ', 'Toronto', 3, 'Canada');

-- --------------------------------------------------------

--
-- Table structure for table `airportmanagement`
--

CREATE TABLE `airportmanagement` (
  `AIRPORT_AIRPORT-CODE` char(3) NOT NULL,
  `FLIGHT_FLIGHT-ID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airportmanagement`
--

INSERT INTO `airportmanagement` (`AIRPORT_AIRPORT-CODE`, `FLIGHT_FLIGHT-ID`) VALUES
('CDG', 'CY406'),
('CDG', 'YC450'),
('EDI', 'EY265'),
('JFK', 'JY398'),
('JFK', 'YJ121'),
('YUL', 'YC450'),
('YYZ', 'CY406'),
('YYZ', 'EY265'),
('YYZ', 'JY398'),
('YYZ', 'YJ121');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `bookid` int(11) NOT NULL,
  `BOOKING-DATE` datetime NOT NULL,
  `customer_documentid` varchar(20) NOT NULL,
  `FLIGHT_FLIGHT-ID` varchar(10) NOT NULL,
  `SEAT_SEAT-ID` int(11) NOT NULL,
  `total_cost` double NOT NULL,
  `paid_ammount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`bookid`, `BOOKING-DATE`, `customer_documentid`, `FLIGHT_FLIGHT-ID`, `SEAT_SEAT-ID`, `total_cost`, `paid_ammount`) VALUES
(0, '2020-06-08 22:35:32', 'FR1876', 'YC450', 11, 70, 70),
(57772, '2020-06-08 22:11:28', 'AK47', 'CY406', 0, 301.5, 301.5),
(612733, '2020-06-08 21:20:35', 'GR123', 'YJ121', 57, 139.5, 139);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `countryname` varchar(20) NOT NULL,
  `telcode` int(11) NOT NULL,
  `currency` varchar(20) NOT NULL,
  `AIRLINE-ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`countryname`, `telcode`, `currency`, `AIRLINE-ID`) VALUES
('Canada', 1, 'Canadian Dollar', 'AirCan'),
('France', 33, 'French Francs', 'AirFrance'),
('Germany', 49, 'German Pound', 'LuftAir'),
('Italy', 39, 'Italian Pound', 'ItalAir'),
('United Kingdom', 44, 'English Pound', 'BritAir'),
('USA', 1, 'USA Dollar', 'USAir');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `documentid` varchar(20) NOT NULL,
  `name` varchar(4000) NOT NULL,
  `surname` varchar(4000) NOT NULL,
  `telephone` varchar(200) DEFAULT NULL,
  `email` varchar(4000) DEFAULT NULL,
  `fax` varchar(200) DEFAULT NULL,
  `HOMEADDRESS_STREET-ADDRESS` varchar(80) NOT NULL,
  `HOMEADDRESS_AREA-CODE` int(11) NOT NULL,
  `homeaddress_countryname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`documentid`, `name`, `surname`, `telephone`, `email`, `fax`, `HOMEADDRESS_STREET-ADDRESS`, `HOMEADDRESS_AREA-CODE`, `homeaddress_countryname`) VALUES
('59694', 'Lakis', 'Gavalas', '0', '0', '0', 'Karaoli', 18553, 'Canada'),
('AK47', 'MAKIS', 'DIMAKIS', '2102202558', NULL, NULL, 'Karaoli kai dimitriou 80', 18534, 'Canada'),
('FR1876', 'John', 'Kennedy', '', 'johnk@gmail.fr', '', 'Axarnwn 22', 15822, 'France'),
('GB1245', 'George', 'Kolios', '', 'georgek@gmail.com', '', 'Tsimiski 23', 18596, 'France'),
('GR123', 'Dridan', 'Papadopoyloy', '', 'pap32@gmail.com', '', 'marathonos 122', 11812, 'Italy'),
('GR1234', 'Babis', 'Xristoy', '', 'babakas2@gmail.com', '', 'Kykladon 12', 11361, 'Italy'),
('SV1212', 'Seby', 'Andrisan', '0', 'seb@gmail.com', '0', 'Agioy Meletioy', 11361, 'France');

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `FLIGHTID` varchar(10) NOT NULL,
  `DEPARTURE-DATETIME` timestamp NULL DEFAULT NULL,
  `ARRIVAL-DATETIME` timestamp(6) NULL DEFAULT NULL,
  `FLIGHT-TIME` varchar(50) DEFAULT NULL,
  `FLIGHT-PRICE` float NOT NULL,
  `FROM` varchar(10) NOT NULL,
  `TO` varchar(10) NOT NULL,
  `airline` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`FLIGHTID`, `DEPARTURE-DATETIME`, `ARRIVAL-DATETIME`, `FLIGHT-TIME`, `FLIGHT-PRICE`, `FROM`, `TO`, `airline`) VALUES
('CY406', '2020-06-10 08:50:00', '2020-06-10 13:45:00.000000', '4 hours and 55', 180, 'CDG', 'YYZ', 'AirFrance'),
('EY265', '2021-01-15 17:40:00', '2021-01-15 18:50:00.000000', '1 hours and 10', 99, 'EDI', 'YYZ', 'BritAir'),
('JY398', '2020-09-03 07:20:00', '2020-09-03 07:55:00.000000', '0 hours and 35', 27, 'JFK', 'YYZ', 'USAir'),
('YC450', '2021-02-25 13:45:00', '2021-02-25 16:10:00.000000', '2 hours and 25', 50, 'YUL', 'CDG', 'AirCan'),
('YJ121', '2020-11-04 19:00:00', '2020-11-04 20:35:00.000000', '1 hours and 35', 78, 'YYZ', 'JFK', 'USAir');

-- --------------------------------------------------------

--
-- Table structure for table `homeaddress`
--

CREATE TABLE `homeaddress` (
  `country_countryname` varchar(20) NOT NULL,
  `STREET-ADDRESS` varchar(80) NOT NULL,
  `AREA-CODE` int(11) NOT NULL,
  `town` varchar(4000) NOT NULL,
  `state` varchar(4000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ok';

--
-- Dumping data for table `homeaddress`
--

INSERT INTO `homeaddress` (`country_countryname`, `STREET-ADDRESS`, `AREA-CODE`, `town`, `state`) VALUES
('France', 'Agioy Meletioy', 11361, 'Lyon', 'Attiki'),
('France', 'Axarnwn 22', 15822, 'Bayern', 'Indiana'),
('Canada', 'Karaoli', 18553, 'Pireas', 'Attica'),
('Canada', 'Karaoli kai dimitriou 80', 18534, 'Peiraias', 'Attica of Canada'),
('Italy', 'Kykladon 12', 11361, 'Babylon', 'Sicily'),
('Italy', 'Kykladon 45', 11361, 'Babylon', 'Sicilia'),
('Italy', 'marathonos 122', 11812, 'Milan', 'Sicily'),
('France', 'Tsimiski 23', 18596, 'Athens', 'Attica');

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `SEAT_STATE` varchar(4000) NOT NULL DEFAULT '',
  `issmoking` varchar(10) NOT NULL,
  `TRAVEL-CLASS_CLASSID` varchar(20) NOT NULL,
  `TRAVEL-CLASS_FLIGHT_FLIGHT-ID` varchar(10) NOT NULL,
  `booking_bookid` int(11) DEFAULT NULL,
  `seat_flPK` varchar(30) NOT NULL,
  `seatnum` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seat`
--

INSERT INTO `seat` (`SEAT_STATE`, `issmoking`, `TRAVEL-CLASS_CLASSID`, `TRAVEL-CLASS_FLIGHT_FLIGHT-ID`, `booking_bookid`, `seat_flPK`, `seatnum`) VALUES
('', 'no', 'eco', 'CY406', NULL, '10CY406', 10),
('', 'yes', 'eco', 'EY265', NULL, '10EY265', 10),
('', 'no', 'eco', 'JY398', NULL, '10JY398', 10),
('', 'yes', 'eco', 'YC450', NULL, '10YC450', 10),
('', 'yes', 'eco', 'YJ121', NULL, '10YJ121', 10),
('', 'no', 'eco', 'CY406', NULL, '11CY406', 11),
('', 'no', 'eco', 'EY265', NULL, '11EY265', 11),
('', 'no', 'eco', 'JY398', NULL, '11JY398', 11),
('a', 'no', 'eco', 'YC450', 0, '11YC450', 11),
('', 'no', 'eco', 'YJ121', NULL, '11YJ121', 11),
('', 'no', 'eco', 'CY406', NULL, '12CY406', 12),
('', 'no', 'eco', 'EY265', NULL, '12EY265', 12),
('', 'no', 'eco', 'JY398', NULL, '12JY398', 12),
('', 'no', 'eco', 'YC450', NULL, '12YC450', 12),
('', 'no', 'eco', 'YJ121', NULL, '12YJ121', 12),
('', 'no', 'eco', 'CY406', NULL, '13CY406', 13),
('', 'no', 'eco', 'EY265', NULL, '13EY265', 13),
('', 'no', 'eco', 'JY398', NULL, '13JY398', 13),
('', 'no', 'eco', 'YC450', NULL, '13YC450', 13),
('', 'no', 'eco', 'YJ121', NULL, '13YJ121', 13),
('', 'no', 'eco', 'CY406', NULL, '14CY406', 14),
('', 'no', 'eco', 'EY265', NULL, '14EY265', 14),
('', 'no', 'eco', 'JY398', NULL, '14JY398', 14),
('', 'no', 'eco', 'YC450', NULL, '14YC450', 14),
('', 'no', 'eco', 'YJ121', NULL, '14YJ121', 14),
('', 'no', 'eco', 'CY406', NULL, '15CY406', 15),
('', 'no', 'eco', 'EY265', NULL, '15EY265', 15),
('', 'no', 'eco', 'JY398', NULL, '15JY398', 15),
('', 'no', 'eco', 'YC450', NULL, '15YC450', 15),
('', 'no', 'eco', 'YJ121', NULL, '15YJ121', 15),
('', 'no', 'eco', 'CY406', NULL, '16CY406', 16),
('', 'no', 'eco', 'EY265', NULL, '16EY265', 16),
('', 'no', 'eco', 'JY398', NULL, '16JY398', 16),
('', 'no', 'eco', 'YC450', NULL, '16YC450', 16),
('', 'no', 'eco', 'YJ121', NULL, '16YJ121', 16),
('', 'no', 'eco', 'CY406', NULL, '17CY406', 17),
('', 'no', 'eco', 'EY265', NULL, '17EY265', 17),
('', 'no', 'eco', 'JY398', NULL, '17JY398', 17),
('', 'no', 'eco', 'YC450', NULL, '17YC450', 17),
('', 'no', 'eco', 'YJ121', NULL, '17YJ121', 17),
('', 'no', 'eco', 'CY406', NULL, '18CY406', 18),
('', 'no', 'eco', 'EY265', NULL, '18EY265', 18),
('', 'no', 'eco', 'JY398', NULL, '18JY398', 18),
('', 'no', 'eco', 'YC450', NULL, '18YC450', 18),
('', 'no', 'eco', 'YJ121', NULL, '18YJ121', 18),
('', 'no', 'eco', 'CY406', NULL, '19CY406', 19),
('', 'no', 'eco', 'EY265', NULL, '19EY265', 19),
('', 'no', 'eco', 'JY398', NULL, '19JY398', 19),
('', 'no', 'eco', 'YC450', NULL, '19YC450', 19),
('', 'no', 'eco', 'YJ121', NULL, '19YJ121', 19),
('', 'yes', 'eco', 'CY406', NULL, '1CY406', 1),
('', 'yes', 'eco', 'EY265', NULL, '1EY265', 1),
('', 'yes', 'eco', 'JY398', NULL, '1JY398', 1),
('', 'yes', 'eco', 'YC450', NULL, '1YC450', 1),
('', 'yes', 'eco', 'YJ121', NULL, '1YJ121', 1),
('', 'no', 'eco', 'CY406', NULL, '20CY406', 20),
('', 'no', 'eco', 'EY265', NULL, '20EY265', 20),
('', 'no', 'eco', 'JY398', NULL, '20JY398', 20),
('', 'no', 'eco', 'YC450', NULL, '20YC450', 20),
('', 'no', 'eco', 'YJ121', NULL, '20YJ121', 20),
('', 'no', 'eco', 'CY406', NULL, '21CY406', 21),
('', 'no', 'eco', 'EY265', NULL, '21EY265', 21),
('', 'no', 'eco', 'JY398', NULL, '21JY398', 21),
('', 'no', 'eco', 'YC450', NULL, '21YC450', 21),
('', 'no', 'eco', 'YJ121', NULL, '21YJ121', 21),
('', 'no', 'eco', 'CY406', NULL, '22CY406', 22),
('', 'no', 'eco', 'EY265', NULL, '22EY265', 22),
('', 'no', 'eco', 'JY398', NULL, '22JY398', 22),
('', 'no', 'eco', 'YC450', NULL, '22YC450', 22),
('', 'no', 'eco', 'YJ121', NULL, '22YJ121', 22),
('', 'no', 'eco', 'CY406', NULL, '23CY406', 23),
('', 'no', 'eco', 'EY265', NULL, '23EY265', 23),
('', 'no', 'eco', 'JY398', NULL, '23JY398', 23),
('', 'no', 'eco', 'YC450', NULL, '23YC450', 23),
('', 'no', 'eco', 'YJ121', NULL, '23YJ121', 23),
('', 'no', 'eco', 'CY406', NULL, '24CY406', 24),
('', 'no', 'eco', 'EY265', NULL, '24EY265', 24),
('', 'no', 'eco', 'JY398', NULL, '24JY398', 24),
('', 'no', 'eco', 'YC450', NULL, '24YC450', 24),
('', 'no', 'eco', 'YJ121', NULL, '24YJ121', 24),
('', 'no', 'eco', 'CY406', NULL, '25CY406', 25),
('', 'no', 'eco', 'EY265', NULL, '25EY265', 25),
('', 'no', 'eco', 'JY398', NULL, '25JY398', 25),
('', 'no', 'eco', 'YC450', NULL, '25YC450', 25),
('', 'no', 'eco', 'YJ121', NULL, '25YJ121', 25),
('', 'no', 'eco', 'CY406', NULL, '26CY406', 26),
('', 'no', 'eco', 'EY265', NULL, '26EY265', 26),
('', 'no', 'eco', 'JY398', NULL, '26JY398', 26),
('', 'no', 'eco', 'YC450', NULL, '26YC450', 26),
('', 'no', 'eco', 'YJ121', NULL, '26YJ121', 26),
('', 'no', 'eco', 'CY406', NULL, '27CY406', 27),
('', 'no', 'eco', 'EY265', NULL, '27EY265', 27),
('', 'no', 'eco', 'JY398', NULL, '27JY398', 27),
('', 'no', 'eco', 'YC450', NULL, '27YC450', 27),
('', 'no', 'eco', 'YJ121', NULL, '27YJ121', 27),
('', 'no', 'eco', 'CY406', NULL, '28CY406', 28),
('', 'no', 'eco', 'EY265', NULL, '28EY265', 28),
('', 'no', 'eco', 'JY398', NULL, '28JY398', 28),
('', 'no', 'eco', 'YC450', NULL, '28YC450', 28),
('', 'no', 'eco', 'YJ121', NULL, '28YJ121', 28),
('', 'no', 'eco', 'CY406', NULL, '29CY406', 29),
('', 'no', 'eco', 'EY265', NULL, '29EY265', 29),
('', 'no', 'eco', 'JY398', NULL, '29JY398', 29),
('', 'no', 'eco', 'YC450', NULL, '29YC450', 29),
('', 'no', 'eco', 'YJ121', NULL, '29YJ121', 29),
('', 'yes', 'eco', 'CY406', NULL, '2CY406', 2),
('', 'yes', 'eco', 'EY265', NULL, '2EY265', 2),
('', 'yes', 'eco', 'JY398', NULL, '2JY398', 2),
('', 'yes', 'eco', 'YC450', NULL, '2YC450', 2),
('', 'yes', 'eco', 'YJ121', NULL, '2YJ121', 2),
('', 'no', 'eco', 'CY406', NULL, '30CY406', 30),
('', 'no', 'eco', 'EY265', NULL, '30EY265', 30),
('', 'no', 'eco', 'JY398', NULL, '30JY398', 30),
('', 'no', 'eco', 'YC450', NULL, '30YC450', 30),
('', 'no', 'eco', 'YJ121', NULL, '30YJ121', 30),
('', 'no', 'eco', 'CY406', NULL, '31CY406', 31),
('', 'no', 'eco', 'EY265', NULL, '31EY265', 31),
('', 'no', 'eco', 'JY398', NULL, '31JY398', 31),
('', 'no', 'eco', 'YC450', NULL, '31YC450', 31),
('', 'no', 'eco', 'YJ121', NULL, '31YJ121', 31),
('', 'no', 'eco', 'CY406', NULL, '32CY406', 32),
('', 'no', 'eco', 'EY265', NULL, '32EY265', 32),
('', 'no', 'eco', 'JY398', NULL, '32JY398', 32),
('', 'no', 'eco', 'YC450', NULL, '32YC450', 32),
('', 'no', 'eco', 'YJ121', NULL, '32YJ121', 32),
('', 'no', 'eco', 'CY406', NULL, '33CY406', 33),
('', 'no', 'eco', 'EY265', NULL, '33EY265', 33),
('', 'no', 'eco', 'JY398', NULL, '33JY398', 33),
('', 'no', 'eco', 'YC450', NULL, '33YC450', 33),
('', 'no', 'eco', 'YJ121', NULL, '33YJ121', 33),
('', 'no', 'eco', 'CY406', NULL, '34CY406', 34),
('', 'no', 'eco', 'EY265', NULL, '34EY265', 34),
('', 'no', 'eco', 'JY398', NULL, '34JY398', 34),
('', 'no', 'eco', 'YC450', NULL, '34YC450', 34),
('', 'no', 'eco', 'YJ121', NULL, '34YJ121', 34),
('', 'no', 'eco', 'CY406', NULL, '35CY406', 35),
('', 'no', 'eco', 'EY265', NULL, '35EY265', 35),
('', 'no', 'eco', 'JY398', NULL, '35JY398', 35),
('', 'no', 'eco', 'YC450', NULL, '35YC450', 35),
('', 'no', 'eco', 'YJ121', NULL, '35YJ121', 35),
('', 'no', 'eco', 'CY406', NULL, '36CY406', 36),
('', 'no', 'eco', 'EY265', NULL, '36EY265', 36),
('', 'no', 'eco', 'JY398', NULL, '36JY398', 36),
('', 'no', 'eco', 'YC450', NULL, '36YC450', 36),
('', 'no', 'eco', 'YJ121', NULL, '36YJ121', 36),
('', 'no', 'eco', 'CY406', NULL, '37CY406', 37),
('', 'no', 'eco', 'EY265', NULL, '37EY265', 37),
('', 'no', 'eco', 'JY398', NULL, '37JY398', 37),
('', 'no', 'eco', 'YC450', NULL, '37YC450', 37),
('', 'no', 'eco', 'YJ121', NULL, '37YJ121', 37),
('', 'no', 'eco', 'CY406', NULL, '38CY406', 38),
('', 'no', 'eco', 'EY265', NULL, '38EY265', 38),
('', 'no', 'eco', 'JY398', NULL, '38JY398', 38),
('', 'no', 'eco', 'YC450', NULL, '38YC450', 38),
('', 'no', 'eco', 'YJ121', NULL, '38YJ121', 38),
('', 'no', 'eco', 'CY406', NULL, '39CY406', 39),
('', 'no', 'eco', 'EY265', NULL, '39EY265', 39),
('', 'no', 'eco', 'JY398', NULL, '39JY398', 39),
('', 'no', 'eco', 'YC450', NULL, '39YC450', 39),
('', 'no', 'eco', 'YJ121', NULL, '39YJ121', 39),
('', 'yes', 'eco', 'CY406', NULL, '3CY406', 3),
('', 'yes', 'eco', 'EY265', NULL, '3EY265', 3),
('', 'yes', 'eco', 'JY398', NULL, '3JY398', 3),
('', 'yes', 'eco', 'YC450', NULL, '3YC450', 3),
('', 'yes', 'eco', 'YJ121', NULL, '3YJ121', 3),
('', 'no', 'eco', 'CY406', NULL, '40CY406', 40),
('', 'no', 'eco', 'EY265', NULL, '40EY265', 40),
('', 'no', 'eco', 'JY398', NULL, '40JY398', 40),
('', 'no', 'eco', 'YC450', NULL, '40YC450', 40),
('', 'no', 'eco', 'YJ121', NULL, '40YJ121', 40),
('', 'no', 'eco', 'CY406', NULL, '41CY406', 41),
('', 'no', 'buss', 'EY265', NULL, '41EY265', 41),
('', 'no', 'eco', 'JY398', NULL, '41JY398', 41),
('', 'no', 'buss', 'YC450', NULL, '41YC450', 41),
('', 'no', 'eco', 'YJ121', NULL, '41YJ121', 41),
('', 'no', 'eco', 'CY406', NULL, '42CY406', 42),
('', 'no', 'buss', 'EY265', NULL, '42EY265', 42),
('', 'no', 'eco', 'JY398', NULL, '42JY398', 42),
('', 'no', 'buss', 'YC450', NULL, '42YC450', 42),
('', 'no', 'eco', 'YJ121', NULL, '42YJ121', 42),
('', 'no', 'eco', 'CY406', NULL, '43CY406', 43),
('', 'no', 'buss', 'EY265', NULL, '43EY265', 43),
('', 'no', 'buss', 'JY398', NULL, '43JY398', 43),
('', 'no', 'buss', 'YC450', NULL, '43YC450', 43),
('', 'no', 'eco', 'YJ121', NULL, '43YJ121', 43),
('', 'no', 'eco', 'CY406', NULL, '44CY406', 44),
('', 'no', 'buss', 'EY265', NULL, '44EY265', 44),
('', 'no', 'buss', 'JY398', NULL, '44JY398', 44),
('', 'no', 'buss', 'YC450', NULL, '44YC450', 44),
('', 'no', 'eco', 'YJ121', NULL, '44YJ121', 44),
('', 'no', 'eco', 'CY406', NULL, '45CY406', 45),
('', 'no', 'buss', 'EY265', NULL, '45EY265', 45),
('', 'no', 'buss', 'JY398', NULL, '45JY398', 45),
('', 'no', 'buss', 'YC450', NULL, '45YC450', 45),
('', 'no', 'eco', 'YJ121', NULL, '45YJ121', 45),
('', 'no', 'eco', 'CY406', NULL, '46CY406', 46),
('', 'no', 'buss', 'EY265', NULL, '46EY265', 46),
('', 'no', 'buss', 'JY398', NULL, '46JY398', 46),
('', 'no', 'buss', 'YC450', NULL, '46YC450', 46),
('', 'no', 'eco', 'YJ121', NULL, '46YJ121', 46),
('', 'no', 'eco', 'CY406', NULL, '47CY406', 47),
('', 'no', 'buss', 'EY265', NULL, '47EY265', 47),
('', 'no', 'buss', 'JY398', NULL, '47JY398', 47),
('', 'no', 'buss', 'YC450', NULL, '47YC450', 47),
('', 'no', 'eco', 'YJ121', NULL, '47YJ121', 47),
('', 'no', 'eco', 'CY406', NULL, '48CY406', 48),
('', 'no', 'buss', 'EY265', NULL, '48EY265', 48),
('', 'no', 'buss', 'JY398', NULL, '48JY398', 48),
('', 'no', 'buss', 'YC450', NULL, '48YC450', 48),
('', 'no', 'eco', 'YJ121', NULL, '48YJ121', 48),
('', 'no', 'eco', 'CY406', NULL, '49CY406', 49),
('', 'no', 'buss', 'EY265', NULL, '49EY265', 49),
('', 'no', 'buss', 'JY398', NULL, '49JY398', 49),
('', 'no', 'buss', 'YC450', NULL, '49YC450', 49),
('', 'no', 'eco', 'YJ121', NULL, '49YJ121', 49),
('', 'no', 'eco', 'CY406', NULL, '4CY406', 4),
('', 'yes', 'eco', 'EY265', NULL, '4EY265', 4),
('', 'yes', 'eco', 'JY398', NULL, '4JY398', 4),
('', 'yes', 'eco', 'YC450', NULL, '4YC450', 4),
('', 'yes', 'eco', 'YJ121', NULL, '4YJ121', 4),
('', 'no', 'eco', 'CY406', NULL, '50CY406', 50),
('', 'no', 'buss', 'EY265', NULL, '50EY265', 50),
('', 'no', 'buss', 'JY398', NULL, '50JY398', 50),
('', 'no', 'buss', 'YC450', NULL, '50YC450', 50),
('', 'no', 'eco', 'YJ121', NULL, '50YJ121', 50),
('', 'no', 'eco', 'CY406', NULL, '51CY406', 51),
('', 'no', 'buss', 'EY265', NULL, '51EY265', 51),
('', 'no', 'buss', 'JY398', NULL, '51JY398', 51),
('', 'no', 'buss', 'YC450', NULL, '51YC450', 51),
('', 'no', 'eco', 'YJ121', NULL, '51YJ121', 51),
('', 'no', 'eco', 'CY406', NULL, '52CY406', 52),
('', 'no', 'buss', 'EY265', NULL, '52EY265', 52),
('', 'no', 'buss', 'JY398', NULL, '52JY398', 52),
('', 'no', 'buss', 'YC450', NULL, '52YC450', 52),
('', 'no', 'eco', 'YJ121', NULL, '52YJ121', 52),
('', 'no', 'eco', 'CY406', NULL, '53CY406', 53),
('', 'no', 'buss', 'EY265', NULL, '53EY265', 53),
('', 'no', 'buss', 'JY398', NULL, '53JY398', 53),
('', 'no', 'buss', 'YC450', NULL, '53YC450', 53),
('', 'no', 'eco', 'YJ121', NULL, '53YJ121', 53),
('', 'no', 'eco', 'CY406', NULL, '54CY406', 54),
('', 'no', 'buss', 'EY265', NULL, '54EY265', 54),
('', 'no', 'buss', 'JY398', NULL, '54JY398', 54),
('', 'no', 'buss', 'YC450', NULL, '54YC450', 54),
('', 'no', 'eco', 'YJ121', NULL, '54YJ121', 54),
('', 'no', 'eco', 'CY406', NULL, '55CY406', 55),
('', 'no', 'buss', 'EY265', NULL, '55EY265', 55),
('', 'no', 'buss', 'JY398', NULL, '55JY398', 55),
('', 'no', 'buss', 'YC450', NULL, '55YC450', 55),
('', 'no', 'eco', 'YJ121', NULL, '55YJ121', 55),
('', 'no', 'eco', 'CY406', NULL, '56CY406', 56),
('', 'no', 'buss', 'EY265', NULL, '56EY265', 56),
('', 'no', 'buss', 'JY398', NULL, '56JY398', 56),
('', 'no', 'buss', 'YC450', NULL, '56YC450', 56),
('b', 'no', 'buss', 'YJ121', 612695, '56YJ121', 56),
('', 'no', 'eco', 'CY406', NULL, '57CY406', 57),
('', 'no', 'buss', 'EY265', NULL, '57EY265', 57),
('', 'no', 'buss', 'JY398', NULL, '57JY398', 57),
('', 'no', 'buss', 'YC450', NULL, '57YC450', 57),
('a', 'no', 'buss', 'YJ121', 612733, '57YJ121', 57),
('', 'no', 'eco', 'CY406', NULL, '58CY406', 58),
('', 'no', 'buss', 'EY265', NULL, '58EY265', 58),
('', 'no', 'buss', 'YC450', NULL, '58YC450', 58),
('', 'no', 'buss', 'YJ121', NULL, '58YJ121', 58),
('', 'no', 'eco', 'CY406', NULL, '59CY406', 59),
('', 'no', 'buss', 'EY265', NULL, '59EY265', 59),
('', 'no', 'buss', 'YC450', NULL, '59YC450', 59),
('', 'no', 'buss', 'YJ121', NULL, '59YJ121', 59),
('', 'no', 'eco', 'CY406', NULL, '5CY406', 5),
('', 'yes', 'eco', 'EY265', NULL, '5EY265', 5),
('', 'yes', 'eco', 'JY398', NULL, '5JY398', 5),
('', 'yes', 'eco', 'YC450', NULL, '5YC450', 5),
('', 'yes', 'eco', 'YJ121', NULL, '5YJ121', 5),
('', 'no', 'eco', 'CY406', NULL, '60CY406', 60),
('', 'no', 'buss', 'EY265', NULL, '60EY265', 60),
('', 'no', 'buss', 'YC450', NULL, '60YC450', 60),
('', 'no', 'buss', 'YJ121', NULL, '60YJ121', 60),
('', 'no', 'eco', 'CY406', NULL, '61CY406', 61),
('', 'no', 'buss', 'YJ121', NULL, '61YJ121', 61),
('', 'no', 'eco', 'CY406', NULL, '62CY406', 62),
('', 'no', 'buss', 'YJ121', NULL, '62YJ121', 62),
('', 'no', 'eco', 'CY406', NULL, '63CY406', 63),
('', 'no', 'buss', 'YJ121', NULL, '63YJ121', 63),
('', 'no', 'eco', 'CY406', NULL, '64CY406', 64),
('', 'no', 'buss', 'YJ121', NULL, '64YJ121', 64),
('', 'no', 'eco', 'CY406', NULL, '65CY406', 65),
('', 'no', 'buss', 'YJ121', NULL, '65YJ121', 65),
('', 'no', 'eco', 'CY406', NULL, '66CY406', 66),
('', 'no', 'buss', 'YJ121', NULL, '66YJ121', 66),
('', 'no', 'eco', 'CY406', NULL, '67CY406', 67),
('', 'no', 'buss', 'YJ121', NULL, '67YJ121', 67),
('', 'no', 'eco', 'CY406', NULL, '68CY406', 68),
('', 'no', 'buss', 'YJ121', NULL, '68YJ121', 68),
('', 'no', 'eco', 'CY406', NULL, '69CY406', 69),
('', 'no', 'buss', 'YJ121', NULL, '69YJ121', 69),
('', 'no', 'eco', 'CY406', NULL, '6CY406', 6),
('', 'yes', 'eco', 'EY265', NULL, '6EY265', 6),
('', 'no', 'eco', 'JY398', NULL, '6JY398', 6),
('', 'yes', 'eco', 'YC450', NULL, '6YC450', 6),
('', 'yes', 'eco', 'YJ121', NULL, '6YJ121', 6),
('', 'no', 'eco', 'CY406', NULL, '70CY406', 70),
('', 'no', 'buss', 'YJ121', NULL, '70YJ121', 70),
('', 'no', 'eco', 'CY406', NULL, '71CY406', 71),
('', 'no', 'buss', 'YJ121', NULL, '71YJ121', 71),
('', 'no', 'eco', 'CY406', NULL, '72CY406', 72),
('', 'no', 'buss', 'YJ121', NULL, '72YJ121', 72),
('', 'no', 'eco', 'CY406', NULL, '73CY406', 73),
('', 'no', 'buss', 'YJ121', NULL, '73YJ121', 73),
('', 'no', 'eco', 'CY406', NULL, '74CY406', 74),
('', 'no', 'buss', 'YJ121', NULL, '74YJ121', 74),
('', 'no', 'eco', 'CY406', NULL, '75CY406', 75),
('', 'no', 'buss', 'YJ121', NULL, '75YJ121', 75),
('', 'no', 'eco', 'CY406', NULL, '76CY406', 76),
('', 'no', 'eco', 'CY406', NULL, '77CY406', 77),
('', 'no', 'eco', 'CY406', NULL, '78CY406', 78),
('', 'no', 'eco', 'CY406', NULL, '79CY406', 79),
('', 'no', 'eco', 'CY406', NULL, '7CY406', 7),
('', 'yes', 'eco', 'EY265', NULL, '7EY265', 7),
('', 'no', 'eco', 'JY398', NULL, '7JY398', 7),
('', 'yes', 'eco', 'YC450', NULL, '7YC450', 7),
('', 'yes', 'eco', 'YJ121', NULL, '7YJ121', 7),
('', 'no', 'eco', 'CY406', NULL, '80CY406', 80),
('', 'no', 'buss', 'CY406', NULL, '81CY406', 81),
('', 'no', 'eco', 'CY406', NULL, '8CY406', 8),
('', 'yes', 'eco', 'EY265', NULL, '8EY265', 8),
('', 'no', 'eco', 'JY398', NULL, '8JY398', 8),
('', 'yes', 'eco', 'YC450', NULL, '8YC450', 8),
('', 'yes', 'eco', 'YJ121', NULL, '8YJ121', 8),
('', 'no', 'eco', 'CY406', NULL, '9CY406', 9),
('', 'yes', 'eco', 'EY265', NULL, '9EY265', 9),
('', 'no', 'eco', 'JY398', NULL, '9JY398', 9),
('', 'yes', 'eco', 'YC450', NULL, '9YC450', 9),
('', 'yes', 'eco', 'YJ121', NULL, '9YJ121', 9);

-- --------------------------------------------------------

--
-- Table structure for table `trclass`
--

CREATE TABLE `trclass` (
  `classid` varchar(20) NOT NULL,
  `total` int(11) NOT NULL,
  `booked` int(11) DEFAULT NULL,
  `FLIGHT_FLIGHTID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trclass`
--

INSERT INTO `trclass` (`classid`, `total`, `booked`, `FLIGHT_FLIGHTID`) VALUES
('buss', 1, 1, 'CY406'),
('buss', 20, 0, 'EY265'),
('buss', 15, 0, 'JY398'),
('buss', 20, 0, 'YC450'),
('buss', 20, 2, 'YJ121'),
('eco', 80, 0, 'CY406'),
('eco', 40, 0, 'EY265'),
('eco', 42, 0, 'JY398'),
('eco', 40, 1, 'YC450'),
('eco', 55, 0, 'YJ121');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`AIRPORT-CODE`),
  ADD KEY `airport_country_fk` (`country_countryname`);

--
-- Indexes for table `airportmanagement`
--
ALTER TABLE `airportmanagement`
  ADD PRIMARY KEY (`AIRPORT_AIRPORT-CODE`,`FLIGHT_FLIGHT-ID`),
  ADD KEY `AIRPORT-MANAGMENT_FLIGHT_FK` (`FLIGHT_FLIGHT-ID`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`bookid`),
  ADD UNIQUE KEY `booking__idxv1` (`SEAT_SEAT-ID`),
  ADD KEY `booking_customer_fk` (`customer_documentid`),
  ADD KEY `booking_flight_fk` (`FLIGHT_FLIGHT-ID`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`countryname`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`documentid`),
  ADD KEY `customer_homeaddress_fk` (`HOMEADDRESS_STREET-ADDRESS`,`HOMEADDRESS_AREA-CODE`,`homeaddress_countryname`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`FLIGHTID`);

--
-- Indexes for table `homeaddress`
--
ALTER TABLE `homeaddress`
  ADD PRIMARY KEY (`STREET-ADDRESS`,`AREA-CODE`,`country_countryname`),
  ADD KEY `homeaddress_country_fk` (`country_countryname`);

--
-- Indexes for table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`seat_flPK`),
  ADD UNIQUE KEY `seat__idx` (`booking_bookid`),
  ADD KEY `SEAT_TRAVEL-CLASS_FK` (`TRAVEL-CLASS_CLASSID`,`TRAVEL-CLASS_FLIGHT_FLIGHT-ID`);

--
-- Indexes for table `trclass`
--
ALTER TABLE `trclass`
  ADD PRIMARY KEY (`classid`,`FLIGHT_FLIGHTID`),
  ADD KEY `TRAVEL-CLASS_FLIGHT_FK` (`FLIGHT_FLIGHTID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `airport`
--
ALTER TABLE `airport`
  ADD CONSTRAINT `airport_country_fk` FOREIGN KEY (`country_countryname`) REFERENCES `country` (`countryname`);

--
-- Constraints for table `airportmanagement`
--
ALTER TABLE `airportmanagement`
  ADD CONSTRAINT `AIRPORT-MANAGMENT_AIRPORT_FK` FOREIGN KEY (`AIRPORT_AIRPORT-CODE`) REFERENCES `airport` (`AIRPORT-CODE`),
  ADD CONSTRAINT `AIRPORT-MANAGMENT_FLIGHT_FK` FOREIGN KEY (`FLIGHT_FLIGHT-ID`) REFERENCES `flight` (`FLIGHTID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
