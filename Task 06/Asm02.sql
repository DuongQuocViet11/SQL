USE  QuanLyBanHang
GO
CREATE TABLE Company(
	ComID INT PRIMARY KEY IDENTITY,
	ComName NVARCHAR(100),
	Address NVARCHAR(100),
	TEL INT
)
GO
SELECT * FROM Company
GO
CREATE TABLE PRODUCTS(
	PROID INT PRIMARY KEY IDENTITY,
	ProName NVARCHAR(100),
	MoTa NVARCHAR(100),
	UNIT NVARCHAR(20),
	Gia MONEY,
	Qty INT
)
GO
SELECT * FROM PRODUCTS
GO
CREATE TABLE CATEGORYS(
	PROID INT ,
	ComID INT,
	Loai NVARCHAR(50)
)
GO
SELECT * FROM CATEGORYS
GO

--3. Viết các câu lệnh để thêm dữ liệu vào các bảng
INSERT INTO Company VALUES ('ASUS','USA',983232),
							('SONY','JAPAN',854759),
							('SAMSUNG','KOREA',221452),
							('NOKIA','FINLAND',988587)
GO
INSERT INTO PRODUCTS VALUES (N'Máy Tính T450',N'Máy nhập cũ',N'Chiếc',1000,10),
							(N'Điện Thoại Nokia5670',N'Điện thoại đang hot',N'Chiếc',200,200),
							(N'Máy In Samsung 450',N'Máy in đang loại bình',N'Chiếc',100,10)
GO
INSERT INTO CATEGORYS VALUES (1,1,N'COMPUTER'),
							(2,4,N'Điện Thoại'),
							(3,3,N'MÁY IN')
GO
--4. Viết các câu lênh truy vấn để
--a) Hiển thị tất cả các hãng sản xuất.
SELECT ComName FROM Company
GO
--b) Hiển thị tất cả các sản phẩm.
SELECT ProName FROM PRODUCTS
GO
--5. Viết các câu lệnh truy vấn để 
--a) Liệt kê danh sách hãng theo thứ thự ngược với alphabet của tên.
SELECT ComName FROM Company
ORDER BY ComName DESC
GO
--b) Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá  giảm dần.
SELECT ProName FROM PRODUCTS
ORDER BY PROID DESC
GO
--c) Hiển thị thông tin của hãng Asus.
SELECT * FROM Company
WHERE ComName = 'ASUS'
GO
--d) Liệt kê danh sách sản phẩm còn ít hơn 11 chiếc trong kho
SELECT ProName FROM PRODUCTS
WHERE Qty<11
GO
--e) Liệt kê danh sách sản phẩm của hãng Asus

--6. Viết các câu lệnh truy vấn để lấy
--a) Số hãng sản phẩm mà cửa hàng có.
SELECT COUNT(ComName) FROM Company
GO
--b) Số mặt hàng mà cửa hàng bán.
SELECT COUNT(ProName) FROM PRODUCTS
GO
--c) Tổng  số loại sản phẩm của mỗi hãng có trong cửa hàng.

--d) Tổng số đầu sản phẩm của toàn cửa hàng
SELECT COUNT(ProName) FROM PRODUCTS
GO
--7. Thay đổi những thay đổi sau trên cơ sở dữ liệu
--a) Viết câu lệnh để  thay đổi  trường giá tiền của từng mặt hàng là dương(>0).
ALTER TABLE PRODUCTS ADD CONSTRAINT Gia Check(Gia>0) 
GO
--b) Viết câu lệnh để  thay đổi  số điện thoại phải bắt đầu bằng 0.

--c) Viết các câu lệnh để xác định các khóa ngoại và khóa chính của các bảng.