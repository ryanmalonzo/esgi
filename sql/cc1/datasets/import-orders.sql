DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    product VARCHAR(100) NOT NULL,
    brand VARCHAR(20) NOT NULL,
    category VARCHAR(20) NOT NULL,
    price NUMERIC NOT NULL,
    quantity INT NOT NULL,
    purchased_at TIMESTAMP NOT NULL
);

COPY orders(product, brand, category, price, quantity, purchased_at)
FROM '/sql/datasets/orders_20000.csv'
DELIMITER ','
CSV HEADER;
