USE yelp_db;
SET SQL_SAFE_UPDATES = 0; 


#Remove records if the review_count  in Business is smaller than the number of reviews in Review
DELETE business FROM business
	   INNER JOIN (
             SELECT business_id, COUNT(DISTINCT id)AS rev_num FROM review GROUP BY business_id
	    )AS X 
		ON business.id=X.business_id 
        WHERE review_count<X.rev_num ;


#Sanity check for review_count
SELECT id, review_count, X.rev_num AS num FROM business
	   INNER JOIN (
             SELECT business_id, COUNT(DISTINCT id)AS rev_num FROM review GROUP BY business_id
	    )AS X 
		ON business.id=X.business_id 
        WHERE review_count<X.rev_num ;