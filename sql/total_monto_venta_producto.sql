select 
dp.nombre_producto as nombre_producto,
sum(nsfs.monto_venta) as total_ventas
from nfc_sales_facts_sql nsfs 
inner join dim_producto dp on dp.id_producto = nsfs.id_producto 
group by dp.nombre_producto 
