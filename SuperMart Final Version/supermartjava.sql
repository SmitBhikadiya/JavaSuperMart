-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 23, 2021 at 11:08 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `supermartjava`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminuser`
--

CREATE TABLE `adminuser` (
  `adid` int(11) NOT NULL,
  `adname` varchar(100) NOT NULL,
  `ademail` varchar(100) NOT NULL,
  `adcontact` varchar(100) NOT NULL,
  `adtype` varchar(50) NOT NULL,
  `adpassword` varchar(200) NOT NULL,
  `adaddress` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `adminuser`
--

INSERT INTO `adminuser` (`adid`, `adname`, `ademail`, `adcontact`, `adtype`, `adpassword`, `adaddress`) VALUES
(1, 'Smit Bhikadiya', 'sbhikadiya892@rku.ac.in', '7096794625', 'shopkeeper', '123456789', 'tramba village , botad'),
(2, 'Shailesh Lakhani', 'slakhani062@rku.ac.in', '9874564555', 'shopkeeper', '123456789', 'hifali, bhabhan road, botad'),
(3, 'Ankit Chauhan', 'ankit@gmail.com', '9764576556', 'servicer', '123456789', 'Hifali, bhabhan road, botad'),
(4, 'smit patel', 'smit@gmail.com', '4526347232', 'admin', '123456789', '123456789'),
(5, 'Ravi Parmar', 'ravi@rku.ac.in', '8734526478', 'shopkeeper', '123456789', 'bhavnagar road, botad'),
(13, 'Khalid Ansari', 'khalid@rku.ac.in', '1234567890', 'shopkeeper', '123456789', 'mahadev society - 1, paliyad road, botad'),
(18, 'Rahul Kalathiya', 'rahul@gmail.com', '7096794623', 'servicer', '123456789', 'gadhada road, botad');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `ctid` int(11) NOT NULL,
  `category` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`ctid`, `category`) VALUES
(1, 'grocery'),
(3, 'frozen foods'),
(4, 'fruits'),
(5, 'vegetables'),
(6, 'health-beauty'),
(7, 'dairy-bakery'),
(8, 'pet care'),
(10, 'fast food'),
(11, 'home care'),
(12, 'baby care'),
(13, 'home-kitchen'),
(16, 'farsan'),
(17, 'cold drinks');

-- --------------------------------------------------------

--
-- Table structure for table `compare`
--

CREATE TABLE `compare` (
  `cmprid` int(11) NOT NULL,
  `prdid` int(11) NOT NULL,
  `cstmid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `compare`
--

