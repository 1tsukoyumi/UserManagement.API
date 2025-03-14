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
go

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
go

-- Procedure 1: Lấy tất cả người dùng
CREATE PROCEDURE GetAllUsers as
BEGIN
    SELECT UserID, FullName, PhoneNumber, Email, CreatedDate, Status 
    FROM Users 
    WHERE Status = 1
    ORDER BY FullName;
END
go

-- Procedure 2: Lấy thông tin người dùng theo ID
CREATE PROCEDURE GetUserByID
    @UserID INT
AS
BEGIN
    SELECT UserID, FullName, PhoneNumber, Email, CreatedDate, Status 
    FROM Users 
    WHERE UserID = @UserID AND Status = 1;
END
GO

-- Procedure 3: Tìm kiếm người dùng theo tên, số điện thoại hoặc email
CREATE PROCEDURE SearchUsers
    @SearchTerm VARCHAR(100)
AS
BEGIN
    SET @SearchTerm = '%' + @SearchTerm + '%';
    
    SELECT UserID, FullName, PhoneNumber, Email, CreatedDate, Status 
    FROM Users 
    WHERE (FullName LIKE @SearchTerm 
           OR PhoneNumber LIKE @SearchTerm 
           OR Email LIKE @SearchTerm)
          AND Status = 1
    ORDER BY FullName;
END
GO

-- Procedure 4: Thêm người dùng mới
CREATE PROCEDURE AddUser
    @FullName NVARCHAR(100),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @UserID INT OUTPUT
AS
BEGIN
    INSERT INTO Users (FullName, PhoneNumber, Email)
    VALUES (@FullName, @PhoneNumber, @Email);
    
    SET @UserID = SCOPE_IDENTITY();
END
GO

-- Procedure 5: Cập nhật thông tin người dùng
CREATE PROCEDURE UpdateUser
    @UserID INT,
    @FullName NVARCHAR(100),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE Users
    SET FullName = @FullName,
        PhoneNumber = @PhoneNumber,
        Email = @Email
    WHERE UserID = @UserID;
END
GO

-- Procedure 6: Xóa người dùng (xóa mềm - chỉ cập nhật trạng thái)
CREATE PROCEDURE DeleteUser
    @UserID INT
AS
BEGIN
    UPDATE Users
    SET Status = 0
    WHERE UserID = @UserID;
END
GO

-- Procedure 7: khôi phục người dùng sau khi xóa mềm (điều chỉnh lại status)
CREATE PROCEDURE RestoreDeletedUsers
AS
BEGIN
    UPDATE Users
    SET status = 1
    WHERE status = 0;

    -- Trả về số lượng user đã được khôi phục
    SELECT @@ROWCOUNT AS RestoredUsersCount;
END
GO
-- Procedure 8: xóa vĩnh viễn người dùng sau 30 ngày không khôi phục
-- Dùng SQL Server Agent để tự động hóa việc chạy procedure nàyATE PROCEDURE SearchUsers
    @SearchTerm VARCHAR(100)
AS
BEGIN
    SET @SearchTerm = '%' + @SearchTerm + '%';
    
    SELECT UserID, FullName, PhoneNumber, Email, CreatedDate, Status 
    FROM Users 
    WHERE (FullName LIKE @SearchTerm 
           OR PhoneNumber LIKE @SearchTerm 
           OR Email LIKE @SearchTerm)
          AND Status = 1
    ORDER BY FullName;
END
GO

-- Procedure 4: Thêm người dùng mới
CREATE PROCEDURE AddUser
    @FullName NVARCHAR(100),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @UserID INT OUTPUT
AS
BEGIN
    INSERT INTO Users (FullName, PhoneNumber, Email)
    VALUES (@FullName, @PhoneNumber, @Email);
    
    SET @UserID = SCOPE_IDENTITY();
END
GO

-- Procedure 5: Cập nhật thông tin người dùng
CREATE PROCEDURE UpdateUser
    @UserID INT,
    @FullName NVARCHAR(100),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE Users
    SET FullName = @FullName,
        PhoneNumber = @PhoneNumber,
        Email = @Email
    WHERE UserID = @UserID;
END
GO

-- Procedure 6: Xóa người dùng (xóa mềm - chỉ cập nhật trạng thái)
CREATE PROCEDURE DeleteUser
    @UserID INT
AS
BEGIN
    UPDATE Users
    SET Status = 0
    WHERE UserID = @UserID;
END
GO

-- Procedure 7: khôi phục người dùng sau khi xóa mềm (điều chỉnh lại status)
CREATE PROCEDURE RestoreDeletedUsers
AS
BEGIN
    UPDATE Users
    SET status = 1
    WHERE status = 0;

    -- Trả về số lượng user đã được khôi phục
    SELECT @@ROWCOUNT AS RestoredUsersCount;
END
GO
-- Procedure 8: xóa vĩnh viễn người dùng sau 30 ngày không khôi phục
-- Dùng SQL Server Agent để tự động hóa việc chạy procedure này
CREATE PROCEDURE PermanentlyDeleteUsers
AS
BEGIN
    DELETE FROM Users
    WHERE Status = 0 AND DATEDIFF(DAY, CreatedDate, GETDATE()) > 30;
END;
GO
