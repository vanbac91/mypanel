 
Phiên bản Pagoda Panel 5.9.X Pro bằng một cú nhấp chuột đã được hoàn thành, mời các bạn sử dụng.

Phương pháp phổ biến là nhập thông tin cấu hình của những người dùng được ủy quyền khác. Một phần nguồn tải xuống không phải từ kênh chính thức của chùa và không thể đảm bảo tính bảo mật. Phương pháp này dựa trên việc sửa đổi tệp cấu hình cục bộ để đạt được, an toàn và xanh

Nguyên lý của phương pháp này là chiếm đoạt tấm ván chùa common.py , Ghi dòng 164 release Thông tin，Hoãn nó đến năm 2999，Mục đích của vết nứt vĩnh viễn đạt được.

thông báo sử dụng
Tập lệnh này phải hoàn toàn sạch Cài đặt trên hệ thống CentOS/Debian/Ubuntu 

Nếu phiên bản cao hơn của bảng chùa đã được cài đặt, vui lòng gỡ cài đặt phiên bản cao hơn trước khi cài đặt

Nếu bạn đã cài đặt các loại bảng điều khiển khác hoặc môi trường hoạt động như LNMP, gói một cú nhấp chuột, bạn nên sao lưu dữ liệu, cài đặt lại hệ thống sạch và sau đó cài đặt

Cài đặt

wget --no-check-certificate -qO crack_bt_panel_pro.sh https://git.io/JU4ib && bash crack_bt_panel_pro.sh

Gỡ cài đặt

wget --no-check-certificate -qO uninstall.sh https://git.io/JU4Pv && bash uninstall.sh


Cập nhật nhật ký
Phiên bản dòng chính openssl của trình cài đặt Nginx đã được nâng cấp lên 1.1.1d và 1.0.2t；
Cung cấp chức năng gỡ cài đặt;
Khôi phục lại nguồn cài đặt chính thức và sử dụng kho này làm nguồn dự phòng;
Để ngăn chùa panel chính thức ngăn chặn phương pháp này, file cài đặt main panel đã được chuyển vào kho dự án, nếu có thắc mắc về file cài đặt có cửa sau vui lòng đối chiếu với file cài đặt chính thức;
Trình cài đặt Nginx được đặt trước theo mặc định, phiên bản dòng chính Nginx đã được nâng cấp lên 1.15.12 và phiên bản dòng chính openssl đã được nâng cấp lên 1.1.1c và 1.0.2s;

Đăng nhập ssl được bật theo mặc định, vì chứng chỉ ssl do bảng điều khiển tự ký, vì vậy nó sẽ không được trình duyệt tin cậy, chỉ cần bỏ qua nó;

Vì quá trình sẽ xuất ra một số lệnh nên kết quả đầu ra chứa thông tin đăng nhập ban đầu sẽ được đặt ở đầu, vui lòng điều chỉnh thanh cuộn trong thiết bị đầu cuối，vặn to lên Bt-Panel：https://mydomain:8888 Một mục, tên người dùng và mật khẩu bên dưới tương ứng là tên người dùng và mật khẩu mặc định sau khi cài đặt bảng điều khiển hoàn tất.
