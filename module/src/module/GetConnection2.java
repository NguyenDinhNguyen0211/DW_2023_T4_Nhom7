package module;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class GetConnection2 {
	String driver = null;
	String url = null;
	String user = null;
	String pass = null;
	String databasebName = null;
	public static int checkE;

	public Connection getConnection(String location) {
		// path config
		String link = "./module/config/config.properties";
		Connection result = null;
		// ket noi db warehouse
		if (location.equalsIgnoreCase("warehouse")) {
			try (InputStream input = new FileInputStream(link)) {
				Properties prop = new Properties();
				prop.load(input);
				// lấy từng thuộc tính cấu hình trong file config
				driver = prop.getProperty("driver_local");
				url = prop.getProperty("url_local");
				databasebName = prop.getProperty("dbName_datawarehouse");
				user = prop.getProperty("user_local");
				pass = prop.getProperty("pass_local");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
			// ket noi db mart local
		} else if (location.equalsIgnoreCase("mart")) {
			try (InputStream input = new FileInputStream(link)) {
				Properties prop = new Properties();
				prop.load(input);
				// 2.2.1 lấy từng thuộc tính cấu hình trong file config
				driver = prop.getProperty("driver_local");
				url = prop.getProperty("url_local");
				databasebName = prop.getProperty("dbName_datamart");
				user = prop.getProperty("user_local");
				pass = prop.getProperty("pass_local");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		} else if (location.equalsIgnoreCase("control")) {
			try (InputStream input = new FileInputStream(link)) {
				Properties prop = new Properties();
				prop.load(input);
				// lấy từng thuộc tính cấu hình trong file config
				driver = prop.getProperty("driver_local");
				url = prop.getProperty("url_local");
				databasebName = prop.getProperty("dbName_control");
				user = prop.getProperty("user_local");
				pass = prop.getProperty("pass_local");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
			// ket noi db mart server
//		}else if (location.equalsIgnoreCase("mart")) {
//			try (InputStream input = new FileInputStream(link)) {
//				Properties prop = new Properties();
//				prop.load(input);
//				// 2.2.1 lấy từng thuộc tính cấu hình trong file config
//				driver = prop.getProperty("driver_local");
//				url = prop.getProperty("url_server");
//				databasebName = prop.getProperty("dbName_datamart");
//				user = prop.getProperty("username_server");
//				pass = prop.getProperty("pass_server");
//			} catch (IOException ex) {
//				ex.printStackTrace();
//			}
		}
		try {
			// đăng kí driver
			Class.forName(driver);
			String connectionURL = url + databasebName;
			try {
//				2. Kết nối db control
				result = DriverManager.getConnection(connectionURL, user, pass);
				checkE = 1;
			} catch (SQLException e) {
//				2.1 Thông báo lỗi
				if (location.equalsIgnoreCase("control")) {
					System.out.println("Kết nối không thành công");

					System.exit(0);
				}
				checkE = 0;
//				e.printStackTrace();
			}

		} catch (ClassNotFoundException e) {
			// thông báo không tìm thấy file config
			System.out.println("Không tìm thấy file config");
			System.exit(0);
			e.printStackTrace();
		}
		return result;
	}

}
