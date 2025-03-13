-- Tạo cơ sở dữ liệu
CREATE DATABASE UserManagement;
USE UserManagement;

-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
	Status bit default 1
);

-- Chèn dữ liệu mẫu với 20 người dùng
INSERT INTO Users (FullName, PhoneNumber, Email) VALUES
(N'Nguyễn Văn An', '0912345678', 'nguyenvanan@gmail.com'),
(N'Trần Thị Bình', '0923456789', 'tranthib@gmail.com'),
(N'Lê Văn Cường', '0934567890', 'levancuong@gmail.com'),
(N'Phạm Thị Dung', '0945678901', 'phamthidung@gmail.com'),
(N'Hoàng Văn Em', '0956789012', 'hoangvanem@gmail.com'),
(N'Ngô Thị Phương', '0967890123', 'ngothiphuong@gmail.com'),
(N'Đặng Văn Giang', '0978901234', 'dangvangiang@gmail.com'),
(N'Vũ Thị Hương', '0989012345', 'vuthihuong@gmail.com'),
(N'Bùi Văn Inh', '0990123456', 'buivaninh@gmail.com'),
(N'Đỗ Thị Kim', '0901234567', 'dothikim@gmail.com'),
(N'Hồ Văn Lâm', '0912345687', 'hovanlam@gmail.com'),
(N'Mai Thị Nga', '0923456798', 'maithinga@gmail.com'),
(N'Trịnh Văn Oanh', '0934567809', 'trinhvanoanh@gmail.com'),
(N'Lý Thị Phúc', '0945678910', 'lythiphuc@gmail.com'),
(N'Đinh Văn Quang', '0956789021', 'dinhvanquang@gmail.com'),
(N'Cao Thị Rạng', '0967890132', 'caothirang@gmail.com'),
(N'Lương Văn Sơn', '0978901243', 'luongvanson@gmail.com'),
(N'Chu Thị Tâm', '0989012354', 'chuthitam@gmail.com'),
(N'Dương Văn Ứng', '0990123465', 'duongvanung@gmail.com'),
(N'Võ Thị Xuân', '0901234576', 'vothixuan@gmail.com');