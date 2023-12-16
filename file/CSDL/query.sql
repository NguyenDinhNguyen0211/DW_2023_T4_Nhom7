SELECT data_file.id, data_file.name, data_file.row_count, data_file_configs.source_path, data_file_configs.location,data_file_configs.format,data_file_configs.colums, data_file_configs.destination from data_file JOIN data_file_configs ON data_file.df_config_id = data_file_configs.id where data_file.status = 'N' AND data_file_configs.destination='F'

LOAD DATA INFILE 'D:\\DW_2023_T4_Nhom7\\file\\data.csv'
INTO TABLE  exchange_rate
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 3 LINES;