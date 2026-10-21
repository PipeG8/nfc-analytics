WITH mensual AS (
    SELECT
        DATE_TRUNC('month', date_key)::date AS mes,
        SUM(monto_venta)::numeric           AS ingresos
    FROM nfc_sales_facts_sql
    GROUP BY 1
),
con_crecimiento AS (
    SELECT
        mes,
        ingresos,
        100.0 * (ingresos - LAG(ingresos) OVER (ORDER BY mes))
        / NULLIF(LAG(ingresos) OVER (ORDER BY mes), 0) AS crecimiento_pct
    FROM mensual
)
SELECT ROUND(AVG(crecimiento_pct), 2) AS crecimiento_promedio_mensual_pct
FROM con_crecimiento;