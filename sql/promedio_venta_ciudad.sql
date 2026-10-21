select 
dci.nombre_ciudad as ciudad,
sum(nsfs.monto_venta)/count(nsfs.id_venta ) as promedio_ciudad
from nfc_sales_facts_sql nsfs 
	inner   join dim_ciudad dci  on dci.id_ciudad =nsfs.id_ciudad  
group by dci.nombre_ciudad 