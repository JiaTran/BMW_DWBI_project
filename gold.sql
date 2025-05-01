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

CREATE TABLE dim_date (
	date_id INT IDENTITY(1,1) PRIMARY KEY,
	time_date DATE,
	time_year INT,
	time_month VARCHAR(10),
	time_monthnum INT,
	time_weekday VARCHAR(10),
	time_weeknum INT,
	time_qtr VARCHAR(5),
	time_weektype VARCHAR(10)
);
/* dim_date */
INSERT INTO dim_date ( time_date, time_year, time_month, time_monthnum, time_weekday, time_weeknum, time_qtr, time_weektype)
SELECT DISTINCT
	s.sls_date AS Date,
    YEAR(s.sls_date) AS time_year,
    DATENAME(MONTH, s.sls_date) AS time_month,
    MONTH(s.sls_date) AS Monthnum,
    DATENAME(WEEKDAY, s.sls_date) AS time_weekday,
    DATEPART(WEEK, s.sls_date) AS time_weeknum,
    'Q-' + CAST(DATEPART(QUARTER, s.sls_date) AS VARCHAR(1)) AS time_qtr,
    CASE 
        WHEN DATEPART(WEEKDAY, s.sls_date) IN (1, 7) THEN 'weekend'
        ELSE 'weekday'
    END AS WeekType
FROM silver_crm_sale s
ORDER BY s.sls_date;

/* fact table */
CREATE TABLE fact_table (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    channel_id INT,
    country_id INT,
    date_id INT,
    model_id INT,
    quantity_sold INT,
    revenue DECIMAL(18,2),
    tm_Year INT,
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (model_id) REFERENCES dim_model(model_id)
);

INSERT INTO fact_table (channel_id, country_id, date_id, model_id, quantity_sold, revenue, tm_Year)
SELECT 
    dc.channel_id,
    dco.country_id,
    dd.date_id,
    dm.model_id,
    s.sls_quantity_sold,
    s.sls_revenue,
    s.sls_year
FROM silver_crm_sale s
JOIN dim_channel dc ON s.sls_channel = dc.channel
JOIN dim_country dco ON s.sls_country = dco.country AND s.sls_region = dco.region
JOIN dim_date dd ON s.sls_date = dd.time_date
JOIN dim_model dm ON s.sls_model = dm.model;
