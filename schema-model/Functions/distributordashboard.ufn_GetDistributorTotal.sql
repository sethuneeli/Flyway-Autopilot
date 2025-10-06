SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [distributordashboard].[ufn_GetDistributorTotal](@DistributorId INT)
RETURNS DECIMAL(18,4)
AS
BEGIN
    DECLARE @total DECIMAL(18,4);
    SELECT @total = SUM(Amount) FROM distributordashboard.DistributorSales WHERE DistributorId = @DistributorId;
    RETURN ISNULL(@total, 0);
END;
GO
