CREATE TABLE [dbo].[Fact_Ventas] (
    [FacturaID]   INT             NULL,
    [VehiculoID]  INT             NULL,
    [PrecioVenta] DECIMAL (18, 2) NULL
);


GO

ALTER TABLE [dbo].[Fact_Ventas]
    ADD CONSTRAINT [FK_Ventas_Cliente] FOREIGN KEY ([FacturaID]) REFERENCES [dbo].[Dim_Cliente] ([ClienteID]) NOT ENFORCED;


GO