/*
LOAD ALL FILES IN S3 PREFIX
*/
/*
######################################
#        FOR JSON SOURCE FILE        #
######################################
*/
COPY product_reviews_json
FROM 's3://YOUR-S3-BUCKET/amzn_reviews_en.json' 
IAM_ROLE 'YOUR-REDSHIFT-CLUSTER-IAM-ROLE-ARN'
json 'auto ignorecase';



/*
#########################################
#        FOR PARQUET SOURCE FILE        #
#########################################
*/
COPY product_reviews_parquet
FROM 's3://YOUR-S3-BUCKET/amzn_reviews_en_part00000.parquet.snappy' 
IAM_ROLE 'YOUR-REDSHIFT-CLUSTER-IAM-ROLE-ARN'
FORMAT AS PARQUET;


/* COUNT FOR ALL RECORDS */
SELECT COUNT(*)
FROM product_reviews_json;

SELECT COUNT(*)
FROM product_reviews_parquet;


/*
LOAD ONLY ONE FILE
*/
copy product_reviews
from 's3://YOUR-S3-BUCKET/500_lines_per_file/amzn_reviews_en_0500.json' 
iam_role 'YOUR-REDSHIFT-CLUSTER-IAM-ROLE-ARN'
json 'auto ignorecase' ;



/* FASHION REVIEW */

COPY fashion_reviews
FROM 's3://raw-data-bkt-010/amzn_fashion_reviews/AMAZON_FASHION.json.gz' 
iam_role 'YOUR-REDSHIFT-CLUSTER-IAM-ROLE-ARN'
json 'auto ignorecase' 
GZIP ACCEPTINVCHARS TRUNCATECOLUMNS TRIMBLANKS;