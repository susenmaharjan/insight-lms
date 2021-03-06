USE [master]
GO
/****** Object:  Database [lms]    Script Date: 4/15/2020 12:09:41 PM ******/
CREATE DATABASE [lms]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'lms', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\lms.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'lms_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\lms_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [lms] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lms].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [lms] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [lms] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [lms] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [lms] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [lms] SET ARITHABORT OFF 
GO
ALTER DATABASE [lms] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [lms] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [lms] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [lms] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [lms] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [lms] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [lms] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [lms] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [lms] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [lms] SET  DISABLE_BROKER 
GO
ALTER DATABASE [lms] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [lms] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [lms] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [lms] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [lms] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [lms] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [lms] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [lms] SET RECOVERY FULL 
GO
ALTER DATABASE [lms] SET  MULTI_USER 
GO
ALTER DATABASE [lms] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [lms] SET DB_CHAINING OFF 
GO
ALTER DATABASE [lms] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [lms] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [lms] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'lms', N'ON'
GO
ALTER DATABASE [lms] SET QUERY_STORE = OFF
GO
USE [lms]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Author] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Availability] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Records]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Records](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[BookId] [int] NULL,
	[ApprovedOn] [datetime] NULL,
	[Expiry] [datetime] NULL,
	[ReturnStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](25) NULL,
	[Password] [nvarchar](15) NULL,
	[RoleId] [int] NULL,
	[Email] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_Username]    Script Date: 4/15/2020 12:09:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [U_Username] ON [dbo].[Users]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [fk_book_id] FOREIGN KEY([BookId])
REFERENCES [dbo].[Books] ([Id])
GO
ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [fk_book_id]
GO
ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [fk_user_id] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [fk_user_id]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [fk_role_id] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [fk_role_id]
GO
/****** Object:  StoredProcedure [dbo].[procApproveBook]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procApproveBook](@Id int, @ApprovedOn datetime, @Expiry datetime)
AS
BEGIN
	UPDATE Records
	SET ApprovedOn =@ApprovedOn, Expiry = @Expiry
	WHERE Id= @Id
END
GO
/****** Object:  StoredProcedure [dbo].[procAuthorizeUser]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procAuthorizeUser](@Username nvarchar(20), @Password nvarchar(20))
AS
BEGIN
	SELECT [Id], [Username], [Password], [RoleId], [Email] FROM Users
	WHERE [Username] = @Username AND [Password]=@Password
END
GO
/****** Object:  StoredProcedure [dbo].[procBorrowBook]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procBorrowBook](@UserId int, @BookId int)
AS
BEGIN
	INSERT INTO Records(UserId,BookId) VALUES(@UserId, @BookId)
END
GO
/****** Object:  StoredProcedure [dbo].[procDeleteBookById]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procDeleteBookById](@Id int)
AS
BEGIN
	DELETE FROM Books
	WHERE Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[procGetApprovedRecordsByUser]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGetApprovedRecordsByUser](@UserId int)
AS
BEGIN
	SELECT rec.Id as RecordId, rec.UserId as UserId, rec.BookId AS BookId,bk.Title as BookTitle, usr.Username as Username FROM Records rec
	JOIN Books bk ON rec.BookId = bk.Id
	JOIN Users usr ON rec.UserId = usr.Id
	WHERE UserId = @UserId
	AND (ReturnStatus IS NULL OR ReturnStatus = 0)
	AND ApprovedOn IS NOT NULL
END


GO
/****** Object:  StoredProcedure [dbo].[procGetBookById]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procGetBookById](@Id int)
AS
BEGIN
(
	SELECT [Id], [Title], [Author], [Quantity], [Availability] FROM Books
	WHERE Id = @Id
)
END
GO
/****** Object:  StoredProcedure [dbo].[procGetBooks]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGetBooks]
AS
BEGIN
SELECT Id, Title, Author, Quantity, [Availability] FROM Books
END
GO
/****** Object:  StoredProcedure [dbo].[procGetLateRecordsByDate]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGetLateRecordsByDate](@Expiry datetime)
AS  
BEGIN  
	SELECT rec.Id as RecordId, rec.UserId as UserId, rec.BookId AS BookId,bk.Title as BookTitle, usr.Username as Username, usr.Email as Email FROM Records rec
	JOIN Books bk ON rec.BookId = bk.Id
	JOIN Users usr ON rec.UserId = usr.Id
	WHERE rec.Expiry <= @Expiry
	ORDER BY rec.Id DESC
END  
GO
/****** Object:  StoredProcedure [dbo].[procGetRecordById]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGetRecordById](@Id int)
AS
BEGIN
	SELECT * FROM Records
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[procGetReturnedRecords]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGetReturnedRecords]
AS  
BEGIN  
	SELECT rec.Id as RecordId, rec.UserId as UserId, rec.BookId AS BookId,bk.Title as BookTitle, usr.Username as Username FROM Records rec
	JOIN Books bk ON rec.BookId = bk.Id
	JOIN Users usr ON rec.UserId = usr.Id
	WHERE rec.ReturnStatus = 1
	ORDER BY rec.Id DESC
END  
GO
/****** Object:  StoredProcedure [dbo].[procGetUnapprovedRecords]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGetUnapprovedRecords]  
AS  
BEGIN  
SELECT rec.Id as RecordId, rec.UserId as UserId, rec.BookId AS BookId,bk.Title as BookTitle, usr.Username as Username FROM Records rec
JOIN Books bk ON rec.BookId = bk.Id
JOIN Users usr ON rec.UserId = usr.Id
WHERE rec.ApprovedOn IS NULL
END  
GO
/****** Object:  StoredProcedure [dbo].[procRegisterUser]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procRegisterUser](@Username nvarchar(25),@Password nvarchar(15), @Email nvarchar(30))
AS
BEGIN
	INSERT INTO Users(Username,[Password],Email,RoleId)
	VALUES (@Username,@Password,@Email,2)
END
GO
/****** Object:  StoredProcedure [dbo].[procReturnBook]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procReturnBook](@Id int, @ReturnStatus BIT)
AS
BEGIN
	UPDATE Records
	SET Expiry=NULL,
	ReturnStatus = @ReturnStatus
	WHERE Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[procUpdateBook]    Script Date: 4/15/2020 12:09:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procUpdateBook](@Author nvarchar(20), @Availability bit, @Quantity int, @Title nvarchar(20), @Id int)
AS
BEGIN
	UPDATE [Books]
	SET
	Author = @Author,
	Availability = @Availability,
	Quantity = @Quantity,
	Title = @Title
	WHERE Id = @Id
END
GO
USE [master]
GO
ALTER DATABASE [lms] SET  READ_WRITE 
GO
