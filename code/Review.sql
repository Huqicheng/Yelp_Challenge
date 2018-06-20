-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 


#Add Indexes on user_id and business_id
ALTER TABLE `review` ADD INDEX `idx_review_userid` (`user_id`) USING BTREE;
ALTER TABLE `review` ADD INDEX `idx_review_businessid` (`business_id`) USING BTREE;
ALTER TABLE `review` ADD INDEX `idx_review_date` (`date`) USING BTREE;


#Add Primary Key and Foreign Key constraint
-- ALTER TABLE review ADD PRIMARY KEY (id);

ALTER TABLE `review` ADD CONSTRAINT `fk_review_userid` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;
           
ALTER TABLE `review` ADD CONSTRAINT `fk_review_businessid` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;


#Remove the record whose date is out of range 2004-2018
SET @@sql_mode='no_engine_substitution';
SELECT @@sql_mode;
DELETE FROM review WHERE  date < '2004-01-01 00:00:00'  or date >='2019-01-01 00:00:00' ;

#Remove the record whose date is before the user's yelping_since
DELETE review FROM review INNER JOIN user ON review.user_id = user.id  WHERE review.date< user.yelping_since;


#Sanity check for foreign keys
SELECT  COUNT(id) FROM review WHERE user_id not in( 
     SELECT  id FROM user
) ;

SELECT  COUNT(id) FROM review WHERE business_id not in( 
     SELECT  id FROM business
) ;


#Sanity check for date
SELECT * FROM review WHERE date < '2004-01-01 00:00:00'  or date >='2019-01-01 00:00:00';
SELECT * FROM review INNER JOIN user ON review.user_id = user.id  WHERE review.date< user.yelping_since;

