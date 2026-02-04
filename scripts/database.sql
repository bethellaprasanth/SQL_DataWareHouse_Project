----CREATE DATABASE----

/*This repository contains SQL scripts for building the DataWarehouse using a Bronze, Silver, Gold schema design. The structure separates raw ingestion, cleaned transformations, and business-ready models to support reliable analytics and reporting.
    Bronze → Raw source data as-is
    Silver → Cleaned and standardized data
    Gold → Star schema for reporting and dashboards
These scripts can be executed in sequence to recreate the full warehouse structure from scratch for development, testing, or deployment.*/

---SQL SCRIPT---

IF DB_ID('DataWarehouse') IS NOT NULL
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO

---CREATE DATABASE 'Datawarehouse'---

USE master;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas--
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


