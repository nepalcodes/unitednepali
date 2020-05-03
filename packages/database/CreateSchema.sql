USE [master]
GO

-- Replace [unitednepdb] with [%Your choice of DB Name%] in entire script
CREATE DATABASE [unitednepdb]
GO

USE [unitednepdb]
GO

DECLARE @CreatedNow DateTimeOffset = SYSDATETIMEOFFSET();

--Create a developer log table
CREATE TABLE [dbo].[DevLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[LogThread] [varchar](255) NOT NULL,
	[LogLevel] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Exception] [nvarchar](max) NULL,
	[UserName] [nvarchar](128) NULL,
	[HostAddress] [varchar](255) NULL,
	[Browser] [varchar](255) NULL
	CONSTRAINT [PK_DevLog] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)


----------USER LOGIN AND ROLES MANAGEMENT

CREATE TABLE [dbo].[UserLogin](
	[Id] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](128) NOT NULL,
	[TemporaryPassword] [nvarchar] NULL,
	[UserConfirmed] [bit] NOT NULL DEFAULT ((0)),
	[PasswordHash] [nvarchar](max) NULL,
	[LastLoginDate] [datetimeoffset](7) NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[IsActive] [bit] NOT NULL DEFAULT ((1))
	CONSTRAINT [PK_UserLogin] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)

--Create Roles for basically every minute actions we want to control and assign it to various profiles
--These are updated using scripts as new functionality are added to the application
CREATE TABLE [dbo].[Role](
	[Id] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](256) NULL,
	CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
	(
	[Id] ASC
	)
)
--[Role] Seed Data
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'ManageRegions')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'CreateOrganizations')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'ManageOrganization')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'ManageSecurityProfile')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'ManageUsers')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'AssignUsersToOrganization')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'ManageEvents')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'ViewUsers')
INSERT INTO [dbo].[Role] ([Id]) VALUES (N'Basic')


CREATE TABLE [dbo].[SecurityProfile](
	[Id] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[Description] [nvarchar](256) NULL,
	CONSTRAINT [PK_SecurityProfile] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
--[SecurityProfile] Seed Data
INSERT INTO [dbo].[SecurityProfile] ([Id], [CreatedDate]) VALUES (N'Administrator', @CreatedNow)
INSERT INTO [dbo].[SecurityProfile] ([Id], [CreatedDate]) VALUES (N'OrganizationAdmin', @CreatedNow)
INSERT INTO [dbo].[SecurityProfile] ([Id], [CreatedDate]) VALUES (N'Executive', @CreatedNow)
INSERT INTO [dbo].[SecurityProfile] ([Id], [CreatedDate]) VALUES (N'BoardMember', @CreatedNow)
INSERT INTO [dbo].[SecurityProfile] ([Id], [CreatedDate]) VALUES (N'GeneralMember', @CreatedNow)
GO

CREATE TABLE [dbo].[SecurityProfileRole](
	[ProfileId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	CONSTRAINT [PK_SecurityProfileRole] PRIMARY KEY CLUSTERED 
	(
	[ProfileId] ASC,
	[RoleId] ASC
	)
)

--[SecurityProfileRole] Seed Data
--UnitedNepali Administrators
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'Administrator', N'CreateOrganizations')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'Administrator', N'ManageRegions')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'Administrator', N'ManageSecurityProfile')
--Organization Administrator (Usually President)
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'OrganizationAdmin', N'ManageOrganization')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'OrganizationAdmin', N'ManageSecurityProfile')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'OrganizationAdmin', N'AssignUsersToOrganization')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'OrganizationAdmin', N'ManageEvents')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'OrganizationAdmin', N'ViewUsers')
--Organization Operating board executives (e.g. Secretary, Treasurer, Vice-president)
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'Executive', N'AssignUsersToOrganization')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'Executive', N'ManageEvents')
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'Executive', N'ViewUsers')
--All other users
INSERT INTO [dbo].[SecurityProfileRole] ([ProfileId], [RoleId]) VALUES (N'GeneralMember', N'Basic')


CREATE TABLE [dbo].[UserSecurityProfile](
	[UserId] [int] NOT NULL,
	[ProfileId] [nvarchar](128) NOT NULL,
	CONSTRAINT [PK_UserSecurityProfile] PRIMARY KEY CLUSTERED 
	(
		[ProfileId] ASC,
		[UserId] ASC
	)
)

--BACKUP: If we want simple relation between just user & roles (Not recommended)
--CREATE TABLE [dbo].[UserRole](
--	[UserId] [nvarchar](128) NOT NULL,
--	[RoleId] [nvarchar](128) NOT NULL,
-- CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
--(
--	[UserId] ASC,
--	[RoleId] ASC
--)
--)

