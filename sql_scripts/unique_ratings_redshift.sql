/* Count of unique ratings */
SELECT COUNT ( DISTINCT stars ) AS "unique_ratings" 
FROM product_reviews;

/* DISTINCT PRODUCT CATEGORIES */
SELECT DISTINCT product_category AS "unique_category" FROM product_reviews_json;


/* 
CAST STRING TO NUMBER
https://docs.aws.amazon.com/redshift/latest/dg/r_TO_NUMBER.html
https://docs.aws.amazon.com/redshift/latest/dg/r_Numeric_formating.html
*/
SELECT
    COUNT(stars)
FROM
    product_reviews
WHERE
    TO_NUMBER(stars, '9')=5;


/* FIND DISTINCT VALUES IN A COLUMN */
SELECT DISTINCT product_category AS unique_category FROM product_reviews_json;


/* FIND DISTINCT VALUES IN A COLUMN */
SELECT COUNT(DISTINCT product_category) AS unique_category FROM product_reviews;


SELECT AVG(TO_NUMBER(stars, '9')) FROM product_reviews_json WHERE product_category='kitchen' or product_category='grocery';
SELECT AVG(TO_NUMBER(stars, '9')) FROM product_reviews_parquet WHERE product_category='kitchen' or product_category='grocery';




SELECT stars, COUNT(stars) total_ratings FROM product_reviews_json WHERE product_category='kitchen' or product_category='grocery'
GROUP BY stars;




/* FASHION REVIEWS */
/* -- Does verified users rate higher? */
SELECT overall, COUNT(overall) total_ratings FROM fashion_reviews WHERE verified IS TRUE
GROUP BY overall;

/* Does verified users get more votes? */
SELECT verified, COUNT(vote) total_votes FROM fashion_reviews WHERE vote IS NOT NULL
GROUP BY verified;

/* Do verified users write longer reviews - based on avg. of review text length */
/* LOOKS LIKE PEOPLE WRITE MORE WHEN THEY ARE ANONYMOUS */
SELECT verified, AVG(LEN(reviewtext)) FROM fashion_reviews
GROUP BY verified;


/* Do unverified users write more for lower ratings? */
SELECT overall, AVG(LEN(reviewtext)) avg_len_of_review FROM fashion_reviews WHERE verified is FALSE
GROUP BY overall;

/* Do verified users write detailed reviews for 5 star ratings? */
SELECT overall, AVG(LEN(reviewtext)) avg_len_of_review FROM fashion_reviews WHERE verified is TRUE
GROUP BY overall;


