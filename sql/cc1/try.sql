SELECT
  product,
  price,
  quantity,
  quantity * price AS total,
  EXTRACT(YEAR FROM purchased_at) AS purchase_year
FROM orders
ORDER BY purchased_at;

WITH totals AS (
  SELECT
    quantity * price AS total
    FROM orders
)
SELECT sum(total)
FROM totals;

WITH orders_plus_year AS (
  SELECT
    *,
    EXTRACT(YEAR FROM purchased_at) AS purchase_year
  FROM orders
)
SELECT
  purchase_year,
  category,
  sum(quantity) AS sold_units,
  sum(quantity * price)::MONEY AS total_ca
FROM orders_plus_year
GROUP BY category, purchase_year
ORDER BY purchase_year, category;

WITH ca_pixel8_2023 AS (
  SELECT
    (quantity * price) AS ca
  FROM orders
  WHERE product = 'Pixel 8'
  AND EXTRACT(YEAR FROM purchased_at) = 2023
)
SELECT avg(ca)::MONEY
FROM ca_pixel8_2023;

WITH xyz AS (
  SELECT
    product,
    extract(year from purchased_at) as purchase_year,
    (quantity * price) as ca
  FROM orders
),
yyy as (
  select
    product,
    purchase_year,
    sum(ca),
    dense_rank() OVER (order by sum(ca) desc)
  from xyz
  group by product, purchase_year
)
SELECT *
from yyy;

