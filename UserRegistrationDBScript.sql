USE [master]
GO
/****** Object:  Database [UserRegistrationDB]    Script Date: 12/03/2023 9:16:28 pm ******/
CREATE DATABASE [UserRegistrationDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tbl_UserRegistation', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\Tbl_UserRegistation.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tbl_UserRegistation_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\Tbl_UserRegistation_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [UserRegistrationDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UserRegistrationDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UserRegistrationDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UserRegistrationDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UserRegistrationDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UserRegistrationDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UserRegistrationDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET RECOVERY FULL 
GO
ALTER DATABASE [UserRegistrationDB] SET  MULTI_USER 
GO
ALTER DATABASE [UserRegistrationDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UserRegistrationDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UserRegistrationDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UserRegistrationDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UserRegistrationDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UserRegistrationDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'UserRegistrationDB', N'ON'
GO
ALTER DATABASE [UserRegistrationDB] SET QUERY_STORE = OFF
GO
USE [UserRegistrationDB]
GO
/****** Object:  Table [dbo].[tbl_UserRegistration]    Script Date: 12/03/2023 9:16:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserRegistration](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Email] [nvarchar](150) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[CreditCardNumber] [nvarchar](max) NULL,
	[CCV] [nvarchar](max) NULL,
	[ExpireDate] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_UserRegistration] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spGetAllData]    Script Date: 12/03/2023 9:16:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllData]  

AS
BEGIN
	select * from tbl_UserRegistration 
	order by CreatedOn desc
END
GO
/****** Object:  StoredProcedure [dbo].[spUserRegistration]    Script Date: 12/03/2023 9:16:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUserRegistration]  
@FirstName			nvarchar(100),
@LastName			nvarchar(100),
@Email				nvarchar(150),
@PhoneNumber		nvarchar(15),
@CreditCardNumber	nvarchar(max),
@CVV				nvarchar(max),
@ExpireDate			nvarchar(50)
AS
BEGIN
	insert into tbl_UserRegistration(FirstName,LastName,Email,PhoneNumber,CreditCardNumber,CCV,[ExpireDate],CreatedOn)
	values(
		@FirstName,			
		@LastName,			
		@Email,				
		@PhoneNumber,		
		@CreditCardNumber,	
		@CVV,				
		@ExpireDate	,
		GETDATE()
	)
END
GO
USE [master]
GO
ALTER DATABASE [UserRegistrationDB] SET  READ_WRITE 
GO
