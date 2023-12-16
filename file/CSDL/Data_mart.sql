CREATE DATABASE mart;
USE mart;

CREATE TABLE db_rename_exchange(
id int PRIMARY KEY auto_increment,
date DATETIME, 
currency_code VARCHAR(50),
currency_name VARCHAR(1000),
bank_name VARCHAR(1000),
buy_cash_rate FLOAT,
buy_transfer_rate FLOAT,
sale_rate FLOAT,
create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_at TIMESTAMP NULL,
create_by VARCHAR(1000),
update_by VARCHAR(1000)
);

CREATE TABLE db_rename_avg(
id int PRIMARY KEY auto_increment,
month_avg VARCHAR(50),
year_avg VARCHAR(50), 
currency_code VARCHAR(50),
currency_name VARCHAR(1000),
bank_name VARCHAR(1000),
avg_buy_cash_rate FLOAT,
avg_buy_transfer_rate FLOAT,
avg_sale_rate FLOAT,
create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_at TIMESTAMP NULL,
create_by VARCHAR(1000),
update_by VARCHAR(1000)

);
CREATE TABLE exchange_rate_aggregate(
id int PRIMARY KEY auto_increment,
date DATETIME, 
currency_code VARCHAR(50),
currency_name VARCHAR(1000),
bank_name VARCHAR(1000),
buy_cash_rate FLOAT,
buy_transfer_rate FLOAT,
sale_rate FLOAT,
create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_at TIMESTAMP NULL,
create_by VARCHAR(1000),
update_by VARCHAR(1000)
);

CREATE TABLE avg_rate_aggregate(
id int PRIMARY KEY auto_increment,
month_avg VARCHAR(50),
year_avg VARCHAR(50), 
currency_code VARCHAR(50),
currency_name VARCHAR(1000),
bank_name VARCHAR(1000),
avg_buy_cash_rate FLOAT,
avg_buy_transfer_rate FLOAT,
avg_sale_rate FLOAT,
create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_at TIMESTAMP NULL,
create_by VARCHAR(1000),
update_by VARCHAR(1000)
);

CREATE DEFINER=`root`@`localhost` PROCEDURE `copyDB`()
BEGIN
		INSERT INTO mart.db_rename_exchange (date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_at, update_at, create_by, update_by)
		SELECT date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_at, update_at, create_by, update_by
		FROM mart.exchange_rate_aggregate
WHERE mart.exchange_rate_aggregate.update_at < CURRENT_TIMESTAMP;


INSERT INTO mart.db_rename_avg (month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_at, update_at, create_by, update_by)
		SELECT month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_at, update_at, create_by, update_by
		FROM mart.avg_rate_aggregate
WHERE mart.avg_rate_aggregate.update_at < CURRENT_TIMESTAMP;

END;


CREATE DEFINER=`root`@`localhost` PROCEDURE `renameTable`()
BEGIN
RENAME TABLE avg_rate_aggregate TO temp_table, db_rename_avg TO avg_rate_aggregate, temp_table TO db_rename_avg;
RENAME TABLE exchange_rate_aggregate TO temp_table, db_rename_exchange TO exchange_rate_aggregate, temp_table TO db_rename_exchange;

END;


