CREATE DATABASE QuanLyThueBao
GO
CREATE TABLE CUSTOMER(
	CusID INT Primary key IDENTITY,
	Name NVARCHAR(100),
	IDcard INT UNIQUE,
	Address NVARCHAR(100)
)
GO
SELECT * FROM CUSTOMER
GO

CREATE TABLE TTTB(
	SoTB INT primary key,
	CusID INT,
	NgayDK Date
	CONSTRAINT li FOREIGN KEY (CusID) REFERENCES CUSTOMER(CusID)
)
GO
SELECT * FROM TTTB
GO

CREATE TABLE TTSTB(
	SoTB INT,
	Unit NVARCHAR(50)
	CONSTRAINT ll FOREIGN KEY (SoTB) REFERENCES TTTB(SoTB)
)
GO
SELECT * FROM TTSTB
GO
--3. Viết các câu lệnh để thêm dữ liệu vào các bảng
INSERT INTO CUSTOMER VALUES (N'Dương Quốc Việt',123456789,N'Hà Nội'),
							(N'Dương Danh Tuấn',152487569,N'Hà Nội')
GO
INSERT INTO TTTB VALUES (123456789,1,'12/12/02'),
						(123568947,2,'12/12/30')
GO
INSERT INTO TTSTB VALUES (123456789,N'Trả trước'),
						(123568947,N'Trả sau')
GO
--4. Viết các câu lênh truy vấn để
--a) Hiển thị toàn bộ thông tin của các khách hàng của công ty.
SELECT * FROM CUSTOMER
GO
--b) Hiển thị toàn bộ thông tin của các số thuê bao của công ty.
SELECT * FROM TTTB
GO
--5. Viết các câu lệnh truy vấn để lấy
--a) Hiển thị toàn bộ thông tin của thuê bao có số: 0123456789
SELECT * FROM TTTB WHERE SoTB = 123456789
GO
--b) Hiển thị thông tin về khách hàng có số CMTND: 123456789
SELECT * FROM CUSTOMER WHERE IDcard = 123456789
GO
--c) Hiển thị các số thuê bao của khách hàng có số CMTND:123456789

--d) Liệt kê các thuê bao đăng ký vào ngày 12/12/09
SELECT SoTB FROM TTTB WHERE NgayDK = '12/12/09'
GO
--e) Liệt kê các thuê bao có địa chỉ tại Hà Nội

--6. Viết các câu lệnh truy vấn để lấy
--a) Tổng số khách hàng của công ty.
SELECT COUNT(Name) FROM CUSTOMER
GO
--b) Tổng số thuê bao của công ty.
SELECT COUNT(SoTB) FROM TTSTB
GO
--c) Tổng số thuê bào đăng ký ngày 12/12/09.
SELECT COUNT(NgayDK) FROM TTTB WHERE NgayDK = '12/12/09'
GO
--d) Hiển thị toàn bộ thông tin về khách hàng và thuê bao của tất cả các  số thuê bao.

--7. Thay đổi những thay đổi sau trên cơ sở dữ liệu
--a) Viết câu lệnh để  thay đổi trường ngày đăng ký là not null.
ALTER TABLE TTTB ALTER COLUMN NgayDK DATE NOT NULL;
--b) Viết câu lệnh để  thay đổi trường ngày đăng ký là trước hoặc bằng ngày hiện tại.
ALTER TABLE TTTB ADD CONSTRAINT NgayDK Check(NgayDK<getdate() AND NgayDK=GETDATE()) 
GO
--c) Viết câu lệnh để  thay đổi số điện thoại phải bắt đầu 09

--d) Viết câu lệnh để thêm trường số điểm thưởng cho mỗi số thuê bao.