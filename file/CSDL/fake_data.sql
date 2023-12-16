insert into bank_dim (id_bank, bank_name, dt_expired) values (1, 'VCB', '9999-12-31 23:59:00');
insert into bank_dim (id_bank, bank_name, dt_expired) values (2, 'BIDV', '9999-12-31 23:59:00');




insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (1, 1, 'GBP', 'Bang Anh', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (2, 2, 'GBP', 'Bang Anh', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (3, 1, 'VND', 'VN', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (4, 2, 'VND', 'VN', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (5, 1, 'USD', 'My', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (6, 2, 'USD', 'My', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (7, 1, 'KRW', 'HQ', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (8, 2, 'KRW', 'HQ', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (9, 1, 'HKD', 'HongKong', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (10, 2, 'HKD', 'HongKong', '9999-12-31 23:59:00');



insert into date_dim (id_date, date, day, month, year, hour, minute) values (1, '2023-11-17 8:30:00', 17, 11, 2023, 8, 30);
insert into date_dim (id_date, date, day, month, year, hour, minute) values (2, '2023-11-18 8:30:00', 18, 11, 2023, 8, 30);
insert into date_dim (id_date, date, day, month, year, hour, minute) values (3, '2023-11-19 8:30:00', 19, 11, 2023, 8, 30);
insert into date_dim (id_date, date, day, month, year, hour, minute) values (4, '2023-10-17 8:30:00', 17, 10, 2023, 8, 30);
insert into date_dim (id_date, date, day, month, year, hour, minute) values (5, '2023-10-18 8:30:00', 18, 10, 2023, 8, 30);
insert into date_dim (id_date, date, day, month, year, hour, minute) values (6, '2023-10-19 8:30:00', 19, 10, 2023, 8, 30);



insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (1, 1, 1, 62, 4, 25, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (2, 1, 2, 69, 63, 10, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (3, 1, 3, 90, 35, 29, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (4, 1, 4, 92, 8, 94, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (5, 1, 5, 66, 21, 60, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (6, 1, 6, 77, 3, 70, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (7, 1, 7, 73, 32, 72, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (8, 1, 8, 84, 93, 91, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (9, 1, 9, 80, 90, 72, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (10, 1, 10, 83, 52, 62, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (11, 2, 1, 87, 20, 22, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (12, 2, 2, 97, 64, 99, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (13, 2, 3, 64, 10, 89, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (14, 2, 4, 73, 4, 2, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (15, 2, 5, 30, 90, 56, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (16, 2, 6, 12, 3, 44, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (17, 2, 7, 37, 26, 53, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (18, 2, 8, 10, 3, 84, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (19, 2, 9, 28, 96, 83, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (20, 2, 10, 48, 26, 76, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (21, 3, 1, 76, 52, 81, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (22, 3, 2, 13, 86, 91, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (23, 3, 3, 96, 81, 71, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (24, 3, 4, 12, 89, 94, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (25, 3, 5, 34, 61, 68, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (26, 3, 6, 30, 46, 36, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (27, 3, 7, 11, 24, 82, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (28, 3, 8, 40, 72, 44, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (29, 3, 9, 36, 42, 54, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (30, 3, 10, 42, 36, 36, '9999-12-31 23:59:00');



insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (31, 4, 1, 10, 4, 25, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (32, 4, 2, 12, 63, 10, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (33, 4, 3, 90, 35, 29, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (34, 4, 4, 92, 8, 94, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (35, 4, 5, 66, 21, 60, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (36, 4, 6, 64, 3, 70, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (37, 4, 7, 44, 32, 72, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (38, 4, 8, 46, 93, 91, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (39, 4, 9, 80, 90, 72, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (40, 4, 10, 83, 52, 62, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (41, 5, 1, 11, 20, 22, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (42, 5, 2, 13, 64, 99, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (43, 5, 3, 90.5, 10, 89, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (44, 5, 4, 91, 4, 2, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (45, 5, 5, 65, 90, 56, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (46, 5, 6, 65, 3, 44, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (47, 5, 7, 37, 26, 53, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (48, 5, 8, 38, 3, 84, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (49, 5, 9, 81, 96, 83, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (50, 5, 10, 82, 26, 76, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (51, 6, 1, 16, 52, 81, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (52, 6, 2, 17, 86, 91, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (53, 6, 3, 96, 81, 71, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (54, 6, 4, 96.6, 89, 94, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (55, 6, 5, 68, 61, 68, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (56, 6, 6, 67, 46, 36, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (57, 6, 7, 40, 24, 82, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (58, 6, 8, 40.6, 72, 44, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (59, 6, 9, 80, 42, 54, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (60, 6, 10, 80.54, 36, 36, '9999-12-31 23:59:00');