CREATE TABLE [dbo].[TableEmp]
(
[Id] [int] NOT NULL,
[Name] [nvarchar] (100) NULL,
[Salary] [decimal] (10, 2) NULL
)
GO
ALTER TABLE [dbo].[TableEmp] ADD CONSTRAINT [PK__TableEmp__3214EC0783F494BD] PRIMARY KEY CLUSTERED ([Id])
GO
