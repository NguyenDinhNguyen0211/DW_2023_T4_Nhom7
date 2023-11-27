import time
import pandas as pd
from datetime import datetime
from selenium import webdriver
from bs4 import BeautifulSoup
import os

# Đường dẫn của thư mục bạn muốn lưu file
output_folder = "E:\\Code\\Python\\Learn\\warehouse\\data"
url = "https://bidv.com.vn/vn/ty-gia-ngoai-te"

option = webdriver.ChromeOptions()
driver = webdriver.Chrome(options=option)

data = []  # Danh sách chứa dữ liệu

if not os.path.exists(output_folder):
    os.makedirs(output_folder)

try:
    driver.get(url)

    # Đợi cho đến khi trang web tải hoàn tất (có thể thay đổi timeout theo nhu cầu)
    timeout = 10
    start_time = time.time()
    while time.time() - start_time < timeout:
        if "document.readyState === 'complete'" in driver.execute_script("return document.readyState"):
            break
        time.sleep(1)

    # Lấy nội dung HTML đã tải
    html = driver.page_source

    # Tiếp tục xử lý HTML bằng BeautifulSoup
    soup = BeautifulSoup(html, 'html.parser')

    # Xác định bảng
    table = soup.find('table', class_='table-reponsive')

    # Kiểm tra xem bảng có tồn tại không
    if table:
        # Lấy các dòng từ tbody
        rows = table.select('tbody tr')

        for row in rows:
            row_data = []  # Danh sách chứa dữ liệu từ mỗi dòng

            # Lấy các ô từ mỗi dòng
            cells = row.select('td')

            # In thông tin từ mỗi ô
            for cell in cells:
                # Kiểm tra xem có phần tử mong muốn trong cell không
                content_span = cell.select_one('span.mobile-content span.ng-binding')
                if content_span:
                    content = content_span.text.strip()
                    row_data.append(content)
                else:
                    row_data.append("Không có dữ liệu")

            # Thêm dữ liệu từ mỗi dòng vào danh sách chính
            data.append(row_data)

    else:
        print("Không tìm thấy bảng")

finally:
    # Đóng trình duyệt sau khi hoàn thành
    driver.quit()

# Tạo DataFrame từ danh sách dữ liệu
df = pd.DataFrame(data, columns=["Ký hiệu ngoại tệ", "Tên ngoại tệ", "Mua tiền mặt và Séc", "Mua chuyển khoản", "Bán"])

# Lấy ngày và thời gian hiện tại
current_datetime = datetime.now().strftime("%Y%m%d_%H%M%S")

# Tạo tên file với định dạng "vietcombank_data_<ngày>_<giờ>.xlsx"
excel_filename = f"{output_folder}/bidv_data_{current_datetime}.xlsx"
df.to_excel(excel_filename, index=False)

df.to_excel("data.xlsx", index=False)
