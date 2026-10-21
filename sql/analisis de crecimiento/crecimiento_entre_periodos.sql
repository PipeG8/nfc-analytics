WITH h1 AS (
    SELECT
        SUM(monto_venta) FILTER (WHERE date_key >= '2023-01-01' AND date_key < '2023-07-01')::numeric AS h1_2023,
        SUM(monto_venta) FILTER (WHERE date_key >= '2024-01-01' AND date_key < '2024-07-01')::numeric AS h1_2024
    FROM nfc_sales_facts_sql
)
SELECT
    ROUND(h1_2023, 2) AS h1_2023,
    ROUND(h1_2024, 2) AS h1_2024,
    ROUND(100.0 * (h1_2024 - h1_2023) / h1_2023, 2) AS crecimiento_yoy_pct
FROM h1;