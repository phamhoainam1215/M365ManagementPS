# Hướng dẫn sử dụng: M365 Management Release v12.1
- Cập nhật điều kiện nếu chưa cài thư viện cần thiết thì sẽ cài, nếu cài rồi thì bỏ qua > tiết kiệm thời gian.
- Sửa lỗi lệnh 11.2 
- Cập nhật thời gian chờ 10 giây cho lệnh 11 để không bị lỗi: tạo nhóm và phân quyền không hoạt động.

#Cài đặt 1 số công cụ này trước:
-	Vào thư mục Library cài đặt các file thư viện theo số thứ tự.

# 1.	Cách chạy script
Chuột phải vào file M365 Management Release v12.1.PS1 -> chọn Run with PowerShell:
 
# 2. Đổi thông tin giấy phép/licenses chỉ cần làm cho lần đầu
- Phải chạy lệnh 1 trước để đăng nhập vào O365 với tài khoản admin
- Sử dụng lệnh 2 để lấy SKUID và thay thông tin giấy phép:
Mở file M365 Management Release v12.1.PS1 lên bằng bằng notepad và sửa lại thông tin sau:
 •	Thay thế những “**abceduvn**:STANDARDWOFFPACK...” Bằng thông tin lưu tạm của AccountSkuId(nếu là O365 Edu thì thay thế ở mục Edu, nếu O365 là Business thì thay ở mục Business Trial)
 •	Lưu lại.

# 3.	Để tạo nhiều tài khoản cùng 1 lúc ta làm như sau:
-	Phải chạy lệnh 1 trước để đăng nhập vào O365 với tài khoản admin
-	Để tạo tài nhiều tài khoản cần phải xem thông tin SKU licenses của O365 trước -> chạy lệnh 3 > 3.3(chọn lệnh phù hợp): 
 •	Mở file "Script-ImportUser-OPwd-tmpl-full-detail.csv" hoặc "Script-ImportUser-OPwd-tmpl-full-detail.csv"(theo lệnh đã chọn) cập nhật thông tin ở các cột cần thiết, sửa lại thông tin ở cột AssignedLicense bằng EDU1, EDU2,….
 •	VD chọn mục 3.2: nhập địa chỉ file Script-ImportUser-OPwd-tmpl-full-detail.csv đã sửa ở trên vd: C:\TEMP\Script-ImportUser-OPwd-tmpl-full-detail.csv > Enter
 •	Xem kết quả.
 
# 4.	Để xóa nhiều tài khoản:
-	Mở file script lên và đăng nhập
-	Nhập lệnh 9
-	Nhập địa chỉ file Script-DeleteUser-List.csv vào
-	Nhấp enter:

Ta thấy sẽ mất các users vừa tạo ở trên.

# 5.	Với ReAssign Licenses làm tương tự như 4

# 6.	Những chức năng khác chỉ cần tương tác trực tiếp không cần sử dụng đến file *.csv
...
