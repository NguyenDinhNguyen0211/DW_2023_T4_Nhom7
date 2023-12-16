use control;
insert into data_file_configs (id, description, source_path, location, format, seperator, colums, destination, created_at, update_at, create_by, update_by) values (1, null, 'vietcombank.com', 'D:\\\\DW_2023_T4_Nhom7\\\\file', '.csv', ',', 24, 'M', '2023-12-03 8:30:00', '2023-12-03 8:35:00', 'Nhật', null);
insert into data_file_configs (id, description, source_path, location, format, seperator, colums, destination, created_at, update_at, create_by, update_by) values (2, null, 'bidv.com', 'D:\\\\DW_2023_T4_Nhom7\\\\file', '.csv', ',', 24, 'M', '2023-12-03 8:30:00', '2023-12-03 8:35:00', 'Nhật', null);

insert into data_file (id, df_config_id, name, row_count, status, note, created_at, update_at, create_by, update_by) values (1, 1, 'vietcombank_data_20231211_085312.csv', 24, 'C', 'Data import success', '2023-12-03 8:35:00', '2023-12-03 8:35:00', 'Nhật', null);
insert into data_file (id, df_config_id, name, row_count, status, note, created_at, update_at, create_by, update_by) values (2, 2, 'bidv_data_20231211_085522.csv', 24, 'C', 'Data import success', '2023-12-03 8:35:00', '2023-12-03 8:35:00', 'Nhật', null);


use warehouse;
insert into bank_dim (id_bank, bank_name, dt_expired) values (1, 'VCB', '9999-12-31 23:59:00');
insert into bank_dim (id_bank, bank_name, dt_expired) values (2, 'BIDV', '9999-12-31 23:59:00');


insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (1, 1, 'USD', 'US DOLLAR', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (2, 1, 'EUR', 'EURO', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (3, 1, 'GBP', 'POUND STERLING', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (4, 1, 'JPY', 'YEN', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (5, 1, 'AUD', 'AUSTRALIAN DOLLAR', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (6, 1, 'SGD', 'SINGAPORE DOLLAR', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (7, 1, 'THB', 'THAILAND BAHT', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (8, 1, 'CAD', 'CANADIAN DOLLAR', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (9, 1, 'CHF', 'SWISS FRANC', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (10, 1, 'HKD', 'HONGKONG DOLLAR', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (11, 1, 'CNY', 'YUAN RENMINBI', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (12, 1, 'DKK', 'DANISH KRONE', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (13, 1, 'INR', 'INDIAN RUPEE', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (14, 1, 'KRW', 'KOREAN WON', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (15, 1, 'KWD', 'KUWAITI DINAR', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (16, 1, 'MYR', 'MALAYSIAN RINGGIT', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (17, 1, 'NOK', 'NORWEGIAN KRONER', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (18, 1, 'RUB', 'RUSSIAN RUBLE', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (19, 1, 'SAR', 'SAUDI RIAL', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (20, 1, 'SEK', 'SWEDISH KRONA', '9999-12-31 23:59:00');


insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (21, 2, 'USD', 'Dollar Mỹ', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (22, 2, 'USD(1-2-5)', 'Dollar', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (23, 2, 'USD(10-20)', 'Dollar', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (24, 2, 'GBP', 'Bảng Anh', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (25, 2, 'HKD', 'Dollar Hồng Kông', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (26, 2, 'CHF', 'Franc Thụy Sỹ', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (27, 2, 'JPY', 'Yên Nhật', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (28, 2, 'THB', 'Baht Thái Lan', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (29, 2, 'AUD', 'Dollar Australia', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (30, 2, 'CAD', 'Dollar Canada', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (31, 2, 'SGD', 'Dollar Singapore', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (32, 2, 'SEK', 'Krone Thụy Điển', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (33, 2, 'LAK', 'Kip Lào', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (34, 2, 'DKK', 'Krone Đan Mạch', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (35, 2, 'NOK', 'Krone Na Uy', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (36, 2, 'CNY', 'Nhân Dân Tệ', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (37, 2, 'RUB', 'Rub Nga', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (38, 2, 'NZD', 'Dollar New Zealand', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (39, 2, 'KRW', 'Won Hàn Quốc', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (40, 2, 'EUR', 'Euro', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (41, 2, 'TWD', 'Dollar Đài Loan', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (42, 2, 'MYR', 'Ringgit Malaysia', '9999-12-31 23:59:00');
insert into currency_dim (id_currency, id_bank, currency_code, currency_name, dt_expired) values (43, 2, 'SAR', 'Saudi Arabian Riyals', '9999-12-31 23:59:00');


insert into date_dim (id_date, date, day, month, year, hour, minute) values (1, '2023-12-03 8:30:00', 1, 12, 2023, 10, 00);
insert into date_dim (id_date, date, day, month, year, hour, minute) values (2, '2023-12-03 8:30:00', 2, 12, 2023, 20, 00);


insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (1, 1, 1, 24080	, 24110, 24450, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (2, 1, 2, 25781.55, 26041.97, 27197.16, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (3, 1, 3, 29888.43, 30190.33, 31161.13, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (4, 1, 4, 159.30, 160.91, 168.63, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (5, 1, 5, 15620.81, 15778.59, 16285.97, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (6, 1, 6, 17691.56, 17870.26, 18444.90, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (7, 1, 7, 607.59, 675.10, 701.00, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (8, 1, 8, 17470.81, 17647.28, 18214.75, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (9, 1, 9, 27049.00, 27322.22, 28200.79, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (10, 1, 10, 3029.11, 3059.70, 3158.09, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (11, 1, 11, 3331.69, 3365.34, 3474.08, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (12, 1, 12, NULL, 3484.07, 3617.75, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (13, 1, 13, NULL, 290.74, 302.39, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (14, 1, 14, 16.07, 17.86, 19.48, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (15, 1, 15, NULL, 78405.37, 81545.81, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (16, 1, 16, NULL, 5137.93, 5250.36, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (17, 1, 17, NULL, 2203.39, 2297.11, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (18, 1, 18, NULL, 256.80, 284.30, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (19, 1, 19, NULL, 6454.01, 6712.52, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (20, 1, 20, NULL, 2269.76, 2366.29, '9999-12-31 23:59:00');


insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (21, 1, 21, 24100, 24100, 24400, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (22, 1, 22, 23881, NULL, NULL, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (23, 1, 23, 23881, NULL, NULL, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (24, 1, 24, 29994, 30175, 31125, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (25, 1, 25, 3040, 3062, 3150, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (26, 1, 26, 27283, 27448, 27283, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (27, 1, 27, 167.12, 168.13, 175.9, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (28, 1, 28, 661.48, 668.16, 713.58, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (29, 1, 29, 15969, 16066, 16518, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (30, 1, 30, 17617, 17723, 18262, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (31, 1, 31, 17870, 17977, 18479, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (32, 1, 32, NULL, 2323,2400, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (33, 1, 33, NULL, 0.9, 1.24, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (34, 1, 34, NULL, 3488, 3603, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (35, 1, 35, NULL, 2221, 2295, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (36, 1, 36, NULL, 3363, 3454, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (37, 1, 37, NULL, 245, 314, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (38, 1, 38, 14840, 14929, 15342, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (39, 1, 39, 16.44, 18.16, 19.49, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (40, 1, 40, 25944, 26015, 27136, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (41, 1, 41, 701.6, NULL, 847.59, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (42, 1, 42, 4858.16, NULL, 5471.69, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (43, 1, 43, NULL, 6360.83, 6685.8, '9999-12-31 23:59:00');



insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (44, 2, 1, 24060	, 24090, 24430, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (45, 2, 2, 25748.48, 26008.56, 27162.31, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (46, 2, 3, 29830.70, 30132.02, 31100.98, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (47, 2, 4, 166.42, 168.10, 176.16, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (48, 2, 5, 15858.49, 16018.68, 16533.79, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (49, 2, 6, 17787.36	, 17967.03, 18544.80, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (50, 2, 7, 611.07, 678.97, 705.02, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (51, 2, 8, 17565.35, 17742.77, 18313.33, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (52, 2, 9, 27101.05, 27374.80, 28255.10, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (53, 2, 10, 3027.58, 3058.16, 3156.50, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (54, 2, 11, 3330.58, 3364.22, 3472.93, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (55, 2, 12, NULL, 3479.52, 3613.03, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (56, 2, 13, NULL, 290.39, 302.02, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (57, 2, 14, 16.18, 17.98, 19.61, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (58, 2, 15, NULL, 78697.52, 81849.78, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (59, 2, 16, NULL, 5142.49, 5255.04, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (60, 2, 17, NULL, 2215.10, 2309.32, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (61, 2, 18, NULL, 256.14, 285.79, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (62, 2, 19, NULL, 6449.03, 6707.35, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (63, 2, 20, NULL, 2311.97, 2410.30, '9999-12-31 23:59:00');


insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (64, 2, 21, 24100, 24100, 24400, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (65, 2, 22, 23881, NULL, NULL, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (66, 2, 23, 23881, NULL, NULL, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (67, 2, 24, 29994, 30175, 31125, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (68, 2, 25, 3040, 3062, 3150, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (69, 2, 26, 27283, 27448, 28305, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (70, 2, 27, 167.12, 168.13, 175.9, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (71, 2, 28, 661.48, 668.16, 713.58, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (72, 2, 29, 15969, 16066, 16518, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (73, 2, 30, 17617, 17723, 18262, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (74, 2, 31, 17870, 17977, 18479, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (75, 2, 32, NULL, 2323,2400, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (76, 2, 33, NULL, 0.9, 1.24, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (77, 2, 34, NULL, 3488, 3603, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (78, 2, 35, NULL, 2221, 2295, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (79, 2, 36, NULL, 3363, 3454, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (80, 2, 37, NULL, 245, 314, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (81, 2, 38, 14840, 14929, 15342, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (82, 2, 39, 16.44, 18.16, 19.49, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (83, 2, 40, 25944, 26015, 27136, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (84, 2, 41, 701.6, NULL, 847.59, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (85, 2, 42, 4858.16, NULL, 5471.69, '9999-12-31 23:59:00');
insert into exchange_rate_fact (id, id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired) values (86, 2, 43, NULL, 6360.83, 6685.8, '9999-12-31 23:59:00');