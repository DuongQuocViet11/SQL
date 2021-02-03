USE AdventureWorks2019
GO

--Tạo một thủ tục lưu trữ lấy ra toàn bộ nhận viên vào làm theo năm có tham số đầu vào là một năm
CREATE PROCEDURE sp_DisplayEmployeesHireYear
@HireYear int
AS
SELECT * FROM HumanResources.Employee
WHERE DATEPART(YY, HireDate)=@HireYear
GO

--Để chạy thủ tục này cân phái truyền tham số vào là năm mà nhận viên vào làm
EXECUTE sp_DisplayEmployeesHireYear 2003
GO

--Tạo thủ tục lưu trữ đếm số ngựờỉ vào làm trọng một năm xác đỉnh có tham số đầu vào là một năm,
--tham số đầu ra là số người vào làm trọng năm này
CREATE PROCEDURE sp_EmployeesHireYearCount
@HireYear int,
@Count int OUTPUT
AS
SELECT @Count=COLWT(*) FROM HumanResources.Employee
WHERE DATEPART(YY, HireDate)=@HireYear
GO

--Chạy thủ tục lưu trữ cần phái truyền vào 1 tham số đầu vào và một tham số đầu ra.
DECLARE @Number int
EXECUTE sp_EmployeesHireYearCount 2003, @Number OUTPUT
PRINT @Number
GO

--Tạo thủ tục lưu trữ đếm số người vào làm trọng một năm xác đỉnh có tham số đầu vào là một năm, hàm trá về số người vào làm năm đó
CREATE PROCEDURE sp_EmployeesHireYearCount2
@HireYear int
AS
DECLARE @Count int
SELECT @Count=COLWT(*) FROM HumanResources.Employee
WHERE DATEPART(YY, HireDate)=@HireYear
RETURN @Count 
GO

--Chạy thủ tục lưu trữ cần phái trụvển vào 1 tham số đầu và lấy về số người làm trọng năm đó.
DECLARE @Number int
EXECUTE @Number = sp_EmployeesHireYearCount2 2003
PRINT @Number
GO

--Tạo báng tạm #Students
CREATE TABLE #Students (
	RollNo varchar(6) CONSTRAINT PK-Students PRIMARY KEY,
	FullName nvarchar(100),
	Birthday datetỉme constraint DF_StudentsBỉrthday DEFAULT DATEADD(yy, -18, GETDATE() ) 
)
GO

--Tạo thủ tục lưu trữ tạm để chèn dữ Liệu vào bỏng tạm
CREATE PROCEDURE #splnsertstudents
@rollNo varchar(6),
@fullName nvarchar(100),
@bỉrthday datetỉme
AS BEGIN
IF(@bỉrthday IS NULL)
SET @bỉrthday=DATEADD(YY, -18, GETDATEO)
INSERT INTO #Students(RollNo, FullName, Bỉrthday)
VALUES(@rollNo, @fullName, @bỉrthday) 
END
GO

--Sử dụng thủ tục lưu trữ để chèn dữ Lịêu vào báng tạm
EXEC SpStudents 'A12345', 'abc' NULL
EXEC #spStudents 'A54321', 'abc', '12/24/2011'
SELECT * FROM #Students
--Tạo thủ tục lưu trữ tạm để xóa dữ liệu từ bỏng tạm theo RollNo
CREATE PROCEDURE #spDeleteStudents
@rollNo varchar(6) AS 
BEGIN
DELETE FR0M #Students WHERE RollNo=@rollNo 
END

--xóa dữ Ịịêụ sử dụng thủ tục lưu trữ
EXECUTE #spDeleteStudents 'A12345'
GO
--Tạo một thủ tục lưu trữ sử dung lệnh RETURN để trỏ về một số nguyên
CREATE PROCEDURE Cal_Square @num int=0 AS
BEGIN
	RETURN (@num * @num);
END
GO

--Chạy thủ tục lưu trữ
DECLARE @square int;
EXEC @square = Cal_Square 10;
PRINT @square;
GO

