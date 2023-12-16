CREATE DATABASE control
USE control
CREATE TABLE data_file_configs (id SERIAL PRIMARY KEY, description text, source_path varchar(1000), location varchar(1000), format varchar(255), seperator varchar(255), colums text, destination varchar(1000), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at TIMESTAMP NULL, create_by varchar(255), update_by varchar(255));
CREATE TABLE data_file (id SERIAL PRIMARY KEY, df_config_id bigint not null, name varchar(1000), row_count int, status varchar(1000), note text, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, update_at  TIMESTAMP NULL, create_by varchar(255), update_by varchar(255));


INSERT INTO `data_file` (`id`, `df_config_id`, `name`, `row_count`, `status`, `note`, `created_at`, `update_at`, `create_by`, `update_by`) VALUES (1, 1, 'data.csv', 24, 'N', NULL, '2023-11-20 23:08:58', '2023-11-22', 'Nhat', NULL);
INSERT INTO `data_file_configs` (`id`, `description`, `source_path`, `location`, `format`, `seperator`, `colums`, `destination`, `created_at`, `update_at`, `create_by`, `update_by`) VALUES (1, 'Mô tả', 'vietcombank.com', 'D:\\DW_2023_T4_Nhom7\\file', '.csv', ',', '5', 'F', '2023-11-20 22:56:21', NULL, 'Nhat', NULL);
