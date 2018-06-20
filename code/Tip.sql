-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 

#Add Primary Key and Foreign Key constraint
-- ALTER TABLE tip ADD PRIMARY KEY (id);

ALTER TABLE `tip` ADD CONSTRAINT `fk_tip_userid` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;
           
ALTER TABLE `tip` ADD CONSTRAINT `fk_tip_businessid` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;

#Remove the record whose date is out of range 2004-2018
SET @@sql_mode='no_engine_substitution';
SELECT @@sql_mode;
DELETE FROM tip WHERE  date < '2004-01-01 00:00:00'  or date >='2018-04-18 00:00:00';

#Remove the record whose date is before the user's yelping_since
DELETE tip FROM tip INNER JOIN user ON tip.user_id = user.id where tip.date<user.yelping_since;

#Sanity check for foreign keys
SELECT  COUNT(id) FROM tip WHERE user_id not in( 
     SELECT  id FROM user
) ;

#Sanity check for date
SELECT * FROM tip WHERE  date < '2004-01-01 00:00:00'  or date >='2018-04-18 00:00:00';
SELECT user.id, tip.date,user.yelping_since FROM tip INNER JOIN user ON tip.user_id = user.id where tip.date<user.yelping_since;