-- use yelp_db;
SET SQL_SAFE_UPDATES = 0; 


#Add Primary Key and Foreign Key constraint
-- ALTER TABLE user ADD PRIMARY KEY (id);


#Remove the record whose yelping_since is out of range 2004-2018
SET @@sql_mode='no_engine_substitution';
SELECT @@sql_mode;
DELETE FROM user WHERE  yelping_since < '2004-01-01 00:00:00'  or yelping_since >='2018-04-18 00:00:00';

#Remove records if the review_count  in User is smaller than the number of reviews in Review
DELETE user FROM `user` INNER JOIN (
       SELECT  user_id, COUNT(DISTINCT id
       )AS rev_num 
       FROM review GROUP BY user_id)AS X 
	ON `user`.id=X.user_id 
    WHERE review_count<X.rev_num ;
 
#Remove records if the difference of a user's average_stars in User and the average stars computing by  satars in Review is greater than 0.5
DELETE user FROM user WHERE id IN(
       SELECT  DISTINCT(id) FROM (SELECT id,average_stars  FROM user) A 
       INNER JOIN
       (SELECT user_id , AVG(stars)AS r_stars FROM review GROUP BY id) B 
	ON A.id = B.user_id
	WHERE ABS(average_stars- r_stars)>0.5);

#Sanity check for review_count
SELECT id, review_count, X.rev_num AS num FROM user 
	   INNER JOIN (
             SELECT user_id, COUNT(DISTINCT id)AS rev_num FROM review GROUP BY user_id
	    )AS X 
		ON user.id=X.user_id 
        WHERE review_count<X.rev_num ;

#Sanity check for date
SELECT * FROM user WHERE yelping_since < '2004-01-01 00:00:00'  or yelping_since >='2018-04-18 00:00:00';

#Sanity check for review stars
SELECT COUNT(DISTINCT X.id) FROM 
       (SELECT * FROM (SELECT id,average_stars  FROM user) A 
       INNER JOIN
       (SELECT user_id , AVG(stars)AS r_stars FROM review GROUP BY id) B 
	ON A.id = B.user_id ) X
	WHERE ABS(average_stars- r_stars)>0.5;
