package module;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Staging {
    public static void staging() {
        // 1. Kết nối db control
        Connection conn = null;
        PreparedStatement pre_control = null;
        conn = new GetConnection().getConnection("control");
        // 2. Tìm các file có status N và destination là F
        try {
            pre_control = conn.prepareStatement(
                    "SELECT data_file.id, data_file.name, data_file.row_count, data_file_configs.source_path, data_file_configs.location,data_file_configs.format,data_file_configs.colums, data_file_configs.destination from data_file JOIN data_file_configs ON data_file.df_config_id = data_file_configs.id where data_file.status = 'N' AND data_file_configs.destination='F' ");
            ResultSet re = pre_control.executeQuery();
            int id;
            String filename = null;
            // 3. Chạy từng dong`
            while (re.next()) {
               
                // 3.1 lấy từng thuộc tính
                id = re.getInt("id");
                filename = re.getString("name");
                int row_count = re.getInt("row_count");
                String source_path = re.getString("source_path");
                String location = re.getString("location"); 
                String format = re.getString("format");
                // 4. Ktra file có tồn tại trong folder chưa
                String path = location + "\\" + "\\"+ filename;
                File file = new File(path);
                if (!file.exists()) {
                    // 4.1 file không tồn tại - thông báo - cập nhật status: Error
                    System.out.println(path + " khong ton tai"); // 4.1.1 thông báo
                    String sql2 = "UPDATE data_file SET status='E', "
                            + "data_file.update_at=now() WHERE id=" + id;
                    pre_control = conn.prepareStatement(sql2);
                    pre_control.executeUpdate(); // 4.1.2 cập nhật status: Error
                } else {
                    // 4.2 file tồn tại - kết nối db staging - load dữ liệu - thông báo thành công - cập nhật status: C, destination: S và status: E khi không thể load all data
                    Connection conn_Staging = new GetConnection().getConnection("staging"); // 4.2.0 kết nối db staging
                    int count = 0;
                    String sql = "LOAD DATA INFILE '" + path + "' INTO TABLE  exchange_rate\r\n" + //
                            "COLUMNS TERMINATED BY ','\r\n" + //
                            "OPTIONALLY ENCLOSED BY '\"'\r\n" + //
                            "IGNORE 3 LINES;";
                    PreparedStatement pre_Staging = conn_Staging.prepareStatement(sql);
                    count = pre_Staging.executeUpdate(); // 4.2.1 load dữ liệu
                    System.out.println(
                            "Complete:\t" + "file name: " + filename
                                    + " ,total: " + count + " row"); //   4.2.2 thông báo hoàn thành
                    if (count == row_count) {
                        String sql2 = "UPDATE data_file join data_file_configs on data_file.df_config_id = data_file_configs.id SET status='C', destination = 'S', data_file.update_at=now() WHERE data_file.id="
                                + id;
                        pre_control = conn.prepareStatement(sql2);
                        pre_control.executeUpdate(); //  4.2.3 cập nhật status: C, destination: S khi load all data

                    } else {
                        String sql2 = "UPDATE data_file SET status='E', data_file.update_at=now() WHERE id=" + id;
                        pre_control = conn.prepareStatement(sql2);
                        pre_control.executeUpdate(); //  4.2.4 cập nhật status: E khi không thể load all data
                    }
                }
            }
            re.close();
            pre_control.close();
            conn.close();

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new Staging().staging();
    }
}
