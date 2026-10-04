import pandas as pd
from sqlalchemy import create_engine

print(sqlalchemy.__version__)
# Cargar CSV
df = pd.read_csv('data/nfc_sales_Facts_sql.csv')

# Conexión a PostgreSQL
engine = create_engine(
    'postgresql+psycopg2://postgres:Pipe1234@localhost:5432/nfc_analytics'
)

# Cargar datos
df.to_sql(
    'nfc_sales_facts',
    engine,
    if_exists='replace',
    index=False
)

print("✅ Datos cargados a PostgreSQL")