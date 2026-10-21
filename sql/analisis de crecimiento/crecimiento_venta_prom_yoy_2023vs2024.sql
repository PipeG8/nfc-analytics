WITH h1 AS (
    SELECT
        avg(monto_venta ) FILTER (WHERE date_key >= '2023-01-01' AND date_key < '2023-07-01')::numeric AS avg_venta_h1_2023,
        avg(monto_venta ) FILTER (WHERE date_key >= '2024-01-01' AND date_key < '2024-07-01')::numeric AS avg_venta_h1_2024
    FROM nfc_sales_facts_sql
)
SELECT
    ROUND(avg_venta_h1_2023 , 2) AS avg_venta_h1_2023,
    ROUND(avg_venta_h1_2024, 2) AS avg_venta_h1_2024,
    ROUND(100.0 * (avg_venta_h1_2024 - avg_venta_h1_2023) / avg_venta_h1_2023, 2) AS crecimiento_mean_venta_yoy_pct
FROM h1;