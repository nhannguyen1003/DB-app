delimiter \\
CREATE TRIGGER `check_create_account`
BEFORE INSERT ON `Account`
FOR EACH ROW
IF (NEW.`username` IN (SELECT `username` FROM `Account`))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'username has been taken already';
END IF \\
delimiter ;


-- Produres insert account
delimiter \\
CREATE PROCEDURE food_order.insertAccount(IN username VARCHAR(50), IN password VARCHAR(50))
BEGIN
	INSERT INTO food_order.`Account` VALUES(username,password);
END\\
delimiter ;

-- CALL insertAccount('nhannguyen1','1234567');


-- insert Cart
delimiter \\
CREATE PROCEDURE food_order.insertCart(IN username varchar(50))
begin
	INSERT INTO food_order.`Cart`(username) values(username);
end\\
delimiter ;


-- insert Mem
delimiter \\
CREATE PROCEDURE food_order.insertMem(IN username varchar(50))
begin
	INSERT INTO food_order.`Membership`(username) values(username);
end\\
delimiter ;



-- insert Customer
delimiter \\
CREATE PROCEDURE food_order.insertCus(IN FName varchar(50), IN MName varchar(50),
				IN LName varchar(50), IN BDate date, IN email varchar(200), 
                IN username varchar(50), IN password varchar(50), IN gender varchar(7))
BEGIN
	declare age INT;
    set age := DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), BDate)), '%Y') + 0;
    IF (age < 18) 
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'customer are not old enough';
	END IF;
    
    IF (email not like ('%@%'))
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'mail must contain @';
	END IF;
    
	CALL insertAccount(username, password);
  
	INSERT INTO food_order.`Customer` VALUES(FName, MName, LName,
									BDate, email, username, gender, age);
	call insertCart(username);
    call insertMem(username);
END\\
delimiter ;


--  insertCus('nguyen','thanh','nhan', '2002-10-03', 'nhan@gmail.com', 'nhan','123456','Male');

-- update Customer info
delimiter \\
CREATE PROCEDURE food_order.updateCus(IN F varchar(50), IN M varchar(50),
				IN L varchar(50), IN BD date, IN email varchar(200), 
                username varchar(50), IN gender varchar(7))
                
BEGIN
	declare age INT;
    set age := DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), BD)), '%Y') + 0;
    IF (age < 18) 
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'customer are not old enough';
	END IF;
    
    IF (email not like ('%@%'))
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'mail must contain @';
	END IF;
    
    IF (username not in (select username from `Customer`))
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'unknown username';
	END IF;
    
	UPDATE food_order.`Customer` 
    SET Customer.FName = F, Customer.MName = M, 
		Customer.LName = L, Customer.BDate = BD, 
        Customer.Email = email, Customer.Gender = gender, 
        Customer.Age = age
    WHERE username = Customer.username;
                                    
END\\
delimiter ;

-- call updateCus('nguyen','thanh','nhan', '2002-10-03', 'nhan@gmail.com', 'nhan','Male');



delimiter \\
create procedure `delete_account`(username varchar(50))
begin
	IF (username not in (select username from `Account`))
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'unknown username';
	END IF;
    
    delete from `Account` 
    where Account.username = username;
end \\
delimiter ;



delimiter \\

create procedure `delete_customer`(username varchar(50))
begin
	IF (username not in (select username from `customer`))
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'unknown username';
	END IF;
    
    delete from `Customer` 
    where Customer.username = username;
	call delete_account(username);
end\\

delimiter ;

-- call delete_customer('nhan');



-- inter
delimiter \\
CREATE PROCEDURE food_order.insertCo_res( IN name varchar(255),
                IN username varchar(50), IN password varchar(50))
BEGIN
	CALL insertAccount(username, password);
	INSERT INTO food_order.`Co_restaurant`(`Res_name`, `username`) VALUES(name, username);
END \\
delimiter ;

