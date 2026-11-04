[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Clients_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Clients = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Clients", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"ClientID", Int64.Type}, {"ClientName", type text}, {"Address1", type text}, {"Address2", type text}, {"Town", type text}, {"County", type text}, {"Region", type text}, {"OuterPostode", type text}, {"CountryID", Int64.Type}, {"ClientType", type text}, {"ClientSize", type text}, {"IsCreditWorthy", Int64.Type}, {"IsDealer", Int64.Type}}, "es"),
  #"Columnas quitadas" = Table.RemoveColumns(#"Tipo de columna cambiado", {"Address2"}),
  #"Errores quitados" = Table.RemoveRowsWithErrors(#"Columnas quitadas", {"County"}),
  #"Valor reemplazado" = Table.ReplaceValue(#"Errores quitados", "NULL", "", Replacer.ReplaceText, {"County"})
in
  #"Valor reemplazado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Colors_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Colors = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Colors", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"ColorID", Int64.Type}, {"Color", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Countries_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Countries = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Countries", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"CountryID", Int64.Type}, {"CountryName", type text}, {"CountryISOCode", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Stock_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Stock = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Stock", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"StockID", Int64.Type}, {"Make", type text}, {"Model", type text}, {"ColorID", Int64.Type}, {"VehicleType", type text}, {"CostPrice", Int64.Type}, {"SpareParts", Int64.Type}, {"LaborCost", Int64.Type}, {"Registration_Date", type date}, {"Mileage", Int64.Type}, {"VehicleAgeInYears", type number}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Invoices_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Invoices = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "Invoices", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"InvoiceID", Int64.Type}, {"InvoiceNumber", type text}, {"ClientID", Int64.Type}, {"InvoiceDate", type datetime}, {"TotalDiscount", type number}, {"DeliveryCharge", Int64.Type}, {"InvoiceDateKey", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "InvoiceLines_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared InvoiceLines = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "InvoiceLines", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"InvoiceLineID", Int64.Type}, {"InvoiceID", Int64.Type}, {"StockID", Int64.Type}, {"SalePrice", Int64.Type}, {"LineItem", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "DateDimension_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared DateDimension = let
  Origen = Excel.Workbook(Web.Contents("https://tajamar365-my.sharepoint.com/personal/javier_vazquez_tajamar365_com/Documents/Aplicaciones/Microsoft Power Query/Uploaded Files/CarSalesData 14.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "DateDimension", Kind = "Sheet"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 1", [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"DateKey", type date}, {"Year", Int64.Type}, {"MonthNum", Int64.Type}, {"MonthFull", type text}, {"MonthAbbr", type text}, {"QuarterNum", Int64.Type}, {"QuarterFull", type text}, {"QuarterAbbr", type text}, {"YearAndQuarterNum", Int64.Type}, {"QuarterAbbrAndYear", type text}, {"MonthAbbrAndYear", type date}, {"MonthAndYear", type date}, {"MonthName", type text}, {"MonthNameAbbr", type text}, {"QuarterAndYear", type text}, {"QuarterAndYearAbbr2", type text}, {"YearAndMonthNum", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
shared Clients_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Clients", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Colors_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Colors", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Countries_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Countries", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Stock_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Stock", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Invoices_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Invoices", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared InvoiceLines_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "InvoiceLines", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared DateDimension_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "DateDimension", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
