WITH mensual AS (
    SELECT
        DATE_TRUNC('month', nsfs.date_key )::date AS mes,
        SUM(nsfs.monto_venta)                 AS ingresos,
        COUNT(*)                         AS transacciones
    FROM nfc_sales_facts_sql nsfs 
    GROUP BY 1
)
SELECT
    mes,
    ROUND(ingresos::numeric, 2)                          AS ingresos,
    transacciones,
    ROUND(LAG(ingresos) OVER (ORDER BY mes)::numeric, 2) AS ingresos_mes_anterior,
   ROUND((
    100.0 * (ingresos - LAG(ingresos) OVER (ORDER BY mes))
    / NULLIF(LAG(ingresos) OVER (ORDER BY mes), 0)
)::numeric, 2) AS crecimiento_pct                                      
FROM mensual
ORDER BY mes
;
