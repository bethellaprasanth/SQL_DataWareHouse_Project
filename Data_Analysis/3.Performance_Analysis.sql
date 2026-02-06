/* Analyse the yearly performance of products 
by comparing  each product's sales to both its 
average sales performance and the previous year sales */

select
Order_Year,
Product_Name,
Total_Sales,
AVG(Total_Sales) OVER(PARTITION BY Product_Name) as Product_Avg_Sales,
LAG(Total_Sales) over(PARTITION BY Product_Name order by Order_Year) as Prev_Sales,
Total_Sales - (AVG(Total_Sales) OVER(PARTITION BY Product_Name)) as AvgDiff,
CASE 
	WHEN Total_Sales - (AVG(Total_Sales) OVER(PARTITION BY Product_Name)) > 0 THEN 'Above Avg'
	when Total_Sales - (AVG(Total_Sales) OVER(PARTITION BY Product_Name)) <0 then 'Below Avg'
	else 'Avg'
end as Segment,
Total_Sales - (LAG(Total_Sales) over(PARTITION BY Product_Name order by Order_Year)) as YearSalesDiff,
CASE 
	WHEN Total_Sales - (LAG(Total_Sales) over(PARTITION BY Product_Name order by Order_Year)) > 0 THEN 'Increased'
	when Total_Sales - (LAG(Total_Sales) over(PARTITION BY Product_Name order by Order_Year)) <0 then 'Decreased'
	else 'No Change'
end as PyChange
from
(SELECT 
YEAR(s.Order_dt) as Order_Year,
p.Product_Name,
sum(s.Sales) as Total_Sales
FROM gold.fact_sales s
left join 
gold.dim_products p
on s.Product_key = p.Product_key
WHERE Order_dt is not null
group by YEAR(s.Order_dt),p.Product_Name)t;