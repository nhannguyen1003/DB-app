DROP TRIGGER IF EXISTS `check_create_account`;
delimiter \\
CREATE TRIGGER `check_create_account` 
BEFORE INSERT ON `Account`
FOR EACH ROW
IF (NEW.`username` IN (SELECT `username` FROM `Account`))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'username has been taken already';
END IF \\
delimiter ;

-- delele res_trigger - total partition food
DROP TRIGGER IF EXISTS `delete_restaurant`;
delimiter \\
CREATE TRIGGER `delete_restaurant`
BEFORE DELETE ON `Co_restaurant`
FOR EACH ROW
IF ((SELECT COUNT(*)
	 FROM `Food`
     WHERE `Food`.`Res_id` = OLD.`Res_id`) <= 1)
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Remain the only. Please delete from food table';
END IF \\
end
delimter ;

-- delete food - order total partitiom
DROP TRIGGER IF EXISTS `delete_order_food`;
delimiter \\
CREATE TRIGGER `delete_order_food`
BEFORE DELETE ON `Food`
FOR EACH ROW
IF ((SELECT COUNT(*)
	 FROM `Order_food`
     WHERE `Order_food`.`F_id` = OLD.`F_id` AND `Order_food`.`Res_id` = OLD.`Res_id`) <= 1)
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Remain the only. Please delete from Food_order table';
END IF \\
end
delimter ;

-- delete order_combo 
DROP TRIGGER IF EXISTS `delete_order_combo`;
delimiter \\
CREATE TRIGGER `delete_order_combo`
BEFORE DELETE ON `Combo`
FOR EACH ROW
IF ((SELECT COUNT(*)
	 FROM `Order_combo`
     WHERE `Order_combo`.`Cb_id` = OLD.`Cb_id`) <= 1)
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Remain the only. Please delete from Food_order table';
END IF \\
end
delimter ;


-- Produres insert account
DROP PROCEDURE IF EXISTS insertAccount;
delimiter \\
CREATE PROCEDURE insertAccount(IN username VARCHAR(50), IN password VARCHAR(50))
BEGIN
	INSERT INTO food_order.`Account` VALUES(username,password);
END\\
delimiter ;

-- CALL insertAccount('nhannguyen1','1234567');


-- insert Cart
DROP PROCEDURE IF EXISTS insertCart;

delimiter \\
CREATE PROCEDURE food_order.insertCart(IN Cus_id integer)
begin
	INSERT INTO food_order.`Cart`(Cus_id) values(Cus_id);
end\\
delimiter ;


-- insert Mem
DROP PROCEDURE IF EXISTS insertMem;
delimiter \\
CREATE PROCEDURE food_order.insertMem(IN Cus_id integer)
begin
	INSERT INTO food_order.`Membership`(Cus_id) values(Cus_id);
end\\
delimiter ;



