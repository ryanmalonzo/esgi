-- Exercice 1
WITH total_sales AS (
  SELECT name, sum(eu_sales + na_sales + jp_sales + other_sales) AS sales 
  FROM video_game_sales
  GROUP BY name 
)
SELECT name, sales
FROM total_sales
ORDER BY sales DESC
LIMIT 5;

-- Exercice 2
WITH avg_sales_per_genre AS (
  SELECT genre, avg(eu_sales + na_sales + jp_sales + other_sales) AS sales
  FROM video_game_sales
  GROUP BY genre
)
SELECT genre, sales::MONEY
FROM avg_sales_per_genre 
ORDER BY sales DESC;

-- Exercice 3
WITH publisher_nb_games AS (
  SELECT publisher, count(*) AS nb_games
  FROM video_game_sales
  GROUP BY publisher
)
SELECT *
FROM publisher_nb_games
WHERE nb_games >= 100
ORDER BY nb_games DESC;

