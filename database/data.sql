INSERT INTO `Account` values
('nhanmnm', 'nhan123'),(
 'huylkl', 'HUY09123'),(
 'khanhhit', 'Khanhhaha123'),(
 'daobahuy89', 'Huydao347'),(
 'saigonquangt', 'Saigonquan456'),(
 'thedailycoffee90', 'Thedailycf567'),(
 'phohanoi79', 'Phoquan0595'),(
 'trankimkhanh29', 'Khanhne020902'),(
 'legiang45', 'Giangadmin456');
INSERT INTO `Administration` values(
	1, 'trankimkhanh29') ,(
	2, 'legiang45'
);
INSERT INTO `Co_restaurant` values(
	1, 'saigonquangt', 'Sai Gon quan', 4),(
	2, 'thedailycoffee90', 'The Daily Coffee', 5),(
	3, 'phohanoi79', 'Pho Ha Noi', 3
);
INSERT INTO `Customer`( `Cus_id` , `username` , `FName` , `MName` , `LName` , `BDate` , `Email` , `Gender`) 
VALUES(
    1, 'nhanmnm', 'Nhan', 'Thanh','Nguyen', '2002-03-10', 'nhan123@gmail.com', 'Male'),(
	2, 'huylkl', 'Huy','Quang','Le', "2000-11-10", "huy.le@gmail.com", "Male"),(
	3, 'khanhhit', 'Khanh','Minh','Tran', "2001-09-01", "khanhhehe@gmail.com", "Female"),(
	4, 'daobahuy89',  'Duy', 'Ba', 'Dao',"1999-04-05", "dao.ba.duy@gmail.com", "Male"
);
INSERT INTO `Customer_phone` values(
1,  '0903481044'),(
1,  '0904586111'),(
2, '0905345756'),(
3, '0935044849'),(
4, '0835488751'
);