-- insert Customer
DROP PROCEDURE IF EXISTS insertCus;
delimiter \\
CREATE PROCEDURE insertCus(IN FName varchar(50), IN MName varchar(50),
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
	INSERT INTO `Customer`(`username`, `FName`, `MName`, `LName`, `BDate`, `Email`, `Gender`, `Age`)
	VALUES(username, FName, MName, LName, BDate, email, gender, age); 
	call insertCart((select Cus_id from Customer where Customer.username = username));
	call insertMem((select Cus_id from Customer where Customer.username = username));
END\\
delimiter ;


-- call insertCus('nguyen','thanh','nhan', '2002-10-03', 'nhan@gmail.com', 'nhan','123456','Male');

-- update Customer info
DROP PROCEDURE IF EXISTS updateCus;
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



DROP PROCEDURE IF EXISTS delete_account;
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



DROP PROCEDURE IF EXISTS delete_customer;
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



-- insertCo
DROP PROCEDURE IF EXISTS insertCo_res;

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
DROP PROCEDURE IF EXISTS insertFood;

delimiter \\
create procedure food_order.insertFood(IN Res_id integer,IN typeID integer,
									IN price integer, IN des varchar(255),
                                     IN status integer, IN size char(1), 
                                     IN Fname VARCHAR(100))
begin
	IF (Res_id NOT IN (SELECT `Res_id` FROM `Co_restaurant`))
		THEN SIGNAL SQLSTATE '45000'
			 SET MESSAGE_TEXT = 'account not exist';
	END IF;
    
    
    INSERT INTO `Food`(`Res_id`, `Type_ID`, `Unit_price`, `Description` , `Status`, `Size`, `Fname`)
    VALUES(Res_id, typeID, price, des, status, size, Fname);
end \\
delimiter ;


-- call insertFood(100, 1, 50000, "do vl", 1, 'M', 'Mi xao');

drop function if exists cal_total_price;
delimiter \\
create function cal_total_price(Cart_id int)
returns integer
deterministic
begin
	declare total1 integer default 0; 
	declare total2 integer default 0;
    SELECT sum(`Quantity`*`Quoted_Price`) from `Food_cart`
    where Cart_id = `Food_Cart`.`Cart_id`
    into total1;
    SELECT sum(`Quantity`*`Quoted_Price`) from `Combo_cart`
    where Cart_id = `Combo_cart`.`Cart_id`
    into total2;
    
    return total2 + total1;
end \\
delimiter ;

-- SELECT cal_total_price(1);



-- ADD food to cart 
drop procedure if exists AddFoodToCart;

delimiter \\ 
create procedure AddFoodToCart(IN Res_id int,IN F_id integer,
							 IN Cart_id int, IN quantity integer)
BEGIN
	INSERT INTO `Food_cart` VALUES (Res_id, F_id, Cart_id, quantity,
        (select Unit_price from `Food` where `Food`.Res_id = Res_id and `Food`.F_id = F_id));
	update `Cart` set `Cart`.`total_food` = `Cart`.`total_food` 
							+ quantity*(select Unit_price from `Food` where `Food`.Res_id = Res_id and `Food`.F_id = F_id )
	where `Cart`.`Cart_id` = Cart_id;
END \\
delimiter ; 

-- call AddFoodToCart(1, 2, 1, 2);

-- ADD combo
drop procedure if exists insertCombo;


delimiter \\
create procedure food_order.insertCombo(IN Res_id varchar(50), IN price integer,
									IN Cb_name VARCHAR(255), IN des varchar(255))
begin
	IF (Res_id NOT IN (SELECT `Res_id` FROM `Co_restaurant`))
		THEN SIGNAL SQLSTATE '45000'
			 SET MESSAGE_TEXT = 'Restaurant not exist';
	END IF;
    
    INSERT INTO `Combo`(`Res_id`, `Cb_name`, `Description`, `Cost`, `Status`)
    VALUES(Res_id, Cb_name, des, price, 1);
end \\
delimiter ;

-- call insertCombo(1,30000, "Ga heo", "hehe");

drop procedure if exists AddComboToCart;
delimiter \\ 
create procedure AddComboToCart(IN Cb_id integer, IN Cart_id int, 
											IN quantity integer)
	BEGIN
		INSERT INTO `Combo_cart` VALUES (Cb_id, Cart_id, quantity, 
        (select Cost from `Combo` where `Combo`.Cb_id = Cb_id));
        update `Cart` set `Cart`.`total_food` = `Cart`.`total_food` + quantity
        * (select Cost from `Combo` where `Combo`.Cb_id = Cb_id)
        where `Cart`.`Cart_id` = Cart_id;
	END \\
delimiter ;

-- call AddComboToCart(1, 3, 2);


-- cart has combo and food items
-- order all food in cart



drop procedure if exists OrderAllFood;

delimiter \\
create procedure OrderAllFood(in Cart_id int, in Order_id int ,in Cus_id int, 
									in Pmt_id int, in Shipper_name varchar(50),
                                    in Shipper_phone char(10), in Shipper_lic char(12),
                                    in Note varchar(255), in Delivery_address VARCHAR(255),
                                    in Order_time datetime, in Arrival_time datetime, 
                                    in Wait_time datetime, in Delivery_cost integer)
	BEGIN
		-- check all food availible
		IF ((select Count(*) from 
			(select Status as Fstatus from Food 
									where Food.Res_id in( select Res_id from Food_cart 
										where Food_cart.Cart_id = Cart_id)
									and Food.F_id in( select F_id from Food_cart 
										where Food_cart.Cart_id = Cart_id)) AS F
			join
			(select Status as Cstatus from Combo
										where Combo.Cb_id in(select Cb_id from Combo_cart 
										where Combo_cart.Cart_id = Cart_id)) AS Cb
			where (F.FStatus = 0 or Cb.Cstatus = 0)) > 0)
		THEN SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'food are unavailible';
		END IF ;
		
		
        
        INSERT INTO `Order`(`Cart_id`, `Order_id` ,`Cus_id`,`Pmt_id`, `Shipper_name` ,`Shipper_phone`,
			`Shipper_lic` , `Note`, `Delivery_address`, `Order_time`, `Arrival_time`, 
            `Required_time`,`Total_price`, `Delivery_cost`, `Need_to_pay`, `Status`)
        VALUES(Cart_id, Order_id, Cus_id, Pmt_id, 
				Shipper_name, Shipper_phone, Shipper_lic, Note,
                Delivery_address, Order_time, Arrival_time, Wait_time,
				(select cal_total_price(Cart_id)),
				Delivery_cost,
				(select cal_total_price(Cart_id)) + Delivery_cost,
				0);
                
		-- Insert food_order
        INSERT INTO `Food_order`(Res_id, F_id, Cart_id, Order_id ,Quantity)
		(SELECT A.Res_id, A.F_id, A.Cart_id, B.Order_id, A.Quantity 
        FROM `Food_Cart` as A join (SELECT DISTINCT Order_id from `Order` where Order_id = `Order`.Order_id ) as B
		WHERE A.`Cart_id` = A.Cart_id);
        -- Insert combo_order
        INSERT INTO `Combo_order`(Cb_id, Cart_id, Order_id ,Quantity)
		(SELECT A.Cb_id, A.Cart_id, B.Order_id ,A.Quantity 
        FROM `Combo_Cart` as A join (SELECT DISTINCT Order_id from `Order` where Order_id = `Order`.Order_id ) as B
		WHERE A.`Cart_id` = A.Cart_id);
    END \\
delimiter ;

-- call OrderAllFood(1, 122, 1, 1, 'Nguyen Van Lam', '0903481048', '891363183151', 'lấy nhiều chanh', '78 Nguyễn Du', '2022-12-05:14:00:00', '2022-12-05:14:40:00', '2022-12-05:14:30:00', 20000);




-- update membership
delimiter \\
create procedure food_order.updateMembership(Cus_id int, price integer)
begin 
	update `Membership` set `Accumulated_point` = `Accumulated_point` + price/1000;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.Cus_id = Cus_id) > 100
	then 
		update `Membership` set `Rank` = 1;
	end if;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.Cus_id = Cus_id) > 1000
	then 
		update `Membership` set `Rank` = 2;
	end if;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.Cus_id = Cus_id) > 10000
	then 
		update `Membership` set `Rank` = 3;
	end if;
    if (select `Accumulated_point` from `Membership` 
			where `Membership`.Cus_id = Cus_id) > 100000
	then 
		update `Membership` set `Rank` = 4;
	end if;
