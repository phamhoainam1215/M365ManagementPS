# M365ManagementPS
PowerShell for management M365
Hướng dẫn sử dụng: M365 Management Release v2.0.PS1
Cài đặt 1 số công cụ này trước:
-	First install the Microsoft Online Services Sign-In Assistant for IT Professionals RTW from the Microsoft Download Center.(hoặc thư mục Libary)
-	Then install the Azure Active Directory Module for Windows PowerShell (64-bit version), and click Run to run the installer package.(hoặc thư mục Libary)
More info: https://technet.microsoft.com/library/jj151815.aspx

1.	Chuột phải vào file M365 Management Release v2.0.PS1 -> chọn Run with PowerShell:
 
2.	Trước khi sử dụng lệnh 2 -> 13 phải đăng nhập O365 với tài khoản admin bằng lệnh 1 trước.

3.	Để tạo nhiều tài khoản cùng 1 lúc ta làm như sau:

-	Phải chạy lệnh 1 trước để đăng nhập vào O365 với tài khoản admin
-	Để tạo tài nhiều tài khoản cần phải xem thông tin SKU licenses của O365 trước -> chạy lệnh 2:

-	Lưu tạm lại tất cả thông tin AccountSkuId ra đâu đó.

-	Mở file M365 Management Release v2.0.PS1 lên sửa lại thông tin sau:
•	Thay thế những “abceduvn:….” Bằng thông tin lưu tạm của AccountSkuId(nếu là O365 Edu thì thay thế ở mục Edu, nếu O365 là Business thì thay ở mục Business Trial)

•	Mở file Script-ImportUser-OPwd-tmpl-full-detail.csv sửa lại thông tin ở cột AssignedLicense bằng EDU1, EDU2,….

•	Lưu tất cả lại, tắt Script đang chạy và chạy lại file script vừa lưu:

•	Đăng nhập lại O365

•	Chọn mục 3.2: nhập địa chỉ file Script-ImportUser-OPwd-tmpl-full-detail.csv đã sửa ở trên -> Enter

4.	Để xóa nhiều tài khoản:
-	Mở file script lên và đăng nhập
-	Nhập lệnh 9
-	Nhập địa chỉ file Script-DeleteUser-List.csv vào
-	Nhấp enter:

Ta thấy đã mất 4 users vừa tạo ở trên.

5.	Với ReAssign Licenses làm tương tự như 4

6.	Những chức năng khác chỉ cần tương tác trực tiếp không cần sử dụng đến file *.csv

Chi tiết: ReadMe - M365 Management Release v2.pdf
