/*Calculate Total Sales permonth and 
the cumulative total of sales over time*/

SELECT
	Order_Date,
	sales_amount,
	SUM(sales_amount) over(order by Order_Date asc) as cumulative_sales,
	AVG(sales_amount) over(order by Order_Date asc) as Moving_Average
FROM
	(SELECT
	DATETRUNC(YEAR,Order_dt) as Order_Date,
	sum(sales) as sales_amount,
	AVG(sales) as AVG_Sales
	FROM gold.fact_sales
	WHERE Order_dt IS NOT NULL
	group by DATETRUNC(YEAR,Order_dt))t;
