-- Find the ten best-selling games. The output should contain all the columns in the game_sales table and be sorted by the games_sold column in descending order.
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10

-- Find the ten years with the highest average critic score, where at least four games were released (to ensure a good sample size). Return an output with the columns year, num_games released, and avg_critic_score. The avg_critic_score should be rounded to 2 decimal places. The table should be ordered by avg_critic_score in descending order.
SELECT game_sales.year AS year,
COUNT(*) AS num_games,
AVG(reviews.critic_score) AS avg_critic_score
FROM game_sales
JOIN reviews 
ON game_sales.name = reviews.name
GROUP BY game_sales.year
HAVING COUNT(*) > 4
ORDER BY critic_score DESC
LIMIT 10

-- Find the years where critics and users broadly agreed that the games released were highly rated. Specifically, return the years where the average critic score was over 9 OR the average user score was over 9.
-- golden_years
SELECT users.year,
users.num_games AS num_games,
critics.avg_critic_score AS avg_critic_score,
users.avg_user_score AS avg_user_score,
(critics.avg_critic_score - users.avg_user_score) AS diff
FROM users_avg_year_rating users
JOIN critics_avg_year_rating critics
ON users.year = critics.year
WHERE critics.avg_critic_score > 9
OR users.avg_user_score > 9
ORDER BY year
LIMIT 10