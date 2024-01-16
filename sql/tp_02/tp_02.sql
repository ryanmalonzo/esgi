-- Exercice 1
WITH sales AS (
  SELECT
    name,
    genre,
    (eu_sales + na_sales + jp_sales + other_sales) AS sales,
    percent_rank() OVER (ORDER BY (eu_sales + na_sales + jp_sales + other_sales)) AS rank
  FROM video_game_sales
  WHERE genre = 'Action'
)
SELECT *
FROM sales
WHERE rank >= 0.9
ORDER BY rank DESC;

-- Exercice 2
SELECT
    name,
    (eu_sales + na_sales + jp_sales + other_sales) AS sales,
    cume_dist() OVER (ORDER BY (eu_sales + na_sales + jp_sales + other_sales) DESC) AS dist
FROM video_game_sales
WHERE platform = 'PS4';

-- Exercice 3
SELECT
  name,
  (eu_sales + na_sales + jp_sales + other_sales) AS sales,
  ntile(4) OVER (ORDER BY (eu_sales + na_sales + jp_sales + other_sales) DESC) AS quartile
FROM video_game_sales;

-- Exercice 4
WITH yearly_platform_sales AS (
  SELECT
    year,
    sum(eu_sales + na_sales + jp_sales + other_sales) AS sales
  FROM video_game_sales
  WHERE genre = 'Platform'
  AND year IS NOT NULL
  GROUP BY year
  ORDER BY year
)
SELECT 
  *, 
  (sales - lag(sales, 1) OVER(ORDER BY year)) AS diff
FROM yearly_platform_sales;

-- Exercice 5
WITH yearly_platform_sales AS (
  SELECT
    year,
    sum(eu_sales + na_sales + jp_sales + other_sales) AS sales
  FROM video_game_sales
  WHERE genre = 'Role-Playing'
  AND year IS NOT NULL
  GROUP BY year
  ORDER BY year
)
SELECT 
  *, 
  (sales - lead(sales, 1) OVER(ORDER BY year)) AS diff
FROM yearly_platform_sales;

-- Exercice 6
SELECT
  name,
  first_value(name) OVER (PARTITION BY year ORDER BY year) AS first
FROM video_game_sales;

-- Exercice 7
SELECT
  name,
  last_value(name) OVER (PARTITION BY year ORDER BY year) AS last 
FROM video_game_sales;

-- Exercice 8
SELECT
  name,
  nth_value(name, 3) OVER (PARTITION BY year ORDER BY year) AS third 
FROM video_game_sales;

-- Exercice 9
WITH RECURSIVE h(init_h, init_sub, nb_employees) AS (
    VALUES (1, SELECT min())
  UNION ALL
    SELECT m+2, n+1 FROM h WHERE n < 100
)
SELECT * FROM t;
