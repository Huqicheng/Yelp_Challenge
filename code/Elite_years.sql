-- USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 

#Add Primary Key and Foreign Key constraint
-- ALTER TABLE elite_years ADD PRIMARY KEY (id);

ALTER TABLE `elite_years` ADD CONSTRAINT `fk_eliteyears_userid` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;

#Remove the record whose year is out of range 2004-2018
DELETE FROM elite_years WHERE  year< '2004'  or year >'2018' ;



#Sanity check for foreign keys
SELECT  COUNT(id) FROM elite_years WHERE user_id not in( 
     SELECT  id FROM user
) ;

#Sanity check for year
SELECT * FROM elite_years WHERE  year< '2004'  or year >'2018' ;
SELECT * FROM elite_years INNER JOIN (SELECT id, DATE_FORMAT(yelping_since, '%Y')AS since FROM user)AS X ON elite_years.user_id= X.id  WHERE elite_years.year<X.since;