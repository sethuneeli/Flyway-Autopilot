CREATE TABLE [distributordashboard].[Distributor]
(
[DistributorId] [int] NOT NULL IDENTITY(1, 1),
[DistributorCode] [nvarchar] (50) NOT NULL,
[DisplayName] [nvarchar] (200) NOT NULL,
[Region] [nvarchar] (100) NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__Distribut__IsAct__24285DB4] DEFAULT ((1)),
[CreatedAt] [datetime2] (3) NOT NULL CONSTRAINT [DF__Distribut__Creat__251C81ED] DEFAULT (sysutcdatetime())
)
GO
ALTER TABLE [distributordashboard].[Distributor] ADD CONSTRAINT [PK__Distribu__FD1AEB9E7A77F1EC] PRIMARY KEY CLUSTERED ([DistributorId])
GO
ALTER TABLE [distributordashboard].[Distributor] ADD CONSTRAINT [UQ__Distribu__CD0EC65C9C70B434] UNIQUE NONCLUSTERED ([DistributorCode])
GO
