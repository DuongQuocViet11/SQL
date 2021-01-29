CREATE DATABASE Lab11
GO
USE Lab11
--Bài 1
CREATE VIEW Productlist
AS
SELECT ProductID, Name FROM AdventureWorks2019.Production.Product
SELECT * FROM Productlist

--Bài 2
CREATE VIEW SalesOrderDetail
AS 
SELECT pr.ProductID, pr.Name, od.UnitPrice, od.OrderQty,
od.UnitPrice*od.OrderQty as [Total Price]
FROM AdventureWorks2019.Sales.SalesOrderDetail od
JOIN AdventureWorks2019.Production.Product pr
ON od.ProductID=pr.ProductID

SELECT * FROM SalesOrderDetail

--Bài 3
USE AdventureWorks2019
GO
--Tạo khung nhìn lấy ra thông tin cơ bản trong bảng Person.Contact
CREATE VIEW V_Contact_Info AS
SELECT FirstName, MiddleName, LastName
FROM Person.Person

--Tạo khung nhìn lấy ra thông tin về nhân viên
CREATE VIEW V_Employee_Contact AS
SELECT p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate
FROM HumanResources.Employee e
JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID;
GO

--Xem một khung nhìn
SELECT * FROM V_Employee_Contact
GO

--Thay đổi khung nhìn V_Employee_Contact bằng viết thêm cột Birthdate
ALTER VIEW V_Employee_Contact AS
SELECT p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate, e.Birthdate
FROM HumanResources.Employee e
JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
WHERE p.FirstName like '%B%';
GO

--Xóa một khung nhìn
DROP VIEW V_Contact_Info
GO

--Xem định nghĩa khung nhìn V_Employee_Contact
EXECUTE sp_helptext 'V_Employee_Contact'
GO

--Xem các thành phần mà khung nhìn phụ thuộc
EXECUTE sp_depends 'V_Employee_Contact'
GO
--Tạo khung nhìn ổn mà định nghĩa bị ẩn đi (không xem được định nghĩa khung nhìn)
CREATE VIEW OrderRejects
WITH ENCRYPTION
AS
SELECT PurchaseOrderlD, ReceivedQty, RejectedQty,
RejectedQty / ReceivedQty AS RejectRatio, DueDate
FROM Purchasing. PurchaseOrderDetail
WHERE RejectedQty / ReceivedQty > 0
AND DueDate > CONVERT(DATETIME,20010630,101) ;
--Không xem được định nghĩa Khung nhìn V_Contact_Info
sp_helptext 'OrderRejects'
GO
--Không xem được định .nghĩa Khung nhìn V_Contact_Info 
sp_helptext 'OrderRejects'
GO
--Thay đổi khung nhìn thêm tùy chọn CHECK OPTION
ALTER VIEW V_Employee_Contact AS
SELECT p.FirstName, p.LastName, e.BusinessEntitylD, e.HireDate FROM HumanResources.Employee e
JOIN Person.Person AS p ON e.BusinessEntitylD = p.BusinessEntitylD
WHERE p.FirstName like 'A%' WITH CHECK OPTION 
GO
SELECT * FROM V_Employee_Contact
--Cập nhật được khung nhìn khi FirstName bất đầu bằng ký tự 'A'
UPDATE V_Employee_Contact SET FirstName='Atest' WHERE LastName='Amy'
--Không cập nhật được khung nhìn khi FirstName bất đầu bằng ký tự khác'A'
UPDATE V_Employee_Contact SET FirstName='BCD' WHERE LastName='Atest'
GO
--Phải xóa khung nhìn trước
DROP VIEW V_Contact_Info 
GO
--Tạo khung nhìn có giản đổ
CREATE VIEW V_Contact_Info WITH SCHEMABINDING AS 
SELECT FirstName, MiddleName, LastName, EmailAddress
--Phái xóa khung nhịn trước
DROP VIEW V_Contact_Info
GO
--Tạo khung nhìn có giận đổ
CREATE VIEW V_Contact_Info WITH SCHEMABINDING AS
SELECT FirstName, MiddleName, LastName, EmailAddress
FROM Person.Contact
GO
--Không thể truy, vấn được khung nhìn có tên là V_Contact_Info
select * from V_Contact_Info
GO
--Tạo chỉ mục duy nhạt trên cột EmailAddress trên khung nhìn V_Contact_Info
CREATE UNIQUE CLUSTERED INDEX IX_Contact_Email
ON V_Contact_Info(EmailAddress)
GO
--Thực hiện đổi tên khung nhìn
exec sp_rename V_Contact_Info, V_Contact_Infomation
--Trụy vấn khung nhìn
select * from V_Contact_Infomation
--Không thể thêm bản ghi vào khung nhìn 
--vì có cột không cho phép. NULL trọng bạng Contact
INSERT INTO V_Contact_Infomation values ('ABC', 'DEF', 'GHI', 'abc@yahoo.com')
--Không thể xóa bản ghi của khung nhìn V_Contact_Infomation
--vì bảng Person.Contact còn có các khóa ngoại.
DELETE FROM V_Contact_Infomation WHERE LastName='Gilbert' and FirstName='Guy'