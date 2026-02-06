/*which category contributes most
to the overall sales*/

WITH CTE_Category_Sales as
(
select 
p.Category,
sum(s.Sales) as Total_Sales
from gold.fact_sales s
LEFT JOIN
gold.dim_products p
on s.Product_key = p.Product_key
GROUP BY P.Category),

CTE_PercentSales AS 
(SELECT
	Category,
	Total_Sales,
	SUM(Total_Sales) over() as Total_Cat_Sales,
	CONCAT(ROUND((CAST(Total_Sales AS FLOAT)/SUM(Total_Sales) over()),2) * 100,' ','%') as PercentSales
FROM CTE_Category_Sales)

SELECT
*,
RANK() over(order by PercentSales desc) as Best_Category
FROM CTE_PercentSales
