# NFC Analytics Dashboard 📊

## Descripción

Análisis completo de un negocio de accesorios NFC usando Python, SQL y Power BI.
**Datos sintéticos generados para propósitos de portafolio.**

## 📋 Contenido del Proyecto

- **Generador de datos:** Script Python que crea dataset realista
- **Análisis exploratorio:** Pandas + visualizaciones
- **Queries SQL:** Análisis profundo con SQL
- **Dashboard:** Power BI con insights interactivos

## 🔧 Tecnologías

- **Python 3.9+** (Pandas, NumPy, Matplotlib)
- **SQL** (postgresql)
- **Power BI**
- **Git + GitHub**

## 📊 Dataset

- **Período:** Enero 2023 - Junio 2024
- **Transacciones:** 380
- **Productos:** 5 tipos de accesorios NFC
- **Canales:** Instagram, TikTok, Facebook, etc.
- **Ciudades:** Principales ciudades de Colombia

### Estadísticas Generales

- Ingresos totales: $18,500 COP
- Ticket promedio: $48.68
- Margen promedio: 62%

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

### 4. Abrir dashboard
Abre `nfc_dashboard.pbix` en Power BI



## 📈 Insights Principales

El 80% de las ventas se concentra en Bogota, Medellin y cali, siendo Bogota la que mas vende con 6797.25$ correspondiente al 36.86%

Nuestros 3 productos mas vendidos son pulsera NFC, Pack 3 pulseras, brazalete Premium las cuales corresponden al 77.93% de las ventas, donde las pulseras NFC plus son el producto mas vendido con un 31,12% del total de las ventas

El dia de la semana que mas se vende es el lunes con un promedio de ventas de diarias de 55$

el ingreso promedio mensual es de 1540$ y el promedio de venta diario es 34.21$

El 70.79% de las transacciones son tienen como origen instagram,TikTok y facebook, siendo instagrma el que mas clientes atrae con un 33% de las transacciones 

## 👨‍💻 Autor

Ing. Felipe Guzman Chaves
Analista de datos | Ingeniero Químico | Emprendedor

## 📝 Notas

Este es un proyecto educativo usando datos sintéticos generados con Python.
Ideal para portafolio en búsqueda de roles de Data Analyst.

---
**Última actualización:** septiemebre 2026