-- Exercice 1
with action_sales as (
  select name,
  eu_sales + na_sales + jp_sales + other_sales as sales,
  percent_rank() over (
    order by eu_sales + na_sales + jp_sales + other_sales
  ) as pr 
  from video_game_sales
  where genre = 'Action'
)
select *
from action_sales
where pr >= 0.9
order by sales desc;

-- Exercice 2
with ps4_dist as (
  select name,
  eu_sales + na_sales + jp_sales + other_sales as sales,
  cume_dist() over (
    order by eu_sales + na_sales + jp_sales + other_sales desc
  )
  from video_game_sales
  where platform = 'PS4'
)
select *
from ps4_dist
order by sales desc;


-- Exercice 3
select name,
eu_sales + na_sales + jp_sales + other_sales as sales,
ntile(4) over (
  order by eu_sales + na_sales + jp_sales + other_sales
) as quartile
from video_game_sales;

-- Exercice 4
with platform_sales as (
  select genre,
  year,
  sum(eu_sales + na_sales + jp_sales + other_sales) as total_sales
  from video_game_sales
  where genre = 'Platform'
  group by genre, year
  order by year
)
select *,
(total_sales - lag(total_sales, 1) over (order by year asc)) as diff
from platform_sales;

-- Exercice 5
with rp_sales as (
  select genre,
  year,
  sum(eu_sales+na_sales+jp_sales+other_sales) as total_sales
  from video_game_sales
  where genre = 'Role-Playing'
  and year is not null
  group by genre, year
  order by year
)
select *,
(total_sales - lead(total_sales, 1) over (order by year)) as diff
from rp_sales;

-- Exercice 6
select name,
year,
first_value(name) over (
  partition by year
  order by name
)
from video_game_sales
order by year, name;
