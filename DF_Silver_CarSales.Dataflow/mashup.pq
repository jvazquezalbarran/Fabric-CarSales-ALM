[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Clients_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Clients = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Clients", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Colors_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Colors = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Colors", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Countries_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Countries = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Countries", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "DateDimension_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared DateDimension = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "DateDimension", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "InvoiceLines_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared InvoiceLines = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "InvoiceLines", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Invoices_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Invoices = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Invoices", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Stock_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Stock = let
  Origen = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navegación 1" = Origen{[workspaceId = "7a550828-440d-4737-8629-60b8018cc24e"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[lakehouseId = "e08a24b9-cb18-4405-b06b-b4cf82cf25ba"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Id = "Stock", ItemKind = "Table"]}[Data]
in
  #"Navegación 3";
shared Clients_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_Clients", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Colors_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_Colors", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Countries_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_Countries", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared DateDimension_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_DateDimension", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared InvoiceLines_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_InvoiceLines", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Invoices_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_Invoices", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Stock_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[lakehouseName = "LH_Fabric_Curso_Prueba_JVA"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Silver_Stock", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
