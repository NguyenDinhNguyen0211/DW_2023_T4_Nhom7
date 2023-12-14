package extract2;

import module.GetConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Transform {
    Connection warehouse = null;
    public void transformDataBankDim(){
        Connection stagging = new GetConnection().getConnection("staging");
        warehouse = new GetConnection().getConnection("warehouse");

        // Transform dữ liệu vào bảng bank_dim
        String transformBankDimQuery = "INSERT INTO data_warehouse.bank_dim (bank_name, dt_expired) " +
                "SELECT DISTINCT bank_name, '2030-01-01' as dt_expired " +
                "FROM staging.exchange_rate";

        try (PreparedStatement preparedStatement = warehouse.prepareStatement(transformBankDimQuery)) {
//            preparedStatement.setInt(1, dfConfigId);
            preparedStatement.executeUpdate();
            System.out.println("thanh cong");
        } catch (SQLException e) {
            System.out.println("that bai");
            throw new RuntimeException(e);
        }
    }
    public void transformDataCurrencyDim(){
        Connection stagging = new GetConnection().getConnection("staging");
        warehouse = new GetConnection().getConnection("warehouse");

        // Transform dữ liệu vào bảng bank_dim
        String transformBankDimQuery = "INSERT INTO data_warehouse.currency_dim (id_bank, currency_code, currency_name, dt_expired)\n" +
                "SELECT\n" +
                "    bd.id_bank,\n" +
                "    er.currency_code,\n" +
                "    er.currency_name,\n" +
                "    '2030-01-01' as dt_expired\n" +
                "FROM staging.exchange_rate er\n" +
                "JOIN data_warehouse.bank_dim bd ON er.bank_name = bd.bank_name";

        try (PreparedStatement preparedStatement = warehouse.prepareStatement(transformBankDimQuery)) {
//            preparedStatement.setInt(1, dfConfigId);
            preparedStatement.executeUpdate();
            System.out.println("thanh cong");
        } catch (SQLException e) {
            System.out.println("that bai");
            throw new RuntimeException(e);
        }
    }
    public void transformDataDateDim(){
        Connection stagging = new GetConnection().getConnection("staging");
        warehouse = new GetConnection().getConnection("warehouse");

        // Transform dữ liệu vào bảng bank_dim
        String transformBankDimQuery = "INSERT INTO data_warehouse.date_dim (date, day, month, year, hour, minute)\n" +
                "SELECT\n" +
                "    DISTINCT exchange_rate.`date`,\n" +
                "    DAY(exchange_rate.`date`) as day,\n" +
                "    MONTH(exchange_rate.`date`) as month,\n" +
                "    YEAR(exchange_rate.`date`) as year,\n" +
                "    HOUR(exchange_rate.`date`) as hour,\n" +
                "    MINUTE(exchange_rate.`date`) as minute\n" +
                "FROM staging.exchange_rate";

        try (PreparedStatement preparedStatement = warehouse.prepareStatement(transformBankDimQuery)) {
//            preparedStatement.setInt(1, dfConfigId);
            preparedStatement.executeUpdate();
            System.out.println("thanh cong");
        } catch (SQLException e) {
            System.out.println("that bai");
            throw new RuntimeException(e);
        }
    }
    public void transformDataExchangeRateFact(){
        Connection stagging = new GetConnection().getConnection("staging");
        warehouse = new GetConnection().getConnection("warehouse");

        // Transform dữ liệu vào bảng bank_dim
        String transformBankDimQuery = "INSERT INTO data_warehouse.exchange_rate_fact (id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired)\n" +
                "SELECT\n" +
                "    dd.id_date,\n" +
                "    cd.id_currency,\n" +
                "    er.buy_cash_rate,\n" +
                "    er.buy_transfer_rate,\n" +
                "    er.sale_rate,\n" +
                "    NOW() as dt_expired\n" +
                "FROM staging.exchange_rate er\n" +
                "JOIN data_warehouse.date_dim dd ON er.date = dd.date\n" +
                "JOIN data_warehouse.currency_dim cd ON er.currency_code = cd.currency_code\n" +
                "ORDER BY er.date, cd.id_currency";

        try (PreparedStatement preparedStatement = warehouse.prepareStatement(transformBankDimQuery)) {
//            preparedStatement.setInt(1, dfConfigId);
            preparedStatement.executeUpdate();
            System.out.println("thanh cong");
        } catch (SQLException e) {
            System.out.println("that bai");
            throw new RuntimeException(e);
        }
    }
    public static void main(String[] args) {
//        Connection stagging = new GetConnection().getConnection("staging");
        Connection warehouse = new GetConnection().getConnection("warehouse");
        Transform n = new Transform();
        n.transformDataBankDim();
        n.transformDataCurrencyDim();
        n.transformDataDateDim();
        n.transformDataExchangeRateFact();
    }
}
/*
-- staging exchange_rate --> bank_dim
INSERT INTO data_warehouse.bank_dim (bank_name, dt_expired)
SELECT DISTINCT bank_name, '2030-01-01' as dt_expired
FROM staging.exchange_rate;

-- staging exchange_rate --> currency_dim
INSERT INTO data_warehouse.currency_dim (id_bank, currency_code, currency_name, dt_expired)
SELECT
    bd.id_bank,
    er.currency_code,
    er.currency_name,
    '2030-01-01' as dt_expired
FROM staging.exchange_rate er
JOIN data_warehouse.bank_dim bd ON er.bank_name = bd.bank_name;

-- staging exchange_rate --> date_dim
INSERT INTO data_warehouse.date_dim (date, day, month, year, hour, minute)
SELECT
    DISTINCT exchange_rate.`date`,
    DAYNAME(date),
    MONTHNAME(date),
    YEAR(date),
    HOUR(date),
    MINUTE(date)
FROM staging.exchange_rate;
-- dùng
INSERT INTO data_warehouse.date_dim (date, day, month, year, hour, minute)
SELECT
    DISTINCT exchange_rate.`date`,
    DAY(exchange_rate.`date`) as day,
    MONTH(exchange_rate.`date`) as month,
    YEAR(exchange_rate.`date`) as year,
    HOUR(exchange_rate.`date`) as hour,
    MINUTE(exchange_rate.`date`) as minute
FROM staging.exchange_rate;

-- staging exchange_rate --> exchange_rate_fact
INSERT INTO data_warehouse.exchange_rate_fact (id_date, id_currency, buy_cash_rate, buy_transfer_rate, sale_rate, dt_expired)
SELECT
    dd.id_date,
    cd.id_currency,
    er.buy_cash_rate,
    er.buy_transfer_rate,
    er.sale_rate,
    NOW() as dt_expired
FROM staging.exchange_rate er
JOIN data_warehouse.date_dim dd ON er.date = dd.date
JOIN data_warehouse.currency_dim cd ON er.currency_code = cd.currency_code
ORDER BY er.date, cd.id_currency;

-- staging exchange_rate --> aggregate
INSERT INTO data_warehouse.exchange_rate_aggregate (date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_by, update_by, update_at)
SELECT
    dd.date,
    cd.currency_code,
    cd.currency_name,
    bd.bank_name,
    AVG(er.buy_cash_rate) as buy_cash_rate,
    AVG(er.buy_transfer_rate) as buy_transfer_rate,
    AVG(er.sale_rate) as sale_rate,
    'admin' as create_by,
    'admin' as update_by,
    NOW() as update_at
FROM staging.exchange_rate er
JOIN data_warehouse.date_dim dd ON er.date = dd.date
JOIN data_warehouse.currency_dim cd ON er.currency_code = cd.currency_code
JOIN data_warehouse.bank_dim bd ON er.bank_name = bd.bank_name
GROUP BY dd.date, cd.currency_code, bd.bank_name;

-- staging exchange_rate --> avg
INSERT INTO data_warehouse.avg_rate_aggregate (month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_by, update_by, update_at)
SELECT
    MONTHNAME(dd.date) as month_avg,
    YEAR(dd.date) as year_avg,
    cd.currency_code,
    cd.currency_name,
    bd.bank_name,
    AVG(er.buy_cash_rate) as avg_buy_cash_rate,
    AVG(er.buy_transfer_rate) as avg_buy_transfer_rate,
    AVG(er.sale_rate) as avg_sale_rate,
    'admin' as create_by,
    'admin' as update_by,
    NOW() as update_at
FROM staging.exchange_rate er
JOIN data_warehouse.date_dim dd ON er.date = dd.date
JOIN data_warehouse.currency_dim cd ON er.currency_code = cd.currency_code
JOIN data_warehouse.bank_dim bd ON er.bank_name = bd.bank_name
GROUP BY MONTH(dd.date), YEAR(dd.date), cd.currency_code, bd.bank_name;
 */

