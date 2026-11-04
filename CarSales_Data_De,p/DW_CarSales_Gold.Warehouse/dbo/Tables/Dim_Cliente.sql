CREATE TABLE [dbo].[Dim_Cliente] (
    [ClienteID]     INT           NOT NULL,
    [NombreCliente] VARCHAR (150) NULL,
    [Direccion]     VARCHAR (255) NULL,
    [PaisID]        INT           NULL
);


GO

ALTER TABLE [dbo].[Dim_Cliente]
    ADD CONSTRAINT [PK_Dim_Cliente] PRIMARY KEY NONCLUSTERED ([ClienteID] ASC) NOT ENFORCED;


GO