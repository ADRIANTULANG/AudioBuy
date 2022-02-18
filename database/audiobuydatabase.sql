-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2022 at 03:16 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `audiobuydatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customers`
--

CREATE TABLE `tbl_customers` (
  `userid` int(11) NOT NULL,
  `user` varchar(100) NOT NULL,
  `pass` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `contactno` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `usertype` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_customers`
--

INSERT INTO `tbl_customers` (`userid`, `user`, `pass`, `name`, `contactno`, `image`, `address`, `usertype`) VALUES
(16, 'Myshel', 'Admin', '$Myshel Gaid Bonita', '09669362180', 'Screenshot_2022-01-10-13-21-01-72.jpg', 'Bukidnon', 'customer'),
(17, 'newuser', 'asd', '$marian', '09886752977', 'no-image.jpg', 'tanglub', 'customer'),
(18, 'newusernew', 'asd', '$marian', '09886752977', 'no-image.jpg', 'tanglub', 'customer'),
(19, 'Graphics', '123', 'Graphics Store', '09786271122', 'storenew.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(20, 'servicesprovider', '123', 'Electrico Lights Services Incorporation.', '09667872355', 'images (7).jpeg', 'Tangkub Libertad Misamis Oriental  ', 'provider'),
(21, 'customer', '1234', 'Adrian Benedict S. Tulangs', '09669362180', 'Screenshot_2022-01-14-19-33-01-63.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'customer'),
(22, 'strz', '123', 'STRZ Electronics', '09786777562', 'samplestore.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(23, 'Bele', '123', 'Belamide Music and Piano Supply', '09786777562', 'storeimage.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(24, 'Stereo', '123', 'Stereo Profile', '09786777562', 'samplestore.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(25, 'jvs', '123', 'JVS Audio System', '09786777562', 'storeimage.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(26, 'jb', '123', 'JB Music', '09786777562', 'storeimage.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(27, 'solid', '123', 'Solidmark Inc.', '09786777562', 'storenew.jpg', 'Lapasan,Cagayan De Oro City, Misamis Oriental', 'store'),
(28, 'yamaha', '123', 'YAMAHA Music Store', '09786777562', 'images (7).jpeg', 'Lapasan Misamis Oriental,Cagayan De Oro City, Misamis Oriental', 'store'),
(29, 'power', '123', 'Powered Audio Lights Sound and Effects Rental', '09668362190', 'storeimage.jpg', 'Cugma Cagayan de Oro city', 'provider'),
(30, 'electro', '123', 'Electro Lights and Sound Rentals', '09668362190', 'storenew.jpg', 'Cugma Cagayan de Oro city', 'provider'),
(31, 'Cone', '123', 'C-One Lights & Audio Rentals', '09668362190', 'samplestore.jpg', 'Cugma Cagayan de Oro city', 'provider'),
(32, 'Blaster', '123', 'Blaster pro Audio Services', '09668362190', 'storeimage.jpg', 'Lapasan Cagayan De Oro City', 'provider'),
(33, 'Abss', '123', 'Abss Lights and Sounds', '09668362190', 'storenew.jpg', 'Lapasan Cagayan De Oro City', 'provider'),
(34, 'soundstorm', '123', 'SoundStorm Audio and Visual', '09668362190', 'samplestore.jpg', 'Lapasan Cagayan De Oro City', 'provider'),
(35, 'Store Audio', '123', 'Store Audio', '09876752180', 'IMG20220112221924.jpg', 'Cagayan De Oro City Lapasan Mis.Or', 'store'),
(36, 'Canyon', '123', 'Canyon Audio Store', '09886752218', 'images (4).jpeg', 'Cagayan De Oro City Cugman Mis. Or', 'store');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_products`
--

CREATE TABLE `tbl_order_products` (
  `orderproductID` int(11) NOT NULL,
  `ordernumber` varchar(200) NOT NULL,
  `productID` varchar(100) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productPrice` varchar(100) NOT NULL,
  `productDescription` varchar(500) NOT NULL,
  `productStoreID` varchar(100) NOT NULL,
  `productImage` varchar(100) NOT NULL,
  `productQuantity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_order_products`
--

INSERT INTO `tbl_order_products` (`orderproductID`, `ordernumber`, `productID`, `productName`, `productPrice`, `productDescription`, `productStoreID`, `productImage`, `productQuantity`) VALUES
(1, 'TRNSCTN-1643100572-21-2022012509:49-32', '3', 'MARSHALL MG101GFX 100W COMBO AMPLIFIER W/ EFFECTS', '38300', 'Output: 100 Watts\r\n2 channels with 2 overdrive voicings\r\nSpeaker size: 1 x 12\"\r\nEmulated Headphone Output\r\nMP3/Line In\r\nFootswitchable (sold separately)\r\nBuilt-in digital effects including chorus, flanger, phaser and octave\r\nBuilt-in reverb with studio & spring voicings\r\nDedicated delay FX control with 4 types to choose from\r\nStore feature to save your favourite tone presets\r\nClassic black & gold Marshall aesthetic\r\nMarshall script logo\r\n', '28', 'product1.jpg', '3'),
(2, 'TRNSCTN-1643100762-21-2022012509:52-42', '3', 'MARSHALL MG101GFX 100W COMBO AMPLIFIER W/ EFFECTS', '38300', 'Output: 100 Watts\r\n2 channels with 2 overdrive voicings\r\nSpeaker size: 1 x 12\"\r\nEmulated Headphone Output\r\nMP3/Line In\r\nFootswitchable (sold separately)\r\nBuilt-in digital effects including chorus, flanger, phaser and octave\r\nBuilt-in reverb with studio & spring voicings\r\nDedicated delay FX control with 4 types to choose from\r\nStore feature to save your favourite tone presets\r\nClassic black & gold Marshall aesthetic\r\nMarshall script logo\r\n', '28', 'product1.jpg', '3'),
(3, 'TRNSCTN-1643100776-21-2022012509:52-56', '3', 'MARSHALL MG101GFX 100W COMBO AMPLIFIER W/ EFFECTS', '38300', 'Output: 100 Watts\r\n2 channels with 2 overdrive voicings\r\nSpeaker size: 1 x 12\"\r\nEmulated Headphone Output\r\nMP3/Line In\r\nFootswitchable (sold separately)\r\nBuilt-in digital effects including chorus, flanger, phaser and octave\r\nBuilt-in reverb with studio & spring voicings\r\nDedicated delay FX control with 4 types to choose from\r\nStore feature to save your favourite tone presets\r\nClassic black & gold Marshall aesthetic\r\nMarshall script logo\r\n', '28', 'product1.jpg', '3'),
(4, 'TRNSCTN-1643117319-21-2022012514:28-39', '1', 'D&D CANDELARIA ACOUSTIC GUITAR MAHOGANY FISHMAN PRESYS', '15990', 'A modern Pinoy music maker. The D&D Candelaria Acoustic Guitar, designed by Raymund Marasigan, is an outstanding instrument for all kinds of musicians- from bedroom producers to performing artists. With its iconic shape and amazing sounding Fishman Pre-amp, this guitar is ready to sing along with you.', '28', 'product1.jpg', '3'),
(5, 'TRNSCTN-1643117319-21-2022012514:28-39', '2', 'Roland XPS-10 Expandable Synthesizer\n', '29950', 'Pro performance keyboard with a diverse selection of high-quality sounds for live and studio playing\r\nIncludes a wide range of ethnic sounds, plus a User Scale function for creating regional tunings\r\nSample Import function allows users to import and play custom sounds from the keyboard\r\nSix Audio Pads for triggering audio files, loops, and sound effects via USB memory or built-in XPS-10 rhythms\r\n', '28', 'product1.jpg', '3'),
(6, 'TRNSCTN-1643117319-21-2022012514:28-39', '3', 'MARSHALL MG101GFX 100W COMBO AMPLIFIER W/ EFFECTS', '38300', 'Output: 100 Watts\r\n2 channels with 2 overdrive voicings\r\nSpeaker size: 1 x 12\"\r\nEmulated Headphone Output\r\nMP3/Line In\r\nFootswitchable (sold separately)\r\nBuilt-in digital effects including chorus, flanger, phaser and octave\r\nBuilt-in reverb with studio & spring voicings\r\nDedicated delay FX control with 4 types to choose from\r\nStore feature to save your favourite tone presets\r\nClassic black & gold Marshall aesthetic\r\nMarshall script logo\r\n', '28', 'product1.jpg', '4'),
(7, 'TRNSCTN-1643226419-21-2022012620:46-59', '4', 'Roland XPS-10 Expandable Synthesizer\r\n', '29950', 'Pro performance keyboard with a diverse selection of high-quality sounds for live and studio playing\r\nIncludes a wide range of ethnic sounds, plus a User Scale function for creating regional tunings\r\nSample Import function allows users to import and play custom sounds from the keyboard\r\nSix Audio Pads for triggering audio files, loops, and sound effects via USB memory or built-in XPS-10 rhythms\r\n', '28', 'product1.jpg', '7'),
(8, 'TRNSCTN-1644057414-21-2022020511:36-54', '2', 'Roland XPS-10 Expandable Synthesizer\r\n', '29950', 'Pro performance keyboard with a diverse selection of high-quality sounds for live and studio playing\r\nIncludes a wide range of ethnic sounds, plus a User Scale function for creating regional tunings\r\nSample Import function allows users to import and play custom sounds from the keyboard\r\nSix Audio Pads for triggering audio files, loops, and sound effects via USB memory or built-in XPS-10 rhythms\r\n', '28', 'product1.jpg', '2'),
(9, 'TRNSCTN-1644057414-21-2022020511:36-54', '4', 'Roland XPS-10 Expandable Synthesizer\r\n', '29950', 'Pro performance keyboard with a diverse selection of high-quality sounds for live and studio playing\r\nIncludes a wide range of ethnic sounds, plus a User Scale function for creating regional tunings\r\nSample Import function allows users to import and play custom sounds from the keyboard\r\nSix Audio Pads for triggering audio files, loops, and sound effects via USB memory or built-in XPS-10 rhythms\r\n', '28', 'product1.jpg', '2'),
(10, 'TRNSCTN-1645192155-21-2022021814:49-15', '1', 'D&D CANDELARIA ACOUSTIC GUITAR MAHOGANY FISHMAN PRESYS', '15990', 'A modern Pinoy music maker. The D&D Candelaria Acoustic Guitar, designed by Raymund Marasigan, is an outstanding instrument for all kinds of musicians- from bedroom producers to performing artists. With its iconic shape and amazing sounding Fishman Pre-amp, this guitar is ready to sing along with you.', '28', 'product1.jpg', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_services`
--

CREATE TABLE `tbl_order_services` (
  `orderservicesid` int(11) NOT NULL,
  `transactionNo` varchar(100) NOT NULL,
  `servicesID` varchar(100) NOT NULL,
  `serviceName` varchar(100) NOT NULL,
  `servicePrice` varchar(100) NOT NULL,
  `serviceDescription` varchar(500) NOT NULL,
  `serviceStoreID` varchar(100) NOT NULL,
  `serviceImage` varchar(100) NOT NULL,
  `serviceRentalDate_from` varchar(100) NOT NULL,
  `serviceRentalDate_to` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `note` varchar(500) NOT NULL,
  `customerid` varchar(100) NOT NULL,
  `customercontactno` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_order_services`
--

INSERT INTO `tbl_order_services` (`orderservicesid`, `transactionNo`, `servicesID`, `serviceName`, `servicePrice`, `serviceDescription`, `serviceStoreID`, `serviceImage`, `serviceRentalDate_from`, `serviceRentalDate_to`, `status`, `note`, `customerid`, `customercontactno`) VALUES
(1, 'TRNSCTN-1643169449-21-2022012604:57-29', '1', 'Lighting Services', '3000', 'Install all lights in the events like Concerts Birthday party Clubs and more.', '20', 'storenew.jpg', '2022-01-01 00:00:00.000', '2022-01-08 00:00:00.000', 'Paid', 'please contact me for further discussions', '21', '09669362180'),
(2, 'TRNSCTN-1643179509-21-2022012607:45-09', '2', 'Services Lights and Speakers', '2000', 'Install lights and Speakers', '20', 'images (3).jpeg', '2022-01-04 00:00:00.000', '2022-01-11 00:00:00.000', 'Pending', 'Contact after validating', '21', '09669362180'),
(3, 'TRNSCTN-1643204858-21-2022012614:47-38', '5', 'Silver Lights Services Corp.', '2000', 'Concert Lightings Installation.', '20', 'images (8).jpeg', '2022-01-01 00:00:00.000', '2022-01-13 00:00:00.000', 'Paid', 'Plss Contact me.', '21', '09669362180'),
(4, 'TRNSCTN-1645192268-21-2022021814:51-08', '1', 'Lighting Services', '3000', 'Install all lights in the events like Concerts Birthday party Clubs and more.', '20', 'storenew.jpg', '2022-02-01 00:00:00.000', '2022-02-02 00:00:00.000', 'Pending', 'note', '21', '09669362180');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `productID` int(11) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productPrice` varchar(100) NOT NULL,
  `ProductDescription` varchar(500) NOT NULL,
  `productStoreID` varchar(100) NOT NULL,
  `productImage` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`productID`, `productName`, `productPrice`, `ProductDescription`, `productStoreID`, `productImage`) VALUES
(1, 'D&D CANDELARIA ACOUSTIC GUITAR MAHOGANY FISHMAN PRESYS', '15990', 'A modern Pinoy music maker. The D&D Candelaria Acoustic Guitar, designed by Raymund Marasigan, is an outstanding instrument for all kinds of musicians- from bedroom producers to performing artists. With its iconic shape and amazing sounding Fishman Pre-amp, this guitar is ready to sing along with you.', '28', 'product1.jpg'),
(2, 'Roland XPS-10 Expandable Synthesizer\r\n', '29950', 'Pro performance keyboard with a diverse selection of high-quality sounds for live and studio playing\r\nIncludes a wide range of ethnic sounds, plus a User Scale function for creating regional tunings\r\nSample Import function allows users to import and play custom sounds from the keyboard\r\nSix Audio Pads for triggering audio files, loops, and sound effects via USB memory or built-in XPS-10 rhythms\r\n', '28', 'product1.jpg'),
(3, 'MARSHALL MG101GFX 100W COMBO AMPLIFIER W/ EFFECTS', '38300', 'Output: 100 Watts\r\n2 channels with 2 overdrive voicings\r\nSpeaker size: 1 x 12\"\r\nEmulated Headphone Output\r\nMP3/Line In\r\nFootswitchable (sold separately)\r\nBuilt-in digital effects including chorus, flanger, phaser and octave\r\nBuilt-in reverb with studio & spring voicings\r\nDedicated delay FX control with 4 types to choose from\r\nStore feature to save your favourite tone presets\r\nClassic black & gold Marshall aesthetic\r\nMarshall script logo\r\n', '28', 'product1.jpg'),
(4, 'Roland XPS-10 Expandable Synthesizer\r\n', '29950', 'Pro performance keyboard with a diverse selection of high-quality sounds for live and studio playing\r\nIncludes a wide range of ethnic sounds, plus a User Scale function for creating regional tunings\r\nSample Import function allows users to import and play custom sounds from the keyboard\r\nSix Audio Pads for triggering audio files, loops, and sound effects via USB memory or built-in XPS-10 rhythms\r\n', '28', 'product1.jpg'),
(5, 'MARSHALL MG101GFX 100W COMBO AMPLIFIER W/ EFFECTS', '38300', 'Output: 100 Watts\r\n2 channels with 2 overdrive voicings\r\nSpeaker size: 1 x 12\"\r\nEmulated Headphone Output\r\nMP3/Line In\r\nFootswitchable (sold separately)\r\nBuilt-in digital effects including chorus, flanger, phaser and octave\r\nBuilt-in reverb with studio & spring voicings\r\nDedicated delay FX control with 4 types to choose from\r\nStore feature to save your favourite tone presets\r\nClassic black & gold Marshall aesthetic\r\nMarshall script logo\r\n', '28', 'product1.jpg'),
(6, 'Guitar', '200000', 'Metalica Electric Guitar', '28', 'images (3).jpeg'),
(7, 'Piano', '88888', 'Best Piano in the Whole Wide World', '28', 'images (4).jpeg'),
(8, 'Bass Guitar', '89088', 'Best Guitar in the Whole world', '28', 'images (7).jpeg'),
(13, 'Amplifier V2Ss', '20000', 'Best Amplifier in the World.', '28', 'images (3).jpeg'),
(14, 'Super Electric Guitar', '2000202', 'Powered Electrifying Guitar', '28', 'images (6).jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_services`
--

CREATE TABLE `tbl_services` (
  `servicesID` int(11) NOT NULL,
  `serviceName` varchar(100) NOT NULL,
  `servicePrice` varchar(100) NOT NULL,
  `serviceDescription` varchar(500) NOT NULL,
  `serviceStoreID` varchar(100) NOT NULL,
  `serviceImage` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_services`
--

INSERT INTO `tbl_services` (`servicesID`, `serviceName`, `servicePrice`, `serviceDescription`, `serviceStoreID`, `serviceImage`) VALUES
(1, 'Lighting Services', '3000', 'Install all lights in the events like Concerts Birthday party Clubs and more.', '20', 'storenew.jpg'),
(2, 'Services Lights and Speakers', '2000', 'Install lights and Speakers', '20', 'images (3).jpeg'),
(5, 'Silver Lights Services Corp.', '2000', 'Concert Lightings Installation.', '20', 'images (8).jpeg'),
(6, 'Lighter Lights', '3000', 'Classic lights', '20', 'images (7).jpeg'),
(8, 'Lighting wirings', '3000', 'Amazing lightings.', '20', 'images (8).jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_store_products_transaction`
--

CREATE TABLE `tbl_store_products_transaction` (
  `orderid` int(11) NOT NULL,
  `ordernumber` varchar(200) NOT NULL,
  `timeStamp` varchar(100) NOT NULL,
  `customerid` varchar(100) NOT NULL,
  `storeid` varchar(100) NOT NULL,
  `customercontactno` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `seen` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_store_products_transaction`
--

INSERT INTO `tbl_store_products_transaction` (`orderid`, `ordernumber`, `timeStamp`, `customerid`, `storeid`, `customercontactno`, `status`, `seen`) VALUES
(6, 'TRNSCTN-1643100572-21-2022012509:49-32', '2022-01-25 16:49:32.997012', '21', '28', '09786777562', 'Paid', 0),
(7, 'TRNSCTN-1643100762-21-2022012509:52-42', '2022-01-25 16:52:43.071394', '21', '28', '09786777562', 'Cancelled', 1),
(8, 'TRNSCTN-1643100776-21-2022012509:52-56', '2022-01-25 16:52:56.452399', '21', '28', '09786777562', 'Paid', 1),
(9, 'TRNSCTN-1643117319-21-2022012514:28-39', '2022-01-25 21:28:39.770075', '21', '28', '09786777562', 'Paid', 1),
(10, 'TRNSCTN-1643226419-21-2022012620:46-59', '2022-01-27 03:46:58.201483', '21', '28', '09786777562', 'Pending', 0),
(11, 'TRNSCTN-1644057414-21-2022020511:36-54', '2022-02-05 18:36:54.566848', '21', '28', '09669362180', 'Pending', 0),
(12, 'TRNSCTN-1645192155-21-2022021814:49-15', '2022-02-18 21:49:17.401238', '21', '28', '09669362180', 'Pending', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_customers`
--
ALTER TABLE `tbl_customers`
  ADD PRIMARY KEY (`userid`);

--
-- Indexes for table `tbl_order_products`
--
ALTER TABLE `tbl_order_products`
  ADD PRIMARY KEY (`orderproductID`);

--
-- Indexes for table `tbl_order_services`
--
ALTER TABLE `tbl_order_services`
  ADD PRIMARY KEY (`orderservicesid`);

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `tbl_services`
--
ALTER TABLE `tbl_services`
  ADD PRIMARY KEY (`servicesID`);

--
-- Indexes for table `tbl_store_products_transaction`
--
ALTER TABLE `tbl_store_products_transaction`
  ADD PRIMARY KEY (`orderid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_customers`
--
ALTER TABLE `tbl_customers`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `tbl_order_products`
--
ALTER TABLE `tbl_order_products`
  MODIFY `orderproductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_order_services`
--
ALTER TABLE `tbl_order_services`
  MODIFY `orderservicesid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tbl_services`
--
ALTER TABLE `tbl_services`
  MODIFY `servicesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_store_products_transaction`
--
ALTER TABLE `tbl_store_products_transaction`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
