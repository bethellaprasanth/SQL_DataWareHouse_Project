/* 
=====================================================================
Product Report
=====================================================================

Purpose:
- This report consolidates key product metrics and behaviors.

Highlights:

1. Gathers essential fields such as product name, category, subcategory, and cost.
--2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
3. Aggregates product-level metrics:
   - total orders
   - total sales
   - total quantity sold
   - total customers (unique)
   - lifespan (in months)

---4. Calculates valuable KPIs:
   - recency (months since last sale)
   - average order revenue (AOR)
   - average monthly revenue

=====================================================================
*/
WITH CTE_KeyColumns as 
(
select
	f.Order_Num,
	f.Order_dt,
	f.customer_key,
	p.Product_key,
	f.Sales,
	f.Qunatity as Quantity,
	f.Price,
	p.Product_Name,
	p.Category,
	p.Sub_Category,
	p.Cost,
	p.Start_dt
from gold.fact_sales f
left join
gold.dim_products p
on f.Product_key = p.Product_key
),
/*2. Segments products by revenue to identify High-Performers, 
Mid-Range, or Low-Performers.*/
CTE_Product_Aggregations as 
(
SELECT 
	Product_key,
	Product_Name,
	Category,
	Sub_Category,
	Cost,
	Price,
	DATEDIFF(MONTH,MIN(Order_dt),max(Order_dt)) as LifeSpan,
	count(distinct customer_key) as total_customers,
	sum(Quantity) as total_orders,
	sum(Sales) as Revenue,
	avg(Price) as AVG_Price
from CTE_KeyColumns
GROUP BY 	Product_key, Product_Name, Category, Sub_Category, Cost,Price)

---4. Calculates valuable KPIs:
   -- recency (months since last sale)
   --average order revenue (AOR)
   --average monthly revenue

select
	Product_key,
	Product_Name,
	Category,
	Sub_Category,
	total_customers
	LifeSpan,
	Cost,
	AVG_Price
	total_orders,
	Revenue,
	CASE
		WHEN Revenue = 0 THEN 0
		ELSE Revenue/total_orders
	end as AVG_RevenueByOrder,
	CASE
		WHEN Revenue = 0 then 0
		WHEN LifeSpan = 0 then Revenue
		else Revenue/NULLIF(LifeSpan,0)
	end as AVG_MonthlyRevenue,
	CASE 
		WHEN Revenue < 500000 then 'Low Performer'
		WHEN Revenue < 1000000 then 'Medium Performer'
		else 'High Performer'
	end as ProductPerformance
from CTE_Product_Aggregations