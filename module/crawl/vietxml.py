import os
import requests
import xml.etree.ElementTree as ET
import pandas as pd
from datetime import datetime

url = "https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx"
# ...

# Đặt đường dẫn thư mục lưu trữ trực tiếp trong mã code
folder_selected = "D:\\DW_2023_T4_Nhom7\\file"
try:
    # Kiểm tra nếu thư mục không tồn tại, tạo nó
    if not os.path.exists(folder_selected):
         # 1. create folder
        os.makedirs(folder_selected) 
        print(f"Thư mục {folder_selected} đã được tạo.")

    try:
        # 2. connect url source
        response = requests.get(url)
        if response.status_code == 200:
            # 3. Parse XML data
            root = ET.fromstring(response.content)

            # 4. get data
            # Lấy giá trị từ các phần tử XML
            date_time = root.find(".//DateTime").text
            source = root.find(".//Source").text

            # Tạo DataFrame từ dữ liệu XML
            data = []
            for exrate_elem in root.findall(".//Exrate"):
                currency_code = exrate_elem.get("CurrencyCode")
                currency_name = exrate_elem.get("CurrencyName")
                buy = exrate_elem.get("Buy")
                transfer = exrate_elem.get("Transfer")
                sell = exrate_elem.get("Sell")

                data.append({
                    "Currency Code": currency_code,
                    "Currency Name": currency_name,
                    "Buy": buy,
                    "Transfer": transfer,
                    "Sell": sell
                })

            df = pd.DataFrame(data)

            # Lấy ngày và thời gian hiện tại
            current_datetime = datetime.now().strftime("%Y%m%d_%H%M%S")
            # 5. save data to file
            # Tạo tên file với định dạng "vietcombank_data_<ngày>_<giờ>.xlsx"
            excel_filename = f"{folder_selected}/vietcombank_data_{current_datetime}.xlsx"
            df.to_csv(excel_filename, index=False)

            print("Data saved to", excel_filename)

        else:
            # 2.1 thông báo lỗi
            print("Failed to retrieve data. Status code:", response.status_code) 
    except Exception as e:
        print("An error occurred:", e)

except Exception as e:
    print("An error occurred:", e)
