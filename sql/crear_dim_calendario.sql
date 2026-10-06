  
--1. Crear la tabla física
CREATE TABLE dim_calendar AS
WITH bounds AS (
    -- Obtener la fecha mínima y máxima de la tabla de hechos
    SELECT 
        MIN(date_key)::date AS min_date,
        MAX(date_key)::date AS max_date
    FROM nfc_sales_facts_sql
),
date_series AS (
    -- Generar la serie de días entre la fecha mínima y máxima
    SELECT 
        generate_series(min_date, max_date, interval '1 day')::date AS date_key
    FROM bounds
)
SELECT
    date_key,
    EXTRACT(YEAR FROM date_key)::integer AS year,
    EXTRACT(QUARTER FROM date_key)::integer AS quarter,
    EXTRACT(MONTH FROM date_key)::integer AS month,
    TO_CHAR(date_key, 'Month') AS month_name,
    EXTRACT(DAY FROM date_key)::integer AS day_of_month,
    EXTRACT(ISODOW FROM date_key)::integer AS day_of_week, -- 1 = Lunes, 7 = Domingo
    TO_CHAR(date_key, 'Day') AS day_name,
    EXTRACT(WEEK FROM date_key)::integer AS week_of_year,
    CASE WHEN EXTRACT(ISODOW FROM date_key) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend
FROM date_series;


