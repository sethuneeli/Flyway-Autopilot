SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- 4. Create Scalar Function
CREATE FUNCTION [dbo].[fn_GetEmployeeFullName]
(
    @EmployeeID INT
)
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @FullName NVARCHAR(101);
    SELECT @FullName = FirstName + ' ' + LastName
    FROM dbo.Employee
    WHERE EmployeeID = @EmployeeID;
    RETURN @FullName;
END;
GO
