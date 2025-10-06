SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- 2. Create View
CREATE VIEW [dbo].[vw_EmployeeDetails] AS
SELECT
    EmployeeID,
    FirstName + ' ' + LastName AS FullName,
    HireDate,
    Salary
FROM dbo.Employee;
GO
