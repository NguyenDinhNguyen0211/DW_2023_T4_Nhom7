package extract;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class RunPythonScript {
    public static boolean runScript(String scriptPath) {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder("C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python311\\python.exe", scriptPath);
            Process process = processBuilder.start();

            // Đọc output của lệnh Python (nếu có)
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }

            // Đọc error của lệnh Python (nếu có)
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
            while ((line = errorReader.readLine()) != null) {
                System.err.println(line);
            }

            int exitCode = process.waitFor();

            // Return true if the exit code is 0 (success), otherwise return false
            return exitCode == 0;

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            // Return false in case of an exception
            return false;
        }
    }

    public static void main(String[] args) {
        String pythonScriptPath = "D:\\DW_2023_T4_Nhom7\\module\\crawl\\bidvcrawl.py";
        boolean scriptResult = runScript(pythonScriptPath);

        if (scriptResult) {
            System.out.println("Script executed successfully.");
        } else {
            System.out.println("Script failed.");
        }
//        // Kết nối và thêm thông tin vào cơ sở dữ liệu control
//        GetConnection connectionManager = new GetConnection();
//        Connection connection = connectionManager.getConnection("control");
//
    }
}
