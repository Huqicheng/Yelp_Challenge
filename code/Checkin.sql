-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 

#Add Primary Key and Foreign Key constraint
-- ALTER TABLE checkin ADD PRIMARY KEY (id);
           
ALTER TABLE `checkin` ADD CONSTRAINT `fk_checkin_businessid` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;


#Sanity check for foreign keys
SELECT  COUNT(id) FROM checkin WHERE business_id not in( 
     SELECT  id FROM business
) ;