end \\
delimiter ;


-- pay success
delimiter \\
create procedure food_order.updatePay(Cart_id int, order_id integer)
begin
	update `Order` set `Status` = 1 
    where Cart_id = `Order`.`Cart_id` and order_id = `Order`.`Order_id`;
	call updateMembership(username, (select `Need_to_pay` from `Order` 
									where username = `Order`.`username` 
                                    and order_id = `Order`.`Order_id` ));
end \\
delimiter ;


drop function if exists needtopay;
delimiter \\
-- recalculate need to pay = gia + deliver - promotion
create function needtopay(Cart_id int, order_id integer)
returns int
deterministic
begin
	declare temp1 int default 0;
    declare result int default 0;
    declare temp2 int default 1;
    if ((select count(Cart_id) from `Order`
						where Cart_id = `Order`.`Cart_id` 
						and order_id = `Order`.`Order_id`) < 1)
	then SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'invalid order';
	END IF;
    
    -- check voucher
    (select sum(`Total_price` + `Delivery_cost`) from `Order` 
			 where Cart_id = `Order`.`Cart_id` 
			 and order_id = `Order`.`Order_id`)
	into result;
	select sum(`Value`) from `Voucher`
			where `Voucher`.`Code` in (select `Code` from `Order_promotion`
									  where Cart_id = `Order_promotion`.`Cart_id` 
									  and order_id = `Order_promotion`.`Order_id` )
	into temp1;
    -- check Coupon                     
	(select sum(`Percent`) from `Coupon` 
					where `Coupon`.`Code` in (select `Code` from `Order_promotion`
											  where Cart_id = `Order_promotion`.`Cart_id` 
											  and order_id = `Order_promotion`.`Order_id` ))
	into temp2;
    if(temp2 < 1)
		then select count(Cart_id) from `Order`
						where Cart_id = `Order`.`Cart_id` 
						and order_id = `Order`.`Order_id`
			 into temp2;
	end if;
return (result - temp1)*temp2;
end \\
delimiter ;

-- needtopay(1,1)
-- add promotion to order

drop procedure if exists addPromotionToOrder;
delimiter \\
create procedure addPromotionToOrder(IN Cart_id int, IN Order_id int,IN Code integer)
begin
	-- check code
    if((select count(*) from `Promotion` where `Promotion`.`Code` = code) < 1)
	then SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'invalid code';
	END IF;
    -- update needtopay
    insert into `Order_promotion` values(Cart_id, Order_id, Code);
    call needtopay(Cart_id, Order_id);
end \\
delimiter ;

-- call addPromotionToOrder(1,1, 12345);





-- view customer infor
drop procedure if exists getCustomerInfo;
delimiter \\
create procedure getCustomerInfo(IN Cus_id int)
begin
	select * from `Customer` 
    join `Membership` on `Membership`.`Cus_id` = `Customer`.`Cus_id` 
    where `Customer`.Cus_id = Cus_id;
end \\
delimiter ;


-- 1.2.3 Trả về max acc_point của những customer theo họ nếu max acc_point của họ lớn hơn 1000,
-- sắp xếp theo điểm.
drop procedure if exists MaxRank;  
delimiter \\
create procedure MaxRank()
begin
	select `FName`, max(`Accumulated_point`) from
	`Customer`,`Membership`
    where `Membership`.`Cus_id` = `Customer`.`Cus_id`
    group by `Fname`
    having max(`Accumulated_point`) > 10
    order by max(`Accumulated_point`)
    ;
end \\
delimiter ;
-- call MaxRank();

drop procedure if exists getAllCustomer;

delimiter \\
create procedure getAllCustomer()
begin
	select * from `Customer`
    join `Membership` on `Membership`.`Cus_id` = `Customer`.`Cus_id`
    order by `Rank`;
end \\
delimiter ;

-- call getAllCustomer();




