#cargar datos a sql
import pandas as pd
import sqlite3

# Cargar CSV
df = pd.read_csv('data/nfc_sales_Facts_sql.csv')

# Conectar a SQLite (crea la BD si no existe)
conexion = sqlite3.connect('nfc_analytics.db')

# Cargar dataframe a la BD
df.to_sql('nfc_sales_Facts_sql', conexion, if_exists='replace', index=False)
#         ↑ nombre tabla       ↑ conexión  ↑ opción     ↑ sin índice

conexion.close()

print("✅ Datos cargados a SQLite")