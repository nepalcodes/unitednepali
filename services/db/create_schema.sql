--Assumption: the database exists
--CREATE DATABASE united_nepali_db; 

--Clean the schema	
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

--Create a developer log table
CREATE TABLE dev_log(
	id INT  NOT NULL,
	log_date TIMESTAMP NOT NULL,
	log_thread VARCHAR(255) NOT NULL,
	log_level VARCHAR(50) NOT NULL,
	logger VARCHAR(255) NOT NULL,
	message TEXT NOT NULL,
	exception TEXT NULL,
	user_name VARCHAR(128) NULL,
	host_address VARCHAR(255) NULL,
	browser VARCHAR(255) NULL,
	CONSTRAINT pk_devlog PRIMARY KEY  
	(
		id
	));


----------USER LOGIN AND ROLES MANAGEMENT
CREATE TABLE user_login(
	id UUID NOT NULL,
	user_name VARCHAR(128) NOT NULL,
	temporary_password VARCHAR NULL,
	user_confirmed BOOLEAN NOT NULL DEFAULT FALSE,
	password_hash TEXT NULL,
	last_login_date TIMESTAMP NULL,
	created_by VARCHAR(128) NOT NULL,
	created_date TIMESTAMP NOT NULL,
	is_active BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT pk_user_login PRIMARY KEY  
	(
		id
	));

--Create Roles for basically every minute actions we want to control and assign it to various profiles
--These are upDATEd using scripts as new functionality are added to the application
CREATE TABLE role(
	id VARCHAR(128) NOT NULL,
	description VARCHAR(256) NULL,
	CONSTRAINT pk_role PRIMARY KEY  
	(
	id
	));

--Security profiles 
CREATE TABLE security_profile(
	id VARCHAR(128) NOT NULL,
	created_date TIMESTAMP NOT NULL,
	description VARCHAR(256) NULL,
	CONSTRAINT pk_security_profile PRIMARY KEY  
	(
		id
	));

CREATE TABLE security_profile_role(
	profile_id VARCHAR(128) NOT NULL,
	role_id VARCHAR(128) NOT NULL,
	CONSTRAINT pk_security_profile_role PRIMARY KEY  
	(
	profile_id,
	role_id
	));


CREATE TABLE user_security_profile(
	user_id INT NOT NULL,
	profile_id VARCHAR(128) NOT NULL,
	CONSTRAINT pk_user_security_profile PRIMARY KEY  
	(
		profile_id,
		user_id
	));

--BACKUP: If we want simple relation between just user & roles (Not recommended)
--CREATE TABLE UserRole(
--	user_id VARCHAR(128) NOT NULL,
--	Roleid VARCHAR(128) NOT NULL,
-- CONSTRAINT PK_UserRole PRIMARY KEY  
--(
--	user_id,
--	RoleId
--)
--);

--Create the organization table
CREATE TABLE organization(
	id SERIAL NOT NULL,
	name VARCHAR(128) NOT NULL,
	business_id VARCHAR(128) NULL,
	parent_id VARCHAR(128) NULL,
	email VARCHAR(256) NOT NULL,
	organization_url VARCHAR(256) NULL,
	purpose VARCHAR(50) NULL,
	photo BYTEA NULL,
	country VARCHAR(500) NULL,
	province VARCHAR(500) NULL,
	district VARCHAR(500) NULL,
	municipality VARCHAR(500) NULL,
	address1 VARCHAR(500) NULL,
	address2 VARCHAR(500) NULL,
	postal_code VARCHAR(50) NULL,
	phone_number VARCHAR(50) NULL,
	created_by INT NOT NULL,
	created_date TIMESTAMP NOT NULL,
	is_active BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT pk_organization PRIMARY KEY  
	(
		id
	));

--Create the user table
CREATE TABLE users(
	id SERIAL NOT NULL,
	login_id UUID NOT NULL,
	first_name VARCHAR(128) NULL,
	last_name VARCHAR(128) NULL,
	other_names VARCHAR(256) NULL,
	title VARCHAR(100) NULL,
	administrative_sex VARCHAR(50) NULL,
	date_of_birth VARCHAR(50) NULL,
	highest_education VARCHAR(50) NULL,
	profession VARCHAR(50) NULL,
	street_address VARCHAR(128) NULL,
	municipality VARCHAR(128) NULL,
	district VARCHAR(128) NULL,
	province VARCHAR(128) NULL,
	country VARCHAR(128) NULL,
	mobile_phone VARCHAR(50) NULL,
	other_phone VARCHAR(50) NULL,
	email VARCHAR(256) NOT NULL,
	social_link TEXT NULL,
	photo BYTEA NULL,
	CONSTRAINT pk_user PRIMARY KEY  
	(
		id
	));

--Assign the user 
CREATE TABLE organization_user(
	organization_id INT NOT NULL,
	user_id INT NOT NULL,
	member_id VARCHAR (128) NULL,
	registered_on TIMESTAMP NOT NULL,
	CONSTRAINT pk_organization_user PRIMARY KEY  
	(
		organization_id,
		user_id
	));


--- EVENT MANAGEMENT ---
CREATE TABLE event(
	id INT  NOT NULL,
	name VARCHAR(50) NULL,
	location VARCHAR(255) NULL,
	start_date TIMESTAMP NULL,
	end_date TIMESTAMP NULL,
	event_url VARCHAR(255) NULL,
	created_by INT NULL,
	created_date TIMESTAMP NULL,
	event_coordinator INT NULL,
	event_type VARCHAR(50) NULL,
	CONSTRAINT pk_event PRIMARY KEY  
	(
		id
	));

CREATE TABLE event_registration(
	id INT  NOT NULL,
	event_id INT NOT NULL,
	user_id INT NOT NULL,
	availability VARCHAR(50) NULL,
	adult_count INT NULL,
	kids_count INT NULL,
	CONSTRAINT pk_event_registration PRIMARY KEY  
	(
		id
	));



----TODO
--Concept of Family 
--Language support in website and how to store them in DB
--Messaging support between users and organization 
--Organization notices and blogs
--Purchases and expenses in the organization
--Report generation for the organizations (Charts/Tables/...)
--Organization Gallery (Pictures/Videos)



