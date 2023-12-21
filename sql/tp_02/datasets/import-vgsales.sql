DROP TABLE IF EXISTS video_game_sales;
CREATE TABLE video_game_sales (
    name VARCHAR(200) NOT NULL,
    platform VARCHAR(20) NOT NULL,
    year SMALLINT,
    genre VARCHAR(20) NOT NULL,
    publisher VARCHAR(50),
    NA_sales NUMERIC NOT NULL,
    EU_sales NUMERIC NOT NULL,
    JP_sales NUMERIC NOT NULL,
    other_sales NUMERIC NOT NULL
);

COPY video_game_sales(name, platform, year, genre, publisher, NA_sales, EU_sales, JP_sales, other_sales)
FROM '/sql/datasets/video-game-sales_16599.csv'
DELIMITER ','
CSV HEADER;
