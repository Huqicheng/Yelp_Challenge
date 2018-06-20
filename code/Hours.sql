-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 

#Add Primary Key and Foreign Key constraint
-- ALTER TABLE hours ADD PRIMARY KEY (id);
           
ALTER TABLE `hours` ADD CONSTRAINT `fk_hours_businessid` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;


#Sanity check for foreign keys
SELECT  COUNT(id) FROM hours WHERE business_id not in( 
     SELECT  id FROM business
) ;
