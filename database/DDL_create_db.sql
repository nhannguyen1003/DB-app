DROP DATABASE IF EXISTS `food_order`;
CREATE DATABASE `food_order`;
USE `food_order`;

SET NAMES utf8;



CREATE TABLE `Account`(
    `username` VARCHAR(50) PRIMARY KEY ,
    `password` VARCHAR(50) NOT NULL,
    CONSTRAINT `ct_pass_len` CHECK(LENGTH(`password`) >= 6)
);




CREATE TABLE `Customer` (
    `FName` VARCHAR(50),
    `MName` VARCHAR(50),
    `LName` VARCHAR(50),
    `BDate` DATE,
    `Email` VARCHAR(200) CHECK(`Email` LIKE "%@%" ),
    `username` VARCHAR(50) NOT NULL,
    `Gender` VARCHAR(7) CHECK(`Gender` in ("Male", "Female", "Other")),
    FOREIGN KEY (`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (`username`)
);



CREATE TABLE `Customer_phone`(
    `username` VARCHAR(50) NOT NULL,
    `Phone` CHAR(10) NOT NULL UNIQUE CHECK(`Phone` LIKE "0%"),
    PRIMARY KEY (`username`,`Phone`),
	FOREIGN KEY (`username`) REFERENCES `Customer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Co_restaurant`(
    `Res_name` VARCHAR(255) NOT NULL,
    `Rate` INTEGER CHECK (`Rate` IN (1, 2, 3, 4, 5)),
    `username` VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Co_restaurant_phone`(
    `username` VARCHAR(50) NOT NULL,
    `Phone` CHAR(10) NOT NULL UNIQUE CHECK(`Phone` LIKE "0%"),
    FOREIGN KEY (`username`) REFERENCES `Co_restaurant` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`username`,`Phone`)
);

CREATE TABLE `Co_restaurant_address`(
    `username` VARCHAR(50) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`username`) REFERENCES `Co_restaurant` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`username`,`Address`)
);


CREATE TABLE `Membership`(
    `username` VARCHAR(50) NOT NULL,
    `Rank` INTEGER CHECK(`Rank` IN (0,1,2,3,4)) default 0, -- 0, 100k 1tr 10tr 100tr   
    `Accumulated_point` INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (`username`),
    FOREIGN KEY (`username`) REFERENCES `Customer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
);




CREATE TABLE `Payment` (
    `username` VARCHAR(50) NOT NULL,
    `Pmt_id` VARCHAR(25) NOT NULL,
    `Method` VARCHAR(15) NOT NULL CHECK(`Method` IN ('E-wallet', 'Card', 'Cash')),
    FOREIGN KEY (`username`) REFERENCES `Customer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`username`, `Pmt_id`)
);


CREATE TABLE `E-wallet` (
    `username` VARCHAR(50) NOT NULL,
    `Pmt_id` VARCHAR(25) NOT NULL,
    `E_id` VARCHAR(25) UNIQUE NOT NULL,
    FOREIGN KEY (`username`,`Pmt_id`) REFERENCES `Payment`(`username`,`Pmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`username`,`Pmt_id`)
);

CREATE TABLE `Card` (
    `username` VARCHAR(50) NOT NULL,
    `Pmt_id` VARCHAR(25) NOT NULL,
    `Bank_name` VARCHAR(50) UNIQUE NOT NULL,
    `Card_number` CHAR(16) NOT NULL,
	FOREIGN KEY (`username`,`Pmt_id`) REFERENCES `Payment`(`username`,`Pmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`username`,`Pmt_id`)
);

CREATE TABLE `Food_type` (
    `Name` VARCHAR(255) UNIQUE NOT NULL,
    `Type_ID` INTEGER PRIMARY KEY
);

