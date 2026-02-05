#  SQL Data Warehouse Project — End-to-End Bronze, Silver, Gold Architecture

## Project Overview

This project demonstrates the complete lifecycle of building a **Data Warehouse using SQL Server**, transforming raw CRM and ERP source files into an **analytics-ready Star Schema model** using a structured **Bronze → Silver → Gold** layered architecture.

It covers requirement analysis, architecture design, ETL pipeline creation, data cleansing, dimensional modeling, documentation, and Git-based project organization — mirroring real Data Engineering workflows.

---

## What This Project Proves

- Ability to design Data Warehouse architecture from scratch
- Building ETL pipelines using stored procedures
- Data cleansing, validation, and transformation logic
- Handling Slowly Changing Dimensions (SCD)
- Creating dimensional models for reporting
- Integrating multiple source systems (CRM + ERP)
- Maintaining professional documentation (Data Catalog, Diagrams)
- Organizing a project using Git best practices

---

## Data Warehouse Architecture

| Layer | Purpose | Object Type | Key Activities |
|------|---------|-------------|----------------|
| **Bronze** | Raw ingestion | Tables | Bulk load, no transformations |
| **Silver** | Cleaned & standardized | Tables | Data cleansing, normalization, derived columns |
| **Gold** | Business ready | Views | Star schema, aggregations, business logic |

<img src="docs/images/data-architecture.png" width="900"/>
---

## Bronze Layer — Raw Data

- Direct CSV ingestion from CRM and ERP
- No data type enforcement
- Full fidelity to source data
- Batch load using `BULK INSERT`

---

## Silver Layer — Data Cleansing & Standardization

### Key Transformations

- Customer deduplication using latest record
- Gender, marital status, and country standardization
- Date validation and correction
- Derived `cat_id` and `prd_key`
- SCD handling for product lifecycle
- Sales and price correction rules

---
## Gold Layer — Analytical Model

-Surrogate keys using ROW_NUMBER()
-Customer and product dimensions enriched with ERP data
-Sales fact linked via surrogate keys
-Optimized for reporting and BI tools

## Data Flow

Data moves from:

```
CRM & ERP CSV Sources → Bronze Tables → Silver Transformations → Gold Analytical Model
```
<img src="docs/images/data-flow.png" width="900"/>
---

## Integration Model (CRM + ERP)

Customer, product, and category data from different systems are integrated and standardized before dimensional modeling.

<img src="docs/images/integration-model.png" width="900"/>
---

## Star Schema Model (Gold Layer)

- `dim_customers`
- `dim_products`
- `fact_sales`

Designed for BI tools and analytical querying.

<img src="docs/images/star-schema.png" width="900"/>
---

## Key Stored Procedures

| Procedure | Purpose |
|-----------|---------|
| `bronze.usp_load_bronze_all` | Loads CRM & ERP CSV files into Bronze layer |
| `silver.load_silver` | Cleans, transforms, and loads Silver tables |
| Gold Views | Creates dimensional model for reporting |

---

## Technologies Used

- SQL Server
- T-SQL Stored Procedures
- Dimensional Modeling (Star Schema)
- Git & GitHub
- Data Catalog Documentation

---

## Challenges Solved

- CSV bulk load format and datatype mismatches
- Inconsistent date formats from source files
- Mapping keys across CRM and ERP systems
- Handling dirty and missing data
- Designing reusable ETL procedures
- Performance optimization for joins

---

## Why This Project Matters

This project demonstrates the ability to design and implement a complete Data Warehouse solution end-to-end — from raw data ingestion to analytics-ready dimensional models — following real industry data engineering practices rather than isolated SQL scripting.
---

## 👤 Designed & Implemented By

**Prasanth**  
Data Analyst | Data Warehousing | ETL Developer