-- call insertCo_res('nhan', 'nha_hang', '123456');


-- Insert FOOD
delimiter \\
create procedure food_order.insertFood(IN username varchar(50), IN food_id integer,
									 IN typeID integer, IN price integer, IN des varchar(255),
                                     IN status integer, IN size char(1))
	IF (NEW.`username` NOT IN (SELECT `username` FROM `Account`))
		THEN SIGNAL SQLSTATE '45000'
			 SET MESSAGE_TEXT = 'account not exist';
	END IF \\
    
    
    INSERT INTO `Food`(`username`, `F_id`, `Type_ID`, `Unit_price`, `Description` , `Status`, `Size`)
    VALUES(username,food_id,typeID,price,des,status,size);
delimiter ;


delimiter \\
create function cal_total_price(username varchar(50))
returns integer
deterministic
begin
	declare total1 integer default 0; 
	declare total2 integer default 0;
    SELECT sum(`Quantity`*`Quoted_Price`) from `Food_cart`
    where username = `Food_Cart`.username
    into total1;
    SELECT sum(`Quantity`*`Quoted_Price`) from `Order_cart`
    where username = `Order_Cart`.username
    into total2;
    
    return total2 + total1;
end \\
delimiter ;




-- ADD food to cart 
delimiter \\ 
create procedure food_order.AddFoodToCart(IN username varchar(50),IN f_id integer,
											IN res_username varchar(50), IN quantity integer,  
                                            IN quoted_price integer)
	BEGIN
		INSERT INTO `Food_cart` VALUES (username, f_id, res_username, quantity, quoted_price);
        update `Cart` set `Cart`.`total_food` = `Cart`.`total_food` + quantity* quoted_price
        where `Cart`.username = username;
	END \\
delimter ; 

-- ADD combo
delimiter \\
create procedure food_order.insertCombo(IN username varchar(50), IN cb_id integer,
									 IN price integer, IN des varchar(255),
                                     IN status integer)
	IF (NEW.`username` NOT IN (SELECT `username` FROM `Account`))
		THEN SIGNAL SQLSTATE '45000'
			 SET MESSAGE_TEXT = 'Restaurant not exist';
	END IF \\
    
    
    INSERT INTO `Combo`
    VALUES(cb_id, username, des, price, status);
delimiter ;

-- ADD combo to cart
-- delimiter \\ 
-- create procedure food_order.AddFoodToCart(IN username varchar(50),IN f_id integer,
-- 											IN res_username varchar(50), IN quantity integer,  
--                                             IN quoted_price integer)
-- 	BEGIN
-- 		INSERT INTO `Food_cart` VALUES (username, f_id, res_username, quantity, quoted_price);
--         update `Cart` set `Cart`.`total_food` = `Cart`.`total_food` + quantity* quoted_price
--         where `Cart`.username = username;
-- 	END \\
-- delimter ; 



delimiter \\ 
create procedure food_order.AddComboToCart(IN Cb_id integer, IN C_username varchar(50), 
											IN quantity integer, IN quoted_price integer)
	BEGIN
		INSERT INTO `Order_cart` VALUES (cb_id, C_username, quantity, quoted_price);
        update `Cart` set `Cart`.`total_food` = `Cart`.`total_food` + quantity* quoted_price
        where `Cart`.username = (select `username` from `Combo` 
								where `Combo`.Cb_id = Cb_id);
	END \\
delimter ;




-- cart has combo and food items
-- order all food in cart

