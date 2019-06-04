USE [master]
GO
/****** Object:  Database [Euphoria_SampleProject_DB]    Script Date: 2019/04/03 23:20:22 ******/
CREATE DATABASE [Euphoria_SampleProject_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Euphoria_SampleProject_DB', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Euphoria_SampleProject_DB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Euphoria_SampleProject_DB_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Euphoria_SampleProject_DB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Euphoria_SampleProject_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET  MULTI_USER 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Euphoria_SampleProject_DB]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 2019/04/03 23:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[surname] [varchar](50) NULL,
	[address] [varchar](250) NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Persontbl]    Script Date: 2019/04/03 23:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persontbl](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[image] [image] NULL,
 CONSTRAINT [PK_Persontbl] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ContactCreateOrUpdate]    Script Date: 2019/04/03 23:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactCreateOrUpdate]
@ContactID int,
@Name varchar(50),
@Surname varchar(50),
@Address varchar(250)
AS
BEGIN
IF(@ContactID =0)
	BEGIN
	INSERT INTO Contact(Name,surname,address)
	VALUES(@Name,@Surname,@Address)
	END
ELSE
	BEGIN
	UPDATE Contact
	SET
		Name = @Name,
		Surname = @Surname,
		Address = @Address
	WHERE ContactID = @ContactID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[ContactDeleteByID]    Script Date: 2019/04/03 23:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactDeleteByID]
	@ContactID int
AS
	BEGIN
		DELETE FROM Contact
		WHERE ContactID = @ContactID
	END

GO
/****** Object:  StoredProcedure [dbo].[ContactViewAll]    Script Date: 2019/04/03 23:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactViewAll]
AS
	BEGIN
		SELECT * FROM	Contact
	END

GO
/****** Object:  StoredProcedure [dbo].[ContactviewByID]    Script Date: 2019/04/03 23:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactviewByID]
	@ContactID int
AS
	BEGIN
		SELECT * FROM Contact
		WHERE ContactID = @ContactID
	END

GO
USE [master]
GO
ALTER DATABASE [Euphoria_SampleProject_DB] SET  READ_WRITE 
GO
