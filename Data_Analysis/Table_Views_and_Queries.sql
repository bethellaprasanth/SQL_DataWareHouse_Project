---------BRONZE LAYER------------------
---------crm and erp-------------------
SELECT * FROM bronze.crm_cust_info;
SELECT * FROM bronze.crm_prd_info;
SELECT * FROM bronze.crm_sales_details;

SELECT * FROM bronze.erp_cust;
SELECT * FROM bronze.erp_location;
SELECT * FROM bronze.erp_category;
--------------------------------------

---------SILVER LAYER-----------------
---------crm and erp------------------

SELECT * from silver.crm_cust_info;
SELECT * FROM silver.crm_prd_info;
SELECT * FROM silver.crm_sales_details;

SELECT * FROM silver.erp_cust;
SELECT * FROM silver.erp_location;
SELECT * FROM silver.erp_category;
--------------------------------------

-----STORED PROCEDURES----------------
-----BRONZE, SILVER, GOLD-------------
---------crm and erp------------------

EXEC bronze.usp_load_bronze_all
EXEC silver.load_silver

---------GOLD LAYER - VIEWS-------------------
---------crm and erp------------------

select * from gold.dim_customers;
select * from gold.dim_products;
select * from gold.fact_sales;
select * from gold.customer_report;
select * from gold.product_report;

-----


