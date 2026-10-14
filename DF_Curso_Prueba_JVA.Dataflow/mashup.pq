[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared Clients = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Clients", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"ClientID", Int64.Type}, {"ClientName", type text}, {"Address1", type text}, {"Address2", type text}, {"Town", type text}, {"County", type text}, {"Region", type text}, {"OuterPostode", type text}, {"CountryID", Int64.Type}, {"ClientType", type text}, {"ClientSize", type text}, {"IsCreditWorthy", Int64.Type}, {"IsDealer", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[BindToDefaultDestination = true]
shared Colors = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Colors", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"ColorID", Int64.Type}, {"Color", type text}}, "es")
in
  #"Tipo de columna cambiado";
[BindToDefaultDestination = true]
shared Countries = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Countries", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"CountryID", Int64.Type}, {"CountryName", type text}, {"CountryISOCode", type text}}, "es")
in
  #"Tipo de columna cambiado";
[BindToDefaultDestination = true]
shared Stock = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Stock", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"StockID", Int64.Type}, {"Make", type text}, {"Model", type text}, {"ColorID", Int64.Type}, {"VehicleType", type text}, {"CostPrice", Int64.Type}, {"SpareParts", Int64.Type}, {"LaborCost", Int64.Type}, {"Registration_Date", type date}, {"Mileage", Int64.Type}, {"VehicleAgeInYears", type number}}, "es")
in
  #"Tipo de columna cambiado";
[BindToDefaultDestination = true]
shared Invoices = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Invoices", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"InvoiceID", Int64.Type}, {"InvoiceNumber", type text}, {"ClientID", Int64.Type}, {"InvoiceDate", type datetime}, {"TotalDiscount", type number}, {"DeliveryCharge", Int64.Type}, {"InvoiceDateKey", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[BindToDefaultDestination = true]
shared InvoiceLines = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "InvoiceLines", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"InvoiceLineID", Int64.Type}, {"InvoiceID", Int64.Type}, {"StockID", Int64.Type}, {"SalePrice", Int64.Type}, {"LineItem", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[BindToDefaultDestination = true]
shared DateDimension = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 5.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "DateDimension", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"DateKey", type date}, {"Year", Int64.Type}, {"MonthNum", Int64.Type}, {"MonthFull", type text}, {"MonthAbbr", type text}, {"QuarterNum", Int64.Type}, {"QuarterFull", type text}, {"QuarterAbbr", type text}, {"YearAndQuarterNum", Int64.Type}, {"QuarterAbbrAndYear", type text}, {"MonthAbbrAndYear", type date}, {"MonthAndYear", type date}, {"MonthName", type text}, {"MonthNameAbbr", type text}, {"QuarterAndYear", type text}, {"QuarterAndYearAbbr2", type text}, {"YearAndMonthNum", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
shared DefaultDestination = let
  Origen = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "."]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "dbo", ItemKind = "Schema"]}[Data]
in
  #"Navegación 3";