--Create the organization table
CREATE TABLE [dbo].[Organization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[BusinessId] [nvarchar](128) NULL,
	[ParentId] [nvarchar](128) NULL,
	[Email] [nvarchar](256) NOT NULL,
	[OrganizationUrl] [varchar](256) NULL,
	[Purpose] [nvarchar](50) NULL,
	[Photo] [varbinary](max) NULL,
	[Country] [nvarchar](500) NULL,
	[Province] [nvarchar](500) NULL,
	[District] [nvarchar](500) NULL,
	[Municipality] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[PostalCode] [nvarchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)

--Create the user table
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginId] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](128) NULL,
	[LastName] [nvarchar](128) NULL,
	[OtherNames] [nvarchar](256) NULL,
	[Title] [nvarchar](100) NULL,
	[AdministrativeSex] [nvarchar](50) NULL,
	[DateOfBirth] [nvarchar](50) NULL,
	[HighestEducation] [nvarchar](50) NULL,
	[Profession] [nvarchar](50) NULL,
	[StreetAddress] [nvarchar](128) NULL,
	[Municipality] [nvarchar](128) NULL,
	[District] [nvarchar](128) NULL,
	[Province] [nvarchar](128) NULL,
	[Country] [nvarchar](128) NULL,
	[MobilePhone] [nvarchar](50) NULL,
	[OtherPhone] [nvarchar](50) NULL,
	[Email] [nvarchar](256) NOT NULL,
	[SocialLink] [nvarchar](max) NULL,
	[Photo] [varbinary](max) NULL
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)

--Assign the user 
CREATE TABLE [dbo].[OrganizationUser](
	[OrganizationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[MemberId] [nvarchar] (128) NULL,
	[RegisteredOn] [datetimeoffset](7) NOT NULL,
	CONSTRAINT [PK_OrganizationUser] PRIMARY KEY CLUSTERED 
	(
		[OrganizationId] ASC,
		[UserId] ASC
	)
)


--[UserSecurityProfile] Seed Data
DECLARE @sysAdminUserId nvarchar(max) = N'103b4c40-869d-4fff-831b-464f33c2cc91';
--INSERT INTO [dbo].[User] ([UserId], [UserName], [FirstName], [LastName], [Title], [TemporaryPassword], [PasswordExpirationDate], [PreferredLanguage], [CreatedBy], [CreatedDate], [IsActive], [Email], 
--[EmailConfirmed], [PasswordHash], [SecurityStamp], [WorkPhone], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [Locked], [AccessFailedCount], [ExtendedProperties], [ResetPasswordTries], [SecurityAnswerTries], [LastLoginDate], [HomePhone], [MobilePhone], [OtherPhone], [Organization]) VALUES (@sysAdminUserId, N'sysadmin', N'System', N'Admin', N'System', 0, '20400101 11:00:00.0000000 +00:00', N'en', N'-', @CreatedNow, 1, N'sysadmin@fio.com', 1, N'$2a$10$TWdspp22A.F6IjswrugLNeQAxFAN84SfjxY2BZO0NMMQ5PUtiwUsW', N'457adbf9-71f7-446b-91ce-6c53dbe3d31e', NULL, 1, 0, NULL, 1, 0, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, N'Fio')
--INSERT INTO [dbo].[UserSecurityProfile] ([UserId], [ProfileId]) VALUES (@sysAdminUserId, N'Administrator')


--Create one organization seed data
--Create one admin user seed data for that organization


--- EVENT MANAGEMENT ---

CREATE TABLE [dbo].[Event](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Location] [nvarchar](255) NULL,
	[StartDate] [datetimeoffset](7) NULL,
	[EndDate] [datetimeoffset](7) NULL,
	[EventUrl] [nvarchar](255) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NULL,
	[EventCoordinator] [int] NULL,
	[EventType] [nvarchar](50) NULL,
	CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)

CREATE TABLE [dbo].[EventRegistration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Availability] [nvarchar](50) NULL,
	[AdultCount] [int] NULL,
	[KidsCount] [int] NULL
	CONSTRAINT [PK_EventRegistration] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)



----TODO
--Concept of Family 
--Language support in website and how to store them in DB
--Messaging support between users and organization 
--Organization notices and blogs
--Purchases and expenses in the organization
--Report generation for the organizations (Charts/Tables/...)
--Organization Gallery (Pictures/Videos)


--WORK IN PROGRESS

----Concept of region boundary for any organization operation
--CREATE TABLE [dbo].[Region](
--	[Id] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](128) NOT NULL,
--	[ParentId] [nvarchar](128) NULL,
--	[Level] [int] NOT NULL
--	CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
--	(
--		[Id] ASC
--	)
--)

----[Region] Seed Data
--INSERT INTO [dbo].[Region] ([Name], [ParentId], [Level]) VALUES (N'UnitedNepali', NULL, 1)
--INSERT INTO [dbo].[Region] ([Name], [ParentId], [Level]) VALUES (N'Canada', 1, 2)
--INSERT INTO [dbo].[Region] ([Name], [ParentId], [Level]) VALUES (N'SNS', 1, 2)


