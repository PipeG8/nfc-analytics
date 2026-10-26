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
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/nfc_analytics2.gif" alt="visulización y Despliegue del dashboard" width="400px">
</p>

### Estadísticas Generales

- Ingresos totales: ~$18,500 COP
- Ticket promedio: $48.68
- Margen promedio: 62%

## 📈 Insights Principales

El 80% de las ventas se concentra en Bogota, Medellin y cali, siendo Bogota la que mas vende con 6797.25$ correspondiente a ~36.86%   

Nuestros 3 productos mas vendidos son pulsera NFC, Pack 3 pulseras, brazalete Premium las cuales corresponden al 77.93% de las ventas, donde las pulseras NFC plus son el producto mas vendido con un 31,12% del total de las ventas

El 70.79% de las transacciones son tienen como origen instagram,TikTok y facebook, siendo instagrma el que mas clientes atrae con un 33% de las transacciones 

EL producto mas vendido es la pulsera NFC plus, la cual se vende principalmente a traves de instagram con un 34.54% de las transacciones para este producto. Esto nos permite evaluar que una campaña pulicitaria o descuentos en instagram puede traer un aumento en nuestras ventas.

Se evidencia que hay una disminución de las ventas de la empresa en un 24.95% entre el año 2023 y 2024 lo cual se da por la disminución transacciónes(14.50% menos) y un ticket promedio 12.20% mas bajo como se muestra en la siguiente tabla, el aumento de ventas y valor de ticket promedio permitira mejorar nuestro crecimiento. Se deberia revisar que productos cayeron y evaluar una campaña para recuperarlos

<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/comparativo_crecimiento_h1.png" alt="visulización y Despliegue del dashboard" width="400px">
</p>

El ingreso promedio mensual es de 1540$ y el promedio de venta diario es 34.21$

El martes es el día con mayor venta diaria promedio (~43$), seguido del lunes (~38$). Los más bajos son jueves y domingo (~30$). Hay 265 días sin ninguna venta en el período, así que el principal reto es la frecuencia: solo 4 de cada 7 días hay al menos una venta. Una campaña enfocada en jueves y domingo, o en activar ventas en los días vacíos, tiene más potencial que reforzar los días fuertes.


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

-revision_tamaño_tablas.sql
-cambiar_nombre_columna.sql
-crear_tabla_calendario.sql

Esquema base de datos 

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