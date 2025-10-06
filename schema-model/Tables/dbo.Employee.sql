CREATE TABLE [dbo].[Employee]
(
[EmployeeID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (50) NULL,
[LastName] [nvarchar] (50) NULL,
[HireDate] [date] NULL,
[Salary] [decimal] (10, 2) NULL,
[UpdatedAt] [datetime] NULL
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- 5. Create Trigger
CREATE TRIGGER [dbo].[trg_UpdateEmployeeTimestamp]
ON [dbo].[Employee]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE E
    SET UpdatedAt = GETDATE()
    FROM dbo.Employee E
    INNER JOIN inserted i ON E.EmployeeID = i.EmployeeID;
END;
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK__Employee__7AD04FF170CADE87] PRIMARY KEY CLUSTERED ([EmployeeID])
GO
