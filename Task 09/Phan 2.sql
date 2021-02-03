CREATE DATABASE ToyzUnlimited
GO
 USE ToyzUnlimited
 GO
 --1. Tạo bảng Toys với cấu trúc giống như trên. Thêm dữ liệu (15 bản ghi) vào bảng với giá trị của trường QtyOnHand ít nhất là 20 cho mỗi sản phẩm đồ chơi. 
CREATE TABLE TOYS(
	ProductCode VARCHAR(5) PRIMARY KEY,
	Name VARCHAR(30),
	Category varchar(30),
	Manufacturer varchar(40),
	AgeRange varchar(15),
	UnitPrice MONEY,
	Netweight INT,
	QtyOnHand INT
)
GO
 INSERT INTO TOYS VALUES ('TA012','Barbie Fashionistas Doll 2','Doll','ABC COMPANY','3-9',10,125,50),
						 ('TX125','LEGO Star Wars','LEGO','LEGO COMPANY','3-12',25,400,30),
						 ('TE025','Pokemon Sword Shield 5','CARD','POKEMON COMPANY','6-12',30,325,85),
						 ('TW325','Step2 Timeless Trends Kitchen','KITCHEN','STEP COMPANY','3-12',125,1200,56),
						 ('XR025','Kid Connection Juinor Doctor','DOCTOR','STEP COMPANY','3-12',66,400,38),
						 ('MT125','CAR RACING','RACING CONTROLLER','LEGO COMPANY','3-12',25,400,96),
						 ('RT325','UNO','CARD ','ABC COMPANY','6-18',6,350,80),
						 ('AM032','TEDDY BEAR','STUFFED ANIMAL','TOY COMPANY','2-12',600,356,120),
						 ('RF025','LEGO AVENGERS','LEGO','LEGO COMPANY','3-12',65,362,80),
						 ('OP256','LEGO CREATOR','LEGO','LEGO COMPANY','3-12',25,129,52),
						 ('PL632','Barbie Fashionistas Doll 3','Doll','ABC COMPANY','3-9',15,156,140),
						 ('KL023','SHIP RACING','RACING CONTROLLER','TOY COMPANY','6-12',852,652,75),
						 ('IO025','LEGO Star Wars2','LEGO','LEGO COMPANY','3-12',365,458,65),
						 ('KI236','LEGO Star Wars3','LEGO','LEGO COMPANY','3-12',925,463,35),
						 ('ML559','LEGO Star Wars4','LEGO','LEGO COMPANY','3-12',525,856,46)
--2. Viết câu lệnh tạo Thủ tục lưu trữ có tên là HeavyToys cho phép liệt kê tất cả các loại đồ chơi có trọng lượng lớn hơn 500g.
CREATE PROCEDURE HeavyToys
AS
SELECT * FROM TOYS
WHERE Netweight >500
GO

--3. Viết câu lệnh tạo Thủ tục lưu trữ có tên là PriceIncrease cho phép tăng giá của tất cả các loại đồ chơi lên thêm 10 đơn vị giá. 
CREATE PROCEDURE PriceIncrease
AS
SELECT * FROM TOYS
UPDATE TOYS
SET UnitPrice=UnitPrice+10
GO

--4. Viết câu lệnh tạo Thủ tục lưu trữ có tên là QtyOnHand làm giảm số lượng đồ chơi còn trong của hàng mỗi thứ 5 đơn vị.  
CREATE PROCEDURE QtyOnHand
AS
SELECT * FROM TOYS
UPDATE TOYS
SET QtyOnHand=QtyOnHand-5
GO

--5. Thực thi 3 thủ tục lưu trữ trên. 
EXEC HeavyToys
GO
EXEC PriceIncrease
GO
EXEC QtyOnHand
GO