USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 


#Sanity check for foreign keys
SELECT  COUNT(id) FROM friend WHERE user_id not in( 
     SELECT  id FROM user
) ;
SELECT  COUNT(id) FROM friend WHERE friend_id not in( 
     SELECT  id FROM user
) ;

   
#Remove the record whose friend_id does not keep consistency with id in User
DELETE FROM friend WHERE user_id not in (select id from user);
DELETE FROM friend WHERE friend_id not in (select id from user);



#Add Primary Key and Foreign Key constraint
ALTER TABLE friend ADD PRIMARY KEY (id);

ALTER TABLE `friend` ADD CONSTRAINT `fk_friend_userid` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;
ALTER TABLE `friend` ADD CONSTRAINT `fk_friend_friendid` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
           ON DELETE CASCADE
           ON UPDATE CASCADE;
           


#Sanity check for foreign keys
SELECT  COUNT(id) FROM friend WHERE user_id not in( 
     SELECT  id FROM user
) ;
SELECT  COUNT(id) FROM friend WHERE friend_id not in( 
     SELECT  id FROM user
) ;

