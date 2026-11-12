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

import os
import time
import json
import random
from datetime import datetime

# Definir la ruta de entrada para los archivos de streaming en OneLake
streaming_path = "/lakehouse/default/Files/streaming_input/"
os.makedirs(streaming_path, exist_ok=True)

print(f"Directorio de streaming preparado en: {streaming_path}")

# Función para generar transacciones simuladas de CarSales
def generar_ventas_simuladas(num_eventos=5):
    marcas = ["BMW", "Audi", "Mercedes-Benz", "Toyota", "Volkswagen"]
    concesionarios = ["Madrid-Norte", "Barcelona-Diagonal", "Valencia-Centro", "Sevilla-Sur"]
    
    eventos = []
    for _ in range(num_eventos):
        evento = {
            "TransactionID": str(random.randint(100000, 999999)),
            "Timestamp": datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S"),
            "Marca": random.choice(marcas),
            "Concesionario": random.choice(concesionarios),
            "PrecioVenta": round(random.uniform(15000, 65000), 2),
            "Comision": round(random.uniform(500, 2500), 2)
        }
        eventos.append(evento)
    return eventos

# Generar un primer lote de prueba
lote_inicial = generar_ventas_simuladas(10)
file_name = f"ventas_{int(time.time())}.json"

with open(os.path.join(streaming_path, file_name), "w") as f:
    for ev in lote_inicial:
        f.write(json.dumps(ev) + "\n")

print(f"✅ Primer archivo de streaming generado: {file_name}")



# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

import os
import time
import json
import random
from datetime import datetime, timezone

# Definir la ruta de entrada para los archivos de streaming en OneLake
streaming_path = "/lakehouse/default/Files/streaming_input/"
os.makedirs(streaming_path, exist_ok=True)

print(f"Directorio de streaming preparado en: {streaming_path}")

# Función para generar transacciones simuladas de CarSales
def generar_ventas_simuladas(num_eventos=5):
    marcas = ["BMW", "Audi", "Mercedes-Benz", "Toyota", "Volkswagen"]
    concesionarios = ["Madrid-Norte", "Barcelona-Diagonal", "Valencia-Centro", "Sevilla-Sur"]
    
    eventos = []
    for _ in range(num_eventos):
        evento = {
            "TransactionID": str(random.randint(100000, 999999)),
            # Uso de datetime.now(timezone.utc) sin deprecación
            "Timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S"),
            "Marca": random.choice(marcas),
            "Concesionario": random.choice(concesionarios),
            "PrecioVenta": round(random.uniform(15000, 65000), 2),
            "Comision": round(random.uniform(500, 2500), 2)
        }
        eventos.append(evento)
    return eventos

# Generar un primer lote de prueba
lote_inicial = generar_ventas_simuladas(10)
file_name = f"ventas_{int(time.time())}.json"

ruta_completa = os.path.join(streaming_path, file_name)
with open(ruta_completa, "w") as f:
    for ev in lote_inicial:
        f.write(json.dumps(ev) + "\n")

print(f"✅ Primer archivo de streaming generado con éxito: {file_name}")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.types import StructType, StructField, StringType, DoubleType, TimestampType
from pyspark.sql.functions import col, to_timestamp

# 1. Definir el esquema estricto de los eventos de CarSales
schema_ventas = StructType([
    StructField("TransactionID", StringType(), True),
    StructField("Timestamp", StringType(), True),
    StructField("Marca", StringType(), True),
    StructField("Concesionario", StringType(), True),
    StructField("PrecioVenta", DoubleType(), True),
    StructField("Comision", DoubleType(), True)
])

# 2. Iniciar la lectura en Streaming desde la carpeta de OneLake
df_stream_raw = (
    spark.readStream
    .schema(schema_ventas)
    .option("maxFilesPerTrigger", 1)  # Procesa 1 archivo por micro-lote para ver la evolución
    .json("Files/streaming_input/")
)

# 3. Transformar los datos: Convertir cadena a Timestamp y calcular margen
df_stream_transformed = df_stream_raw \
    .withColumn("FechaHora", to_timestamp(col("Timestamp"), "yyyy-MM-dd HH:mm:ss")) \
    .withColumn("IngresoNeto", col("PrecioVenta") - col("Comision"))

print("Schema del Streaming activado:")
df_stream_transformed.printSchema()


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import window, sum as _sum, count, avg

# Agregación en streaming: Ventanas de 1 minuto agrupadas por Marca y Concesionario
df_resumen_streaming = df_stream_transformed \
    .groupBy(
        window(col("FechaHora"), "1 minute"),
        col("Marca"),
        col("Concesionario")
    ) \
    .agg(
        count("TransactionID").alias("CochesVendidos"),
        _sum("PrecioVenta").alias("TotalVentas"),
        avg("IngresoNeto").alias("IngresoPromedio")
    ) \
    .select(
        col("window.start").alias("VentanaInicio"),
        col("window.end").alias("VentanaFin"),
        col("Marca"),
        col("Concesionario"),
        col("CochesVendidos"),
        col("TotalVentas"),
        col("IngresoPromedio")
    )


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

checkpoint_dir = "Files/checkpoints/ventas_streaming/"
output_table = "Fact_Ventas_Streaming"

# Iniciar la consulta en Streaming escribiendo en la tabla Delta
query_stream = (
    df_resumen_streaming.writeStream
    .format("delta")
    .outputMode("complete")  # "complete" sobrescribe/actualiza los agregados en cada micro-lote
    .option("checkpointLocation", checkpoint_dir)
    .table(output_table)
)

print(f"🟢 Streaming iniciado con éxito. Escribiendo en la tabla Delta '{output_table}'...")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

checkpoint_dir = "Files/checkpoints/ventas_streaming/"
output_table = "Fact_Ventas_Streaming"

# Iniciar la consulta en Streaming escribiendo en la tabla Delta
query_stream = (
    df_resumen_streaming.writeStream
    .format("delta")
    .outputMode("complete")  # "complete" actualiza los agregados en cada micro-lote
    .option("checkpointLocation", checkpoint_dir)
    .toTable(output_table)   # <-- Usar .toTable() en lugar de .table()
)

print(f"🟢 Streaming iniciado con éxito. Escribiendo en la tabla Delta '{output_table}'...")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

print("Simulando llegada de datos en vivo durante 30 segundos...")

for i in range(5):
    nuevos_eventos = generar_ventas_simuladas(num_eventos= random.randint(3, 8))
    archivo_nuevo = f"ventas_live_{int(time.time())}.json"
    
    with open(os.path.join(streaming_path, archivo_nuevo), "w") as f:
        for ev in nuevos_eventos:
            f.write(json.dumps(ev) + "\n")
            
    print(f"  [Lote {i+1}] Nuevas ventas enviadas al Stream en: {archivo_nuevo}")
    time.sleep(5)

print("✅ Generación completada. Revisa la consulta SQL en el siguiente paso.")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC SELECT 
# MAGIC     Marca,
# MAGIC     Concesionario,
# MAGIC     SUM(CochesVendidos) AS Total_Coches,
# MAGIC     ROUND(SUM(TotalVentas), 2) AS Facturacion_Total,
# MAGIC     ROUND(AVG(IngresoPromedio), 2) AS Margen_Medio
# MAGIC FROM 
# MAGIC     Fact_Ventas_Streaming
# MAGIC GROUP BY 
# MAGIC     Marca, Concesionario
# MAGIC ORDER BY 
# MAGIC     Facturacion_Total DESC;


# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# Detener el proceso en streaming cuando finalice la clase
query_stream.stop()
print("🔴 Processo de Streaming detenido correctamente.")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
