select datediff(s,starttime,endtime) as duration,
* 
from 
stl_query 
where query in (
    57991, /*  query id of json copy */
    58689  /*  query id of parquet copy */
);



/* */