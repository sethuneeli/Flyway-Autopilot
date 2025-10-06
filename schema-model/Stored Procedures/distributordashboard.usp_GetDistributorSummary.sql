SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [distributordashboard].[usp_GetDistributorSummary]
    @DistributorId INT = NULL,      -- NULL => return all distributors
    @RecentDays INT = 30            -- include recent sales within this many days
AS
BEGIN
    SET NOCOUNT ON;

    -- return summary rows from view
    SELECT
        v.*
		--,
  --      dbo.fn_Distributor_Exists = CASE WHEN EXISTS (SELECT 1 FROM distributordashboard.Distributor d WHERE d.DistributorId = v.DistributorId) THEN 1 ELSE 0 END
    FROM distributordashboard.vw_DistributorSalesSummary v
    WHERE (@DistributorId IS NULL OR v.DistributorId = @DistributorId)
    ORDER BY v.TotalSales DESC;

    -- return recent sales (if DistributorId specified, filter; otherwise recent sales across all)
    SELECT TOP (100)
        s.SaleId, s.DistributorId, d.DisplayName, s.SaleDate, s.ProductCode, s.Quantity, s.UnitPrice, s.Amount
    FROM distributordashboard.DistributorSales s
    LEFT JOIN distributordashboard.Distributor d ON d.DistributorId = s.DistributorId
    WHERE s.SaleDate >= DATEADD(DAY, -1 * @RecentDays, SYSUTCDATETIME())
      AND (@DistributorId IS NULL OR s.DistributorId = @DistributorId)
    ORDER BY s.SaleDate DESC;
END;
GO
