--1. Create a database as requested above.
CREATE DATABASE SellingPoint
GO
USE SellingPoint
GO
--2. Create table based on the above design.
CREATE TABLE Categories(
	CateID char(6) PRIMARY KEY,
	CateName nvarchar(100) NOT NULL,
	Description nvarchar(200)
)
GO
SELECT * FROM Categories
GO
CREATE TABLE Parts(
	PartID INT PRIMARY KEY IDENTITY,
	PartName nvarchar(100) NOT NULL,
	CateID char(6),
	Description NVARCHAR(1000),
	Price  MONEY,
	Quantity INT DEFAULT '0',
	Warranty INT DEFAULT '1',
	Photo NVARCHAR(200) DEFAULT 'photo/nophoto.png'
	CONSTRAINT FK_Parts FOREIGN KEY (CateID) REFERENCES Categories(CateID)
)
GO
SELECT * FROM Parts
GO
--3. Insert into each table at least three records.
INSERT INTO Categories VALUES('AR125A',N'RAM',N'Bộ nhớ tạm thời'),
							 ('TR142B',N'CPU',N'Bộ vi sử lý'),
							 ('GT124C',N'Mainboard','Bo mạch chủ'),
							 ('GT345M',N'HDD',N'Ổ đĩa cứng, hay còn gọi là ổ cứng là thiết bị dùng để lưu trữ dữ liệu trên bề mặt các tấm đĩa hình tròn phủ vật liệu từ tính'),
							 ('FR147V',N'SSD',N'SSD: Ổ đĩa bán dẫn, Ổ bán dẫn, Ổ đĩa thể đặc hay Ổ đĩa điện tử, là một loại thiết bị lưu trữ được làm từ vật liệu bán dẫn semiconductor/solid state, dùng để lưu trữ dữ liệu')
GO
SELECT * FROM Categories
GO
INSERT INTO Parts(PartName, CateID, Description, Price, Quantity) VALUES ('Ram Desktop Corsair Vengeance LPX','AR125A','RRAM CORSAIR',120,15),
						('Ram Desktop Kingston HyperX Fury RBG','AR125A', 'Ram Desktop Kingston HyperX Fury RGB ',95,50),
						('CPU Intel Core i9-10940X','TR142B',N'BỘ VI SỬ LÝ MỚI NHẤT CỦA INTEL',152,40),
						(N'CPU AMD Ryzen 5 3500X','TR142B',N'BỘ VI SU LÝ CUA AMD',152,40),
						(N'Mainboard ASROCK A320M-HDV R4.0','GT124C',N'Bo mạch chính/ Mainboard
						Asrock A320M-HDV R4.0 được thiết kế và sản xuất bởi hãng Asrock',250,26),
						(N'Mainboard ASUS PRIME B450M-A','GT124C',N'Mainboard ASUS PRIME B450M-A là
						sản phẩm bo mạch chủ sử dụng chipset B450 của AMD, tương thích với các thế hệ 
						chip Ryzen sử dụng socket AM4 bao gồm Ryzen 1000, 2000, 3000 và cả 4000 trong 
						tương lai (sau update Bios)',320,26)
GO
--4. List all parts in the store with price > 100$.
SELECT * FROM Parts
WHERE Price >100
GO
--5. List all parts of the category ‘CPU’.
SELECT c.CateName,p.PartName FROM Categories c
JOIN Parts p ON p.CateID=c.CateID
WHERE c.CateName='CPU'
GO
--6. Create a view v_Parts contains the following information (PartID, PartName, CateName, Price, Quantity) from table Parts and Categories.
CREATE VIEW V_Parts AS
SELECT P.PartID, P.PartName, C.CateName, P.Price, P.Quantity
FROM Parts P
JOIN Categories C ON C.CateID=P.CateID
GO
SELECT * FROM V_Parts
GO
--7. Create a view v_TopParts about 5 parts with the most expensive price.
CREATE VIEW V_v_TopParts AS
SELECT RANK() OVER (ORDER BY PRICE)AS STT,PartName, Price
FROM Parts
GO
SELECT * FROM V_v_TopParts
ORDER BY Price DESC
GO