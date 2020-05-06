--CREATE DATABASE UnitedNepaliDb; 
	
--Create a developer log table
CREATE TABLE DevLog(
	Id int  NOT NULL,
	LogDate date NOT NULL,
	LogThread varchar(255) NOT NULL,
	LogLevel varchar(50) NOT NULL,
	Logger varchar(255) NOT NULL,
	Message text NOT NULL,
	Exception text NULL,
	UserName varchar(128) NULL,
	HostAddress varchar(255) NULL,
	Browser varchar(255) NULL,
	constraint PK_DevLog PRIMARY KEY  
	(
		Id
	));


----------USER LOGIN AND ROLES MANAGEMENT

CREATE TABLE UserLogin(
	Id uuid NOT NULL,
	UserName varchar(128) NOT NULL,
	TemporaryPassword varchar NULL,
	UserConfirmed boolean NOT NULL DEFAULT FALSE,
	PasswordHash text NULL,
	LastLoginDate timestamp NULL,
	CreatedBy varchar(128) NOT NULL,
	CreatedDate timestamp NOT NULL,
	IsActive boolean NOT NULL,
	constraint PK_UserLogin PRIMARY KEY  
	(
		Id
	));

--Create Roles for basically every minute actions we want to control and assign it to various profiles
--These are updated using scripts as new functionality are added to the application
CREATE TABLE Role(
	Id varchar(128) NOT NULL,
	Description varchar(256) NULL,
	constraint PK_Role PRIMARY KEY  
	(
	Id
	));
--Role Seed Data
INSERT INTO Role (Id) VALUES (N'ManageRegions');
INSERT INTO Role (Id) VALUES (N'CreateOrganizations');
INSERT INTO Role (Id) VALUES (N'ManageOrganization');
INSERT INTO Role (Id) VALUES (N'ManageSecurityProfile');
INSERT INTO Role (Id) VALUES (N'ManageUsers');
INSERT INTO Role (Id) VALUES (N'AssignUsersToOrganization');
INSERT INTO Role (Id) VALUES (N'ManageEvents');
INSERT INTO Role (Id) VALUES (N'ViewUsers');
INSERT INTO Role (Id) VALUES (N'Basic');


CREATE TABLE SecurityProfile(
	Id varchar(128) NOT NULL,
	CreatedDate timestamp NOT NULL,
	Description varchar(256) NULL,
	constraint PK_SecurityProfile PRIMARY KEY  
	(
		Id
	));
--SecurityProfile Seed Data
INSERT INTO SecurityProfile (Id, CreatedDate) VALUES (N'Administrator', now());
INSERT INTO SecurityProfile (Id, CreatedDate) VALUES (N'OrganizationAdmin', now());
INSERT INTO SecurityProfile (Id, CreatedDate) VALUES (N'Executive', now());
INSERT INTO SecurityProfile (Id, CreatedDate) VALUES (N'BoardMember', now());
INSERT INTO SecurityProfile (Id, CreatedDate) VALUES (N'GeneralMember', now());


CREATE TABLE SecurityProfileRole(
	ProfileId varchar(128) NOT NULL,
	RoleId varchar(128) NOT NULL,
	constraint PK_SecurityProfileRole PRIMARY KEY  
	(
	ProfileId,
	RoleId
	));

--SecurityProfileRole Seed Data
--UnitedNepali Administrators
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'Administrator', N'CreateOrganizations');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'Administrator', N'ManageRegions');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'Administrator', N'ManageSecurityProfile');
--Organization Administrator (Usually President);
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'OrganizationAdmin', N'ManageOrganization');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'OrganizationAdmin', N'ManageSecurityProfile');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'OrganizationAdmin', N'AssignUsersToOrganization');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'OrganizationAdmin', N'ManageEvents');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'OrganizationAdmin', N'ViewUsers');
--Organization Operating board executives (e.g. Secretary, Treasurer, Vice-president);
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'Executive', N'AssignUsersToOrganization');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'Executive', N'ManageEvents');
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'Executive', N'ViewUsers');
--All other users
INSERT INTO SecurityProfileRole (ProfileId, RoleId) VALUES (N'GeneralMember', N'Basic');


