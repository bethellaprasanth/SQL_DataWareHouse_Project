--Generate a report that shows all metrics---
select 'Total Sales' as Measure_Name, sum(Sales) as Measure_value
from gold.fact_sales
UNION ALL
select 'Total Quantity' as Measure_Name, sum(Qunatity) as Measure_value
from gold.fact_sales
union all
select 'AverageSP' as Measure_Name, AVG(Sales) as Measure_value
from gold.fact_sales
union all
select 'Total Orders' as Measure_Name, count(DISTINCT Order_num) as Measure_value
from gold.fact_sales
union all
select 'Total Customers' as Measure_Name, count(DISTINCT customer_key) as Measure_value
from gold.dim_customers
union all
select 'Total Products' as Measure_Name, count(DISTINCT Product_ID) as Measure_value
from gold.dim_products









