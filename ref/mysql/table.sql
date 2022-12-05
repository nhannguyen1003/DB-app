DROP SCHEMA IF EXISTS education_registration; 
CREATE SCHEMA education_registration; 
USE education_registration;

# create table and constraint for database from here
CREATE TABLE user_system(
	id CHAR(7),
    ssn CHAR(13) UNIQUE NOT NULL,
    last_name VARCHAR(32),
    first_name VARCHAR(64) NOT NULL,
    gender VARCHAR(7), 
    dob DATE,
    phone_number VARCHAR(12),
    address VARCHAR(128),
    username VARCHAR(64) UNIQUE NOT NULL,
    password_user VARCHAR(64) NOT NULL,
    email VARCHAR(64),
    PRIMARY KEY (id),
    CHECK (gender in ("Male", "Female", "Other"))
);

CREATE TABLE supporter(
	id CHAR(7),
    salary INT,
    working_time TIME,
    CHECK (salary > 0),
    CHECK (working_time >= '8:00:00' and working_time <= '18:00:00'),
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES user_system(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE learner(
	id	CHAR(7),
    join_date	DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES user_system(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lecturer(
	id 	CHAR(7),
    salary 	INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES user_system(id) ON UPDATE CASCADE ON DELETE CASCADE
);
-- Check disjoiness in learner and lecture
DELIMITER \\
CREATE TRIGGER check_disjoin_supporter
BEFORE INSERT ON supporter
FOR EACH ROW
IF (NEW.id IN (SELECT id FROM learner) OR NEW.id IN (SELECT id FROM lecturer))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'This new id have been in lecture or leaner';
END IF \\

DELIMITER ;
--
DELIMITER \\
CREATE TRIGGER check_disjoin_supporter_2
BEFORE UPDATE ON supporter
FOR EACH ROW
IF (NEW.id IN (SELECT id FROM learner) OR NEW.id IN (SELECT id FROM lecturer))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'This new id have been in lecture or leaner';
END IF \\

DELIMITER ;
-- Check disjoin in supporter and lecturer
DELIMITER \\
CREATE TRIGGER check_disjoin_learner
BEFORE INSERT ON learner
FOR EACH ROW
IF (NEW.id IN (SELECT id FROM supporter) OR NEW.id IN (SELECT id FROM lecturer))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'This new id have been in lecture or supporter';
END IF \\

DELIMITER ;
--
DELIMITER \\
CREATE TRIGGER check_disjoin_learner_2
BEFORE UPDATE ON learner
FOR EACH ROW
IF (NEW.id IN (SELECT id FROM supporter) OR NEW.id IN (SELECT id FROM lecturer))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'This new id have been in lecture or supporter';
END IF \\

DELIMITER ;
-- Check disjoin in supporter and learner
DELIMITER \\
CREATE TRIGGER check_disjoin_lecturer
BEFORE INSERT ON lecturer
FOR EACH ROW
IF (NEW.id IN (SELECT id FROM supporter) OR NEW.id IN (SELECT id FROM learner))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'This new id have been in supporter or leaner';
END IF \\

DELIMITER ;
--
DELIMITER \\
CREATE TRIGGER check_disjoin_lecturer_2
BEFORE UPDATE ON lecturer
FOR EACH ROW
IF (NEW.id IN (SELECT id FROM supporter) OR NEW.id IN (SELECT id FROM learner))
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'This new id have been in supporter or leaner';
END IF \\

DELIMITER ;

CREATE TABLE field(
	id CHAR(4),
    name VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE course(
	id CHAR(6),
    name VARCHAR(128),
    tuition_fee DECIMAL(10,2),
    start_date DATE,
    course_length INT,
    CHECK (tuition_fee > 0),
    CHECK (course_length > 0),
    PRIMARY KEY (id)
);

CREATE TABLE documents(
	courseid 	CHAR(6),
    serial		CHAR(2),
    name 	CHAR(64) NOT NULL,
    type 	VARCHAR(24), 
    PRIMARY KEY (courseid, serial),
    FOREIGN KEY (courseid) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE test(
	courseid CHAR(6),
    testid	VARCHAR(4),
    type 	VARCHAR(64),
    duration INT NOT NULL,
    CHECK (duration >= 15 and duration <= 200),
    PRIMARY KEY (courseid, testid),
    FOREIGN KEY (courseid) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE learner
ADD COLUMN (
	supportid CHAR(7) NOT NULL,
	FOREIGN KEY (supportid) REFERENCES user_system(id) ON UPDATE CASCADE ON DELETE CASCADE
	);
    
CREATE TABLE enrolls(
	learnerid	CHAR(7),
    courseid	CHAR(6),
    PRIMARY KEY (learnerid, courseid),
    FOREIGN KEY (learnerid) REFERENCES learner(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (courseid)	REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE rates(
	learnerid	CHAR(7),
    courseid	CHAR(6),
    PRIMARY KEY (learnerid, courseid),
    FOREIGN KEY (learnerid) REFERENCES learner(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (courseid)	REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE teaches(
	lecturerid	CHAR(7),
    courseid	CHAR(6),
    PRIMARY KEY (lecturerid, courseid),
    FOREIGN KEY (lecturerid) REFERENCES lecturer(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (courseid) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);
-- check total participation in Course
DELIMITER \\
CREATE TRIGGER check_total_course
BEFORE DELETE ON teaches
FOR EACH ROW
IF ((SELECT COUNT(*)
	 FROM teaches
     WHERE teaches.courseid = OLD.courseid) <= 1)
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Remain the only. Please delete from course table';
END IF \\

DELIMITER ;

CREATE TABLE course_in_field(
	fieldid 	CHAR(4),
    courseid	CHAR(6),
    PRIMARY KEY (fieldid, courseid),
    FOREIGN KEY (fieldid) REFERENCES field(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (courseid) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);
-- check total course_in_field
DELIMITER \\
CREATE TRIGGER check_total_course_2
BEFORE DELETE ON course_in_field
FOR EACH ROW
IF ((SELECT COUNT(*)
	 FROM course_in_field
     WHERE course_in_field.courseid = OLD.courseid) <= 1)
THEN SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Remain the only. Please delete from course table';
END IF \\

DELIMITER ;

CREATE TABLE prerequires(
	precourseid 	CHAR(6),
    courseid		CHAR(6),
    PRIMARY KEY (precourseid, courseid),
    FOREIGN KEY (precourseid) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (courseid) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE takes(
	learnerid 	CHAR(7),
    courseid	CHAR(6),
    testid		VARCHAR(4), 
    test_date	DATE NOT NULL,
    score		INT NOT NULL,
    PRIMARY KEY (learnerid, courseid, testid),
    FOREIGN KEY (courseid, testid) REFERENCES test(courseid, testid) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (score >= 0 and score <= 10)
);

CREATE TABLE enrolls_info(
	learnerid 	CHAR(7),
    courseid 	CHAR(6),
    enrollment_date	 DATE,
    enrollment_status VARCHAR(24) NOT NULL,
    payment_status 	VARCHAR(24) NOT NULL,
    fee 	DECIMAL(10,2) NOT NULL,
    start_date DATE,
    PRIMARY KEY (learnerid, courseid, enrollment_date),
    FOREIGN KEY (learnerid, courseid) REFERENCES enrolls(learnerid, courseid) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (payment_status in ("Complete", "Pending", "Canceled")),
    CHECK (enrollment_status in ("Enrolled", "Postponed", "Canceled")),
    CHECK (fee > 0)
);

CREATE TABLE details_rates(
	learnerid	CHAR(7),
    courseid 	CHAR(6),
    evaluation_date 	DATETIME,
    star_num	INT NOT NULL,
    comment 	VARCHAR(1024),
    PRIMARY KEY (learnerid, courseid, evaluation_date),
    FOREIGN KEY (learnerid, courseid) REFERENCES rates(learnerid, courseid) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (star_num >= 1 and star_num <= 5)
);

CREATE TABLE degree(
	lecturerid 	CHAR(7),
    field		VARCHAR(128),
    level		VARCHAR(128),
    PRIMARY KEY (lecturerid, field, level),
    FOREIGN KEY (lecturerid) REFERENCES lecturer(id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE support_session(
	learnerid	CHAR(7),
    start_time  DATETIME,
    finish_time DATETIME,
    content		VARCHAR(1024),
    PRIMARY KEY (learnerid, start_time, finish_time),
    FOREIGN KEY (learnerid) REFERENCES learner(id) ON UPDATE CASCADE ON DELETE CASCADE
);