--Xem đinh nghĩa thủ tục lưu trữ bằng hàm OBJECT_DEFINITION
SELECT OBJECT_DEFINITION(OBJECT_ID('HumanResources.uspUpdateEmployeePersonallnfo')) AS DEFINITION

--Xem định nghĩa thủ tục lưu trữ bằng
SELECT definition FROM sys.sql_modules
WHERE object_id=OBJECT_ID('HumanResources.uspUpdateEmployeePersonallnfo')
GO

--Thủ tục lưu trữ hệ thống xem các thành phạn mà thủ tục lưu trữ phụ thuộc
sp_depends 'HumanResources.uspUpdateEmployeePersonallnfo'
GO

USE AdventureWorks2019
GO

--Tạo thủ tục lưu trữ sp_DỉsplayEmployees
CREATE PROCEDURE sp_DisplayEmployees AS
SELECT * FR0M HumanResources.Employee 
GO

--Thay đổi thủ tục lưu trữ sp_DỉsplayEmployees
ALTER PROCEDURE sp_DisplayEmployees AS
SELECT * FROM HumanResources.Employee
WHERE Gender='F' 
GO

--Chay thủ tục lưu trữ sp_DỉsplayEmployees 
EXEC sp_DisplayEmployees 
GO
--Xóa một thủ tục lưu trữ
DROP PROCEDURE sp_DỉsplayEmployees 
GO

CREATE PROCEDURE sp_EmployeeHire 
AS 
BEGIN
--Hiển thị
EXECUTE sp_DỉsplayEmployeesHireYear 1999
DECLARE @Number INT
EXECUTE sp_EmployeesHỉreYearCount 1999, @Number OUTPUT
PRINT N'SỐ nhận viên vào làm năm 1999 là:' 1 + C0NVERT(varchar(3),@Number)
END
GO

--Chạy thủ tục lưu trữ 
EXEC sp_EmployeeHỉre
GO

--Thạy đổi thủ tục lưu trữ sp_EmployeeHỉre có khối TRY ... CATCH
ALTER PROCEDURE sp.EmployeeHiRe
	@HireYear INT
AS
BEGIN
	BEGIN TRY
	EXECUTE sp_DisplayEmployeesHireYear @HireYear
	DECLARE gNumber int
	--Lỗi xáy ra ở đây có thủ tục sp_EmployeesHỉreYearCount chì truyền 2 tham số mà ta truyền 3 ẼXECUTE sp_EmployeesHireYearCount gHireYeảr, gNumber OUTPUT,“
	PRINT N'SỐ nhận viện vào làm năm là:' 1 + C0NVERT(varchar(3),@Number)
	END TRY
	BEGIN CATCH
	PRINT N'CÓ lỗi xáy ra trọng khi thực hiên thủ tục lưu trữ'
	END CATCH
	PRINT N'Kết thúc thủ tục lưu trữ'
END
GO

--Chay thủ tục sp_EmployeeHỉre
EXEC sp_EmployeeHire 1999
--Xem thông báo lỗi bên Messages không phái bên Result GO
--Thay đổi thủ tục lưu trữ sp_EmployeeHỉre sử dụng hàm @@ERR0R
ALTER PROCEDURE sp_EmployeeHỉre
@HỉreYear int
AS
BEGIN
EXECUTE sp_DỉsplayEmployeesHireYear @HireYear
DECLARE @Number INT
--Lỗi xỏy ra ở đây có thủ tục sp_EmployeesHỉreYearCount chì truyền 2 tham số mà ta truyền 3
EXECUTE sp_EmployeesHireYearCount @HireYear, gNumber OUTPUT,'123'
IF @@ERR0R <> 0
PRINT N'CÓ lỗi xáy ra trọng khi thực hiên thủ tục lưu trữ'
PRINT N'SỐ nhận viên vào làm năm là:' 1 + C0NVERT(varchar(3),@Number)
END
GO
--Chay thủ tục sp_EmployeeHỉre
EXEC sp_EmployeeHire 1999
--Xem thông báo lỗi bên Messages không phái bên Result