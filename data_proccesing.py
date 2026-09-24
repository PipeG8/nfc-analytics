## traer los paquetes o librerias 
import pandas as pd

#importar datos 

raw_data = pd.read_csv("data/nfc_sales_synthetic.csv")
#1.estructura e inspeccción
print(raw_data.head())
raw_data.info()
print(raw_data.shape)

#1.1 conversión de datos formato correcto de acuerdo con los resultados de raw_data.info donde se idenfica que no hay valores vacios en nuestra infomración
print("isna")
print(raw_data.isna().sum())
    #1.1 Conversión de fecha a objetct a tipo datetime
raw_data['fecha'] = pd.to_datetime(raw_data['fecha'])
print(raw_data['fecha'].dtype)

    #El formato de mes y año no es facil para algun tratamiento de datos  asi que se trasnforman en lo que se esta necestiando 
pre_proccessed_data=raw_data.drop('mes',axis=1)
pre_proccessed_data['año'] = raw_data['fecha'].dt.year


pre_proccessed_data['mes_numero'] = raw_data['fecha'].dt.month
print(len(pre_proccessed_data['mes_numero'].value_counts()))
print(len(pre_proccessed_data['semana'].value_counts()))

#revisión de duplicados 
print("duplicados")
print(pre_proccessed_data.duplicated().sum())
# no hay duplicados de acuerdo con lo obtenido 

#revisamos el nuevo dataset
print("pre_proccessed_data") 
pre_proccessed_data.info()
#2.Analisis estadistico basico del dataset preprocesado
    #2.1 analisis general del dataset
print(pre_proccessed_data.describe())
    #2.2    
