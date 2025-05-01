IF OBJECT_ID('silver_crm_sale', 'U') IS NOT NULL
	DROP TABLE silver_crm_sale;
GO

CREATE TABLE silver_crm_sale (
	sls_date NVARCHAR(50),
	sls_year INT,
	sls_model NVARCHAR(50),
	sls_revenue INT,
	sls_quantity_sold INT,
	sls_region NVARCHAR(50),
	sls_country NVARCHAR(50),
	sls_channel NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

INSERT INTO silver_crm_sale (sls_date, sls_year, sls_model, sls_revenue, sls_quantity_sold, sls_region,sls_country, sls_channel)
SELECT sls_date, sls_year, sls_model, sls_revenue, sls_quantity_sold, sls_region,sls_country, sls_channel FROM bronze_crm_sale
