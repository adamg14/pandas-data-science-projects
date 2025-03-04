SELECT DATE_TRUNC(date, YEAR) AS year,
ROUND(SUM(transaction_revenue), 2) AS gross_revenue
FROM `prism_acquire.transactions`
GROUP BY DATE_TRUNC(date, YEAR);