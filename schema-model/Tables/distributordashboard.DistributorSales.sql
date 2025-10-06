CREATE TABLE [distributordashboard].[DistributorSales]
(
[SaleId] [bigint] NOT NULL IDENTITY(1, 1),
[DistributorId] [int] NOT NULL,
[SaleDate] [datetime2] (3) NOT NULL,
[ProductCode] [nvarchar] (100) NULL,
[Quantity] [int] NOT NULL CONSTRAINT [DF__Distribut__Quant__40C49C62] DEFAULT ((1)),
[UnitPrice] [decimal] (18, 4) NOT NULL,
[Amount] AS ([Quantity]*[UnitPrice]) PERSISTED,
[Notes] [nvarchar] (1000) NULL,
[CreatedAt] [datetime2] (3) NOT NULL CONSTRAINT [DF__Distribut__Creat__41B8C09B] DEFAULT (sysutcdatetime())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [distributordashboard].[trg_DistributorSales_Audit]
ON [distributordashboard].[DistributorSales]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @op NVARCHAR(20) = 'UNKNOWN';
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted) SET @op = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted) SET @op = 'INSERT';
    ELSE IF EXISTS (SELECT 1 FROM deleted) SET @op = 'DELETE';

    -- Insert audit rows for inserted/updated/deleted rows
    INSERT INTO distributordashboard.DistributorSalesAudit (SaleId, DistributorId, SaleDate, Amount, Operation, ChangedAt, ChangedBy, RawData)
    SELECT
        COALESCE(i.SaleId, d.SaleId) AS SaleId,
        COALESCE(i.DistributorId, d.DistributorId) AS DistributorId,
        COALESCE(i.SaleDate, d.SaleDate) AS SaleDate,
        COALESCE(i.Amount, d.Amount) AS Amount,
        @op AS Operation,
        SYSUTCDATETIME() AS ChangedAt,
        SUSER_SNAME() AS ChangedBy,
        -- RawData: JSON representation of the combined row (SQL Server 2016+ for FOR JSON PATH)
        (SELECT COALESCE(i.SaleId, d.SaleId) AS SaleId, COALESCE(i.DistributorId, d.DistributorId) AS DistributorId, COALESCE(i.SaleDate, d.SaleDate) AS SaleDate, COALESCE(i.Amount, d.Amount) AS Amount FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.SaleId = d.SaleId;
END;
GO
ALTER TABLE [distributordashboard].[DistributorSales] ADD CONSTRAINT [PK__Distribu__1EE3C3FF18B082ED] PRIMARY KEY CLUSTERED ([SaleId])
GO
CREATE NONCLUSTERED INDEX [IX_DistributorSales_Distributor_SaleDate] ON [distributordashboard].[DistributorSales] ([DistributorId], [SaleDate] DESC) INCLUDE ([Quantity], [UnitPrice], [Amount])
GO
ALTER TABLE [distributordashboard].[DistributorSales] ADD CONSTRAINT [FK__Distribut__Distr__3FD07829] FOREIGN KEY ([DistributorId]) REFERENCES [distributordashboard].[Distributor] ([DistributorId]) ON DELETE CASCADE
GO
