DROP DATABASE IF EXISTS `food_order`;
CREATE DATABASE `food_order`;
USE `food_order`;
SET NAMES utf8;
CREATE TABLE `Account`(
    `username` VARCHAR(50) PRIMARY KEY,
    `password` VARCHAR(50) NOT NULL,
    CONSTRAINT `ct_pass_len` CHECK(LENGTH(`password`) >= 6)
);
CREATE TABLE `Administration` (
    `Admin_id` INTEGER NOT NULL PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL,
    FOREIGN KEY (`username`) REFERENCES `Account` (`username`)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `Customer` (
    `Cus_id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL,
    `FName` VARCHAR(50),
    `MName` VARCHAR(50),
    `LName` VARCHAR(50),
    `BDate` DATE,
    `Email` VARCHAR(200) CHECK(`Email` LIKE "%@%" ),
    `Gender` VARCHAR(7) CHECK(`Gender` in ("Male", "Female", "Other")),
    FOREIGN KEY (`username`) REFERENCES `Account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (`Cus_id`)
) auto_increment = 100;
CREATE TABLE `Customer_phone`(
    `Cus_id` INTEGER NOT NULL,
    `Phone` CHAR(10) NOT NULL UNIQUE CHECK(`Phone` LIKE "0%"),
    PRIMARY KEY (`Cus_id`,`Phone`),
	FOREIGN KEY (`Cus_id`) REFERENCES `Customer` (`Cus_id`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `Co_restaurant`(
    `Res_id` INTEGER NOT NULL PRIMARY KEY auto_increment,
	`username` VARCHAR(50) NOT NULL,
    `Res_name` VARCHAR(255) NOT NULL,
    `Rate` INTEGER CHECK (`Rate` IN (1, 2, 3, 4, 5)),
    FOREIGN KEY (`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) auto_increment = 100;
CREATE TABLE `Co_restaurant_phone`(
    `Res_id` INTEGER NOT NULL,
    `Phone` CHAR(10) NOT NULL UNIQUE CHECK(`Phone` LIKE "0%"),
    FOREIGN KEY (`Res_id`) REFERENCES `Co_restaurant` (`Res_id`) ON DELETE CASCADE ON UPDATE CASCADE,
     PRIMARY KEY (`Res_id`,`Phone`)
);
CREATE TABLE `Co_restaurant_address`(
   `Res_id` INTEGER NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`Res_id`) REFERENCES `Co_restaurant` (`Res_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Res_id`,`Address`)
);
CREATE TABLE `Membership`(
    `Mem_id` INTEGER NOT NULL AUTO_INCREMENT ,
    `Cus_id` INTEGER NOT NULL,
    `Rank` INTEGER CHECK(`Rank` IN (0,1,2,3,4)) default 0, -- 0, 100k 1tr 10tr 100tr   
    `Accumulated_point` INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (`Cus_id`) REFERENCES `Customer` (`Cus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Mem_id`, `Cus_id`)
) AUTO_INCREMENT = 100;
CREATE TABLE `Payment` (
    `Cus_id` INTEGER NOT NULL,
    `Pmt_id` INTEGER NOT NULL,
    `Method` VARCHAR(15) NOT NULL CHECK(`Method` IN ('E-wallet', 'Card', 'Cash')),
    FOREIGN KEY (`Cus_id`) REFERENCES `Customer` (`Cus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Cus_id`, `Pmt_id`)
);
CREATE TABLE `E-wallet` (
	`Cus_id` INTEGER NOT NULL,
    `Pmt_id` INTEGER NOT NULL,
    `E_id` VARCHAR(25) UNIQUE NOT NULL,
    FOREIGN KEY (`Cus_id`,`Pmt_id`) REFERENCES `Payment`(`Cus_id`,`Pmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Cus_id`,`Pmt_id`)
);
CREATE TABLE `Card` (
    `Cus_id` INTEGER NOT NULL,
    `Pmt_id` INTEGER NOT NULL,
    `Bank_name` VARCHAR(50) UNIQUE NOT NULL,
    `Card_number` CHAR(16) NOT NULL,
	FOREIGN KEY (`Cus_id`,`Pmt_id`) REFERENCES `Payment`(`Cus_id`,`Pmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Cus_id`,`Pmt_id`)
);
CREATE TABLE `Food_type` (
    `Name` VARCHAR(255) UNIQUE NOT NULL,
    `Type_ID` INTEGER PRIMARY KEY
);
CREATE TABLE `Food` (
    `Res_id` INTEGER NOT NULL,
    `F_id` INTEGER NOT NULL,
    `Type_ID` INTEGER NOT NULL,
    `Fname` VARCHAR(100) NOT NULL,
    `Unit_price` INTEGER NOT NULL,
    `Description` VARCHAR(255),
    `Status` INTEGER NOT NULL DEFAULT 1,   #0 IS NOT, 1 IS OKE	
    `Size` CHAR(1) NOT NULL CHECK(`Size` IN ('M','L')) DEFAULT 'M',
    FOREIGN KEY (`Type_ID`) REFERENCES `Food_type` (`Type_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Res_id`) REFERENCES `Co_restaurant`(`Res_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Res_id`,`F_id`),
    CONSTRAINT `check_status_food` CHECK(`Status` IN (0,1))
);
CREATE TABLE `Cart` (
    `Cart_id` INTEGER NOT NULL AUTO_INCREMENT,
    `Cus_id` INTEGER NOT NULL,
    `total_food` INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (`Cus_id`) REFERENCES `Customer` (`Cus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(`Cart_id`)
) AUTO_INCREMENT = 100;
CREATE TABLE `Order` (
    `Cart_id` INTEGER NOT NULL,
    `Order_id` INTEGER NOT NULL UNIQUE auto_increment,
    `Cus_id` INTEGER NOT NULL,
    `Pmt_id` INTEGER NOT NULL,
    `Shipper_name` VARCHAR(50) NOT NULL,
    `Shipper_phone` CHAR(10) NOT NULL CHECK(`Shipper_phone` LIKE '0%'),
    `Shipper_lic` CHAR(12) NOT NULL UNIQUE,
    `Note` VARCHAR(255),
    `Delivery_address` VARCHAR(255) NOT NULL,
    `Order_time` DATETIME NOT NULL,
    `Arrival_time` DATETIME NOT NULL,
    `Required_time` DATETIME NOT NULL,
    `Total_price` INTEGER NOT NULL DEFAULT 0,
    `Delivery_cost` INTEGER NOT NULL DEFAULT 0,
    `Need_to_pay` INTEGER NOT NULL DEFAULT 0, -- Gia + ship - Sale
    `Status` INTEGER NOT NULL CHECK(`Status` IN (0,1)),
    
    
	FOREIGN KEY (`Cart_id`) REFERENCES `Cart` (`Cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Cus_id`,`Pmt_id`) REFERENCES `Payment`(`Cus_id`,`Pmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`Cart_id`, `Order_id`)
) auto_increment = 100;

CREATE TABLE `Combo` (
    `Cb_id` INTEGER NOT NULL PRIMARY KEY auto_increment,
    `Res_id` INTEGER NOT NULL,
    `Cb_name` VARCHAR(255) NOT NULL,
    `Description` VARCHAR(255) DEFAULT '',
    `Cost` INTEGER NOT NULL,
    `Status` INTEGER NOT NULL CHECK(`Status` in (0,1)) DEFAULT 1, #0 IS NOT, 1 IS OKE
    FOREIGN KEY (`Res_id`) REFERENCES `Co_restaurant`(`Res_id`) ON DELETE cascade ON UPDATE CASCADE
) auto_increment = 100;

CREATE TABLE `Food_order` (
    `Res_id` INTEGER NOT NULL,
    `F_id` INTEGER NOT NULL,
    `Cart_id` INTEGER NOT NULL,
    `Order_id` INTEGER NOT NULL,
    `Quantity` INTEGER NOT NULL,
    PRIMARY KEY (`Res_id`, `F_id`, `Cart_id`, `Order_id`),
    FOREIGN KEY (`Res_id`, `F_id`) REFERENCES `Food` (`Res_id`,`F_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Cart_id`, `Order_id`) REFERENCES `Order` (`Cart_id` ,`Order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Combo_order` (
    `Cb_id` INTEGER NOT NULL,
    `Cart_id` INTEGER NOT NULL,
    `Order_id` INTEGER NOT NULL,
    `Quantity` INTEGER NOT NULL,
    PRIMARY KEY(`Cb_id`, `Cart_id`, `Order_id`),
    FOREIGN KEY (`Cb_id`) REFERENCES `Combo` (`Cb_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Cart_id`) REFERENCES `Order` (`Cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Order_id`) REFERENCES `Order` (`Order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Food_cart` (
    `Res_id`INTEGER NOT NULL,
    `F_id` INTEGER NOT NULL,
    `Cart_id` INTEGER NOT NULL,
    `Quantity` INTEGER NOT NULL,
    `Quoted_price` INTEGER NOT NULL,
    PRIMARY KEY ( `Res_id`, `F_id`,`Cart_id`),
    FOREIGN KEY (`Cart_id`) REFERENCES `Cart` (`Cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Res_id`, `F_id`) REFERENCES `Food` (`Res_id`, `F_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Combo_cart` (
    `Cb_id` INTEGER NOT NULL,
    `Cart_id` INTEGER NOT NULL,
    `Quantity` INTEGER NOT NULL,
    `Quoted_price` INTEGER NOT NULL,
    PRIMARY KEY ( `Cart_id`, `Cb_id`),
    FOREIGN KEY (`Cart_id`) REFERENCES `Cart` (`Cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Cb_id`) REFERENCES `Combo` (`Cb_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Promotion` (
    `Code` INTEGER PRIMARY KEY,
    `Number` INTEGER NOT NULL DEFAULT 10,
    `max_sale` INTEGER DEFAULT 100000,
    `min_bill` INTEGER DEFAULT 0,
    `Expiration_date` DATE NOT NULL,
    `Start_date` DATE NOT NULL,
    `Res_id` INTEGER NOT NULL,
    `Admin_id` INTEGER NOT NULL,
    FOREIGN KEY (`Admin_id`) REFERENCES `Administration` (`Admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Res_id`) REFERENCES `Co_restaurant` (`Res_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Order_promotion` (
    `Cart_id` INTEGER NOT NULL,
    `Order_id` INTEGER NOT NULL,
    `Code` INTEGER NOT NULL,
    PRIMARY KEY (`Cart_id`,`Order_id`, `Code`),
    FOREIGN KEY (`Cart_id`, `Order_id`) REFERENCES `Order` (`Cart_id`, `Order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Code`) REFERENCES `Promotion` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Coupon` (
    `Code` INTEGER PRIMARY KEY,
    `Percent` INTEGER NOT NULL DEFAULT 20,
    FOREIGN KEY (`Code`) REFERENCES `Promotion` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK(`Percent` > 0 AND `Percent` <= 50)
);

CREATE TABLE `Voucher` (
    `Code` INTEGER PRIMARY KEY,
    `Value` INTEGER NOT NULL DEFAULT 1000,
    FOREIGN KEY (`Code`) REFERENCES `Promotion` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK(`Value` > 1000)
);

DELIMITER //
CREATE TRIGGER `check_disjoin_promotion`
BEFORE INSERT ON `Voucher`
FOR EACH ROW
IF (NEW.`Code` IN (SELECT `Code` FROM `Coupon`))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Voucher can not Coupon';
END IF \\
DELIMITER ;







ALTER TABLE `Customer`
ADD `Age` INT;