INSERT INTO `Co_restaurant_phone` values(
1, '0905234867'),(
1, '0905232891'),(
2, '0903481041'),(
2, '0782323150'),(
3, '0784545321'
);
INSERT INTO `Co_restaurant_address` values(
1, '45 Trần Minh Quyền'),(
1, '78 Ngô Gia Tự'),(
2, '123 Lê Lai'),(
3, '29 Nguyễn Thị Minh Khai'),(
3, '45 Nguyễn Du'),(
3, '435 Ngô Quyền'
);
INSERT INTO `Membership` values(
1, 1, 3, 150),(
2, 3, 3, 250),(
3, 4, 1, 10),(
4, 2, 4, 3000
);
INSERT INTO `Payment` values(
1, 1, 'E-wallet'),(
4, 2, 'Card'),(
2, 3, 'Cash'
);
INSERT INTO `E-wallet`values (1, 1, '02090045');
INSERT INTO `Card` values(4, 2, 'OCB', '19001345956');
INSERT INTO `Food_type` values(
'alcohol-beer', 1),(
'bun', 2),(
'banh my', 3),(
'com', 4),(
'trang mieng', 5),(
'tra sua', 6),(
'nuoc ep - sinh to', 7),(
'fast food', 8),(
'ca phe - tra', 9),(
'khac',10
);
INSERT INTO `Food` values(
1, 1 , 4 , 'com suon bi', 30000, '1 suon+bi', 1,'M'),(
1, 2, 4, 'com suon bi trung', 40000, '1 suon+1 trung+bi', 1,'M'),(
1, 3 , 4 , 'com suon bi cha', 50000, '1 suon+bi+1 cha', 1,'M'),(
1, 4 , 4 , 'com suon bi', 40000, '1 suon to+bi', 1,'L'),(
1, 5, 4, 'com suon bi trung', 50000, '1 suon to+1 trung+bi', 1,'L'),(
1, 6 , 4 , 'com suon bi cha', 60000, 'suon to+bi+cha', 1,'L'),(
1, 7 , 2 , 'bun rieu',  25000, NULL, 1,'M'),(
1, 8 , 2 , 'bun rieu', 40000, NULL, 1,'L'),(
1, 9 , 2 , 'hu tieu', 30000, NULL , 1,'M'),(
1, 10, 2, 'hu tieu' , 35000,  NULL , 1,'L'),(
1, 11, 10 , 'suon',  15000, NULL, 1,'M'),(
1, 12 , 10 , 'trung', 5000, NULL, 1,'M'),(
1, 13, 10, 'cha', 5000, NULL, 1,'M'),(
1, 14 , 10 , 'bi', 5000, NULL, 1,'M'),(
1, 15 , 10 , 'bun them', 5000, NULL, 1,'M'),(
1, 16 , 10 , 'com them', 2000, NULL, 1,'M'),(
2, 1 , 6 , 'tra sua dac biet', 45000, '7 loai topping', 1,'M'),(
2, 2, 6, 'tra sua truyen thong kem trung nuong', 42000, 'da bao gom chan trau trang', 1,'M'),(
2, 3 , 6 , 'tra sua olong', 42000, 'da bao gom tran chau den', 1,'M'),(
2, 4 , 6 , 'tra sua gao rang', 40000, 'da bao gom tran chau trang', 1,'M'),(
2, 5, 6, 'tra sua hoa nhai', 35000, NULL, 1,'M'),(
2, 6 , 6 , 'tra sua socola', 40000, 'da bao gom tran chau den', 1,'M'),(
2, 7 , 6 , 'tra sua khoai mon',  40000, NULL, 1,'M'),(
2, 8 , 6 , 'tra sua bac ha', 40000, NULL, 1,'M'),(
2, 9 , 6 , 'tra sua dau', 40000, NULL , 1,'M'),(
2, 10, 6, 'tra sua thái xanh' , 40000,  NULL , 1,'M'),(
2, 11, 6, 'tra sua truyen thong kem trung nuong', 47000, 'da bao gom chan trau trang', 1,'L'),(
2, 12, 6 , 'tra sua olong', 47000, 'da bao gom tran chau den', 1,'L'),(
2, 13 , 6 , 'tra sua gao rang', 45000, 'da bao gom tran chau trang', 1,'L'),(
2, 14, 6, 'tra sua hoa nhai', 40000, NULL, 1,'L'),(
2, 15 , 6 , 'tra sua socola', 45000, 'da bao gom tran chau den', 1,'L'),(
2, 16 , 6 , 'tra sua khoai mon',  45000, NULL, 1,'L'),(
2, 17 , 6 , 'tra sua bac ha', 45000, NULL, 1,'L'),(
2, 18 , 6 , 'tra sua dau', 45000, NULL , 1,'L'),(
2, 19, 6, 'tra sua thái xanh' , 45000,  NULL , 1,'L'),(
2, 20, 7 , 'sinh to dau',  25000, NULL, 1,'M'),(
2, 21 , 7 , 'sinh to bo', 25000, NULL, 1,'M'),(
2, 22, 7, 'sinh to mang cau', 25000, NULL, 1,'M'),(
2, 23 , 7 , 'sinh to sapoche', 25000, NULL, 1,'M'),(
2, 24 , 7 , 'sinh to dua gang', 25000, NULL, 1,'M'),(
2, 25 , 7 , 'sinh to dua', 25000, NULL, 1,'M'),(
2, 26, 7 , 'sinh to dau',  30000, NULL, 1,'L'),(
2, 27 , 7 , 'sinh to bo', 30000, NULL, 1,'L'),(
2, 28, 7, 'sinh to mang cau', 30000, NULL, 1,'L'),(
2, 29 , 7 , 'sinh to sapoche', 30000, NULL, 1,'L'),(
2, 30 , 7 , 'sinh to dua gang', 30000, NULL, 1,'L'),(
2, 31 , 7 , 'sinh to dua', 30000, NULL, 1,'L'),(
2, 32, 8 , 'ca phe den',  25000, NULL, 1,'M'),(
2, 33 , 8 , 'ca phe sua', 25000, NULL, 1,'M'),(
2, 34, 8, 'bac xiu', 25000, NULL, 1,'M'),(
2, 35 , 8 , 'tra dao', 25000, NULL, 1,'M'),(
2, 36 , 8 , 'tra dau', 25000, NULL, 1,'M'),(
2, 37, 8 , 'ca phe den',  30000, NULL, 1,'L'),(
2, 38 , 8 , 'ca phe sua', 30000, NULL, 1,'L'),(
2, 39, 8, 'bac xiu', 30000, NULL, 1,'L'),(
2, 40 , 8 , 'tra dao', 30000, NULL, 1,'L'),(
2, 41 , 8 , 'tra dau', 30000, NULL, 1,'L'),(
3, 1 , 2 , 'pho bo thap cam', 45000, 'bo tai, nam, gan, bo vien' , 1,'M'),(
3, 2, 2, 'pho tai bo vien', 35000, NULL, 1,'M'),(
3, 3 , 2 , 'pho nam gan', 35000, NULL, 1,'M'),(
3, 4 , 2 , 'pho tai gan', 35000, NULL, 1,'M'),(
3, 5, 2, 'pho tai nam', 35000, NULL, 1,'M'),(
3, 6 , 2 , 'pho tai', 30000, NULL, 1,'M'),(
3, 7 , 2 , 'pho gan',  30000, NULL, 1,'M'),(
3, 8 , 2 , 'pho nam', 30000, NULL, 1,'M'),(
3, 9 , 2 , 'pho ga', 30000, NULL , 1,'M'),(
3, 10 , 2 , 'pho bo thap cam', 60000, 'bo tai, nam, gan, bo vien' , 1,'L'),(
3, 11, 2, 'pho tai bo vien', 45000, NULL, 1,'L'),(
3, 12 , 2 , 'pho nam gan', 45000, NULL, 1,'L'),(
3, 13 , 2 , 'pho tai gan', 45000, NULL, 1,'L'),(
3, 14, 2, 'pho tai nam', 45000, NULL, 1,'L'),(
3, 15 , 2 , 'pho tai', 40000, NULL, 1,'L'),(
3, 16 , 2 , 'pho gan',  40000, NULL, 1,'L'),(
3, 17 , 2 , 'pho nam', 40000, NULL, 1,'L'),(
3, 18 , 2 , 'pho ga', 40000, NULL , 1,'L'),(
3, 19, 10, 'thit bo nam' , 15000,  NULL , 1,'M'),(
3, 20, 10, 'gan bo', 15000, NULL, 1,'M'),(
3, 21, 10, 'bo vien', 15000, NULL, 1,'M'),(
3, 22 , 10, 'thit bo tai', 15000, NULL, 1,'M'),(
3, 23, 10, 'quay', 5000, NULL, 1,'M'),(
3, 24 , 10 , 'pho them', 10000, NULL , 1,'M'
);


