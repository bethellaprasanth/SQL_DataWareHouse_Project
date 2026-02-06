/* Group Customers into Three segments based on their spending behaviour
	-VIP with atleast 12 months of history and spending more than 5000
	-Regular with atleast 12 months of history and spending less than 5000
	-New Customer below 12 months of history
 and find the Total Number of customers in each group*/

WITH CTE_Total_Sales AS
(
    SELECT 
        s.customer_key,
        SUM(s.Sales) AS Total_sales
    FROM gold.fact_sales s
    GROUP BY s.customer_key
),

CTE_No_Of_Months AS
(
    SELECT
        s.customer_key,
        DATEDIFF(month, MIN(s.Order_dt), MAX(s.Order_dt)) AS No_ofMonths
    FROM gold.fact_sales s
    WHERE s.Order_dt IS NOT NULL
    GROUP BY s.customer_key
),

CTE_Customer_Segment AS
(
    SELECT
        CASE 
            WHEN n.No_ofMonths >= 12 AND t.Total_sales >= 5000 THEN 'VIP'
            WHEN n.No_ofMonths >= 12 AND t.Total_sales < 5000 THEN 'Regular'
            ELSE 'New Customer'
        END AS Customer_Type
    FROM CTE_Total_Sales t
    JOIN CTE_No_Of_Months n
        ON n.customer_key = t.customer_key
)

SELECT 
    Customer_Type,
    COUNT(*) AS Total_Customers
FROM CTE_Customer_Segment
GROUP BY Customer_Type;
