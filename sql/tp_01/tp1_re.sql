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

-- Exercice 4
WITH game_sales AS (
  SELECT name, genre, eu_sales + na_sales + jp_sales + other_sales AS sales
  FROM video_game_sales
  GROUP BY name, genre, sales
)
SELECT *
FROM game_sales
ORDER BY genre, sales DESC;
WITH game_sales AS (
  SELECT name, genre, eu_sales + na_sales + jp_sales + other_sales AS sales
  FROM video_game_sales
  GROUP BY name, genre, sales
)
SELECT *
FROM game_sales
ORDER BY genre, sales DESC;

-- Exercice 5
WITH mario_sales AS (
  SELECT name, platform, year, eu_sales + na_sales + jp_sales + other_sales AS sales
  FROM video_game_sales
  WHERE name ilike 'Mario%'
  GROUP BY name, platform, year, sales
)
SELECT name, platform, year, sales, sum(sales) OVER (PARTITION BY year)
FROM mario_sales
WHERE year IS NOT NULL
ORDER BY year DESC;

-- Exercice 6
WITH ranked_sales AS (
  SELECT 
    name, 
    year, 
    eu_sales + na_sales + jp_sales + other_sales AS sales,
    rank() OVER (PARTITION BY year ORDER BY eu_sales + na_sales + jp_sales + other_sales) AS rank
  FROM video_game_sales
)
SELECT
  name,
  year,
  sales
FROM ranked_sales 
WHERE rank = 1
AND year IS NOT NULL
ORDER BY year DESC;

-- Exercice 7
-- Je crois pas que ce soit ça mais j'y passe trop de temps et je saurai jamais de toute façon (:
WITH cumulative_sales AS (
  SELECT 
  name,
  genre,
  year, 
  eu_sales + na_sales + jp_sales + other_sales AS sales,
  sum(eu_sales + na_sales + jp_sales + other_sales) OVER (ORDER BY year) AS cml_sales 
  FROM video_game_sales
  WHERE genre = 'Strategy'
)
SELECT name, year, sales, cml_sales
FROM cumulative_sales;

-- Exercice 8
WITH top_platforms AS (
  SELECT
    genre,
    platform,
    sum(eu_sales + na_sales + jp_sales + other_sales) AS sales,
    rank() OVER (PARTITION BY genre ORDER BY sum(eu_sales + na_sales + jp_sales + other_sales)) AS rank
  FROM video_game_sales
)
SELECT DISTINCT genre, platform, sales 
FROM top_platforms
WHERE rank = 1;

-- Feb 5

-- Exercice 4
with sales_genre as (
  select name,
  eu_sales+na_sales+jp_sales+other_sales as sales,
  genre,
  rank() over (
    partition by (genre)
    order by eu_sales+na_sales+jp_sales+other_sales desc
  )
  from video_game_sales
)
select *
from sales_genre;

-- Exercice 5
select name,
eu_sales+jp_sales+na_sales+other_sales as sales,
year,
sum(eu_sales+jp_sales+na_sales+other_sales) over (
  partition by (year)
) as cum_sales
from video_game_sales
where name ilike 'mario%'
order by year;

-- Exercice 6
with ranked_sales_per_year as (
  select name,
  year,
  eu_sales+na_sales+jp_sales+other_sales as sales,
  rank() over (
    partition by (year)
    order by eu_sales+na_sales+jp_sales+other_sales desc
  ) as rk 
  from video_game_sales
)
select *
from ranked_sales_per_year
where rk = 1
order by year;
