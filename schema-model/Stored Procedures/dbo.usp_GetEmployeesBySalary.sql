SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- 3. Create Stored Procedure
CREATE PROCEDURE [dbo].[usp_GetEmployeesBySalary]
    @MinSalary DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM dbo.Employee
    WHERE Salary >= @MinSalary;
END;
GO
