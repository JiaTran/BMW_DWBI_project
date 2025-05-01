/* 
Stored Proceduce : Load Bronze Layer
*/
BULK INSERT bronze_crm_sale
FROM 'D:\BMW Files-20250501T172756Z-001\BMW Files\BMW_Sales_Data.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

DELETE * FROM bronze_crm_sale
WHERE LTRIM(RTRIM(sls_date)) = '' OR sls_date IS NULL;

UPDATE bronze_crm_sale
SET sls_date = TRY_CONVERT(date,
    RIGHT(sls_date, 4) + '-' +        -- Năm: 2023
    SUBSTRING(sls_date, 4, 2) + '-' + -- Tháng: 08
    LEFT(sls_date, 2),                -- Ngày: 15
    120);                             -- ISO format YYYY-MM-DD

ALTER TABLE bronze_crm_sale
ALTER COLUMN sls_date DATE;
