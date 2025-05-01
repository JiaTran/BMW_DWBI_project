IF OBJECT_ID('bronze_crm_sale', 'U') IS NOT NULL
	DROP TABLE bronze_crm_sale;
GO

CREATE TABLE bronze_crm_sale (
	sls_date NVARCHAR(50),
	sls_year INT,
	sls_model NVARCHAR(50),
	sls_revenue INT,
	sls_quantity_sold INT,
	sls_region NVARCHAR(50),
	sls_country NVARCHAR(50),
	sls_channel NVARCHAR(50)
);
