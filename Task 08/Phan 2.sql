USE LAB11
GO
CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY IDENTITY,
	CustomerName  varchar(50),
	Address varchar(100),
	Phone varchar (12)
)
GO
SELECT * FROM Customer
GO
CREATE TABLE Book(
	BookCode INT PRIMARY KEY IDENTITY,
	Category varchar(50),
	Author varchar(50),
	Publisher varchar(50),
	Title varchar(100),
	Price INT,
	InStore  INT
)
GO
SELECT * FROM Book
GO
CREATE TABLE BookSold(
	BookSold INT PRIMARY KEY IDENTITY,
	CustomerID INT,
	BookCode INT,
	Date DATETIME,
	Price INT,
	Amount INT
	CONSTRAINT tk FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT tt FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
)
GO
SELECT * FROM BookSold
GO
--1. Chèn ít nhất 5 bản ghi vào bảng Books, 5 bản ghi vào bảng Customer và 10 bản ghi vào bảng BookSold.
INSERT INTO Customer VALUES ('TRAN TUAN','12 DUY TAN, CAU GIAY, HN', 1235248597),
							('LE HUNG','26 DUY TAN, CAU GIAY, HN', 1238596547),
							('QUANG TRUNG','25 DUY TAN, CAU GIAY, HN', 1252452487),
							('TRAN QUAN','125DUY TAN, CAU GIAY, HN', 9857632521),
							('HANH','12585 DUY TAN, CAU GIAY, HN', 8858585475)
GO
INSERT INTO Book VALUES ('KINH TE','HUY THANH','NXB KIM DONG','KINH TE VI MO',25000,100),
						('VAN HOC','TUNG DUONG','NXB KIM DONG','NHAT KY TRONG TU',15000,100),
						('TOAN HOC','QUANG DU','NXB GIAO DUC','TOAN CAO CAP 3',45000,100),
						('KINH TE','TUAN ANH','NXB LAO DONG','BIEN DONG CHUNG KHOAN',55000,100),
						('CONG NGHE THONG TIN','KIM THI','NXB FPT','QUAN LY DU LIEU SQL',155000,100)
GO
INSERT INTO BookSold VALUES (1,1,17-12-20,23500,50), (1,3,17-12-20,45000,10), (1,5,17-12-20,155000,15),
						(2,2,21-01-05,15000,5), (2,1,21-01-05,23500,10), (3,4,21-01-12,54500,20),
						(4,4,21-01-13,55000,2), (4,5,21-01-13,153000,50), (5,3,21-01-17,45000,5),
						(5,1,21-01-17,20000,50)
GO
--2. Tạo một khung nhìn chứa danh sách các cuốn sách (BookCode, Title, Price) kèm theo số lượng đã bán được của mỗi cuốn sách.  
CREATE VIEW V_Book_BookSold AS
SELECT p.BookCode,p.Amount, e.Title,e.Price
FROM Book e
JOIN BookSold AS p ON e.Price=p.Price;
GO
SELECT * FROM V_Book_BookSold
--3. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) kèm theo số lượng các cuốn sách mà khách hàng đó đã mua. 
CREATE VIEW V_Customer_BookSold AS
SELECT e.CustomerID, e.CustomerName,e.Address, P.Amount
FROM Customer e
JOIN BookSold AS p ON e.CustomerID=p.CustomerID;
GO
SELECT * FROM V_Customer_BookSold
--4. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) đã mua sách vào tháng trước, kèm theo tên các cuốn sách mà khách hàng đã mua. 
CREATE VIEW V_Customer_Book_BookSold AS
SELECT e.CustomerID, e.CustomerName,e.Address,t.BookCode, P.Title
FROM Customer e
JOIN Book AS p  ON t.BookCode=p.BookCode
JOIN BookSold AS t  ON e.CustomerID=t.CustomerID
WHERE t.Date='12/2020';
GO
SELECT * FROM V_Customer_BookSold
--5. Tạo một khung nhìn chứa danh sách các khách hàng kèm theo tổng tiền mà mỗi khách hàng đã chi cho việc mua sách.
CREATE VIEW V_Customar_Price AS
SELECT e.CustomerName,p.CustomerID,p.Price
FROM Customer e
JOIN BookSold AS p ON p.CustomerID=e.CustomerID
GO

SELECT * FROM V_Customar_Price