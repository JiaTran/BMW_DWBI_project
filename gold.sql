CREATE TABLE dim_country (
	country_id INT IDENTITY(1,1) PRIMARY KEY,
	country VARCHAR(50),
	region VARCHAR(50),
)

INSERT INTO dim_country (country, region)
SELECT DISTINCT sls_country, sls_region FROM silver_crm_sale

SELECT * FROM dim_country

/* dim_model */
CREATE TABLE dim_model (
	model_id INT IDENTITY(1,1) PRIMARY KEY,
	model VARCHAR(50),
)

INSERT INTO dim_model(model)
SELECT DISTINCT sls_model FROM silver_crm_sale

/* dim_channel */
CREATE TABLE dim_channel (
	channel_id INT IDENTITY(1,1) PRIMARY KEY,
	channel VARCHAR(50),
)

INSERT INTO dim_channel(channel)
SELECT DISTINCT sls_channel FROM silver_crm_sale
