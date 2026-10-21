WITH mensual AS (
    SELECT
        DATE_TRUNC('month', date_key)::date AS mes,
        SUM(monto_venta)::numeric           AS ingresos
    FROM nfc_sales_facts_sql
    GROUP BY 1
),
extremos AS (
    SELECT
        (SELECT ingresos FROM mensual ORDER BY mes ASC  LIMIT 1) AS primero,
        (SELECT ingresos FROM mensual ORDER BY mes DESC LIMIT 1) AS ultimo,
        (SELECT COUNT(*) FROM mensual)                           AS num_meses
)
SELECT
    ROUND(100.0 * (ultimo - primero) / primero, 2) AS crecimiento_total_pct,
    ROUND(100.0 * (POWER(ultimo / primero, 1.0 / (num_meses - 1)) - 1), 2)
                                                   AS crecimiento_compuesto_mensual_pct
FROM extremos;