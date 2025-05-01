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

/* images */
CREATE TABLE image (
	model NVARCHAR(50),
	img NVARCHAR(1000)
);
BULK INSERT image
FROM 'D:\BMW Files-20250501T172756Z-001\BMW Files\Car_Images.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

// flag
CREATE TABLE flag (
	country NVARCHAR(50),
	country_code NVARCHAR(50),
	region NVARCHAR(50),
	flag NVARCHAR(500)
);
BULK INSERT flag
FROM 'D:\BMW Files-20250501T172756Z-001\BMW Files\Flags_URL.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
