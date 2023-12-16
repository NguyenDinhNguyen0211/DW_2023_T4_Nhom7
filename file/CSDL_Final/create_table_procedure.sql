
CREATE DATABASE control;
USE control;

CREATE TABLE data_file_configs (id SERIAL PRIMARY KEY, description text, source_path varchar(1000), location varchar(1000), format varchar(255), seperator varchar(255), colums text, destination varchar(1000), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by varchar(255), update_by varchar(255));

CREATE TABLE data_file (id SERIAL PRIMARY KEY, df_config_id bigint not null, name varchar(1000), row_count int, status varchar(1000), note text, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at  TIMESTAMP NULL, create_by varchar(255), update_by varchar(255));


CREATE DATABASE staging;
USE staging;
CREATE TABLE exchange_rate (currency_code text, currency_name text, buy_cash_rate text, buy_transfer_rate text, sale_rate text, bank_name text, date text);



CREATE DATABASE warehouse;
USE warehouse;

CREATE TABLE bank_dim (id_bank int PRIMARY KEY auto_increment, bank_name VARCHAR(1000), dt_expired DATETIME);

CREATE TABLE currency_dim (id_currency int PRIMARY KEY auto_increment, id_bank int REFERENCES bank_dim(id_bank),currency_code VARCHAR(50), currency_name VARCHAR(1000), dt_expired DATETIME);

CREATE TABLE date_dim (id_date int PRIMARY key auto_increment, date DATETIME, day VARCHAR(50), month VARCHAR(50), year VARCHAR(50), hour VARCHAR(50), minute VARCHAR(50));

CREATE TABLE exchange_rate_fact (id int PRIMARY KEY auto_increment, id_date int REFERENCES date_dim(id_date),id_currency int REFERENCES currency_dim(id_currency), buy_cash_rate FLOAT, buy_transfer_rate FLOAT, sale_rate FLOAT, dt_expired DATETIME);

CREATE TABLE exchange_rate_aggregate(id int PRIMARY KEY auto_increment, date DATETIME, currency_code VARCHAR(50), currency_name VARCHAR(1000), bank_name VARCHAR(1000), buy_cash_rate FLOAT, buy_transfer_rate FLOAT, sale_rate FLOAT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by VARCHAR(1000),update_by VARCHAR(1000));

CREATE TABLE avg_rate_aggregate(id int PRIMARY KEY auto_increment, month_avg VARCHAR(50), year_avg VARCHAR(50), currency_code VARCHAR(50), currency_name VARCHAR(1000), bank_name VARCHAR(1000), avg_buy_cash_rate FLOAT, avg_buy_transfer_rate FLOAT, avg_sale_rate FLOAT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by VARCHAR(1000),update_by VARCHAR(1000));





CREATE DATABASE mart;
USE mart;

CREATE TABLE db_rename_exchange(id int PRIMARY KEY auto_increment, date DATETIME, currency_code VARCHAR(50), currency_name VARCHAR(1000), bank_name VARCHAR(1000), buy_cash_rate FLOAT, buy_transfer_rate FLOAT, sale_rate FLOAT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by VARCHAR(1000), update_by VARCHAR(1000));

CREATE TABLE db_rename_avg(id int PRIMARY KEY auto_increment, month_avg VARCHAR(50), year_avg VARCHAR(50), currency_code VARCHAR(50),currency_name VARCHAR(1000), bank_name VARCHAR(1000), avg_buy_cash_rate FLOAT, avg_buy_transfer_rate FLOAT, avg_sale_rate FLOAT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by VARCHAR(1000), update_by VARCHAR(1000));

CREATE TABLE exchange_rate_aggregate(id int PRIMARY KEY auto_increment, date DATETIME, currency_code VARCHAR(50), currency_name VARCHAR(1000), bank_name VARCHAR(1000), buy_cash_rate FLOAT, buy_transfer_rate FLOAT, sale_rate FLOAT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by VARCHAR(1000), update_by VARCHAR(1000));

CREATE TABLE avg_rate_aggregate(id int PRIMARY KEY auto_increment, month_avg VARCHAR(50), year_avg VARCHAR(50), currency_code VARCHAR(50), currency_name VARCHAR(1000), bank_name VARCHAR(1000), avg_buy_cash_rate FLOAT, avg_buy_transfer_rate FLOAT, avg_sale_rate FLOAT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by VARCHAR(1000), update_by VARCHAR(1000));

CREATE DEFINER=`root`@`localhost` PROCEDURE `copyDB`()
BEGIN
		INSERT INTO mart.db_rename_exchange (date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_at, update_at, create_by, update_by)
		SELECT date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_at, update_at, create_by, update_by
		FROM mart.exchange_rate_aggregate
WHERE mart.exchange_rate_aggregate.update_at < CURRENT_TIMESTAMP LIMIT 43;


INSERT INTO mart.db_rename_avg (month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_at, update_at, create_by, update_by)
		SELECT month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_at, update_at, create_by, update_by
		FROM mart.avg_rate_aggregate
WHERE mart.avg_rate_aggregate.update_at < CURRENT_TIMESTAMP LIMIT 2;

END;


CREATE DEFINER=`root`@`localhost` PROCEDURE `renameTable`()
BEGIN
RENAME TABLE avg_rate_aggregate TO temp_table, db_rename_avg TO avg_rate_aggregate, temp_table TO db_rename_avg;
RENAME TABLE exchange_rate_aggregate TO temp_table, db_rename_exchange TO exchange_rate_aggregate, temp_table TO db_rename_exchange;

END;



LOAD DATA INFILE 'D:\\DW_2023_T4_Nhom7\\file\\data.csv'
INTO TABLE  exchange_rate
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 3 LINES;