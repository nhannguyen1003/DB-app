-- fuction tinh so khoa hoc 1 sinh vien dang ky 
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER \\
DROP FUNCTION IF EXISTS num_course_reg;
CREATE FUNCTION num_course_reg(l_ID CHAR(7))
RETURNS INT
BEGIN
	DECLARE num_c INT DEFAULT 0;
	SELECT COUNT(courseid) AS num_course
    INTO num_c
	FROM enrolls_info
	WHERE enrolls_info.learnerid = l_ID and enrolls_info.enrollment_status in ('enrolled', 'postponed') ;
    RETURN num_c;
END \\

DELIMITER ;
-- function tinh so sv dk 1 khoa hoc
SELECT num_course_reg('SV00044');
-- fuction tinh so sinh vien dk 1 khoa hoc

SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER \\
DROP FUNCTION IF EXISTS num_learner;
CREATE FUNCTION num_learner(c_ID CHAR(6))
RETURNS INT
BEGIN
	DECLARE num_l INT DEFAULT 0;
	SELECT COUNT(learnerid) AS num_course
    INTO num_l
	FROM enrolls_info
	WHERE enrolls_info.courseid = c_ID and enrolls_info.enrollment_status in ('enrolled', 'postponed') ;
    RETURN num_l;
END \\

DELIMITER ;

SELECT num_learner('BMA003');

-- Hiển thị danh sách thông tin khóa học
DELIMITER // 
DROP PROCEDURE IF EXISTS ViewCourse;
CREATE PROCEDURE ViewCourse()
BEGIN 
DROP VIEW IF EXISTS course_list;
CREATE VIEW course_list
AS
SELECT id, name, tuition_fee, start_date, course_length, num_learner(id) as num_learner
FROM course;

SELECT * FROM course_list;
END //

DELIMITER ;
-- example
CALL ViewCourse();

-- Hiển thị thông tin hoc vien
DELIMITER //
DROP PROCEDURE IF EXISTS ViewLearner;
CREATE PROCEDURE ViewLearner(IN l_ID CHAR(7))
BEGIN 
DROP VIEW IF EXISTS view_learner;
CREATE VIEW view_learner
AS
SELECT id, ssn, last_name, first_name, gender, dob, phone_number, address, email, num_course_reg(id) as num_course_reg
FROM user_system;

SELECT * FROM view_learner
WHERE id = l_ID;
END //

DELIMITER ;

CALL ViewLearner('SV00177');
-- Hiển thị chi tiết khóa học --
-- id do người dùng chọn --
DELIMITER //
DROP PROCEDURE IF EXISTS SelectDetails;
CREATE PROCEDURE SelectDetails (IN temp_id CHAR(6))
BEGIN
DROP  TABLE IF EXISTS temp_details;
CREATE TABLE temp_details
SELECT *  FROM course_list  WHERE id=temp_id;
SELECT * FROM temp_details;
END //
DELIMITER ;
-- example
CALL SelectDetails('ACE001');

-- Tìm khóa học theo tên --
-- tên do người dùng nhập --
DELIMITER //
DROP PROCEDURE IF EXISTS SelectCourse;
CREATE PROCEDURE SelectCourse (IN temp_name VARCHAR(128))
BEGIN
DROP  TABLE IF EXISTS temp_course;
CREATE TABLE temp_course
SELECT *  FROM course  WHERE name=temp_name;
SELECT * FROM temp_course;
END //
DELIMITER ;
-- example
CALL SelectCourse('Fashion as Design, MoMA');

-- các khóa học đã đăng kí --
-- theo id người dùng --
DELIMITER //
DROP PROCEDURE IF EXISTS SelectCourseList;
CREATE PROCEDURE SelectCourseList (IN temp_id CHAR(7))
BEGIN
DROP  TABLE IF EXISTS temp_course_list;
CREATE TABLE temp_course_list
SELECT *  FROM course_list  WHERE id IN (SELECT courseid 
									FROM enrolls 
									WHERE enrolls.learnerid=temp_id);
SELECT * FROM temp_course_list;
END //
DELIMITER ;
-- example
CALL SelectCourseList('SV00002');

-- login --
-- username and password entered by the user -- 
DELIMITER //
DROP PROCEDURE IF EXISTS Login;
CREATE PROCEDURE Login (
	IN username_ VARCHAR(64),
    IN password_ VARCHAR(64)
)
Log: BEGIN
	SELECT COUNT(*) FROM user_system
    WHERE username = username_ AND password_user = password_;
    LEAVE Log;
END //
DELIMITER ;

CALL Login('minh	.buikim	@gmail.com','123456');


