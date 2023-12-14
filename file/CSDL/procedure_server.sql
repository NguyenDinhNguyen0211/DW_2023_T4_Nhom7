CREATE DEFINER=`bqvtglivbf`@`%` PROCEDURE `renameTable`()
BEGIN
RENAME TABLE avg_rate_aggregate TO temp_table, db_rename_avg TO avg_rate_aggregate, temp_table TO db_rename_avg;
RENAME TABLE exchange_rate_aggregate TO temp_table, db_rename_exchange TO exchange_rate_aggregate, temp_table TO db_rename_exchange;
END;


CREATE DEFINER=`bqvtglivbf`@`%` PROCEDURE `copyDB`()
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