-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 

#Add Primary Key and Foreign Key constraint
-- ALTER TABLE photo ADD PRIMARY KEY (id);
           
ALTER TABLE `photo` ADD CONSTRAINT `fk_photo_businessid` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;


#Sanity check for foreign keys
SELECT  COUNT(id) FROM photo WHERE business_id not in( 
     SELECT  id FROM business
) ;