/*
test
INSERT INTO data_warehouse.exchange_rate_aggregate (date, currency_code, currency_name, bank_name, buy_cash_rate, buy_transfer_rate, sale_rate, create_by, update_by, update_at)
SELECT
    dd.date,
    cd.currency_code,
    cd.currency_name,
    bd.bank_name,
    AVG(er.buy_cash_rate) as buy_cash_rate,
    AVG(er.buy_transfer_rate) as buy_transfer_rate,
    AVG(er.sale_rate) as sale_rate,
    'admin' as create_by,
    'admin' as update_by,
    NOW() as update_at
FROM staging.exchange_rate er
JOIN data_warehouse.date_dim dd ON er.date = dd.date
JOIN data_warehouse.currency_dim cd ON er.currency_code = cd.currency_code
JOIN data_warehouse.bank_dim bd ON er.bank_name = bd.bank_name
GROUP BY dd.date, cd.currency_code, bd.bank_name;

INSERT INTO data_warehouse.avg_rate_aggregate (month_avg, year_avg, currency_code, currency_name, bank_name, avg_buy_cash_rate, avg_buy_transfer_rate, avg_sale_rate, create_by, update_by, update_at)
SELECT
    MONTHNAME(dd.date) as month_avg,
    YEAR(dd.date) as year_avg,
    cd.currency_code,
    cd.currency_name,
    bd.bank_name,
    AVG(er.buy_cash_rate) as avg_buy_cash_rate,
    AVG(er.buy_transfer_rate) as avg_buy_transfer_rate,
    AVG(er.sale_rate) as avg_sale_rate,
    'admin' as create_by,
    'admin' as update_by,
    NOW() as update_at
FROM staging.exchange_rate er
JOIN data_warehouse.date_dim dd ON er.date = dd.date
JOIN data_warehouse.currency_dim cd ON er.currency_code = cd.currency_code AND er.bank_name = cd.bank_name
JOIN data_warehouse.bank_dim bd ON er.bank_name = bd.bank_name
GROUP BY MONTH(dd.date), YEAR(dd.date), cd.currency_code, bd.bank_name;
 */