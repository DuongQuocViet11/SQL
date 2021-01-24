
﻿CREATE Database QuanLyBanHang
CREATE TABLE SanPham(
	Macode INT PRIMARY KEY IDENTITY,
	TenHang VARCHAR(50),
	DonVi VARCHAR(10),
	Gia Money,
	SoLuong INT,
	Mota VARCHAR(100)
)
GO
SELECT * FROM SanPham
GO

CREATE TABLE DanhMuc(
	Macode INT,
	TenHang VARCHAR(50),
	Loai VARCHAR(50),
	CONSTRAINT tk FOREIGN KEY (Macode) REFERENCES SanPham(Macode)
)
GO
SELECT * FROM DanhMuc
GO

CREATE TABLE KhachHang(
	MaKhachHang Int PRIMARY KEY IDENTITY,
	TenKhachHang nVARCHAR(50),
	DiaChi nVARCHAR(100),
	DienThoai INT,
)
GO
SELECT * FROM KhachHang
GO

CREATE TABLE Orders(
	MaDonHang Int,
	TenHang NVARCHAR(100),
	Loai NVarchar(50),
	SoLuong INT,
	NgayDatHang Date,
)
GO
SELECT * FROM Orders
GO

CREATE TABLE OrderDetails(
	MaDonHang Int,
	MaKhachHang Int,
	TenKH NVARCHAR(50),
	DiaChi NVARCHAR(100),
	TEL INT,
	NgayDatHang Date, 
	STT INT IDENTITY,
	TenHang NVARCHAR(50),
	MoTa NVARCHAR(100),
	DonVi NVARCHAR(20),
	Gia Money,
	SoLuong INT,
	ThanhTien Money
)
GO
SELECT * FROM OrderDetails
GO

--3. Nhập dữ liệu
INSERT INTO SanPham VALUES ('May Tinh T450','Chiec',1000,10,'May nhap moi'),
						   ('Dien Thoai Nokia5670','Chiec',200,10,'Dien Thoai đang hot'),
						   ('May In Samsung 450','Chiec',100,10,'May in dang e')
GO
INSERT INTO DanhMuc VALUES (1,'May Tinh T450','May Tinh'),
							(2,'Dien Thoai Nokia5670','Dien Thoai'),
							(3,'May In Samsung 450','May In')
