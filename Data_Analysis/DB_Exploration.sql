---EXPLORE ALL OBJECTS in the database----
SELECT * FROM INFORMATION_SCHEMA.TABLES;

---Explore All Columns in database-------
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

----Explore Dimensions------------------
SELECT DISTINCT Country FROM gold.dim_customers 

----Date Exploration-----
--Using MIN and MAX we can extract the earliest and latest dats--

select MIN(Order_dt) AS Fstorde,
MAX(Order_dt) as last_dt,
datediff(year,min(order_dt),max(order_dt)) as diff
from gold.fact_sales 