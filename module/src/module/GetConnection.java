package module;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class GetConnection {
	String driver = null;
	String url = null;
	String user = null;
	String pass = null;
	String databasebName = null;

	public Connection getConnection(String location) {
		// 1. path config
		String link = ".\\config\\config.properties";
		Connection result = null;
		// 2.1 ket noi db control
		if (location.equalsIgnoreCase("control")) {
			try (InputStream input = new FileInputStream(link)) {
				Properties prop = new Properties();
				prop.load(input);
				// 2.1.1 lấy từng thuộc tính cấu hình trong file config
				driver = prop.getProperty("driver_local");
				url = prop.getProperty("url_local");
				databasebName = prop.getProperty("dbName_control");
				user = prop.getProperty("user_local");
				pass = prop.getProperty("pass_local");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
			// 2.2 ket noi db staging
		} else if (location.equalsIgnoreCase("staging")) {
			try (InputStream input = new FileInputStream(link)) {
				Properties prop = new Properties();
				prop.load(input);
				// 2.2.1 lấy từng thuộc tính cấu hình trong file config
				driver = prop.getProperty("driver_local");
				url = prop.getProperty("url_local");
				databasebName = prop.getProperty("dbName_staging");
				user = prop.getProperty("user_local");
				pass = prop.getProperty("pass_local");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		try {
			// 3. đăng kí driver
			Class.forName(driver);
			String connectionURL = url + databasebName;
			try {
				// 4. kết nối
				result = DriverManager.getConnection(connectionURL, user, pass);
			} catch (SQLException e) {
				// 5. thông báo lỗi kết nối
				System.out.println("Error connect");
				System.exit(0);
				e.printStackTrace();
			}

		} catch (ClassNotFoundException e) {
			// 6. thông báo không tìm thấy file config
			System.out.println("file config not found");
			System.exit(0);
			e.printStackTrace();
		}
		return result;
	}

}
