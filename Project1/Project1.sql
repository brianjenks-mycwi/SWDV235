/*Create our database*/
CREATE DATABASE MathHelp
GO
USE MathHelp
GO

/*Create a table for our newsletter*/
CREATE TABLE Newsletter (
	visitorID int primary key identity,
	email nvarchar(200) NOT NULL,
	dateApplied date NOT NULL default getdate() --We want this to be set to today's date
)
GO

/*Create a table for contact reasons*/
CREATE TABLE Reasons (
	reasonID int NOT NULL primary key identity,
	reason varchar(45) NOT NULL
)
GO

/*Create a table for our contact information*/
CREATE TABLE Contact (
	contactID int primary key identity,
	firstName nvarchar(50) NOT NULL,
	lastName nvarchar(50) NOT NULL,
	email nvarchar(200) NOT NULL,
	phone char(10) NOT NULL,
	reasonID int NOT NULL,
	contactComment nvarchar(500) NOT NULL

	FOREIGN KEY (reasonID) REFERENCES Reasons(reasonID)
)
GO

/*Instantiate our reasons table with some data*/
INSERT INTO Reasons
	(reason)
VALUES
	('Not Selected'),
	('Recommendation'),
	('Criticism'),
	('Questions'),
	('Other')
GO

/*Add a contact using a procedure*/
CREATE PROC addContact
	@firstName nvarchar(50),
	@lastName nvarchar(50),
	@email nvarchar(200),
	@phone char(10),
	@reasonID int,
	@contactComment nvarchar(500)
AS
INSERT INTO [MathHelp].[dbo].[Contact]
    ([firstName]
    ,[lastName]
    ,[email]
	,[phone]
	,[reasonID]
	,[contactComment])
VALUES
    (@firstName
	,@lastName
	,@email
	,@phone
	,@reasonID
	,@contactComment)
GO

/*Add a newsletter signup using a procedure*/
CREATE PROC addNewsSignup
	@email nvarchar(200)
AS
INSERT INTO [MathHelp].[dbo].[Newsletter]
	([email])/* The date will be auto populated */
VALUES 
	(@email)
GO

/* Create the login for web users to access */
CREATE LOGIN [MathApp] WITH PASSWORD='Pa$$w0rd', DEFAULT_DATABASE=[MathHelp]
go
use MathHelp
go
CREATE USER [MathApp] FOR LOGIN [MathApp] WITH DEFAULT_SCHEMA=[dbo]
GO
/* They are only allowed to execute two different procedures */
grant execute on addContact to MathApp
go
grant execute on addNewsSignup to MathApp
go

SELECT * FROM Newsletter
GO
SELECT * FROM Contact
GO