"""
GENERADOR DE DATOS SINTÉTICOS REALISTAS
Para portafolio: Análisis de Negocio de Accesorios NFC

Este script crea un dataset que parece completamente real
pero es 100% generado (para propósitos educativos)
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import os

# ========== CONFIGURACIÓN ==========
np.random.seed(42)  # Para reproducibilidad

# Rango de fechas (1 año de datos)
fecha_inicio = datetime(2023, 1, 1)
fecha_fin = datetime(2024, 6, 30)
dias_totales = (fecha_fin - fecha_inicio).days

# Cantidad de transacciones (realista para startup)
num_transacciones = 380

print("🔧 Generando datos sintéticos...")
print(f"   Período: {fecha_inicio.date()} a {fecha_fin.date()}")
print(f"   Transacciones: {num_transacciones}\n")

# ========== DEFINIR PRODUCTOS ==========
productos = {
    'Pulsera NFC Plus': {
        'precio': 45, 
        'costo': 18,
        'popularidad': 0.35  # 35% de las ventas
    },
    'Llavero NFC': {
        'precio': 30,
        'costo': 10,
        'popularidad': 0.25
    },
    'Tarjeta NFC': {
        'precio': 25,
        'costo': 8,
        'popularidad': 0.15
    },
    'Brazalete Premium': {
        'precio': 60,
        'costo': 22,
        'popularidad': 0.15
    },
    'Pack 3 Pulseras': {
        'precio': 120,
        'costo': 45,
        'popularidad': 0.10
    }
}

# ========== DEFINIR CANALES ==========
# Nota: Pesos realistas (Instagram y TikTok lideran)
canales = {
    'Instagram': 0.30,
    'TikTok': 0.25,
    'Facebook': 0.15,
    'Referido': 0.15,
    'Página Web': 0.10,
    'WhatsApp': 0.05
}

# ========== DEFINIR CIUDADES ==========
ciudades = {
    'Bogotá': 0.40,      # Mayor concentración
    'Medellín': 0.25,
    'Cali': 0.15,
    'Barranquilla': 0.10,
    'Cartagena': 0.10
}

# ========== GENERAR TRANSACCIONES ==========

# 1. Generar fechas aleatorias (pero coherentes)
fechas_aleatorias = [fecha_inicio + timedelta(days=float(x)) 
                     for x in np.random.uniform(0, dias_totales, num_transacciones)]
fechas = sorted(fechas_aleatorias)

# 2. Asignar productos (con peso por popularidad)
producto_names = list(productos.keys())
producto_weights = [productos[p]['popularidad'] for p in producto_names]
productos_list = np.random.choice(producto_names, num_transacciones, p=producto_weights)

# 3. Asignar canales (con peso realista)
canal_names = list(canales.keys())
canal_weights = list(canales.values())
canales_list = np.random.choice(canal_names, num_transacciones, p=canal_weights)

# 4. Asignar ciudades
ciudad_names = list(ciudades.keys())
ciudad_weights = list(ciudades.values())
ciudades_list = np.random.choice(ciudad_names, num_transacciones, p=ciudad_weights)

# 5. Crear dataframe base
df = pd.DataFrame({
    'fecha': fechas,
    'producto': productos_list,
    'canal': canales_list,
    'ciudad': ciudades_list,
})

# 6. Agregar precios base
df['precio_unitario'] = df['producto'].map(lambda x: productos[x]['precio'])
df['costo_unitario'] = df['producto'].map(lambda x: productos[x]['costo'])

# 7. Agregar descuentos realistas (solo 25% de clientes)
df['descuento_pct'] = np.random.choice(
    [0, 5, 10, 15], 
    num_transacciones, 
    p=[0.75, 0.15, 0.07, 0.03]  # 75% sin descuento, 15% con 5%, etc
)

# 8. Calcular montos finales
df['monto_venta'] = df['precio_unitario'] * (1 - df['descuento_pct']/100)
df['ganancia'] = df['monto_venta'] - df['costo_unitario']
df['margen_pct'] = (df['ganancia'] / df['monto_venta'] * 100).round(2)

# 9. Agregar otras columnas útiles
df['mes'] = df['fecha'].dt.to_period('M')
df['dia_semana'] = df['fecha'].dt.day_name()
df['semana'] = df['fecha'].dt.isocalendar().week

# ========== REORDENAR COLUMNAS ==========
df = df[[
    'fecha', 'mes', 'dia_semana', 'semana',
    'producto', 'precio_unitario', 'descuento_pct', 
    'monto_venta', 'costo_unitario', 'ganancia', 'margen_pct',
    'canal', 'ciudad'
]]

# ========== GUARDAR ARCHIVO ==========
output_path = 'data/nfc_sales_synthetic.csv'
df.to_csv(output_path, index=False, encoding='utf-8-sig')

print(f"✅ Datos generados exitosamente!")
print(f"📁 Archivo guardado en: {output_path}\n")

# ========== ESTADÍSTICAS ==========
print("="*60)
print("📊 RESUMEN DE DATOS GENERADOS")
print("="*60)

print(f"\n📈 Total de transacciones: {len(df)}")
print(f"💰 Ingresos totales: ${df['monto_venta'].sum():,.2f}")
print(f"💸 Ganancia total: ${df['ganancia'].sum():,.2f}")
print(f"📊 Margen promedio: {df['margen_pct'].mean():.2f}%")
print(f"🎯 Ticket promedio: ${df['monto_venta'].mean():.2f}")

print("\n" + "-"*60)
print("🏆 TOP 5 PRODUCTOS POR INGRESOS")
print("-"*60)
top_productos = df.groupby('producto').agg({
    'monto_venta': ['sum', 'count', 'mean']
}).round(2)
top_productos.columns = ['Total Ingresos', 'Cantidad Ventas', 'Ticket Promedio']
top_productos = top_productos.sort_values('Total Ingresos', ascending=False)
print(top_productos)

print("\n" + "-"*60)
print("📱 INGRESOS POR CANAL")
print("-"*60)
canales_stats = df.groupby('canal').agg({
    'monto_venta': ['sum', 'count', 'mean']
}).round(2)
canales_stats.columns = ['Total Ingresos', 'Cantidad', 'Ticket Promedio']
canales_stats = canales_stats.sort_values('Total Ingresos', ascending=False)
canales_stats['% del Total'] = (canales_stats['Total Ingresos'] / df['monto_venta'].sum() * 100).round(2)
print(canales_stats)

print("\n" + "-"*60)
print("🌍 INGRESOS POR CIUDAD")
print("-"*60)
ciudades_stats = df.groupby('ciudad').agg({
    'monto_venta': ['sum', 'count', 'mean']
}).round(2)
ciudades_stats.columns = ['Total Ingresos', 'Cantidad', 'Ticket Promedio']
ciudades_stats = ciudades_stats.sort_values('Total Ingresos', ascending=False)
print(ciudades_stats)

print("\n" + "-"*60)
print("📅 CRECIMIENTO MENSUAL")
print("-"*60)
monthly = df.groupby('mes').agg({
    'monto_venta': ['sum', 'count']
}).round(2)
monthly.columns = ['Ingresos', 'Transacciones']
print(monthly)

print("\n✨ ¡Datos listos para análisis!\n")