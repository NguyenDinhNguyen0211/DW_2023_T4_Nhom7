use warehouse;

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
WHERE d.id_date = (SELECT max(id_date) FROM date_dim);


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
		c.id_bank
		
		
use mart;

INSERT INTO mart.db_rename_avg (month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_at, update_at, create_by, update_by)
SELECT COALESCE(month_avg, 'N/A'), COALESCE(year_avg, 'N/A'), COALESCE(currency_code, 'N/A'), COALESCE(currency_name, 'N/A'), COALESCE(bank_name, 'N/A'), COALESCE(avg_buy_cash_rate, 'N/A'), COALESCE(avg_buy_transfer_rate, 'N/A'), COALESCE(avg_sale_rate, 'N/A'), COALESCE(create_at, 'N/A'),  COALESCE(update_at, 'N/A'), COALESCE(create_by, 'N/A'), COALESCE(update_by, 'N/A')
FROM warehouse.avg_rate_aggregate
where update_at < CURRENT_TIMESTAMP ORDER BY update_at DESC limit 2;


INSERT INTO mart.db_rename_exchange (date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_at, update_at, create_by, update_by)
SELECT id, COALESCE(date, 'N/A'), COALESCE(currency_code, 'N/A'), COALESCE(currency_name, 'N/A'), COALESCE(bank_name, 'N/A'), COALESCE(buy_cash_rate, 'N/A'), COALESCE(buy_transfer_rate, 'N/A'), COALESCE(sale_rate, 'N/A'), COALESCE(create_at, 'N/A'),  COALESCE(update_at, 'N/A'), COALESCE(create_by, 'N/A'), COALESCE(update_by, 'N/A')
FROM warehouse.exchange_rate_aggregate 
where update_at < CURRENT_TIMESTAMP ORDER BY update_at DESC limit 43;
