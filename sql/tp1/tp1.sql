-- Exercice 1
WITH total_sales AS (
  SELECT name, sum(na_sales + eu_sales + jp_sales + other_sales) AS sales
  FROM video_game_sales
  GROUP BY name
)
SELECT name, sales
FROM total_sales
ORDER BY sales DESC
LIMIT 5;

-- Exercice 2
WITH average_sales_genre AS (
  SELECT genre, avg(na_sales + eu_sales + jp_sales + other_sales) AS sales
  FROM video_game_sales
  GROUP BY genre
)
SELECT genre, sales::MONEY
FROM average_sales_genre
ORDER BY sales DESC;

-- Exercice 3
WITH publisher_nb_games AS (
  SELECT publisher, count(*) AS nb_games
  FROM video_game_sales
  GROUP BY publisher
)
SELECT publisher, nb_games
FROM publisher_nb_games
WHERE nb_games > 100
ORDER BY nb_games DESC;

-- Exercice 4
WITH sales_by_genre AS (
  SELECT name, genre, sum(na_sales + eu_sales + jp_sales + other_sales) AS sales
  FROM video_game_sales
  GROUP BY name, genre
  ORDER BY genre
)
SELECT *
FROM sales_by_genre
ORDER BY genre, sales DESC;

-- Exercice 5
SELECT 
  name,
  platform,
  year,
  na_sales + eu_sales + jp_sales + other_sales AS sales_year,
  sum(na_sales + eu_sales + jp_sales + other_sales) OVER (PARTITION BY name ORDER BY year) AS cmt_sales
FROM video_game_sales
WHERE name ILIKE 'mario%'
AND year IS NOT NULL
ORDER by name, year DESC;

-- Exercice 6
WITH ranked_sales AS (
  SELECT 
    name, 
    year, 
    na_sales + eu_sales + jp_sales + other_sales AS sales,
    rank() OVER (PARTITION BY year ORDER BY na_sales + eu_sales + jp_sales + other_sales DESC)
  FROM video_game_sales
  WHERE year IS NOT NULL
)
SELECT name, year, sales
FROM ranked_sales
WHERE rank = 1;

-- Exercice 7
WITH strategy_sales_year AS (
  SELECT name, year, 
  na_sales + eu_sales + jp_sales + other_sales AS sales,
  sum(na_sales + eu_sales + jp_sales + other_sales) OVER (PARTITION BY name ORDER BY year) AS cumulative_sales
  FROM video_game_sales
  WHERE genre = 'Strategy'
  AND year IS NOT NULL
)
SELECT year, sum(sales)
FROM strategy_sales_year
GROUP BY year
ORDER BY year;

-- Exercice 8
with ranked_platforms_per_genre AS (
  select genre, platform, sum(na_sales + eu_sales + jp_sales + other_sales) as sales, rank() over (partition by genre ORDER BY sum(na_sales + eu_sales + jp_sales + other_sales))
  from video_game_sales
  group by genre, platform
  order by genre
)
select genre, platform, sales
from ranked_platforms_per_genre 
where rank = 1;
