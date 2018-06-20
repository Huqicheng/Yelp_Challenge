-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 

#Add Primary Key and Foreign Key constraint
-- ALTER TABLE attribute ADD PRIMARY KEY (id);
           
ALTER TABLE `attribute` ADD CONSTRAINT `fk_attribute_businessid` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;


#Sanity check for foreign keys
SELECT  COUNT(id) FROM attribute WHERE business_id not in( 
     SELECT  id FROM business
) ;
