CREATE OR ALTER PROCEDURE bronze.usp_load_bronze_all
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        --------------------------------------------------
        -- ========== CRM FILES ==========
        --------------------------------------------------

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\SQL\SQL WITH BAARA\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );


        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'D:\SQL\SQL WITH BAARA\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );


        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'D:\SQL\SQL WITH BAARA\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );


        --------------------------------------------------
        -- ========== ERP FILES (REAL NAMES) ==========
        --------------------------------------------------

        TRUNCATE TABLE bronze.erp_cust;

        BULK INSERT bronze.erp_cust
        FROM 'D:\SQL\SQL WITH BAARA\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );


        TRUNCATE TABLE bronze.erp_location;

        BULK INSERT bronze.erp_location
        FROM 'D:\SQL\SQL WITH BAARA\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );


        TRUNCATE TABLE bronze.erp_category;

        BULK INSERT bronze.erp_category
        FROM 'D:\SQL\SQL WITH BAARA\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT 'Bronze Layer Load Completed Successfully';

    END TRY
    BEGIN CATCH
        PRINT 'Error Occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
