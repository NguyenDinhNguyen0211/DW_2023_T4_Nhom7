CREATE DATABASE warehouse;
USE warehouse;

CREATE TABLE bank_dim (
id_bank int PRIMARY KEY auto_increment,
bank_name VARCHAR(1000),
dt_expired DATETIME
);

CREATE TABLE currency_dim (
id_currency int PRIMARY KEY auto_increment,
id_bank int REFERENCES bank_dim(id_bank),
currency_code VARCHAR(50),
currency_name VARCHAR(1000),
dt_expired DATETIME
);

CREATE TABLE date_dim (
id_date int PRIMARY key auto_increment,
date DATETIME,
day VARCHAR(50),
month VARCHAR(50),
year VARCHAR(50),
hour VARCHAR(50),
minute VARCHAR(50)
);

CREATE TABLE exchange_rate_fact (
id int PRIMARY KEY auto_increment,
id_date int REFERENCES date_dim(id_date),
id_currency int REFERENCES currency_dim(id_currency),
buy_cash_rate FLOAT,
buy_transfer_rate FLOAT,
sale_rate FLOAT,
dt_expired DATETIME
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



CREATE TRIGGER insert_aggregate AFTER INSERT ON exchange_rate_fact FOR EACH ROW

BEGIN

INSERT INTO exchange_rate_aggregate (date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_at, update_at, create_by, update_by)
SELECT
    d.date,
    c.currency_code,
    c.currency_name,
    b.bank_name,
    e.buy_cash_rate AS buy_cash_rate,
    e.buy_transfer_rate AS buy_transfer_rate,
    e.sale_rate AS sale_rate,
	NOW() AS create_at,
	NOW() AS update_at,
    'Nhi' AS create_by,
    '' AS update_by
FROM
    exchange_rate_fact e
    JOIN currency_dim c ON e.id_currency = c.id_currency
		JOIN date_dim d ON e.id_date = d.id_date
		JOIN bank_dim b ON c.id_bank = b.id_bank
GROUP BY
		d.date,
    c.currency_code,
    c.currency_name,
		b.bank_name;
	END;




CREATE TRIGGER insert_aggregate AFTER INSERT ON exchange_rate_fact FOR EACH ROW

BEGIN
INSERT INTO avg_rate_aggregate (month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_at, update_at, create_by, update_by)
SELECT
    MONTH(d.date),
    YEAR(d.date),
    c.currency_code,
    c.currency_name,
    b.bank_name,
    AVG(e.buy_cash_rate) AS avg_buy_cash_rate,
    AVG(e.buy_transfer_rate) AS avg_buy_transfer_rate,
    AVG(e.sale_rate) AS avg_sale_rate,
    NOW() AS create_at,
	NOW() AS update_at,
    'Nhi' AS create_by,
    '' AS update_by
FROM
    exchange_rate_fact e
    JOIN currency_dim c ON e.id_currency = c.id_currency
		JOIN date_dim d ON e.id_date = d.id_date
		JOIN bank_dim b ON c.id_bank = b.id_bank
GROUP BY
    d.month,
    d.year,
    c.currency_code,
    c.currency_name,
		b.bank_name;
	END;
