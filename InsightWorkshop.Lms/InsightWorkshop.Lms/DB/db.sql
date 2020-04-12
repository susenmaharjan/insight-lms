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