IF EXISTS (SELECT * FROM sys.databases WHERE Name='BookLibrary')
 DROP DATABASE BookLibrary
GO
--Tạo đatabase
CREATE DATABASE BookLibrary
Go
--Tạo bảng Book
CREATE TABLE Book(
	BookCode INT IDENTITY,
	BookTitle VARCHAR(100) NOT NULL,
	Author VARCHAR(50),
	Edition INT,
	BookPrice Money,
	Copies INT
)
GO
ALTER TABLE Book ADD CONSTRAINT ad PRIMARY KEY (BookCode)
SELECT * FROM Book
GO

--Tạo bảng Member
CREATE TABLE Member(
	MemberCode INT IDENTITY,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	PhoneNumber INT ,
)
GO
ALTER TABLE Member ADD CONSTRAINT bd PRIMARY KEY (MemberCode)
SELECT * FROM Member
GO
--Tạo bảng IssueDetails
CREATE TABLE IssueDetails(
	BookCode INT,
	MemberCode INT,
	IssueDate Datetime,
	ReturnDate Datetime,
	CONSTRAINT tk FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
)
GO
ALTER TABLE IssueDetails ADD CONSTRAINT rk FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode) 
GO
SELECT * FROM IssueDetails
GO

--a. Xóa bỏ các Ràng buộc Khóa ngoại của bảng  IssueDetails
ALTER TABLE IssueDetails DROP CONSTRAINT tk
 GO
 ALTER TABLE IssueDetails DROP CONSTRAINT rk
 GO

 --b. Xóa bỏ Ràng buộc Khóa chính của bảng  Member và Book 
 ALTER TABLE Book DROP CONSTRAINT ad
 GO
 ALTER TABLE Member DROP CONSTRAINT bd
 GO
 --c. Thêm mới Ràng buộc Khóa chính cho bảng  Member và Book
 ALTER TABLE Book ADD CONSTRAINT cd PRIMARY KEY (BookCode)
 ALTER TABLE Member ADD CONSTRAINT dd PRIMARY KEY (MemberCode)
 GO
 --d. Thêm mới các Ràng buộc Khóa ngoại cho bảng  IssueDetails
ALTER TABLE IssueDetails ADD CONSTRAINT rf FOREIGN KEY (BookCode) REFERENCES Book(BookCode) 
GO
ALTER TABLE IssueDetails ADD CONSTRAINT rd FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode) 
GO
--e. Bổ sung thêm Ràng buộc giá bán sách > 0 và < 200
ALTER TABLE Book ADD CONSTRAINT Bookprice Check(Bookprice>0 and Bookprice<200) 
GO
--f. Bổ sung thêm Ràng buộc duy nhất cho PhoneNumber của bảng Member
ALTER TABLE Member ADD CONSTRAINT st UNIQUE(PhoneNumber)
--g. Bổ sung thêm ràng buộc NOT NULL cho BookCode,  MemberCode trong bảng IssueDetails 
ALTER TABLE IssueDetails ALTER COLUMN BookCode INT NOT NULL;
ALTER TABLE IssueDetails ALTER COLUMN MemberCode INT NOT NULL;
GO 
--h. Tạo khóa chính gồm 2 cột BookCode,  MemberCode cho bảng  IssueDetails
ALTER TABLE IssueDetails ADD CONSTRAINT ed primary key (BookCode, MemberCode)
GO
--i. Chèn dữ liệu hợp lý cho các bảng(Sử dụng SQL)
SELECT * FROM Book
GO
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15247,'Toan Tin','Tran Tuan',5,150,5);
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15567,'Enlish','Tran Tuan',2,121,10);
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15365,'SLQ','Tran Tuan',1,199,1);
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15452,'Database','Kim Thi',3,152,5);
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15547,'HTML','Kim Thi',5,150,5);
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15258,'Game','Dat Nghien',5,150,5);
INSERT INTO Book(BookCode,BookTitle,Author,Edition,BookPrice,Copies)
VALUES (15968,'Noi Phet','Minh',5,150,5);

SELECT * FROM Member
GO
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('Tran Tuan','124 tran phu',0123524854);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('Tran hanh','120 tran dang ninh',0123556852);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('nguyen toan','121 tran phu',0123362587);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('tien',122 tran phu',0123365854);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('tung','127 tran phu',0152485761);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('thanh','126 tran phu',012985673);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('hoa','128 tran phu',012635859);
INSERT INTO Member(Name,Address,PhoneNumber)
VALUES ('huyen','125 tran phu',012363598);
SELECT * FROM IssueDetails
GO
INSERT INTO IssueDetails(BookCode,MemberCOde,IssueDate,ReturnDate )
VALUES (15247,02,05-06-12,06-06-12);