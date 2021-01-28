CREATE DATABASE CodeLean
GO
CREATE TABLE Classes(
	ClassName char(6),
	Teacher varchar(30),
	TimeSlot varchar(30),
	Class INT,
	Lab INT
)
GO
--1. Tạo an unique, clustered index tên là MyClusteredIndex trên trường ClassName 
ALTER TABLE Classes ADD CONSTRAINT UNI_ClassName UNIQUE(ClassName)
GO
CREATE CLUSTERED INDEX MyClusteredIndex
ON Classes(ClassName)
GO
--2. Tạo a nonclustered index tên là TeacherIndex trên trường Teacher
CREATE NONCLUSTERED INDEX TeacherIndex
ON Classes(Teacher)
GO
--3. Xóa chỉ mục TeacherIndex 
DROP INDEX TeacherIndex ON Classes
GO
--4. Xây dựng lại MyClusteredIndex với các thuộc tính FILLFACTOR 
ALTER INDEX MyClusteredIndex ON Classes REBUILD WITH(FILLFACTOR=60)
GO
--5. Tạo một composite index tên là  trên 2 trường Class và Lab.
CREATE INDEX ClassLabIndex ON Classes(Class, Lab)
GO
--6. Viết câu lệnh xem toàn bộ các chỉ mục của cơ sở dữ liệu CodeLean.
DBCC SHOW_STATISTICS(Classes,MyClusteredIndex)
GO