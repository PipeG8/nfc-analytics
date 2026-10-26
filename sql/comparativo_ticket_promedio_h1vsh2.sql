SELECT
    CASE WHEN date_key < '2023-08-01' THEN 'Ene-Jul 2023'
         ELSE 'Ago 2023-Jun 2024' END                          AS periodo,
    COUNT(*)                                                   AS transacciones,
    ROUND(SUM(monto_venta)::numeric, 2)                        AS ingresos,
    ROUND(AVG(monto_venta)::numeric, 2)                        AS ticket_promedio,
    ROUND((SUM(monto_venta)
           / COUNT(DISTINCT DATE_TRUNC('month', date_key)))::numeric, 2) AS ingreso_mensual
FROM nfc_sales_facts_sql
GROUP BY 1
ORDER BY 1;