-- unsubscribe from the course --
-- Id_course entered by the user --
DELIMITER //
DROP PROCEDURE IF EXISTS Delete_course;
CREATE PROCEDURE Delete_course (
	IN Id_course CHAR(6),
    IN Id_user CHAR(7)
)
del_course: BEGIN
    DELETE FROM enrolls
    WHERE learnerid = Id_user AND courseid = Id_course;
    DELETE FROM enrolls_info
    WHERE learnerid = Id_user AND courseid = Id_course;
    LEAVE del_course;
END //
DELIMITER ;

CALL Delete_course('ACE001', 'SV00024');

-- update info 
DELIMITER \\
DROP PROCEDURE IF EXISTS update_info;
CREATE PROCEDURE update_info(IN p_id CHAR(7), IN p_ssn CHAR(13), IN p_lname VARCHAR(32),
							 IN p_fname VARCHAR(64),  IN p_gender VARCHAR(7), IN p_dob DATE,
							 IN p_phone VARCHAR(12),  IN p_address VARCHAR(128),
                              IN p_email VARCHAR(64))
	BEGIN 
			UPDATE user_system 
            SET ssn = IF(p_ssn IS NOT NULL, p_ssn, ssn),
				last_name = IF(p_lname IS NOT NULL, p_lname, last_name),
                first_name = IF(p_fname IS NOT NULL, p_fname, first_name),
                gender = IF(p_gender IS NOT NULL, p_gender, gender),
                dob = IF(p_dob IS NOT NULL, p_dob, dob),
                phone_number = IF(p_phone IS NOT NULL, p_phone, phone_number),
                address = IF(p_address IS NOT NULL, p_address, address),
                
                email = IF(p_email IS NOT NULL, p_email, email)
            WHERE id = p_id; 
    END \\
DELIMITER ;

DELIMITER \\
DROP PROCEDURE IF EXISTS update_pass;
CREATE PROCEDURE update_pass(IN p_id CHAR(7),
                             IN p_password VARCHAR(64))
	BEGIN 
			UPDATE user_system 
            SET 
                password_user = IF(p_password IS NOT NULL, p_password, password_user)
                
            WHERE id = p_id; 
    END \\
DELIMITER ;


-- CALL update_info('GV00001', '155431', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- SELECT * FROM USER_SYSTEM;

-- Đăng ký tài khoản học viên --------------------------------------------------------------------------------------
DELIMITER \\
DROP PROCEDURE IF EXISTS insert_learner;
CREATE PROCEDURE insert_learner(IN p_id CHAR(7))
	BEGIN
		INSERT INTO learner
		VALUES ((SELECT id FROM user_system WHERE ID = p_id), 
				(SELECT CURRENT_DATE()),
				(SELECT ID FROM supporter ORDER BY RAND() LIMIT 1));
    END \\
DELIMITER ;

DELIMITER \\
DROP PROCEDURE IF EXISTS sign_up;
CREATE PROCEDURE sign_up(IN p_ssn CHAR(13), IN p_lname VARCHAR(32),
						 IN p_fname VARCHAR(64),  IN p_gender VARCHAR(7), IN p_dob DATE,
                         IN p_phone VARCHAR(12),  IN p_address VARCHAR(128),
                         IN p_username VARCHAR(64), IN p_password VARCHAR(64), in p_email VARCHAR(64))
	BEGIN
		DECLARE p_id CHAR(7);
        SET p_id = (SELECT IFNULL
					 (CONCAT('SV',LPAD(
					   (SUBSTRING_INDEX (MAX(`id`), 'SV',-1) + 1), 5, '0')), 'SV00001')
					FROM user_system ORDER BY `id` ASC);
                    
		INSERT INTO user_system 
        VALUES (p_id, p_ssn, p_lname, p_fname, p_gender, p_dob, p_phone, p_address, p_username, p_password, p_email);
        CALL insert_learner(p_id);
    END \\
DELIMITER ;



-- Đăng ký khóa học --------------------------------------------------------------------------------------
DELIMITER \\
DROP PROCEDURE IF EXISTS enroll_course;
CREATE PROCEDURE enroll_course (IN l_id CHAR(7), IN c_id CHAR(6), 
								IN en_stat VARCHAR(24), IN pay_stat VARCHAR(24),
								IN fee DECIMAL(10,2), IN startdate DATE)
	BEGIN
		INSERT INTO enrolls  
        VALUES ((SELECT ID FROM learner WHERE ID = l_id), 
				(SELECT ID FROM course WHERE ID = c_id));
                
 		INSERT INTO enrolls_info 
 		VALUES ((SELECT ID FROM learner WHERE ID = l_id), 
				(SELECT ID FROM course WHERE ID = c_id),	
                (SELECT CURRENT_DATE()), 
                en_stat, pay_stat, fee, startdate);
    END \\
DELIMITER ;