GO
INSERT INTO KhachHang VALUES (N'Nguyễn Văn An',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội',987654321),
							(N'Trần Anh Quân',N'99 Cầu giấy, Cầu Giấy, Hà Nội',987456123),
							(N'Dương Quốc Việt',N'56 Đường Láng, Cầu Giấy, Hà Nội',889969533)
GO
INSERT INTO Orders VALUES (1,'May Tinh T450','May Tinh',1,'2011-08-09'),
							(1,'Dien Thoai Nokia5670','Dien Thoai',2,'2011-08-09'),
						   (1,'May In Samsung 450','May In',1,'2011-08-09')
GO
INSERT INTO Orders VALUES (2,'May Tinh T450','May Tinh',2,'2011-10-12'),
							(2,'Dien Thoai Nokia5670','Dien Thoai',2,'2011-10-12'),
						   (2,'May In Samsung 450','May In',2,'2011-10-12')
GO
INSERT INTO OrderDetails VALUES (1,1,N'Nguyễn Văn An',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội',987654321,'2011-08-09',N'Máy Tính T450',N'May nhap moi',N'chiếc',1000,1),
							(1,1,N'Nguyễn Văn An',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội',987654321,'2011-08-09',N'Điện Thoại Nokia5670',N'Dien Thoai đang hot',N'Chiếc',200,2),
						   (1,1,N'Nguyễn Văn An',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội',987654321,'2011-08-09',N'Máy In Samsung 450','May in dang e',N'chiếc',100,1)
GO
INSERT INTO OrderDetails VALUES (2,2,N'Trần Anh Quân',N'99 Cầu Giấy, Cầu Giấy, Hà Nội',987456123,'2011-10-12',N'Máy Tính T450',N'May nhap moi',N'chiếc',1000,2),
							(2,2,N'Trần Anh Quân',N'99 Cầu Giấy, Cầu Giấy, Hà Nội',987456123,'2011-10-12',N'Điện Thoại Nokia5670',N'Dien Thoai đang hot',N'Chiếc',200,2),
						   (2,2,N'Trần Anh Quân',N'17 Cầu Giấy, Cầu Giấy, Hà Nội',987456123,'2011-10-12',N'Máy In Samsung 450','May in dang e',N'chiếc',100,2)
UPDATE OrderDetails SET ThanhTien = Gia * SoLuong
GO
--4.Truy Vấn
SELECT (TenKhachHang) FROM Khachhang
GO
SELECT (TenHang) FROM SanPham
GO
SELECT * FROM Orders
GO
--5.Truy Vấn
Select TenKhachHang from KhachHang
Order by TenKhachHang;
GO
Select TenHang,Gia from SanPham
Order by Gia DESC;
GO
Select TenKH,TenHang from OrderDetails
WHERE TenKH = N'Nguyễn Văn An';
GO
--6.Truy Vấn
SELECT COUNT(TenKhachHang) FROM KhachHang
GO
SELECT COUNT(TenHang) FROM SanPham
GO
SELECT SUM(ThanhTien)
FROM OrderDetails
WHERE MaDonHang =1
GO
SELECT SUM(ThanhTien)
FROM OrderDetails
WHERE MaDonHang =2
GO
--7.Thay đổi những thông tin từ cơ sở dữ liệu
ALTER TABLE SanPham ADD CONSTRAINT Gia Check(Gia>0)
GO
ALTER TABLE Orders ADD CONSTRAINT NgayDatHang Check(NgayDatHang<getdate()) 
GO
ALTER TABLE SanPham ADD Ngayramat date
GO
SELECT *FROM SanPham
GO
--8. Thực hiện yêu cầu
--a) Đặt chỉ mục (index) cho cột Tên hàng và Người đặt hàng để tăng tốc độ truy vấn dữ liệu trên các cột này.
CREATE INDEX index_TenKh ON OrderDetails(TenKH)
GO
CREATE INDEX index_TenHang ON OrderDetails(TenHang)
GO
--b) Xây dựng các view:
--View_KhachHang với các cột: Tên khách hàng, Địa chỉ, Điện thoại
CREATE VIEW View_KhachHang AS SELECT TenKhachHang,diachi,DienThoai
FROM KhachHang
GO
SELECT *FROM View_KhachHang
GO
--View_SanPham với các cột: Tên sản phẩm, Giá bán
CREATE VIEW View_SanPham AS SELECT TenHang,Gia
FROM SanPham
GO
SELECT *FROM View_SanPham
GO
--View_KhachHang_SanPham với các cột: Tên khách hàng, Số điện thoại, Tên sản phẩm, Số lượng, Ngày mua
CREATE VIEW View_KhachHang_SanPham AS SELECT TenKH,TEL,TenHang,SoLuong,NgayDatHang
FROM OrderDetails
GO
SELECT *FROM View_KhachHang_SanPham
GO
--c) Viết các Store Procedure (Thủ tục lưu trữ) sau:
--SP_TimKH_MaKH: Tìm khách hàng theo mã khách hàng
CREATE PROCEDURE SP_TimKH_MaKH AS
SELECT TenKhachHang,diachi,DiaChi FROM KhachHang
WHERE MaKhachHang LIKE 1
GO
EXECUTE SP_TimKH_MaKH
GO
--SP_TimKH_MaHD: Tìm thông tin khách hàng theo mã hóa đơn
CREATE PROCEDURE SP_TimKH_MaHD AS
SELECT TenKH,diachi,TEL FROM OrderDetails
WHERE MaDonHang LIKE '1'
GO
EXECUTE SP_TimKH_MaHD
GO
--SP_SanPham_MaKH: Liệt kê các sản phẩm được mua bởi khách hàng có mã được truyền vào Store.
CREATE PROCEDURE SP_SanPham_MaKH AS
SELECT TenHang,SoLuong,MoTa FROM OrderDetails
WHERE MaKhachHang LIKE '1'
GO
EXECUTE SP_TimKH_MaHD
GO
