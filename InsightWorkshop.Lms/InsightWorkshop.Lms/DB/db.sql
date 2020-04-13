CREATE TABLE Roles
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Type NVARCHAR(10)
)
GO
CREATE TABLE Users
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Username NVARCHAR(25),
	[Password] NVARCHAR(15),
	RoleId INT,
	Email NVARCHAR(30),
    CONSTRAINT fk_role_id FOREIGN KEY(RoleId) REFERENCES Roles(Id)
)
GO
CREATE TABLE Books
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50),
	Author NVARCHAR(50),
	Quantity INT,
	[Availability] BIT
)
GO
CREATE TABLE Records
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	UserId INT,
	BookId INT,
	ApprovedOn DATETIME,
	Expiry DATETIME,
	CONSTRAINT fk_user_id FOREIGN KEY(UserId) REFERENCES Users(Id),
	CONSTRAINT fk_book_id FOREIGN KEY(BookId) REFERENCES Books(Id)
)

GO

CREATE PROCEDURE procGetBooks
AS
BEGIN
	SELECT Id, Title, Author, Quantity, [Availability] FROM Books
END
GO

CREATE PROCEDURE procGetBookById(@Id int)
AS
BEGIN
(
	SELECT [Id], [Title], [Author], [Quantity], [Availability] FROM Books
	WHERE Id = @Id
)
END
GO

CREATE PROCEDURE procUpdateBook(@Author nvarchar(20), @Availability bit, @Quantity int, @Title nvarchar(20), @Id int)
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


CREATE PROCEDURE procDeleteBookById(@Id int)
AS
BEGIN
	DELETE FROM Books
	WHERE Id=@Id
END
GO


CREATE PROCEDURE procAuthorizeUser(@Username nvarchar(20), @Password nvarchar(20))
AS
BEGIN
	SELECT [Id], [Username], [Password], [RoleId], [Email] FROM Users
	WHERE [Username] = @Username AND [Password]=@Password
END
GO


CREATE PROCEDURE procBorrowBook(@UserId int, @BookId int)
AS
BEGIN
	INSERT INTO Records(UserId,BookId) VALUES(@UserId, @BookId)
END
GO

CREATE PROCEDURE procApproveBook(@Id int, @ApprovedOn datetime, @Expiry datetime)
AS
BEGIN
	UPDATE Records
	SET ApprovedOn =@ApprovedOn, @Expiry = @Expiry
	WHERE Id= @Id
END
GO


ALTER TABLE Records
ADD ReturnStatus BIT;
GO

CREATE PROCEDURE procGetUnapprovedRecords  
AS  
BEGIN  
	SELECT rec.Id as RecordId, rec.UserId as UserId, rec.BookId AS BookId,bk.Title as BookTitle, usr.Username as Username FROM Records rec
	JOIN Books bk ON rec.BookId = bk.Id
	JOIN Users usr ON rec.UserId = usr.Id
	WHERE rec.ApprovedOn IS NULL
END  
GO


CREATE PROCEDURE procGetRecordById(@Id int)
AS
BEGIN
	SELECT * FROM Records
	WHERE Id = @Id
END
GO


CREATE PROCEDURE procGetApprovedRecordsByUser(@UserId int)
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


CREATE PROCEDURE procReturnBook(@Id int, @ReturnStatus BIT)
AS
BEGIN
	UPDATE Records
	SET Expiry=NULL,
	ReturnStatus = @ReturnStatus
	WHERE Id=@Id
END
GO


CREATE PROCEDURE procRegisterUser(@Username nvarchar(25),@Password nvarchar(15), @Email nvarchar(30))
AS
BEGIN
	INSERT INTO Users(Username,[Password],Email,RoleId)
	VALUES (@Username,@Password,@Email,2)
END
GO