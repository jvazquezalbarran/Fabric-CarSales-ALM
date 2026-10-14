# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "e08a24b9-cb18-4405-b06b-b4cf82cf25ba",
# META       "default_lakehouse_name": "LH_Fabric_Curso_Prueba_JVA",
# META       "default_lakehouse_workspace_id": "7a550828-440d-4737-8629-60b8018cc24e",
# META       "known_lakehouses": [
# META         {
# META           "id": "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Cargar tablas crudas desde el Lakehouse incluyendo el esquema dbo
df_invoices = spark.read.table("LH_Fabric_Curso_Prueba_JVA.dbo.Invoices")
df_lines = spark.read.table("LH_Fabric_Curso_Prueba_JVA.dbo.InvoiceLines")

# Mostrar las primeras 5 filas y el esquema de los datos
display(df_invoices.limit(5))
df_invoices.printSchema()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import col, to_date, round, current_timestamp

# 1. Limpieza de Invoices
df_invoices_clean = df_invoices \
    .filter(col("ClientID").isNotNull()) \
    .withColumn("InvoiceDate", to_date(col("InvoiceDate"), "yyyy-MM-dd"))

# 2. Limpieza de InvoiceLines (usando LineItem y SalePrice)
df_lines_clean = df_lines \
    .filter(col("LineItem") > 0) \
    .withColumn("CalculatedTotal", round(col("LineItem") * col("SalePrice"), 2)) \
    .withColumn("IngestionTimestamp", current_timestamp())

# Comprobación de resultados
display(df_lines_clean.limit(5))

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_invoices_clean.write.mode("overwrite").format("delta").saveAsTable("Silver_PySpark_Invoices")
df_lines_clean.write.mode("overwrite").format("delta").saveAsTable("Silver_PySpark_InvoiceLines")

print("✅ Carga de capa Silver con PySpark completada exitosamente.")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df = spark.sql("SELECT * FROM LH_Fabric_Curso_Prueba_JVA.dbo.silver_pyspark_invoicelines LIMIT 1000")
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# Crear vistas temporales para usarlas posteriormente con consultas SQL
df_invoices_clean.createOrReplaceTempView("tmp_invoices")
df_lines_clean.createOrReplaceTempView("tmp_lines")

# Cargar la tabla de Clientes incluyendo el esquema dbo
spark.read.table("LH_Fabric_Curso_Prueba_JVA.dbo.Clients").createOrReplaceTempView("tmp_clients")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC -- Consulta de agregación Gold: Ventas totales por Cliente y País/Condado
# MAGIC CREATE OR REPLACE TABLE Silver_PySpark_VentasPorCliente AS
# MAGIC SELECT 
# MAGIC     c.County AS Country,
# MAGIC     i.ClientID,
# MAGIC     COUNT(DISTINCT i.InvoiceID) AS TotalFacturas,
# MAGIC     ROUND(SUM(l.CalculatedTotal), 2) AS ImporteTotalVentas
# MAGIC FROM tmp_invoices i
# MAGIC JOIN tmp_lines l ON i.InvoiceID = l.InvoiceID
# MAGIC JOIN tmp_clients c ON i.ClientID = c.ClientID
# MAGIC GROUP BY c.County, i.ClientID;

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df = spark.sql("SELECT * FROM LH_Fabric_Curso_Prueba_JVA.dbo.silver_pyspark_invoicelines LIMIT 1000")
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
