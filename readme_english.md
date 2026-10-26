# NFC Analytics Dashboard 📊

## Description

A comprehensive analysis of an NFC accessories business using Python, SQL, and Power BI. The objective of this project is to determine the company's current performance and identify actions that can be taken to improve it based on those findings.
**Synthetic data generated for portfolio purposes.**

## 📋 Project Structure

- **Data Generator:** Python script to create a realistic dataset.
- **Exploratory Data Analysis (EDA):** Pandas + visual representations.
- **SQL Queries:** Deep-dive analysis using SQL.
- **Dashboard:** Interactive insights created with Power BI.
- **Cloude** for structure revision and guidance 

## 🔧 Tech Stack

- **Python 3.9+** (Pandas, NumPy, Matplotlib)
- **SQL** (PostgreSQL)
- **Power BI**
- **Git + GitHub**
- **Cloude**

## 📊 Dataset Overview

- **Timeframe:** January 2023 - June 2024
- **Transactions:** 380
- **Products:** 5 types of NFC accessories
- **Acquisition Channels:** Instagram, TikTok, Facebook, etc.
- **Locations:** Major cities in Colombia

<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/nfc-analytics3.gif" alt="Dashboard Visualization and Deployment" width="400px">
</p>

### Key Statistics

- **Total Revenue:** ~$18,500 USD/COP
- **Average Order Value (AOV):** $48.68
- **Average Profit Margin:** 62%

## 📈 Key Insights

- **Geographic Concentration:** 80% of sales are concentrated in Bogotá, Medellín, and Cali. Bogotá leads performance with $6,797.25, accounting for ~36.86% of total revenue.
- **Top Products:** The top 3 selling products are the NFC Wristband, Pack of 3 Wristbands, and Premium Bracelet, representing 77.93% of overall sales. The **NFC Plus Wristband** is the single best-selling item, generating 31.12% of total sales.
- **Acquisition Channels:** 70.79% of transactions originate from Instagram, TikTok, and Facebook. Instagram is the primary driver, attracting 33% of total transactions.
- **Product-Channel Synergy:** The best-selling NFC Plus Wristband is primarily acquired via Instagram (34.54% of its transaction volume). Targeted promotional campaigns or discounts on Instagram present a clear opportunity for revenue growth.
- **YoY Growth Analysis:** A 24.95% sales decline was observed between H1 2023 and H1 2024. This trend was driven by a drop in total transactions (-14.50%) and a lower Average Order Value (-12.20%), as outlined in the summary comparison table. Evaluating declining product lines and launching recovery campaigns will be vital to restoring momentum.

<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/comparativo_crecimiento_h1.png" alt="H1 Growth Comparison" width="400px">
</p>

- **Sales Velocity:** Average monthly revenue stands at $1,540, with an average daily sales figure of $34.21.
- **Sales Cadence & Seasonality:** Tuesday records the highest average daily sales (~$43), closely followed by Monday (~$38). Thursday and Sunday record the lowest (~$30). Significantly, there were 265 zero-sales days throughout the analyzed timeframe—highlighting consistency as the core challenge (sales occur on only 4 out of 7 days on average). Targeted activation campaigns on Thursdays, Sundays, or non-active days offer higher growth potential than doubling down on peak days.

## 🚀 How to Run the Project

### 1. Data Generation
Generate the initial synthetic dataset:
```bash
python scripts/generate_data.py
```
This generates `data/nfc_sales_synthetic.csv`.

### 2. Exploratory Data Analysis & Preprocessing
Run the analysis notebook:
```bash
data_preprocessing.ipynb
```
This step handles data cleaning, standardization, and initial statistical analysis, producing the cleaned CSV files used to populate the SQL database.

### 3. Database Setup (SQL)
Set up the PostgreSQL relational database, including Primary and Foreign Keys, relational constraints, and a dedicated Calendar dimension table.

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

**Database Schema:**

<p align="center">
  <img src="https://github.com/PipeG8/nfc-analytics/blob/main/imagenes%20y%20videos/esquema_bd_sql.png" alt="Database Schema View" width="400px">
</p>

### 4. Interactive Dashboard
Open `nfc_dashboard.pbix` in Power BI Desktop to interact with the visualizations and analytical models.

## 👨‍💻 Author

**Ing. Felipe Guzman Chaves**  
Data Analyst | Chemical Engineer | Entrepreneur  

## 📝 Notes

This is an educational data project built with synthetic data generated via Python. Designed to showcase end-to-end data analytics capabilities for Data Analyst roles.

---
**Last Updated:** September 2026