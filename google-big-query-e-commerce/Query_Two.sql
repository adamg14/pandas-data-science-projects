-- top 10 Prism resellers in a given region, based on the profits from the second fiscal quarter of 2022. I'll need the name of each main contact along with their addresses; so that I can have my PA send them a congratulatory gift.

-- Original Query 2
-- original query - Q2

WITH Q2_2022_ORDERS AS (
  SELECT OD.OrderDateKey,
  OD.ResellerKey,
  OD.ProductKey,
  OD.Quantity,
  CONCAT(COALESCE(RD.Prefix), ' ', RD.FirstName, ' ', RD.LastName) AS full_name,
  RD.Building_Number AS Building_Number,
  RD.Postal_Code AS Postal_Code,
  RD.Sub_Region AS Sub_Region,
  RD.Region AS Region,
  OD.Quantity * (PD.ProductPrice - PD.ProductCost) AS order_profit
  FROM strategic_resellers_initiative.Order_Details OD
  INNER JOIN strategic_resellers_initiative.Reseller_Details RD
  ON OD.ResellerKey = RD.ResellerKey
  INNER JOIN strategic_resellers_initiative.Product_Details PD
  ON OD.ProductKey = PD.ProductKey
  WHERE OD.OrderDateKey > (
                            SELECT MIN(Date_String)
                            FROM strategic_resellers_initiative.Fiscal_Quarters_Filter
                            WHERE Fiscal_Quarter = 'Q2'
                            AND year = 2022
                            )
  AND OD.OrderDateKey < (
                            SELECT MAX(Date_String)
                            FROM strategic_resellers_initiative.Fiscal_Quarters_Filter
                            WHERE Fiscal_Quarter = 'Q2'
                            AND year = 2022
)

),

ranking AS (
  SELECT full_name AS FullName,
  MIN(Building_Number) AS Builiding_Number,
  MIN(Postal_Code) AS Postal_Code,
  MIN(Sub_Region) AS Sub_Region,
  MIN(Region) AS Region,
  SUM(order_profit) AS total_quarterly_profit,
  RANK() OVER(PARTITION BY Region ORDER BY SUM(order_profit) DESC) AS ranking
  FROM Q2_2022_ORDERS
  GROUP BY FullName, Q2_2022_ORDERS.Region
)

SELECT *
FROM ranking
WHERE ranking.ranking <= 10;

-- SELECT RR.Addresse, full_name_details.full_name, RR.TotalProfit
-- FROM (
--   SELECT CONCAT(COALESCE(Prefix, ''), ' ', FirstName, ' ', LastName) AS full_name
--   FROM strategic_resellers_initiative.Reseller_Details
-- ) AS full_name_details
-- INNER JOIN strategic_resellers_initiative.Resellers_Ranked RR
-- ON RR.Addresse = full_name_details.full_name

-- SELECT MIN(Date_String) AS min_date, MAX(Date_String) AS max_date
-- FROM strategic_resellers_initiative.Fiscal_Quarters_Filter
-- WHERE Fiscal_Quarter = 'Q2'
-- AND year = 2022
-- GROUP BY Fiscal_Quarter
-- ;


-- Refined Query 2
WITH Q2_2022_ORDERS AS (
  SELECT *
  FROM strategic_resellers_initiative.Reseller_Gifts RG
  WHERE RG.OrderDate IN (
    SELECT FQF.Date_String
    FROM strategic_resellers_initiative.Fiscal_Quarters_Filter FQF
    WHERE FQF.Fiscal_Quarter = 'Q2'
    AND FQF.Year = 2022
  )
),

MAIN_CONTACT AS (
  SELECT CONCAT(COALESCE(RD.Prefix, ''), ' ', RD.FirstName, ' ', RD.LastName) AS Main_Contact,
  RD.Reseller AS Company,
  CONCAT(RD.Building_Number, ' ', RD.Postal_Code, ' ', RD.Sub_Region, ' ', COALESCE(RD.Sub_Region, 'USA')) AS Full_Address,
  RD.Sub_Region AS Sub_Region,
  ROUND(SUM(TotalProfit), 0) AS Total_Profit,
  FROM Q2_2022_ORDERS
  INNER JOIN strategic_resellers_initiative.Reseller_Details RD
  ON Q2_2022_ORDERS.ResellerID = RD.ResellerKey
  GROUP BY Main_Contact, Company, Full_Address, Sub_Region
),

Sub_Region_Rank AS(
  SELECT MAIN_CONTACT.Main_Contact as Main_Contact,
  Full_Address,
  Sub_Region,
  Total_Profit,
  RANK() OVER(PARTITION BY Sub_Region ORDER BY Total_Profit DESC)AS Sub_Region_Ranking
  FROM MAIN_CONTACT
)

SELECT Main_Contact,
Full_Address,
Sub_Region,
Sub_Region_Ranking,
FROM Sub_Region_Rank
WHERE Sub_Region_Ranking <= 10;