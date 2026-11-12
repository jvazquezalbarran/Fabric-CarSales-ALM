[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Clients xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Clients xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "Clients.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "Clients", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"ClientID", Int64.Type}, {"ClientName", type text}, {"Address1", type text}, {"Address2", type text}, {"Town", type text}, {"County", type text}, {"Region", type text}, {"OuterPostode", type text}, {"CountryID", Int64.Type}, {"ClientType", type text}, {"ClientSize", type text}, {"IsCreditWorthy", Int64.Type}, {"IsDealer", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Colors xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Colors xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "Colors.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "Colors", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"ColorID", Int64.Type}, {"Color", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Countries xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Countries xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "Countries.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "Countries", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"CountryID", Int64.Type}, {"CountryName", type text}, {"CountryISOCode", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "DateDimension xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"DateDimension xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "DateDimension.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "DateDimension", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"DateKey", type date}, {"Year", Int64.Type}, {"MonthNum", Int64.Type}, {"MonthFull", type text}, {"MonthAbbr", type text}, {"QuarterNum", Int64.Type}, {"QuarterFull", type text}, {"QuarterAbbr", type text}, {"YearAndQuarterNum", Int64.Type}, {"QuarterAbbrAndYear", type text}, {"MonthAbbrAndYear", type date}, {"MonthAndYear", type date}, {"MonthName", type text}, {"MonthNameAbbr", type text}, {"QuarterAndYear", type text}, {"QuarterAndYearAbbr2", type text}, {"YearAndMonthNum", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Invoices xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Invoices xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "Invoices.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "Invoices", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"InvoiceID", Int64.Type}, {"InvoiceNumber", type text}, {"ClientID", Int64.Type}, {"InvoiceDate", type datetime}, {"TotalDiscount", type number}, {"DeliveryCharge", Int64.Type}, {"InvoiceDateKey", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "InvoicesLines xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"InvoicesLines xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "InvoicesLines.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "InvoiceLines", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"InvoiceLineID", Int64.Type}, {"InvoiceID", Int64.Type}, {"StockID", Int64.Type}, {"SalePrice", Int64.Type}, {"LineItem", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Stock xlsx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Stock xlsx" = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[Name = "Bronze"]}[Content],
  #"Navegación 5" = #"Navegación 4"{[Name = "Stock.xlsx"]}[Content],
  #"Libro de Excel importado" = Excel.Workbook(#"Navegación 5", null, true),
  Navegación = #"Libro de Excel importado"{[Item = "Stock", Kind = "Table"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(Navegación, {{"StockID", Int64.Type}, {"Make", type text}, {"Model", type text}, {"ColorID", Int64.Type}, {"VehicleType", type text}, {"CostPrice", Int64.Type}, {"SpareParts", Int64.Type}, {"LaborCost", Int64.Type}, {"Registration_Date", type date}, {"Mileage", Int64.Type}, {" VehicleAgeInYears ", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
shared #"Stock xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Stock xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Clients xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Clients xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Colors xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Colors xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Countries xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Countries xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"DateDimension xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "DateDimension xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Invoices xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Invoices xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"InvoicesLines xlsx_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "c89e37dd-8869-4353-bf44-8628edb4e3e2"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7646a8b0-7955-4ed5-9a2b-31f9b5a2c983"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "InvoicesLines xlsx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