CREATE TABLE `Food` (
    `username` VARCHAR(50) NOT NULL,
    `F_id` INTEGER UNIQUE NOT NULL,
    `Type_ID` INTEGER NOT NULL,
    `Unit_price` INTEGER NOT NULL,
    `Description` VARCHAR(255),
    `Status` INTEGER NOT NULL DEFAULT 1,   #0 IS NOT, 1 IS OKE
	
    `Size` CHAR(1) NOT NULL CHECK(`Size` IN ('M','L')) DEFAULT 'M',
    FOREIGN KEY (`Type_ID`) REFERENCES `Food_type` (`Type_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`username`) REFERENCES `Co_restaurant`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`username`,`F_id`),
    CONSTRAINT `check_status_food` CHECK(`Status` IN (0,1))
);

CREATE TABLE `Cart` (
    `username` VARCHAR(50) NOT NULL,
    `total_food` INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (`username`) REFERENCES `Customer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(username)
);

CREATE TABLE `Administration` (
    `username` VARCHAR(50) NOT NULL,
    FOREIGN KEY (`username`) REFERENCES `Account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Order` (
    `C_username` VARCHAR(50) NOT NULL,
    `Order_id` INTEGER NOT NULL UNIQUE,
    `username` VARCHAR(50) NOT NULL,
    `Pmt_id` VARCHAR(25) NOT NULL,
    `Shipper_name` VARCHAR(50) NOT NULL,
    `Shipper_phone` CHAR(10) NOT NULL CHECK(`Shipper_phone` LIKE '0%'),
    `Shipper_lic` CHAR(12) NOT NULL UNIQUE,
    `Note` VARCHAR(255),
    `Delivery_address` VARCHAR(255) NOT NULL,
    `Order_time` DATE NOT NULL,
    `Arrival_time` DATE NOT NULL,
    `Wait_time` DATE NOT NULL,
    `Total_price` INTEGER NOT NULL,
    `Delivery_cost` INTEGER NOT NULL,
    `Need_to_pay` INTEGER NOT NULL, -- Gia + ship - Sale
    `Status` INTEGER NOT NULL CHECK(`Status` IN (0,1)),
    
    
	FOREIGN KEY (`C_username`) REFERENCES `Cart` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`username`,`Pmt_id`) REFERENCES `Payment`(`username`,`Pmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`C_username`, `Order_id`)
);

CREATE TABLE `Combo` (
    `Cb_id` INTEGER PRIMARY KEY,
    `Res_username` VARCHAR(50),
	FOREIGN KEY (`Res_username`) REFERENCES `Co_restaurant`(`username`) ON DELETE cascade ON UPDATE CASCADE,
    `Description` VARCHAR(255) DEFAULT '',
    `Cost` INTEGER NOT NULL,
    `Status` INTEGER NOT NULL CHECK(`Status` in (0,1)) DEFAULT 1 #0 IS NOT, 1 IS OKE
);


CREATE TABLE `Food_order` (
    `username` VARCHAR(50) NOT NULL,
    `F_id` INTEGER NOT NULL,
    `C_username` VARCHAR(50) NOT NULL,
    `Order_id` INTEGER NOT NULL,
    `Quantity` INTEGER NOT NULL,
    PRIMARY KEY (`username`, `F_id`, `C_username`, `Order_id`),
    FOREIGN KEY (`username`, `F_id`) REFERENCES `Food` (`username`,`F_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`C_username`, `Order_id`) REFERENCES `Order` (`C_username` ,`Order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE `Combo_order` (
    `Cb_id` INTEGER NOT NULL,
    `C_username` VARCHAR(50) NOT NULL,
    `Order_id` INTEGER NOT NULL,
    `Quantity` INTEGER NOT NULL,
    PRIMARY KEY(`Cb_id`, `C_username`, `Order_id`),
    FOREIGN KEY (`Cb_id`) REFERENCES `Combo` (`Cb_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`C_username`) REFERENCES `Order` (`C_username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Order_id`) REFERENCES `Order` (`Order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREATE TABLE `Food_combo` (
--     `username` VARCHAR(50) NOT NULL,
--     `F_id` INTEGER NOT NULL,
--     `Cb_id` INTEGER NOT NULL,
--     `Quantity` INTEGER NOT NULL,
--     PRIMARY KEY(`username`, `F_id`, `Cb_id`),
--     FOREIGN KEY (`username`) REFERENCES `Food` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
--     FOREIGN KEY (`F_id`) REFERENCES `Food` (`F_id`) ON DELETE CASCADE ON UPDATE CASCADE,
--     FOREIGN KEY (`Cb_id`) REFERENCES `Combo` (`Cb_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- );

CREATE TABLE `Combo_cart` (
    `Cb_id` INTEGER NOT NULL,
    `C_username` VARCHAR(50) NOT NULL,
    `Quantity` INTEGER NOT NULL,
    `Quoted_price` INTEGER NOT NULL,
    PRIMARY KEY ( `C_username`, `Cb_id`),
    FOREIGN KEY (`C_username`) REFERENCES `Cart` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Cb_id`) REFERENCES `Combo` (`Cb_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Food_cart` (
    `C_username` VARCHAR(50) NOT NULL,
    `F_id` INTEGER NOT NULL,
    `username` VARCHAR(50) NOT NULL,
    `Quantity` INTEGER NOT NULL,
	`Quoted_price` INTEGER NOT NULL,
    PRIMARY KEY ( `username`,`F_id`, `C_username`),
    FOREIGN KEY (`C_username`) REFERENCES `Cart` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`username`) REFERENCES `Food` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`F_id`) REFERENCES `Food` (`F_id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `Promotion` (
    `Code` INTEGER PRIMARY KEY,
    `Number` INTEGER NOT NULL DEFAULT 10,
    `max_sale` INTEGER DEFAULT 100000,
    `min_bill` INTEGER DEFAULT 0,
    `Expiration_date` DATE NOT NULL,
    `Start_date` DATE NOT NULL,
    `Res_id` VARCHAR(50),
    `Admin_id` VARCHAR(50),
    FOREIGN KEY (`Admin_id`) REFERENCES `Administration` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Res_id`) REFERENCES `Co_restaurant` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `Order_promotion` (
    `C_username` VARCHAR(50) NOT NULL,
    `Order_id` INTEGER NOT NULL,
    `Code` INTEGER NOT NULL,
    `Sales` INTEGER NOT NULL, 
    PRIMARY KEY (`C_username`,`Order_id`, `Code`),
    FOREIGN KEY (`C_username`, `Order_id`) REFERENCES `Order` (`C_username`, `Order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
UPDATE `Customer`
SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `BDate`)), '%Y') + 0;


