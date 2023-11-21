CREATE DATABASE DATA_MART;
USE data_mart;

CREATE TABLE db_rename (
id int primary key auto_increment,
month_avg VARCHAR(50) NOT NULL,
year_avg VARCHAR(50) NOT NULL,
date VARCHAR(50) NOT NULL,
currency_code VARCHAR(50) NOT NULL,
currency_name VARCHAR(50) NOT NULL,
bank_name VARCHAR(1000) NOT NULL,
buy_cash_rate FLOAT NOT NULL,
buy_transfer_rate FLOAT NOT NULL,
sale_rate FLOAT NOT NULL,
avg_sale_rate FLOAT NOT NULL,
avg_buy_transfer_rate FLOAT NOT NULL,
avg_buy_cash_rate FLOAT NOT NULL,
create_by VARCHAR(1000) NOT NULL
);


CREATE TABLE exchange_rate (
id int primary key auto_increment,
month_avg VARCHAR(50) NOT NULL,
year_avg VARCHAR(50) NOT NULL,
date VARCHAR(50) NOT NULL,
currency_code VARCHAR(50) NOT NULL,
currency_name VARCHAR(50) NOT NULL,
bank_name VARCHAR(1000) NOT NULL,
buy_cash_rate FLOAT NOT NULL,
buy_transfer_rate FLOAT NOT NULL,
sale_rate FLOAT NOT NULL,
avg_sale_rate FLOAT NOT NULL,
avg_buy_transfer_rate FLOAT NOT NULL,
avg_buy_cash_rate FLOAT NOT NULL,
create_by VARCHAR(1000) NOT NULL
);


INSERT INTO DATA_MART.db_rename (month_avg, year_avg, date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_by)
SELECT COALESCE(month_avg, 'N/A'), COALESCE(year_avg, 'N/A'), COALESCE(date, 'N/A'), COALESCE(currency_code, 'N/A'), COALESCE(currency_name, 'N/A'), COALESCE(bank_name, 'N/A'), COALESCE(buy_cash_rate, 'N/A'), COALESCE(buy_transfer_rate, 'N/A'), COALESCE(sale_rate, 'N/A'), COALESCE(avg_buy_cash_rate, 'N/A'), COALESCE(avg_buy_transfer_rate, 'N/A'), COALESCE(avg_sale_rate, 'N/A'), COALESCE(create_by, 'N/A')
FROM DATA_WAREHOUSE.temp;

RENAME TABLE exchange_rate TO exchange_rate_temp;
RENAME TABLE db_rename TO exchange_rate;
DROP TABLE exchange_rate_temp;

