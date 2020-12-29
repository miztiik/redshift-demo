/* CREATE  PRODUCE REVIEWS TABLE */
/*
######################################
#        FOR JSON SOURCE FILE        #
######################################
*/
CREATE TABLE IF NOT EXISTS product_reviews_json(
review_id           varchar(100)        not null    distkey sortkey,
product_id          varchar(100)        not null,
stars               varchar(10)         not null,
review_body         varchar(10000)      not null,
review_title        varchar(1000)       not null,
reviewer_id         varchar(100)        not null,
language            varchar(2)          not null,
product_category    varchar(100)        not null,
primary key(review_id)
);


/*
#########################################
#        FOR PARQUET SOURCE FILE        #
#########################################
*/

/* For parquet - the field id should match the table columns creation order */

CREATE TABLE IF NOT EXISTS product_reviews_parquet(
language            varchar(20)          not null,
product_category    varchar(1000)        not null,
product_id          varchar(1000)        not null,
review_body         varchar(50000)       not null,
review_id           varchar(1000)        not null    distkey sortkey,
review_title        varchar(10000)       not null,
reviewer_id         varchar(1000)        not null,
stars               varchar(100)         not null,
primary key(review_id)
);


/* 
ADD additional column later if needed
*/
ALTER TABLE product_reviews_json
ADD column reviewer_id varchar(100);



/*
######################################
#        FASHION REVIEW TABLE        #
######################################

SAMPLE DATA

{
  "overall": 5,
  "verified": true,
  "reviewTime": "10 20, 2014",
  "reviewerID": "A1D4G1SNUZWQOT",
  "asin": "7106116521",
  "reviewerName": "Tracy",
  "reviewText": "Exactly what I needed.",
  "summary": "perfect replacements!!",
  "unixReviewTime": 1413763200
}

*/

DROP TABLE public.fashion_reviews;

CREATE TABLE IF NOT EXISTS fashion_reviews(
overall             varchar(10),
vote                varchar(10),
verified            boolean default false,
style               varchar(100),
reviewTime          varchar(15),
reviewerID          varchar(20) distkey sortkey,
reviewerName        varchar(100),
asin                varchar(100),
reviewText          varchar(10000),
summary             varchar(1000),
unixReviewTime      varchar(100)
);


/* 
ADD additional column later if needed
*/
ALTER TABLE fashion_reviews
ADD column vote varchar(10);