delimiter \\
create procedure food_order.OrderFood(in username varchar(50),  in order_id integer,
									in payment_id varchar(25), in Shipper_name varchar(50),
                                    in Shipper_phone char(10), in Shipper_lic char(12),
                                    in Note varchar(255), in Delivery_address VARCHAR(255),
                                    in Order_time date, in Arrival_time date, in Wait_time date,
                                    in Delivery_cost integer)
	BEGIN
		-- check food availible
		IF ((select `Status` from `Food` where `Food`.`F_id` = food_id) = 0)
			THEN SIGNAL SQLSTATE '45000'
				 SET MESSAGE_TEXT = 'food are unavailible';
			END IF;
		
        INSERT INTO `Order` 
        VALUES(username, order_id, username, payment_id, 
				Shipper_name, Shipper_phone, Shipper_lic, Note,
                Delivery_address, Order_time, Arrival_time, Wait_time,
				(select `total_food` from `Cart` where username = `Cart`.username),
				Delivery_cost,
				(select `total_food` from `Cart` where username = `Cart`.username) + Delivery_cost,
				0);
                
		-- Hiện thực thêm vào 2 bảng bên dưới giùm nha.
		-- INSERT INTO `Combo_order`
		-- INSERT INTO `Food_order`
    END \\

delimiter ;


-- update membership
delimiter \\
create procedure food_order.updateMembership(username varchar(50), price integer)
begin 
	update `Membership` set `Accumulated_point` = `Accumulated_point` + price/1000;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.username = username) > 100
	then 
		update `Membership` set `Rank` = 1;
	end if;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.username = username) > 1000
	then 
		update `Membership` set `Rank` = 2;
	end if;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.username = username) > 10000
	then 
		update `Membership` set `Rank` = 3;
	end if;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.username = username) > 100000
	then 
		update `Membership` set `Rank` = 4;
	end if;
end \\
delimiter ;


-- pay success
delimiter \\
create procedure food_order.updatePay(username varchar(50), order_id integer)
begin
	update `Order` set `Status` = 1 
    where username = `Order`.`username` and order_id = `Order`.`Order_id`;
	call updateMembership(username, (select `Need_to_pay` from `Order` 
									where username = `Order`.`username` 
                                    and order_id = `Order`.`Order_id` ));
end \\
delimiter ;



-- delimiter \\
-- -- recalculate need to pay = gia + deliver - promotion
-- create function needtopay(username varchar(50), order_id integer)
-- returns int
-- deterministic
-- begin
-- 	declare result int default 0;
--     if username not in(select username from `Order`
-- 						where username = `Order`.`username` 
-- 								and order_id = `Order`.`Order_id`)
-- 	then SIGNAL SQLSTATE '45000'
-- 		SET MESSAGE_TEXT = 'invalid order';
-- 	END IF;
--     
--     -- check voucher
--     update `Order` set `Need_to_pay` = `Total_price` + `Delivery_cost` -- -voucher
-- 								- (select `Value` from `Voucher` 
-- 									where `Voucher`.`Code` = (select `Code` from `Order_promotion`
-- 																where username = `Order_promotion`.`C_username` 
-- 																and order_id = `Order_promotion`.`Order_id` ))
-- 	where username = `Order`.`username` 
-- 			and order_id = `Order`.`Order_id`;
-- 	
-- end
-- delimiter ;


-- add promotion




-- view customer infor
delimiter \\
create procedure getCustomerInfo(IN username varchar(50))
begin
	select * from `Customer` 
    join `Membership` on `Membership`.`username` = `Customer`.`username` 
    where `Customer`.username = username
	order by `Rank`;
end \\
delimiter ;

delimiter \\
create procedure getAllCustomer()
begin
	select * from `Customer`
    join `Membership` on `Membership`.`username` = `Customer`.`username`
    order by `Rank`;
end
delimiter ;



-- view all cart
delimiter \\
create procedure getCart(IN username varchar(50))
begin 
	select * from (select * from `Food_cart` FC join `Food` F 
					on FC.`F_id` = F.`F_id`
                    and FC.`username` = F.`C_username` 
                    where username = FC.`C_username`)  A
	inner join 
    (select * from `Combo_cart` CbC join `Combo` Cb 
					on CbC.`Cb_id` = Cb.`Cb_id` 
                    where username = CbC.`C_username`) B;
end \\ 
delimiter ;



-- view all 
