SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [distributordashboard].[vw_DistributorSalesSummary]
AS
SELECT
    d.DistributorId,
    d.DistributorCode,
    d.DisplayName,
    d.Region,
    COUNT(s.SaleId)    AS SaleCount,
    SUM(s.Amount)      AS TotalSales,
    MAX(s.SaleDate)    AS LastSaleDate
FROM distributordashboard.Distributor d
LEFT JOIN distributordashboard.DistributorSales s
    ON s.DistributorId = d.DistributorId
GROUP BY
    d.DistributorId, d.DistributorCode, d.DisplayName, d.Region;
GO
