-- Average Order Value - Key Performance Indicator
-- Grouped by calendar month
-- AOV = Total Revenue / Total Orders
SELECT DATE_TRUNC(date, MONTH) AS month,
ROUND(AVG(transaction_revenue), 2) AS AOV
FROM `prism_acquire.transactions`
GROUP BY DATE_TRUNC(date, MONTH)
ORDER BY month ASC;