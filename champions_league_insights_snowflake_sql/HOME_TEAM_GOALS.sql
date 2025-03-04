-- Find the top 3 teams which scored highest goals while playing at their home ground in UEFA Champions League 2020-21. 
SELECT TEAM_NAME_HOME, TEAM_HOME_SCORE
FROM SOCCER.TBL_UEFA_2020
ORDER BY TEAM_HOME_SCORE DESC
LIMIT 3;