CREATE TABLE UserSecurityProfile(
	UserId int NOT NULL,
	ProfileId varchar(128) NOT NULL,
	constraint PK_UserSecurityProfile PRIMARY KEY  
	(
		ProfileId,
		UserId
	));

--BACKUP: If we want simple relation between just user & roles (Not recommended)
--CREATE TABLE UserRole(
--	UserId varchar(128) NOT NULL,
--	RoleId varchar(128) NOT NULL,
-- constraint PK_UserRole PRIMARY KEY  
--(
--	UserId,
--	RoleId
--)
--);

--Create the organization table
CREATE TABLE Organization(
	Id int  NOT NULL,
	Name varchar(128) NOT NULL,
	BusinessId varchar(128) NULL,
	ParentId varchar(128) NULL,
	Email varchar(256) NOT NULL,
	OrganizationUrl varchar(256) NULL,
	Purpose varchar(50) NULL,
	Photo bytea NULL,
	Country varchar(500) NULL,
	Province varchar(500) NULL,
	District varchar(500) NULL,
	Municipality varchar(500) NULL,
	Address1 varchar(500) NULL,
	Address2 varchar(500) NULL,
	PostalCode varchar(50) NULL,
	PhoneNumber varchar(50) NULL,
	CreatedBy int NOT NULL,
	CreatedDate timestamp NOT NULL,
	IsActive bit NOT NULL,
	constraint PK_Organization PRIMARY KEY  
	(
		Id
	));

--Create the user table
CREATE TABLE "User"(
	Id int  NOT NULL,
	LoginId uuid NOT NULL,
	FirstName varchar(128) NULL,
	LastName varchar(128) NULL,
	OtherNames varchar(256) NULL,
	Title varchar(100) NULL,
	AdministrativeSex varchar(50) NULL,
	DateOfBirth varchar(50) NULL,
	HighestEducation varchar(50) NULL,
	Profession varchar(50) NULL,
	StreetAddress varchar(128) NULL,
	Municipality varchar(128) NULL,
	District varchar(128) NULL,
	Province varchar(128) NULL,
	Country varchar(128) NULL,
	MobilePhone varchar(50) NULL,
	OtherPhone varchar(50) NULL,
	Email varchar(256) NOT NULL,
	SocialLink text NULL,
	Photo bytea NULL,
	constraint PK_User PRIMARY KEY  
	(
		Id
	));

--Assign the user 
CREATE TABLE OrganizationUser(
	OrganizationId int NOT NULL,
	UserId int NOT NULL,
	MemberId varchar (128) NULL,
	RegisteredOn timestamp NOT NULL,
	constraint PK_OrganizationUser PRIMARY KEY  
	(
		OrganizationId,
		UserId
	));

--Create one organization seed data
--Create one admin user seed data for that organization


--- EVENT MANAGEMENT ---

CREATE TABLE Event(
	Id int  NOT NULL,
	Name varchar(50) NULL,
	Location varchar(255) NULL,
	StartDate timestamp NULL,
	EndDate timestamp NULL,
	EventUrl varchar(255) NULL,
	CreatedBy int NULL,
	CreatedDate timestamp NULL,
	EventCoordinator int NULL,
	EventType varchar(50) NULL,
	constraint PK_Event PRIMARY KEY  
	(
		Id
	));

CREATE TABLE EventRegistration(
	Id int  NOT NULL,
	EventId int NOT NULL,
	UserId int NOT NULL,
	Availability varchar(50) NULL,
	AdultCount int NULL,
	KidsCount int NULL,
	constraint PK_EventRegistration PRIMARY KEY  
	(
		Id
	));



----TODO
--Concept of Family 
--Language support in website and how to store them in DB
--Messaging support between users and organization 
--Organization notices and blogs
--Purchases and expenses in the organization
--Report generation for the organizations (Charts/Tables/...)
--Organization Gallery (Pictures/Videos)



