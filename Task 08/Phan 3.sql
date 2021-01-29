USE Lab11
GO
CREATE TABLE Class(
	ClassCode varchar(10) PRIMARY KEY,
	HeadTeacher  varchar(30) ,
	Room varchar(30) ,
	TimeSlot char,
	CloseDate datetime 
)
GO
SELECT * FROM Class
GO
CREATE TABLE Student(
	RollNo varchar(10) PRIMARY KEY,
	ClassCode varchar(10),
	FullName varchar(30), 
	Male bit,
	BirthDate datetime ,
	Address varchar(30) ,
	Provice char(2),
	Email	varchar(30)
	CONSTRAINT cc FOREIGN KEY (ClassCode) REFERENCES Class(ClassCode) 
)
GO
SELECT * FROM Student
GO
CREATE TABLE Subject(
	SubjectCode  varchar(10) PRIMARY KEY,
	SubjectName  varchar(40),
	WMark BIT, 
	PMark BIT,
	WTest_per INT ,
	PTest_per INT ,
)
GO
SELECT * FROM Subject
GO
CREATE TABLE Mark(
	RollNo varchar(10),
	SubjectCode varchar(10),
	WMark FLOAT, 
	PMark FLOAT,
	MARK FLOAT
	CONSTRAINT rn FOREIGN KEY (RollNo) REFERENCES Student(RollNo),
	CONSTRAINT sc FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
)
GO
SELECT * FROM Mark
GO
--1. Chèn ít nhất 5 bản ghi cho từng bảng ở trên. 
INSERT INTO Class VALUES ('C10085B','Hoa Hong','B05','G',21/2/28),
						 ('C10210C','Anh Tuan','C03','G',21/3/30),
						 ('C10302A','Kim Lien','A01','G',21/3/15),
						 ('C10056A','Quang Tung','A07','G',21/4/7),
						 ('C10071A','Hong Thuy','A12','G',21/2/28)
GO
SELECT * FROM Class
GO
INSERT INTO Student VALUES ('A00222','C10071A','Nguyen Van Tuan',1,99/05/17,'123 TRAN PHU','HN','TUAN123@GMAIL.COM'),
						   ('B00232','C10085B','Le Van Tuan',1,99/06/11,'123 TRAN PHU','HN','TUANTIEN123@GMAIL.COM'),
						   ('A00125','C10302A','Hoang Van Tuan',0,96/07/19,'123 TRAN PHU','HN','HOA123@GMAIL.COM'),
						   ('A00325','C10071A','Tran Van Tuan',1,98/01/07,'123 TRAN PHU','HN','LOAN123@GMAIL.COM'),
						   ('A00523','C10085B','Nguyen Thi Hoa',0,99/03/15,'123 TRAN PHU','HN','QUAN123@GMAIL.COM')
GO
SELECT * FROM Student
GO
INSERT INTO Subject VALUES ('EPC1','TOAN',1,1,1,2),
						   ('CF','LY',1,1,1,2),
						   ('SQL','HOA',1,1,1,2),
						   ('JQUERY','VAN',1,1,1,2),
						   ('JAVAL','SINH',1,1,1,2)
GO
SELECT * FROM Subject
GO
INSERT INTO Mark VALUES ('A00222','EPC1',8,7,7.3),
						('B00232','CF',8.5,7.5,7.8),
						('A00125','EPC1',6,7.5,7),
						('A00325','JAVAL',7.5,9, 8.3),
						('A00523','JQUERY',9,9,9)
GO
SELECT * FROM Mark
GO
--2. Tạo một khung nhìn chứa danh sách các sinh viên đã có ít nhất 2 bài thi (2 môn học khác nhau). 
CREATE VIEW V_Student_Mark  AS
SELECT e.RollNo,e.FullName
FROM Student e
JOIN Mark AS p ON e.RollNo=p.RollNo
WHERE 
GO
SELECT * FROM V_Book_BookSold