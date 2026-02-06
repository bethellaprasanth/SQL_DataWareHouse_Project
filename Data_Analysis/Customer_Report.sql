/*Customer Report
Purpose:

This report consolidates key customer metrics and behaviors

Highlights:

----1.Gathers essential fields such as names, ages, and transaction details.
----2.Segments customers into categories (VIP, Regular, New) and age groups.
----3.Aggregates customer-level metrics:

		total orders
		total sales
		total quantity purchased
		total products
		lifespan (in months)
	
	4.Calculates valuable KPIs:
		retency (months since last order)
		average order value
		average monthly spend

=====================================================================
*/

/*
1. Retrive core columns from tables*/
CREATE VIEW gold.customer_report as
WITH CTE_base_query as(
SELECT 
	f.Order_Num,
	f.Product_key,
	f.Order_dt,
	f.Sales,
	f.Qunatity,
	c.customer_key,
	c.Customer_Num,
	CONCAT_WS(' ',c.First_Name,c.Last_Name) as Customer_Name,
	c.Gender,
	c.Country,
	DATEDIFF(YEAR,c.BirthDate,getdate()) as Age
FROM gold.fact_sales f
left join 
gold.dim_customers c
on f.customer_key = c.customer_key
WHERE F.Order_dt IS NOT NULL),

CTE_Customer_Aggregation as 
	(
	--Customer Aggregation---
	SELECT 
		customer_key,
		Customer_Num,
		Customer_Name,
		Age,
		COUNT( DISTINCT Order_Num) as Total_Orders,
		count(distinct Product_key) as total_products,
		sum(qunatity) as total_quantity,
		sum(sales) as total_sales,
		max(Order_dt) as Lastorder_dt,
		datediff(month,min(order_dt),max(order_dt)) as LifeSpan
	FROM CTE_base_query
	GROUP BY customer_key, Customer_Num, Customer_Name, Age
	)

SELECT 
customer_key,
Customer_Num,
Customer_Name,
Age,
CASE
	WHEN Age <20 then 'Under 20'
	when Age between 30 and 39 then '30-39'
	when Age between 40 and 49 then '40-49'
	else 'Above 50'
END AS Age_Group,
CASE 
    WHEN LifeSpan >= 12 AND total_sales >= 5000 THEN 'VIP'
    WHEN LifeSpan >= 12 AND total_sales < 5000 THEN 'Regular'
    ELSE 'New Customer'
END AS Customer_Type,
Total_Orders,
total_quantity,
total_products,
total_sales,
Lastorder_dt,
DATEDIFF(MONTH,Lastorder_dt,getdate()) as Recency,
LifeSpan,
---KPI'S----
case 
	when Total_sales = 0 THEN 0
	ELSE total_sales/Total_Orders
END as AvgOrderValue,
case 
	when Total_sales = 0 THEN 0
	ELSE total_sales/NULLIF(LifeSpan,0)
END as AVG_Monthly_Spend
FROM CTE_Customer_Aggregation

