CREATE TABLE [distributordashboard].[DistributorSalesAudit]
(
[AuditId] [bigint] NOT NULL IDENTITY(1, 1),
[SaleId] [bigint] NULL,
[DistributorId] [int] NULL,
[SaleDate] [datetime2] (3) NULL,
[Amount] [decimal] (18, 4) NULL,
[Operation] [nvarchar] (20) NOT NULL,
[ChangedAt] [datetime2] (3) NOT NULL CONSTRAINT [DF__Distribut__Chang__44952D46] DEFAULT (sysutcdatetime()),
[ChangedBy] [nvarchar] (200) NULL,
[RawData] [nvarchar] (max) NULL
)
GO
ALTER TABLE [distributordashboard].[DistributorSalesAudit] ADD CONSTRAINT [PK__Distribu__A17F23980F4DF8A7] PRIMARY KEY CLUSTERED ([AuditId])
GO
