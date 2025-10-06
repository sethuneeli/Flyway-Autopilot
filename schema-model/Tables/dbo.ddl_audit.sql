CREATE TABLE [dbo].[ddl_audit]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[timestamp] [datetime2] NULL,
[action] [nvarchar] (50) NULL,
[env] [nvarchar] (50) NULL,
[dryRun] [bit] NULL,
[success] [bit] NULL,
[rowsAffected] [nvarchar] (max) NULL,
[error] [nvarchar] (max) NULL,
[scriptPreview] [nvarchar] (max) NULL,
[userName] [nvarchar] (200) NULL,
[correlationId] [nvarchar] (200) NULL,
[gitCommit] [nvarchar] (200) NULL,
[clientIp] [nvarchar] (200) NULL
)
GO
ALTER TABLE [dbo].[ddl_audit] ADD CONSTRAINT [PK__ddl_audi__3213E83F0B09BC12] PRIMARY KEY CLUSTERED ([id])
GO
