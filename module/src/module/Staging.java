package module;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class Staging {
    String url_source = null;
    String[] url_sources = null;

    public void staging() throws SQLException, IOException {
        Connection conn = null;
        PreparedStatement pre_control = null;
        String link = ".\\config\\config.properties";
        // 1. Đọc file config.properties
        try (InputStream input = new FileInputStream(link)) {
            Properties prop = new Properties();
            prop.load(input);
            // 2. Lấy đường dẫn các source data từ file config
            url_source = prop.getProperty("url_source");
            url_sources = url_source.trim().split(",");
            // 3. Kết nối db control
            conn = new GetConnection().getConnection("control");
            // 4. Còn source data từ file config
            for (String us : url_sources) {
                try {
                    // 5. Tìm các hàng có status P và destination là S
                    ResultSet re = checkStatus(conn, pre_control, "P", "S", us);
                    // 5. Kiểm tra có tồn tại tiến trình đang chạy
                    if (re.next()) {
                        // 6.1 Thông báo
                        System.out.println("Currently, there is another process at work."
                        // + " Use command: \n" +
                        // "\"stop\" to stop\n" +
                        // "\"stop--emergency\" for emergency stop\n" +
                        // "\"run--hands\" to run with your hands"
                        );
                    } else {
                        // 7. Tìm các hàng có status C và destination là F
                        re = checkStatus(conn, pre_control, "C", "F", us);
                        int id;
                        String filename = null;
                        // 8. Kiểm tra còn dòng không (Lấy giá trị từng dòng)
                        while (re.next()) {
                            id = re.getInt("id");
                            filename = re.getString("name");
                            int row_count = re.getInt("row_count");
                            String source_path = re.getString("source_path");
                            String location = re.getString("location");
                            String format = re.getString("format");
                            String path = location + "\\" + "\\" + filename;
                            File file = new File(path);
                            // 8.1 Cập nhật trạng thái status='P' và destination = S
                            String sql4 = "UPDATE data_file SET status='E', "
                                    + "data_file.update_at=now() WHERE id=" + id;
                            String sql3 = "UPDATE data_file join data_file_configs on data_file.df_config_id = data_file_configs.id SET status='P', destination = 'S', data_file.update_at=now(), data_file_configs.update_at=now() WHERE data_file.id="
                                    + id;
                            pre_control = conn.prepareStatement(sql3);
                            pre_control.executeUpdate();
                            // 8.2 Ktra file có tồn tại trong folder
                            if (!file.exists()) {
                                // file không tồn tại - cập nhật status: E - thông báo
                                pre_control = conn.prepareStatement(sql4);
                                // 8.2.1 cập nhật status: Error
                                pre_control.executeUpdate();
                                // 8.2.2 thông báo file không tồn tại
                                System.out.println(path + " does not exist");
                            } else {
                                // file tồn tại - kết nối db staging - load dữ liệu - thông báo thành công -
                                // cập nhật status: C, destination: S và status: E khi không thể load all data
                                // 8.3 kết nối db staging
                                GetConnection getConn = new GetConnection();
                                Connection conn_Staging = getConn.getConnection("staging");
                                // 8.3.1 Thông báo "Error connect staging"
                                if (getConn.getCheckE()) {
                                    getConn.setCheckE(false);
                                    pre_control.close();
                                    // 8.3.2 Cập nhật trạng thái E
                                    pre_control = conn.prepareStatement(sql4);
                                    pre_control.executeUpdate();
                                    System.exit(0);
                                }
                                int count = 0;
                                String sql = "LOAD DATA INFILE '" + path + "' INTO TABLE  exchange_rate\r\n" + //
                                        "COLUMNS TERMINATED BY ','\r\n" + //
                                        "OPTIONALLY ENCLOSED BY '\"'\r\n" + //
                                        "IGNORE 3 LINES;";
                                PreparedStatement pre_Staging = conn_Staging.prepareStatement(sql);
                                // 8.4 import data từ file vào db staging
                                count = pre_Staging.executeUpdate();
                                // 8.5 Kiểm tra có load hết dữ liệu không
                                if (count == row_count) {
                                    String sql2 = "UPDATE data_file join data_file_configs on data_file.df_config_id = data_file_configs.id SET status='C', destination = 'S', data_file.update_at=now() WHERE data_file.id="
                                            + id;
                                    pre_control.close();
                                    pre_control = conn.prepareStatement(sql2);
                                    // 8.5a cập nhật status: C, destination: S
                                    pre_control.executeUpdate();
                                } else {
                                    String sql2 = "UPDATE data_file SET status='E', data_file.update_at=now() WHERE id="
                                            + id;
                                    pre_control.close();
                                    pre_control = conn.prepareStatement(sql2);
                                    // 8.5b cập nhật status: E
                                    pre_control.executeUpdate();
                                }
                                // 8.6 thông báo hoàn thành
                                System.out.println("Complete:\n" + "file name: " + filename
                                        + " ,total: " + count + "//" + row_count + " row");
                            }
                        }
                    }
                    re.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    System.out.println(e.getMessage());
                    e.printStackTrace();
                }
            }
            // 9. Đóng kết nối db
            pre_control.close();
            conn.close();
        } catch (IOException ex) {
            // 1.1 Thông báo không tìm thấy file
            System.out.println("Unknown file " + link);
            // 1.2 Log file
            new GetConnection().logFile("Unknown file " + link + "\n" + ex.getMessage());
            System.exit(0);
        }
    }

    public ResultSet checkStatus(Connection conn, PreparedStatement pre_control, String status, String destination,
            String bank)
            throws SQLException {
        pre_control = conn.prepareStatement(
                "SELECT data_file.id, data_file.name, data_file.row_count," +
                        "data_file_configs.source_path, data_file_configs.location," +
                        "data_file_configs.format,data_file_configs.colums, data_file_configs.destination " +
                        "from data_file JOIN data_file_configs ON data_file.df_config_id = data_file_configs.id " +
                        "where data_file.status='" + status + "' AND data_file_configs.destination='" + destination
                        + "' AND data_file_configs.source_path='" + bank + "'");
        return pre_control.executeQuery();
    }
}
