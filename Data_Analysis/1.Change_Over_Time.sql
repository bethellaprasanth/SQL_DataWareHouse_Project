--Analyse Sales Performance Over Time--

SELECT 
	DATETRUNC(Month, Order_dt) AS Order_Year,
	sum(Sales) as Total_sales,
	count(distinct customer_key) as Total_Customers,
	sum(Qunatity) as Total_Qunatity
FROM gold.fact_sales
WHERE Order_dt is not null
group by DATETRUNC(Month, Order_dt)
order by DATETRUNC(Month, Order_dt)