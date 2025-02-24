-- *** THESE QUERIES ARE WRITTEN FOR GOOGLE BIG QUERY***

-- What are the most popular transport types, measured by the total number of journeys? The output should contain two columns, 1) journey_type and 2) total_journeys_millions, and be sorted by the second column in descending order. Save the query as most_popular_transport_types.
SELECT JOURNEY_TYPE AS journey_type,
SUM(JOURNEYS_MILLIONS) AS total_journeys_millions
FROM TFL.JOURNEYS
GROUP BY JOURNEY_TYPE
ORDER BY total_journeys_millions DESC

-- Which five months and years were the most popular for the Emirates Airline? Return an output containing month, year, and journeys_millions, with the latter rounded to two decimal places and aliased as rounded_journeys_millions. Exclude null values and order the results by 1) rounded_journeys_millions in descending order and 2) year in ascending order, saving the result as emirates_airline_popularity.
SELECT MONTH AS month,
YEAR AS year,
ROUND(SUM(JOURNEYS_MILLIONS), 2) AS rounded_journeys_millions
FROM TFL.JOURNEYS
WHERE JOURNEYS_MILLIONS IS NOT NULL
AND JOURNEY_TYPE = "Emirates Airline"
GROUP BY MONTH, YEAR
ORDER BY rounded_journeys_millions DESC, YEAR ASC
LIMIT 5

-- Find the five years with the lowest volume of Underground & DLR journeys, saving as least_popular_years_tube. The results should contain the columns year, journey_type, and total_journeys_millions.
SELECT YEAR AS year,		
JOURNEY_TYPE AS journey_type,
SUM(JOURNEYS_MILLIONS) AS total_journeys_millions
FROM TFL.JOURNEYS
WHERE JOURNEY_TYPE = "Underground & DLR"
GROUP BY YEAR, journey_type
ORDER BY total_journeys_millions ASC
LIMIT 5