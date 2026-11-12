# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983",
# META       "default_lakehouse_name": "LH_CarSales",
# META       "default_lakehouse_workspace_id": "c89e37dd-8869-4353-bf44-8628edb4e3e2",
# META       "known_lakehouses": [
# META         {
# META           "id": "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# CELDA 1: Instalación de dependencias y configuración de MLflow
import IPython
IPython.get_ipython().run_line_magic('pip', 'install prophet -q')
import mlflow
import pandas as pd
from prophet import Prophet
from pyspark.sql.functions import col, sum as _sum

# Inicializar el experimento en Fabric para auditoría
mlflow.set_experiment("CarSales_Demand_Forecasting")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# CELDA 2: Carga y preparación de serie temporal para Prophet
from pyspark.sql.functions import count as _count, row_number, expr
from pyspark.sql.window import Window
import pandas as pd

# 1. Leemos la tabla Silver
df_invoices = spark.read.table("LH_CarSales.dbo.invoices_silver_pyspark")

# 2. Generamos una serie de fechas diarias asignando una fecha por cada grupo de registros
windowSpec = Window.orderBy("InvoiceID")
df_with_dates = df_invoices.withColumn("row_num", row_number().over(windowSpec)) \
                           .withColumn("Fecha_Simulada", expr("date_sub(current_date(), cast(row_num % 180 as int))"))

# 3. Agrupamos por fecha simulada para obtener ventas/facturas diarias
df_ventas_diarias = df_with_dates.groupBy("Fecha_Simulada") \
                                 .agg(_count("InvoiceID").alias("VentasTotales")) \
                                 .sort("Fecha_Simulada")

# 4. Convertimos a Pandas y renombramos al formato de Prophet ('ds' y 'y')
pdf_ventas = df_ventas_diarias.toPandas()
pdf_ventas = pdf_ventas.rename(columns={"Fecha_Simulada": "ds", "VentasTotales": "y"})
pdf_ventas['ds'] = pd.to_datetime(pdf_ventas['ds'])

# Confirmación de resultados
print(f"Total de días históricos generados para el modelo: {len(pdf_ventas)}")
pdf_ventas.head(10)


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# CELDA 3: Entrenamiento del modelo Prophet y registro en MLflow
import mlflow
from prophet import Prophet

# Configurar el experimento en Fabric
mlflow.set_experiment("CarSales_Demand_Forecasting")

with mlflow.start_run(run_name="Prophet_Invoices_90Dias"):
    
    # 1. Instanciar y entrenar el modelo Prophet
    model = Prophet(yearly_seasonality=True, weekly_seasonality=True, daily_seasonality=False)
    model.fit(pdf_ventas)
    
    # 2. Generar el marco temporal futuro (próximos 90 días)
    future = model.make_future_dataframe(periods=90)
    
    # 3. Calcular la predicción
    forecast = model.predict(future)
    
    # 4. Registrar parámetros y métricas en MLflow para auditoría
    mlflow.log_param("tabla_origen", "invoices_silver_pyspark")
    mlflow.log_param("dias_historicos", len(pdf_ventas))
    mlflow.log_param("dias_proyectados", 90)
    print("¡Entrenamiento completado con éxito! Predicción a 90 días generada.")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# CELDA 4: Formateo y selección de métricas predictivas
# 1. Filtramos las columnas clave del objeto forecast
df_predicciones_pd = forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].copy()

# 2. Renombramos a nombres de negocio limpios
df_predicciones_pd.columns = ['Fecha', 'Venta_Predicha', 'Venta_Minima_Estimada', 'Venta_Maxima_Estimada']

# 3. Redondeamos valores numéricos a 2 decimales
df_predicciones_pd = df_predicciones_pd.round(2)

# 4. Convertimos a DataFrame de PySpark para la escritura masiva
df_predicciones_spark = spark.createDataFrame(df_predicciones_pd)

# Mostramos los últimos 10 registros (las proyecciones futuras a 90 días)
display(df_predicciones_spark.tail(10))


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# CELDA 5: Escritura en tabla Delta del Lakehouse
df_predicciones_spark.write \
    .format("delta") \
    .mode("overwrite") \
    .saveAsTable("LH_CarSales.dbo.fact_ventas_predicciones")

print("¡Éxito! Tabla 'fact_ventas_predicciones' creada y lista en la capa Gold del Lakehouse.")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
