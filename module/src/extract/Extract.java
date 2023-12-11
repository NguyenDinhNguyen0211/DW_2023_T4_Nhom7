package extract2;

import model.DataFile;
import model.DataFileConfig;
import module.GetConnection;

import java.io.File;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class Extract {
    Connection conn = null;
    PreparedStatement pre_control = null;
    CrawlVietcombank vietcom;
    public static void loadConfig(){
        Connection connection = new GetConnection().getConnection("control");
    }
    public DataFile addDataFile(int dfConfigId) throws SQLException {
        conn = new GetConnection().getConnection("control");
        String insertSql = "INSERT INTO data_file (df_config_id, name, row_count, status, note, created_at, update_at, create_by, update_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String currentDateTime = dateFormat.format(new Date());

        String csvFileName="";
        switch (dfConfigId){
            case 1 :
                 csvFileName = "vietcombank_data_" + currentDateTime + ".csv";
                break;
            case 2 :
                 csvFileName = "bidv_data_" + currentDateTime + ".csv";
                break;
        }
//        String csvFileName = "vietcombank_data_" + currentDateTime + ".csv";

        try (PreparedStatement preparedStatement = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            int dfConfig = dfConfigId;
            String name = csvFileName;
            int rowCount = 24;
            String status = "N";
            String note = "Data imported successfully";
            Date createdAt = new Date();
            Timestamp updatedAt = null;
            String createdBy = "Nhật";
            String updatedBy = null;

            preparedStatement.setLong(1, dfConfig);
            preparedStatement.setString(2, name);
            preparedStatement.setInt(3, rowCount);
            preparedStatement.setString(4, status);
            preparedStatement.setString(5, note);
            preparedStatement.setTimestamp(6, new Timestamp(createdAt.getTime()));
            preparedStatement.setTimestamp(7, new Timestamp(createdAt.getTime()));
            preparedStatement.setString(8, createdBy);
            preparedStatement.setString(9, updatedBy);

            preparedStatement.executeUpdate();

            // Retrieve the generated keys (including the ID of the inserted row)
            ResultSet resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                long generatedId = resultSet.getLong(1);

                // Create a DataFile object with the inserted data
                DataFile dataFile = new DataFile();
                dataFile.setId(generatedId);
                dataFile.setDfConfigId(dfConfigId);
                dataFile.setName(name);
                dataFile.setRowCount(rowCount);
                dataFile.setStatus(status);
                dataFile.setNote(note);

                return dataFile;
            } else {
                // Handle the case where no generated keys are available
                return null;
            }
        }
}
    public DataFileConfig check(int idFileConfig){
        conn = new GetConnection().getConnection("control");
        DataFileConfig dataFileConfig = null;
        // Câu SQL chèn dữ liệu vào bảng data_file
        String query = "SELECT data_file_configs.id, data_file_configs.source_path, data_file_configs.location,data_file_configs.format,data_file_configs.colums, data_file_configs.destination from data_file_configs " +
                "WHERE data_file_configs.id = ?";
        try {
            // Thực hiện truy vấn để lấy thông tin từ data_file_configs
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, idFileConfig);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Kiểm tra xem có dữ liệu trả về không
            if (resultSet.next()) {

                // Tạo đối tượng model.DataFileConfig và gán giá trị từ ResultSet
                 dataFileConfig = new DataFileConfig();
                dataFileConfig.setId(resultSet.getLong("id"));
                dataFileConfig.setSourcePath(resultSet.getString("source_path"));
                dataFileConfig.setLocation(resultSet.getString("location"));
                dataFileConfig.setFormat(resultSet.getString("format"));
                dataFileConfig.setColumns(resultSet.getString("colums"));
                dataFileConfig.setDestination(resultSet.getString("destination"));

                System.out.println("Co du liệu id config");

                // CrawlData.crawl(sourcePath, location, format, columns, destination);
            } else {
                System.out.println("Không tìm thấy dữ liệu cho idFileConfig: " + idFileConfig);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
return dataFileConfig;
    }
//    public File runScript(int idFileConfig){
//        File csvFile=null;
//        switch (idFileConfig){
//            case 1 :
//                 csvFile = new CrawlVietcombank().crawlDataVietcombankFile();
//                System.out.println("Chạy script data thành công");
//            break;
//            case 2 :
//                System.out.println("chua co");;
//                break;
//        }
//        return csvFile;
//    }
    public static boolean runScript(int idFileConfig){
        boolean success = false;
        File csvFile=null;
        switch (idFileConfig){
            case 1 :
                if(new CrawlVietcombank().crawlDataVietcombank()){
                    System.out.println("Chạy script data thành công");
                    success = true;
                }
                else {
                    System.out.println("Chạy script data không thành công");
                    success = false;
                }
                break;
            case 2 :
                if(new RunPythonScript().runScript("E:\\DW_2023_T4_Nhom7-main\\module\\crawl\\bidvcrawl.py")){
                    System.out.println("Chạy script data thành công");
                    success = true;
                }
                else {
                    System.out.println("Chạy script data không thành công");
                    success = false;
                }
                break;
        }
        return success;
    }
    private static boolean checkFile(File csvFile) {
        if (csvFile != null && csvFile.exists()) {
            // Thực hiện các thao tác kiểm tra hoặc xử lý với file CSV tại đây
            System.out.println("File exists: " + csvFile.getAbsolutePath());
            return true;
        }
        return false;
    }

    private void updateStatus(int dataFileId, String newStatus,String note) throws SQLException {
        String updateStatusAndErrorSql = "UPDATE data_file SET status = ?,note =? WHERE id = ?";
        try (PreparedStatement updateStatement = conn.prepareStatement(updateStatusAndErrorSql)) {
            updateStatement.setString(1, newStatus);
            updateStatement.setString(2, note);
            updateStatement.setLong(3, dataFileId);
            updateStatement.executeUpdate();
        }
    }
    private void updateFileName(int dataFileId,String actualFileName) throws SQLException {
        String updateStatusAndFileNameSql = "UPDATE data_file SET name = ? WHERE id = ?";
        try (PreparedStatement updateStatement = conn.prepareStatement(updateStatusAndFileNameSql)) {
            updateStatement.setString(1, actualFileName);
            updateStatement.setLong(2, dataFileId);
            updateStatement.executeUpdate();
        }
    }
    public static void main(String[] args) {
//        loadConfig();
        Connection connect = new GetConnection().getConnection("control");
        Extract n  = new Extract();
//        // check xem co config voi id là 1 khong
//        n.check(1);
        // thong tin config đó luu vao model
        DataFileConfig dataFileConfig =   n.check(2);
        System.out.println(dataFileConfig);
//        //lay id cua
        int dfConfigId = (int) dataFileConfig.getId();

        DataFile dataFile =null;
        try {
             dataFile = n.addDataFile(dfConfigId);
            System.out.println(dataFile);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            n.updateStatus((int) dataFile.getId(), "P","Data import process");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        // Introduce a delay of approximately 10 seconds (10000 milliseconds)
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        boolean crawlSuccess = runScript(dfConfigId);
//        String actualFileName = getActualFileName(dataFile.getId());
        if (crawlSuccess) {
            System.out.println("Crawl operation successful.");
            // Update status to "Complete" in the database
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
                String currentDateTime = dateFormat.format(new Date());

                String csvFileName = "";
                switch (dfConfigId){
                    case 1 :
                        csvFileName = "vietcombank_data_" + currentDateTime + ".csv";
                        break;
                    case 2 :
                        csvFileName = "bidv_data_" + currentDateTime + ".csv";
                        break;
                }
                n.updateStatus((int) dataFile.getId(), "C","Data import success");
                n.updateFileName((int) dataFile.getId(),csvFileName);
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception if needed
            }
        } else {
            System.out.println("Crawl operation failed.");
            // Update status to "Error" in the database
            try {
                n.updateStatus((int) dataFile.getId(), "E","Data import error");
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception if needed
            } finally {
                try {
                    // Close connection
                    connect.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

//        if (checkFile(csvFile)) {
//            try {
//                // 4. insert data_file set status file "N"
//                n.addDataFile(csvFile, dfConfigId);
//            } catch (SQLException e) {
//                e.printStackTrace();
//            } finally {
//                try {
//                    // 5. close connection
//                    connect.close();
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
    }
}
