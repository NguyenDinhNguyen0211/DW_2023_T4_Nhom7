package module;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Staging {
    public void staging() {
        Connection conn = null;
        PreparedStatement pre_control = null;
        // 1. Kết nối db control
        conn = new GetConnection().getConnection("control");
        try {
            ResultSet re = checkStatus(conn, pre_control, "P", "F");
            // 2. Kiểm tra có tồn tại tiến trình đang chạy
            if (re.next()) {
                // 2.1 Thông báo
                System.out.println("Currently, there is another process at work\n" +
                        "Use command: \n" +
                        "\"stop\" to stop\n" +
                        "\"stop--emergency\" for emergency stop\n" +
                        "\"run--hands\" to run with your hands");
                System.exit(0);
            }
            // 3. Tìm các hàng có status N và destination là F
            re = checkStatus(conn, pre_control, "N", "F");
            int id;
            String filename = null;
            // 4. Lấy giá trị từng hàng
            while (re.next()) {
                id = re.getInt("id");
                filename = re.getString("name");
                int row_count = re.getInt("row_count");
                String source_path = re.getString("source_path");
                String location = re.getString("location");
                String format = re.getString("format");
                String path = location + "\\" + "\\" + filename;
                File file = new File(path);
                // 4.1 Cập nhật trạng thái P
                String sql3 = "UPDATE data_file SET status='P', "
                        + "data_file.update_at=now() WHERE id=" + id;
                pre_control = conn.prepareStatement(sql3);
                pre_control.executeUpdate();
                // 4.2 Ktra file có tồn tại trong folder
                if (!file.exists()) {
                    // file không tồn tại - cập nhật status: E - thông báo
                    String sql2 = "UPDATE data_file SET status='E', "
                            + "data_file.update_at=now() WHERE id=" + id;
                    pre_control = conn.prepareStatement(sql2);
                    // 4.2.1 cập nhật status: Error
                    pre_control.executeUpdate();
                    // 4.2.1a thông báo file không tồn tại
                    System.out.println(path + " does not exist");
                } else {
                    // file tồn tại - kết nối db staging - load dữ liệu - thông báo thành công -
                    // cập nhật status: C, destination: S và status: E khi không thể load all data
                    // 4.2.2 kết nối db staging
                    Connection conn_Staging = new GetConnection().getConnection("staging");
                    int count = 0;
                    String sql = "LOAD DATA INFILE '" + path + "' INTO TABLE  exchange_rate\r\n" + //
                            "COLUMNS TERMINATED BY ','\r\n" + //
                            "OPTIONALLY ENCLOSED BY '\"'\r\n" + //
                            "IGNORE 3 LINES;";
                    PreparedStatement pre_Staging = conn_Staging.prepareStatement(sql);
                    // 4.2.3 import data từ file vào db staging
                    count = pre_Staging.executeUpdate();
                    // 4.2.4 Kiểm tra có load hết dữ liệu không
                    if (count == row_count) {
                        String sql2 = "UPDATE data_file join data_file_configs on data_file.df_config_id = data_file_configs.id SET status='N', destination = 'S', data_file.update_at=now() WHERE data_file.id="
                                + id;
                        pre_control.close();
                        pre_control = conn.prepareStatement(sql2);
                        // 4.2.4a cập nhật status: N, destination: S
                        pre_control.executeUpdate();
                    } else {
                        String sql2 = "UPDATE data_file SET status='E', data_file.update_at=now() WHERE id=" + id;
                        pre_control.close();
                        pre_control = conn.prepareStatement(sql2);
                        // 4.2.4b cập nhật status: E
                        pre_control.executeUpdate();
                    }
                    // 4.2.5 thông báo hoàn thành
                    System.out.println("Complete:\n" + "file name: " + filename
                            + " ,total: " + count + "//" + row_count + " row");
                }
            }
            // 5. Đóng kết nối db
            // re.close();
            // pre_control.close();
            // conn.close();

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public ResultSet checkStatus(Connection conn, PreparedStatement pre_control, String status, String destination)
            throws SQLException {
        pre_control = conn.prepareStatement(
                "SELECT data_file.id, data_file.name, data_file.row_count," +
                        "data_file_configs.source_path, data_file_configs.location," +
                        "data_file_configs.format,data_file_configs.colums, data_file_configs.destination " +
                        "from data_file JOIN data_file_configs ON data_file.df_config_id = data_file_configs.id " +
                        "where data_file.status='" + status + "' AND data_file_configs.destination='" + destination
                        + "'");
        return pre_control.executeQuery();
    }
}
