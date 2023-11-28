package extract;

import module.GetConnection;

import java.io.File;
import java.sql.*;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.time.LocalDate;

public class CheckFile {
    private static int addDataConfigFile(Connection connection) throws SQLException {
        // Câu SQL chèn dữ liệu vào bảng data_file
        String insertSql = "INSERT INTO data_file_configs (description, source_path, location, format, `seperator`, colums, destination, created_at, update_at, create_by, update_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        long dfConfigId = -1;
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSql,Statement.RETURN_GENERATED_KEYS)) {
                   String source_path = "vietcombank.com";
                   String location = "D:\\DW_2023_T4_Nhom7\\file\\";
            Date createdAt = new Date(); // Lấy ngày hiện tại
            Timestamp updatedAt = null; // Chưa có thông tin về ngày cập nhật
            String createdBy = "Nhật";
            String updatedBy = null; // Chưa có thông tin về người cập nhật

                    // Thay đổi dữ liệu này dựa trên cấu trúc bảng và cột thực tế của bạn
                    preparedStatement.setString(1, "mô tả"); // description
                    preparedStatement.setString(2,source_path ); // source_path
                    preparedStatement.setString(3,location ); // location
                    preparedStatement.setString(4, ".xlxx"); // format
                    preparedStatement.setString(5, ","); // separator
                    preparedStatement.setString(6, "24"); // columns
                    preparedStatement.setString(7, "D:\\"); // destination
            preparedStatement.setTimestamp(8, new Timestamp(createdAt.getTime()));
            preparedStatement.setTimestamp(9,  new Timestamp(createdAt.getTime()));
                    preparedStatement.setString(10, createdBy); // created_by
                    preparedStatement.setString(11, updatedBy); // updated_by

                    // Thực hiện chèn dữ liệu
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                // Lấy ID được tạo tự động
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        dfConfigId = generatedKeys.getInt(1);
                    }
                }
            }
        }

                return (int) dfConfigId;
    }

    private static void addDataFile(Connection connection, File file, int dfConfigId) throws SQLException {
        // Câu SQL chèn dữ liệu vào bảng data_file
        String insertSql = "INSERT INTO data_file (df_config_id, name, row_count, status, note, created_at, update_at, create_by, update_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSql)) {
            // Giả sử bạn có thông tin cần thêm từ file CSV
            int dfConfig = dfConfigId;
            String name = file.getName();
            int rowCount = 24;
            String status = "N";
            String note = "Data imported successfully";
            Date createdAt = new Date(); // Lấy ngày hiện tại
            Timestamp updatedAt = null; // Chưa có thông tin về ngày cập nhật
            String createdBy = "Nhật";
            String updatedBy = null; // Chưa có thông tin về người cập nhật

            // Thiết lập các tham số cho câu SQL
            preparedStatement.setLong(1, dfConfig);
            preparedStatement.setString(2, name);
            preparedStatement.setInt(3, rowCount);
            preparedStatement.setString(4, status);
            preparedStatement.setString(5, note);
            preparedStatement.setTimestamp(6, new Timestamp(createdAt.getTime()));
            preparedStatement.setTimestamp(7,  new Timestamp(createdAt.getTime()));
            preparedStatement.setString(8, createdBy);
            preparedStatement.setString(9, updatedBy);

            // Thực hiện thêm dữ liệu
            preparedStatement.executeUpdate();
        }
    }

    private static boolean checkFileExits(String filePath){
        File file = new File(filePath);

        if (file.exists()) {
            System.out.println("File exists!");
           return  true;
        } else {
            System.out.println("File does not exist!");
        }
        return false;
    }
    private static String checkFilesInFolder(String folderPath) {
        File folder = new File(folderPath);
        String path ="";
        if (folder.exists() && folder.isDirectory()) {
            File[] files = folder.listFiles();

            if (files != null) {
                for (File file : files) {
                    if (file.isFile() && isFileValid(file)) {
//                        System.out.println("File " + file.getName() + " is valid.");
                        // Gọi phương thức thêm thông tin vào cơ sở dữ liệu control từ file CSV ở đây
                        path = file.getName();
                    } else {
//                        System.out.println("File " + file.getName() + " is not valid.");
                    }
                }
                return path;
            }
        } else {
            System.out.println("Folder does not exist or is not a directory.");
        }
        return "";
    }

    private static boolean checkFilesInFolderTrue(String folderPath) {
        File folder = new File(folderPath);
        System.out.println(folder.getAbsolutePath()+"folder.getAbsolutePath()");
        if (folder.exists() && folder.isDirectory()) {
            File[] files = folder.listFiles();

            if (files != null) {
                for (File file : files) {
                    if (file.isFile() && isFileValid(file)) {
                        System.out.println("File " + file.getName() + " is valid.");
                        // Gọi phương thức thêm thông tin vào cơ sở dữ liệu control từ file CSV ở đây
                        return true;
                    } else {
                        System.out.println("File " + file.getName() + " is not valid.");
                    }
                }
//                return true;
            }
        } else {
            System.out.println("Folder does not exist or is not a directory.");
        }
        return false;
    }
    private static boolean isFileValid(File file) {
        // Kiểm tra xem tên file có đúng cấu trúc ngày không
        // Ví dụ: vietcombank_data_20231128.xlsx
        String fileName = file.getName();
        String prefix = "vietcombank_data_";
        int dateStartIndex = prefix.length();
        int dateEndIndex = dateStartIndex + 8; // Ngày có độ dài là 8 ký tự

        if (fileName.startsWith(prefix) && fileName.length() >= dateEndIndex) {
            String dateString = fileName.substring(dateStartIndex, dateEndIndex);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");

            try {
                LocalDate fileDate = LocalDate.parse(dateString, formatter);
                LocalDate currentDate = LocalDate.now();

                return currentDate.equals(fileDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return false;
    }
    public static void main(String[] args) {

        String folderPath = "D:\\DW_2023_T4_Nhom7\\file\\";
        // 1. check file data exist in folder /D:\\DW_2023_T4_Nhom7\\file
        String filePath = checkFilesInFolder("D:\\DW_2023_T4_Nhom7\\file\\");
        System.out.println(filePath+"filePath");
        File file = new File(filePath);
//        System.out.println(file.getAbsolutePath());
        System.out.println( checkFilesInFolderTrue(folderPath)+"checkFilesInFolderTrue(filePath)");

            // 2. check connect db control
            Connection connection = new GetConnection().getConnection("control");

            // Thêm thông tin từ file CSV vào cơ sở dữ liệu
            if (checkFilesInFolderTrue(folderPath) && connection != null) {
                try {
                    //3. insert data_config_file
                    int dfConfigId = addDataConfigFile(connection);
                    // 4. insert data_file set status file "N"
                    addDataFile(connection, file, dfConfigId);
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        // 5. close connection
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }


    }
}