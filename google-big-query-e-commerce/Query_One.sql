-- how many resellers have made over £6m.

-- Original Query - 1
SELECT COUNT(*)
FROM strategic_resellers_initiative.Resellers_Ranked
WHERE TotalProfit > 6000000


-- Refined question 1
SELECT ResellerId, ROUND(SUM(TotalProfit), 2) AS TotalProfit
FROM strategic_resellers_initiative.Reseller_Gifts
GROUP BY ResellerId