--Vi Du 1:
CREATE DATABASE [Customer_DB] ON PRIMARY
(NAME='Customer_DB',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\Customer_DB.mdf')

 LOG ON
(NAME='Customer_DB_log',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\Customer_DB_log.mdf')

 COLLATE SQL_Latin1_General_CP1_CI_AS



 --Vi Du 2:
 ALTER DATABASE Customer_DB MODIFY NAME = CUST_DB

 --Vi Du 3:
 USE CUST_DB
 EXEC sp_changedbowner 'sa'

 --Vi Du 4:
 USE CUST_DB
 ALTER DATABASE CUST_DB
 SET AUTO_SHRINK ON

 --Vi Du 5:
 CREATE DATABASE [SalesDB] ON PRIMARY
(NAME='SalesDB',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\SalesDB.mdf', SIZE=3072KB, MAXSIZE=UNLIMITED,FILEGROWTH=1024KB),
FILEGROUP [MyFileGroup]
(NAME='SalesDB_FG',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\SalesDB_FG.ndf',SIZE=3072KB, MAXSIZE=UNLIMITED,FILEGROWTH=1024KB)

LOG ON

(NAME='SalesDB_log',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\SalesDB_log.ldf',SIZE=2048KB, MAXSIZE=2048GB,FILEGROWTH=10%)

COLLATE SQL_Latin1_General_CP1_CI_AS

--Vi Du 6:
USE CUST_DB;

ALTER DATABASE CUST_DB

ADD FILEGROUP FG_ReadOnly

--Vi Du 7:
USE CUST_DB
ALTER DATABASE CUST_DB

ADD FILE (NAME='Cust_DB1', 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\Cust_DB1.ndf')

TO FILEGROUP FG_ReadOnly

ALTER DATABASE CUST_DB

MODIFY FILEGROUP FG ReadOnly DEFAULT