INSERT INTO `compare` (`cmprid`, `prdid`, `cstmid`) VALUES
(3, 11, 1),
(4, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `cstmid` int(11) NOT NULL,
  `cstmname` varchar(200) NOT NULL,
  `cstmemail` varchar(100) NOT NULL,
  `cstmcontact` varchar(50) NOT NULL,
  `cstmaddress` varchar(300) NOT NULL,
  `cstmpassword` varchar(200) NOT NULL,
  `cstmupdatedtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`cstmid`, `cstmname`, `cstmemail`, `cstmcontact`, `cstmaddress`, `cstmpassword`, `cstmupdatedtime`) VALUES
(1, 'smit bhikadiya', 'sbhikadiya892@rku.ac.in', '7096794622', 'tramba village , rajkot', '123456789', '2021-03-31 18:27:47'),
(2, 'rahul kalathiya', 'rahul@gmail.com', '7096794625', 'gadhada road, botad', '123456789', '2021-03-26 16:36:45'),
(4, 'shailesh', 'shailesh@gmail.com', '9874564555', 'hifali, bhabhan road, botad', '123456789', '2021-03-26 16:37:55');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `ordratid` int(11) NOT NULL,
  `ordid` int(11) NOT NULL,
  `overall_rat` int(11) DEFAULT NULL,
  `products_rat` int(11) DEFAULT NULL,
  `delivery_service` varchar(50) DEFAULT NULL,
  `review_msg` varchar(400) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `isTestimonial` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`ordratid`, `ordid`, `overall_rat`, `products_rat`, `delivery_service`, `review_msg`, `timestamp`, `isTestimonial`) VALUES
(1, 2, 5, 5, 'Excellent', 'Delivery service is very fast', '2021-03-29 14:00:45', 1),
(2, 4, 5, 5, 'Good', '', '2021-04-01 05:23:13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orderhistory`
--

CREATE TABLE `orderhistory` (
  `ordhistoryid` int(11) NOT NULL,
  `ordid` int(11) NOT NULL,
  `cstmid` int(11) NOT NULL,
  `strid` int(11) NOT NULL,
  `ordcharge` int(11) NOT NULL,
  `deliveredby` varchar(100) NOT NULL,
  `acceptedtype` varchar(50) NOT NULL,
  `deliveredcontact` varchar(50) NOT NULL,
  `orderedtime` varchar(50) NOT NULL,
  `deliveredtime` varchar(50) NOT NULL,
  `billingname` varchar(100) NOT NULL,
  `billingaddress` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderhistory`
--

INSERT INTO `orderhistory` (`ordhistoryid`, `ordid`, `cstmid`, `strid`, `ordcharge`, `deliveredby`, `acceptedtype`, `deliveredcontact`, `orderedtime`, `deliveredtime`, `billingname`, `billingaddress`) VALUES
(1, 2, 1, 2, 0, 'Shailesh Lakhani', 'Shopkeeper', '9874564555', '2021-03-28 11:13:18', '2021-03-29 19:22:40', 'smit bhikadiya', 'tramba village , rajkot'),
(2, 1, 1, 1, 0, 'Ankit Chauhan', 'Servicer', '9764576556', '2021-03-31 22:53:05', '2021-03-31 23:38:56', 'smit bhikadiya', 'tramba village , rajkot'),
(3, 4, 1, 1, 0, 'Smit Bhikadiya', 'Shopkeeper', '7096794625', '2021-04-01 10:50:05', '2021-04-01 10:52:54', 'smit bhikadiya', 'tramba village , rajkot'),
(4, 5, 1, 1, 5, 'Ankit Chauhan', 'Servicer', '9764576556', '2021-04-01 10:55:48', '2021-04-01 10:57:02', 'smit bhikadiya', 'tramba village , rajkot');

-- --------------------------------------------------------

--
-- Table structure for table `orderhistorylist`
--

CREATE TABLE `orderhistorylist` (
  `ordhistorylistid` int(11) NOT NULL,
  `ordhistoryid` int(11) NOT NULL,
  `prdid` int(11) NOT NULL,
  `prdname` varchar(100) NOT NULL,
  `prdprize` int(11) NOT NULL,
  `prdqty` int(11) NOT NULL,
  `prdtotal` int(11) NOT NULL,
  `prdimgpath` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderhistorylist`
--

INSERT INTO `orderhistorylist` (`ordhistorylistid`, `ordhistoryid`, `prdid`, `prdname`, `prdprize`, `prdqty`, `prdtotal`, `prdimgpath`) VALUES
(1, 1, 5, 'Green Gram', 59, 1, 59, 'assets/img/product/Green Gram_2.png'),
(2, 1, 4, 'Cashew', 500, 4, 2000, 'assets/img/product/Cashew_2.png'),
(3, 2, 2, 'Lemon Juice', 50, 5, 250, 'assets/img/product/Lemon Juice_1.png'),
(4, 2, 6, 'Coca Cola', 65, 6, 390, 'assets/img/product/Coca Cola_1.png'),
(5, 2, 11, 'Thums Up', 65, 4, 260, 'assets/img/product/Thums Up_1.png'),
(6, 3, 11, 'Thums Up', 65, 4, 260, 'assets/img/product/Thums Up_1.png'),
(7, 4, 11, 'Thums Up', 65, 1, 65, 'assets/img/product/Thums Up_1.png');

-- --------------------------------------------------------

--
-- Table structure for table `orderlist`
--

CREATE TABLE `orderlist` (
  `ordlistid` int(11) NOT NULL,
  `ordid` int(11) DEFAULT NULL,
  `prdid` int(11) NOT NULL,
  `prdqty` int(11) NOT NULL,
  `prdtotalamount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderlist`
--

INSERT INTO `orderlist` (`ordlistid`, `ordid`, `prdid`, `prdqty`, `prdtotalamount`) VALUES
(6, 3, 10, 4, 60);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ordid` int(11) NOT NULL,
  `strid` int(11) NOT NULL,
  `cstmid` int(11) NOT NULL,
  `paymentmethod` varchar(50) NOT NULL DEFAULT 'Cash On Delivery',
  `ordtotalbill` int(11) DEFAULT NULL,
  `ordcharge` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`ordid`, `strid`, `cstmid`, `paymentmethod`, `ordtotalbill`, `ordcharge`) VALUES
(3, 3, 1, 'COD', 60, 5);

-- --------------------------------------------------------

--
-- Table structure for table `orderstatus`
--

CREATE TABLE `orderstatus` (
  `ordid` int(11) NOT NULL,
  `ordstatus` int(11) NOT NULL DEFAULT 0,
  `ordarrivalat` varchar(100) DEFAULT NULL,
  `accepttime` varchar(50) DEFAULT NULL,
  `deliverytime` varchar(100) DEFAULT NULL,
  `acceptstatus` varchar(50) DEFAULT NULL,
  `acceptedname` varchar(100) DEFAULT NULL,
  `acceptedcontact` varchar(100) DEFAULT NULL,
  `pin` varchar(30) NOT NULL DEFAULT 'NA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderstatus`
--

INSERT INTO `orderstatus` (`ordid`, `ordstatus`, `ordarrivalat`, `accepttime`, `deliverytime`, `acceptstatus`, `acceptedname`, `acceptedcontact`, `pin`) VALUES
(3, 1, '2021-04-01 09:34:51', NULL, NULL, '0', NULL, NULL, 'NA');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `prdid` int(11) NOT NULL,
  `strid` int(11) DEFAULT NULL,
  `imgpath` varchar(50) DEFAULT NULL,
  `prdname` varchar(200) NOT NULL,
  `prdprize` int(11) NOT NULL,
  `prdunit` varchar(50) NOT NULL,
  `prddiscount` int(11) NOT NULL,
  `prdtotalqty` int(11) NOT NULL,
  `prdcategory` varchar(100) NOT NULL,
  `prddescription` varchar(1000) DEFAULT NULL,
  `prdpurchasedbycstm` int(11) NOT NULL DEFAULT 0,
  `prdupdatedtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`prdid`, `strid`, `imgpath`, `prdname`, `prdprize`, `prdunit`, `prddiscount`, `prdtotalqty`, `prdcategory`, `prddescription`, `prdpurchasedbycstm`, `prdupdatedtime`) VALUES
(1, 1, 'assets/img/product/Red Bull_1.png', 'Red Bull', 100, 'piese', 0, 43, 'cold drinks', '...', 2, '2021-03-26 19:25:58'),
(2, 1, 'assets/img/product/Lemon Juice_1.png', 'Lemon Juice', 50, 'piese', 10, 26, 'cold drinks', 'tasty', 2, '2021-03-31 18:08:56'),
(3, 2, 'assets/img/product/Rice_2.png', 'Rice', 65, 'kg', 20, 78, 'grocery', '..', 0, '2021-03-22 10:15:05'),
(4, 2, 'assets/img/product/Cashew_2.png', 'Cashew', 500, 'kg', 2, 23, 'grocery', '..', 4, '2021-03-29 13:52:40'),
(5, 2, 'assets/img/product/Green Gram_2.png', 'Green Gram', 59, 'kg', 2, 64, 'grocery', '..', 1, '2021-03-29 13:52:40'),
(6, 1, 'assets/img/product/Coca Cola_1.png', 'Coca Cola', 65, 'piese', 0, 12, 'cold drinks', '..', 1, '2021-03-31 18:08:56'),
(7, 3, 'assets/img/product/Nivea Men_3.png', 'Nivea Men', 90, 'piese', 2, 30, 'health-beauty', '..', 0, '2021-03-22 10:39:06'),
(8, 3, 'assets/img/product/Harpic_3.png', 'Harpic', 78, 'piese', 5, 20, 'home care', '..', 0, '2021-03-22 10:40:03'),
(10, 3, 'assets/img/product/Maggi_3.png', 'Maggi', 15, 'piese', 0, 15, 'grocery', '..', 1, '2021-04-01 04:04:57'),
(11, 1, 'assets/img/product/Thums Up_1.png', 'Thums Up', 65, 'piese', 0, 15, 'cold drinks', '****About this item****\r\n1.Taste the thunder with Thums Up\'s stronger carbonation\r\n2.Strong, fizzy, and slightly spicy to suit your desi palate\r\n3.Helps brings out the toofani, adventurous side of you\r\n4.It tingles and adds a spicy twist to meals, snacks and even moments\r\n5.raise the excitement of any occasion to toofani levels with Party pack', 6, '2021-04-01 05:27:02'),
(13, 4, 'assets/img/product/Apple_4.png', 'Apple', 24, 'kg', 0, 34, 'fruits', '..', 0, '2021-03-24 12:30:13');

-- --------------------------------------------------------

--
-- Table structure for table `product_review`
--

CREATE TABLE `product_review` (
  `reviewid` int(11) NOT NULL,
  `cstmid` int(11) NOT NULL,
  `prdid` int(11) NOT NULL,
  `rname` varchar(100) NOT NULL,
  `remail` varchar(100) NOT NULL,
  `rmsg` varchar(300) NOT NULL,
  `rrating` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_review`
--

INSERT INTO `product_review` (`reviewid`, `cstmid`, `prdid`, `rname`, `remail`, `rmsg`, `rrating`, `timestamp`) VALUES
(1, 1, 4, 'Shailesh', 'shailesh@gmail.com', '100% natural product', 5, '2021-03-29 14:01:37'),
(2, 1, 6, 'Smit Bhikadiya', 'sbhikadiya892@rku.ac.in', 'best product', 5, '2021-04-01 05:17:56');

-- --------------------------------------------------------

--
-- Table structure for table `servicer`
--

CREATE TABLE `servicer` (
  `servicerid` int(11) NOT NULL,
  `adid` int(11) NOT NULL,
  `serviserstatus` int(11) NOT NULL DEFAULT 0,
  `remaining` int(11) NOT NULL DEFAULT 0,
  `paid` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `servicer`
--

INSERT INTO `servicer` (`servicerid`, `adid`, `serviserstatus`, `remaining`, `paid`) VALUES
(1, 3, 0, 0, 0),
(5, 18, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `serviceraccept`
--

CREATE TABLE `serviceraccept` (
  `said` int(11) NOT NULL,
  `servicerid` int(11) NOT NULL,
  `ordid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `servicerhistory`
--

CREATE TABLE `servicerhistory` (
  `servicerid` int(11) NOT NULL,
  `ordhistoryid` int(11) NOT NULL,
  `strid` int(11) NOT NULL,
  `payment` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `servicerhistory`
--

INSERT INTO `servicerhistory` (`servicerid`, `ordhistoryid`, `strid`, `payment`) VALUES
(1, 2, 1, 15),
(1, 4, 1, 15);

-- --------------------------------------------------------

--
-- Table structure for table `shopkeepers`
--

CREATE TABLE `shopkeepers` (
  `skid` int(11) NOT NULL,
  `adid` int(11) NOT NULL,
  `strid` int(11) DEFAULT 0,
  `skupdatedtime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shopkeepers`
--

INSERT INTO `shopkeepers` (`skid`, `adid`, `strid`, `skupdatedtime`) VALUES
(1, 1, 1, '2021-03-18 11:15:49'),
(2, 2, 2, '2021-03-18 11:59:34'),
(3, 5, 3, '2021-03-22 10:35:03'),
(6, 13, 4, '2021-03-24 12:02:07');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `strid` int(11) NOT NULL,
  `skid` int(11) DEFAULT NULL,
  `imgpath` varchar(100) DEFAULT NULL,
  `strname` varchar(200) NOT NULL,
  `strcontact` varchar(100) NOT NULL,
  `straddress` varchar(300) NOT NULL,
  `stropentime` varchar(50) NOT NULL,
  `strclosetime` varchar(50) NOT NULL,
  `strhavingserviser` int(11) NOT NULL,
  `strupdatedtime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`strid`, `skid`, `imgpath`, `strname`, `strcontact`, `straddress`, `stropentime`, `strclosetime`, `strhavingserviser`, `strupdatedtime`) VALUES
(1, 1, 'assets/img/storeimg/1skstore.png', 'Sardar Cold Drinks', '9824451325', 'gadhadaroad, botad', '00:00', '23:17', 0, '2021-03-18 11:56:08'),
(2, 2, 'assets/img/storeimg/2skstore.png', 'Mahavir Grocery Store', '7096793524', 'mainroad, gajera circal, botad', '09:35', '23:00', 1, '2021-03-18 12:00:29'),
(3, 3, 'assets/img/storeimg/3skstore.png', 'Ravi Provision Store', '9847538356', 'mahadev society - 1, paliyad road, botad', '13:00', '22:00', 1, '2021-03-22 10:37:33'),
(4, 6, 'assets/img/storeimg/6skstore.png', 'Manohar Provision Store', '8468126537', 'mahadev society - 1, botad', '08:00', '23:00', 0, '2021-03-24 12:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `varifystore`
--

CREATE TABLE `varifystore` (
  `vid` int(11) NOT NULL,
  `strid` int(11) NOT NULL,
  `varified` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `varifystore`
--

INSERT INTO `varifystore` (`vid`, `strid`, `varified`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminuser`
--
ALTER TABLE `adminuser`
  ADD PRIMARY KEY (`adid`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ctid`);

--
-- Indexes for table `compare`
--
ALTER TABLE `compare`
  ADD PRIMARY KEY (`cmprid`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cstmid`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`ordratid`);

--
-- Indexes for table `orderhistory`
--
ALTER TABLE `orderhistory`
  ADD PRIMARY KEY (`ordhistoryid`);

--
-- Indexes for table `orderhistorylist`
--
ALTER TABLE `orderhistorylist`
  ADD PRIMARY KEY (`ordhistorylistid`);

--
-- Indexes for table `orderlist`
--
ALTER TABLE `orderlist`
  ADD PRIMARY KEY (`ordlistid`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ordid`);

--
-- Indexes for table `orderstatus`
--
ALTER TABLE `orderstatus`
  ADD PRIMARY KEY (`ordid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`prdid`);

--
-- Indexes for table `product_review`
--
ALTER TABLE `product_review`
  ADD PRIMARY KEY (`reviewid`);

--
-- Indexes for table `servicer`
--
ALTER TABLE `servicer`
  ADD PRIMARY KEY (`servicerid`);

--
-- Indexes for table `serviceraccept`
--
ALTER TABLE `serviceraccept`
  ADD PRIMARY KEY (`said`);

--
-- Indexes for table `servicerhistory`
--
ALTER TABLE `servicerhistory`
  ADD PRIMARY KEY (`ordhistoryid`);

--
-- Indexes for table `shopkeepers`
--
ALTER TABLE `shopkeepers`
  ADD PRIMARY KEY (`skid`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`strid`);

--
-- Indexes for table `varifystore`
--
ALTER TABLE `varifystore`
  ADD PRIMARY KEY (`vid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminuser`
--
ALTER TABLE `adminuser`
  MODIFY `adid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `ctid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `compare`
--
ALTER TABLE `compare`
  MODIFY `cmprid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `cstmid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `ordratid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orderhistory`
--
ALTER TABLE `orderhistory`
  MODIFY `ordhistoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orderhistorylist`
--
ALTER TABLE `orderhistorylist`
  MODIFY `ordhistorylistid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orderlist`
--
ALTER TABLE `orderlist`
  MODIFY `ordlistid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `ordid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orderstatus`
--
ALTER TABLE `orderstatus`
  MODIFY `ordid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `prdid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `product_review`
--
ALTER TABLE `product_review`
  MODIFY `reviewid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `servicer`
--
ALTER TABLE `servicer`
  MODIFY `servicerid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `serviceraccept`
--
ALTER TABLE `serviceraccept`
  MODIFY `said` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `shopkeepers`
--
ALTER TABLE `shopkeepers`
  MODIFY `skid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `strid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `varifystore`
--
ALTER TABLE `varifystore`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