INSERT INTO `Cart` (`Cart_id`, `Cus_id`) values(
1, 1),(
2, 2),(
3, 3),(
4,4
);
INSERT INTO `Combo` values(
1,1, 'Com bo 1', 'Com suon bi va nuoc sam bi dao',45000,1),(
2,1, 'Combo 2', 'Hu tieu va sua bap', 50000, 0),(
3, 1, 'Combo 3', 'Hu tieu và  com suon bi', 50000, 1),(
4, 2, 'Combo tien loi', 'Tra sua olong M va tra sua gao rang M', 75000, 1),(
5, 2, 'Combo dac biet', 'Tra sua dac biet M và tra sua olong M', 80000, 1),(
6, 3, 'Combo sieu bu', 'Pho nam L va pho ga L', 75000, 1),(
7, 3, 'Combo ngon', 'Pho tai M và pho ga M', 55000, 1),(
8, 3, 'Combo hap dan', 'Pho bo thap cam M va pho nam gan L', 85000, 1
);
INSERT INTO `Order`(`Cart_id`, `Order_id`, `Cus_id`,`Pmt_id`, `Shipper_name` ,`Shipper_phone`,
			`Shipper_lic` , `Note`, `Delivery_address`, `Order_time`, `Arrival_time`, `Required_time`, `Status`
            ) values(
            1, 1,1 , 1, 'Nguyen Van Lam', '0903481048', '849364143141', 'lấy nhiều chanh', '78 Nguyễn Du', '2022-12-05:14:00:00', '2022-12-05:14:40:00', '2022-12-05:14:30:00',1),(
            1, 2,2 , 3, 'Le Phuoc Huy', '0784545617', '567364143234', NULL, '841 Lê Lai', '2022-10-05:08:00:00', '2022-10-05:08:30:00', '2022-10-05:14:20:00',0),(
            2, 3,2 , 3, 'Pham Dang Khoa', '0935481041', '434364143376', NULL, '209 Lý Thường Kiệt', '2022-09-02:20:15:00', '2022-09-02:20:40:00', '2022-09-02:20:50:00',1),(
            3, 4,4 , 2, 'Duong Nhu Hung', '0905716225', '205364143286', 'khong lay muong dua', '90 Lý Thái Tổ', '2022-05-04:11:00:00', '2022-05-04:11:50:00', '2022-05-04:11:40:00',1),(
            4, 5,4 , 2, 'La Nhu Hang', '0282424510', '783364143113', 'them nhieu ot', '29 Âu Cơ', '2022-01-17:14:00:00', '2022-01-17:14:35:00', '2022-01-17:14:40:00',0
    );
INSERT INTO `Food_order` VALUES(1, 1, 1, 1, 1) ;
INSERT INTO `Combo_order` values(1,1,1 ,3);
INSERT INTO `Combo_cart` values(1, 1, 2, 45000);
INSERT INTO `Food_cart` values(1, 1,1 , 2, 30000);
INSERT INTO `Promotion` values(12345, 100, 20000, 200000, '2022-12-11', '2022-12-09', 1, 1);
INSERT INTO `Order_promotion` values(1, 1, 12345);
INSERT INTO `Voucher` values(12345, 10000);