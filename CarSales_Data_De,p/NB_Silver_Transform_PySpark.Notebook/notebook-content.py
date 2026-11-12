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

import pandas as pd

# 1. Definir la lista completa con todos los ficheros de la capa Bronze
files = [
    "Clients",
    "Colors",
    "Countries",
    "DateDimension",
    "Invoices",
    "InvoicesLines",
    "Stock",
]

# Diccionario para almacenar los DataFrames de Spark procesados
spark_dfs = {}

# 2. Leer cada archivo Excel y cargarlo en un DataFrame de Pandas
for file_name in files:
    path = f"/lakehouse/default/Files/Bronze/{file_name}.xlsx"

    # Leer archivo con Pandas
    pdf = pd.read_excel(path)

    # 3. Convertir a Spark DataFrame (Estándar Fabric)
    df_spark = spark.createDataFrame(pdf)

    # Almacenar en el diccionario
    spark_dfs[file_name] = df_spark

    print(f"✅ Cargado en memoria Spark: {file_name}")

# Mostrar las primeras filas y el esquema de uno de los ficheros como comprobación
display(spark_dfs["Invoices"].limit(5))
spark_dfs["Invoices"].printSchema()



# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

import pandas as pd
import datetime

files = [
    "Clients",
    "Colors",
    "Countries",
    "DateDimension",
    "Invoices",
    "InvoicesLines",
    "Stock",
]

for file_name in files:
    try:
        raw_path = f"/lakehouse/default/Files/Bronze/{file_name}.xlsx"

        # 1. Leer Excel con Pandas
        pdf = pd.read_excel(raw_path)

        # 2. Convertimos columnas de tipo datetime.time o object/time a string/datetime
        for col_name in pdf.columns:
            # Si detecta objetos de tipo hora (datetime.time), los convierte a texto HH:MM:SS
            if pdf[col_name].apply(lambda x: isinstance(x, datetime.time)).any():
                pdf[col_name] = pdf[col_name].astype(str)
            # Asegurar que las fechas puras sean datetime de pandas
            elif pd.api.types.is_datetime64_any_dtype(pdf[col_name]):
                pdf[col_name] = pd.to_datetime(pdf[col_name])

        # 3. Convertir a Spark DataFrame
        df = spark.createDataFrame(pdf)

        # 4. Limpiar nombres de columnas
        for c in df.columns:
            clean_col = c.replace(" ", "_").replace("-", "_")
            df = df.withColumnRenamed(c, clean_col)

        # 5. Guardar como tabla Delta
        target_table = f"{file_name}_silver_pyspark"
        df.write.format("delta").mode("overwrite").saveAsTable(target_table)
        
        print(f"✅ Creada con éxito: {target_table}")

    except Exception as e:
        print(f"❌ Error procesando '{file_name}': {str(e)}")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

spark.sql("""
CREATE OR REPLACE TABLE Fact_Sales_By_Country_Month_Gold AS
SELECT 
    co.CountryName AS Country,
    YEAR(i.InvoiceDate) AS Year,
    MONTH(i.InvoiceDate) AS Month,
    DATE_FORMAT(i.InvoiceDate, 'yyyy-MM') AS YearMonth,
    COUNT(DISTINCT i.InvoiceID) AS TotalInvoices,
    SUM(il.LineItem) AS TotalUnitsSold,
    ROUND(SUM(il.LineItem * il.SalePrice), 2) AS GrossSalesAmount,
    ROUND(SUM((il.LineItem * il.SalePrice) - COALESCE(i.TotalDiscount, 0)), 2) AS NetSalesAmount
FROM 
    Invoices_silver_pyspark i
INNER JOIN 
    InvoicesLines_silver_pyspark il ON i.InvoiceID = il.InvoiceID
INNER JOIN 
    Clients_silver_pyspark cl ON i.ClientID = cl.ClientID
INNER JOIN 
    Countries_silver_pyspark co ON cl.CountryID = co.CountryID
GROUP BY 
    co.CountryName,
    YEAR(i.InvoiceDate),
    MONTH(i.InvoiceDate),
    DATE_FORMAT(i.InvoiceDate, 'yyyy-MM')
ORDER BY 
    Year DESC, 
    Month DESC, 
    NetSalesAmount DESC
""")

# Comprobación de los resultados generados en la capa Gold
df_gold = spark.read.table("Fact_Sales_By_Country_Month_Gold")
display(df_gold.limit(10))


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
