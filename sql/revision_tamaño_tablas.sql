-- Ver todas las tablas en la BD
SELECT 
    'DIM_PRODUCTOS' as tabla, COUNT(*) as registros FROM dim_producto
UNION ALL
SELECT 'DIM_CIUDADES', COUNT(*) FROM dim_ciudad
UNION ALL
SELECT 'DIM_CANALES', COUNT(*) FROM dim_canal
UNION ALL 
select 'DIM_CALENDAR', count(*) FROM  dim_calendar
UNION ALL
SELECT 'FACT_VENTAS', COUNT(*) FROM nfc_sales_facts_sql nsfs 
ORDER BY tabla;