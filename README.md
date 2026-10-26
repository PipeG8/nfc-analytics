# NFC Analytics Dashboard 📊

## Descripción

Análisis completo de un negocio de accesorios NFC usando Python, SQL y Power BI.
**Datos sintéticos generados para propósitos de portafolio.**

## 📋 Contenido del Proyecto

- **Generador de datos:** Script Python que crea dataset realista
- **Análisis exploratorio:** Pandas + visualizaciones
- **Queries SQL:** Análisis profundo con SQL
- **Dashboard:** Power BI con insights interactivos
- **Cloude:** Uso de cloude para la revisión, diseño del proyecto y guia del proyecto 

## 🔧 Tecnologías

- **Python 3.9+** (Pandas, NumPy, Matplotlib)
- **SQL** (postgresql)
- **Power BI**
- **Git + GitHub**
- **Cloude**

## 📊 Dataset

- **Período:** Enero 2023 - Junio 2024
- **Transacciones:** 380
- **Productos:** 5 tipos de accesorios NFC
- **Canales:** Instagram, TikTok, Facebook, etc.
- **Ciudades:** Principales ciudades de Colombia
<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/nfc-analytics3.gif" alt="visulización y Despliegue del dashboard" width="400px">
</p>

### Estadísticas Generales

- Ingresos totales: ~$18,500 COP
- Ticket promedio: $48.68
- Margen promedio: 62%

## 📈 Insights Principales

EEl 80% de las ventas se concentra en Bogotá, Medellín y Cali, siendo Bogotá la que más vende con $6,797.25, lo que corresponde al ~36.86%.

Nuestros 3 productos más vendidos son la pulsera NFC, el Pack 3 pulseras y el brazalete Premium, los cuales corresponden al 77.93% de las ventas. Las pulseras NFC Plus son el producto más vendido con un 31.12% del total de las ventas.

El 70.79% de las transacciones tienen como origen Instagram, TikTok y Facebook, siendo Instagram la red que más clientes atrae con un 33% de las transacciones.

El producto más vendido es la pulsera NFC Plus, la cual se vende principalmente a través de Instagram con un 34.54% de las transacciones para este producto. Esto nos permite evaluar que una campaña publicitaria o de descuentos en Instagram puede generar un aumento en nuestras ventas.

Se evidencia una disminución en las ventas de la empresa del 24.95% entre los años 2023 y 2024, lo cual se debe a una reducción en las transacciones (14.50% menos) y a un ticket promedio 12.20% más bajo, como se muestra en la siguiente tabla. El aumento de las ventas y del valor del ticket promedio permitirá mejorar nuestro crecimiento. Se debería revisar qué productos cayeron y evaluar una campaña para recuperarlos.

<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/comparativo_crecimiento_h1.png" alt="visulización y Despliegue del dashboard" width="400px">
</p>

El ingreso promedio mensual es de $1,540 y el promedio de venta diario es de $34.21.

El martes es el día con mayor venta diaria promedio (~$43), seguido del lunes (~$38). Los valores más bajos se registran los jueves y domingos (~$30). Hay 265 días sin ninguna venta en el período, por lo que el principal reto es la frecuencia: solo 4 de cada 7 días se registra al menos una venta. Una campaña enfocada en jueves y domingo, o en activar ventas en los días vacíos, tiene más potencial que reforzar los días fuertes.

## 🚀 Cómo Usar

### 1. Generar datos
```bash
python scripts/generate_data.py
```

Esto crea `data/nfc_sales_synthetic.csv`

### 2. Análisis con Python (próximos pasos)
```bash
data_preprocessing.ipynb
```
En este paso se hace limpieza, estandarización de datos y analisis estadisticio inicial lo cual nos permite obtener nuestros archivos csv con los cuales se crea nuestra base de datos en SQL

### 3. Creación de base de datos en SQL 

Se crea la base de datos en postgresql incluyendo las llaves primarias y foraneas junto con nuestro esquema de base de datos, ademas se crea la dimensión o tabla calendario y se hace difentes consultas de prueba como se puede evidenciar en los archivos.

- sales_analysis.sql (analisis_ventas.sql)
- rename_column.sql (cambiar_nombre_columna.sql)
- average_ticket_comparison_h1_vs_h2.sql (comparativo_ticket_promedio_h1vsh2.sql)
- create_calendar_dimension.sql (crear_dim_calendario.sql)
- average_sales_by_city.sql (promedio_venta_ciudad.sql)
- check_table_sizes.sql (revision_tamaño_tablas.sql)
- check_foreign_keys.sql (revisión_de_llaves_foraneas.sql)
- total_sales_amount_by_product.sql (total_monto_venta_producto.sql)
- monthly_pct_growth.sql (creciemiento_pct_mensual.sql)
- period_to_period_growth.sql (creciemiento_entre_periodos.sql)
- average_monthly_growth.sql (creciemiento_mensual_avg.sql)
- total_growth_and_compound_growth_pct.sql (crecimiento_total_y_crecimiento_compuesto_pct.sql)
- yoy_average_sales_growth_2023_vs_2024.sql (crecimiento_venta_prom_yoy_2023vs2024.sql)

**Esquema base de datos:** 

<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/esquema_bd_sql.png" alt="visualización del esquema de  la base de datos en sql" width="400px">
</p>


### 4. Abrir dashboard
Abre `nfc_dashboard.pbix` en Power BI


## 👨‍💻 Autor

Ing. Felipe Guzman Chaves
Analista de datos | Ingeniero Químico | Emprendedor

## 📝 Notas

Este es un proyecto educativo usando datos sintéticos generados con Python.
Ideal para portafolio en búsqueda de roles de Data Analyst.

---
**Última actualización:** septiemebre 2026