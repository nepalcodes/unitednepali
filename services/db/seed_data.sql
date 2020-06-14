
--Create some basic roles (This represents application wide features)
INSERT INTO role (id) VALUES ('CreateOrganizations');
INSERT INTO role (id) VALUES ('ManageOrganization');
INSERT INTO role (id) VALUES ('Managesecurity_profiles');
INSERT INTO role (id) VALUES ('AssignUsersToOrganization');
INSERT INTO role (id) VALUES ('ManageUsers');
INSERT INTO role (id) VALUES ('ManageEvents');
INSERT INTO role (id) VALUES ('ViewUsers');
INSERT INTO role (id) VALUES ('Basic');

--Create seed security profile (This can be dynamically created/updated by Organization Admins)
INSERT INTO security_profile (id, created_date) VALUES ('Administrator', now());
INSERT INTO security_profile (id, created_date) VALUES ('OrganizationAdmin', now());
INSERT INTO security_profile (id, created_date) VALUES ('Executive', now());
INSERT INTO security_profile (id, created_date) VALUES ('BoardMember', now());
INSERT INTO security_profile (id, created_date) VALUES ('GeneralMember', now());

--security_profile_role Seed Data
--UnitedNepali Administrators (Create new organization and create new profiles)
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('Administrator', 'CreateOrganizations');

--Organization Administrator (Edit Organizations, Manage Security Profile, Assign roles, Manage Users);
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('OrganizationAdmin', 'ManageOrganization');
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('OrganizationAdmin', 'Managesecurity_profiles');

--Organization Board (e.g. Secretary, Treasurer, Vice-president);
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('Executive', 'AssignUsersToOrganization');
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('Executive', 'ManageUsers');
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('Executive', 'ManageEvents');
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('Executive', 'ViewUsers');

--All other users
INSERT INTO security_profile_role (profile_id, role_id) VALUES ('GeneralMember', 'Basic');

--Create a mock login users
INSERT INTO user_login (id, user_name, temporary_password, created_date, is_active)
    VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'unitednepali', 'p@ssw0rd', now(), '1');
INSERT INTO user_login (id, user_name, temporary_password, created_date, is_active)
    VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'administrator', 'p@ssw0rd', now(), '1');

INSERT INTO users (login_id, first_name, email) 
    VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'United Nepali', 'un@gmail.com');
INSERT INTO users (login_id, first_name, email) 
    VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Administrator', 'administrator@gmail.com');

--Create a mock organization seed data
INSERT INTO organization (name, email, created_by, created_date, is_active )
    VALUES ('Organization1', 'org1@gmail.com', 1, now(), '1');
INSERT INTO organization (name, email, created_by, created_date, is_active )
    VALUES ('Organization2', 'org2@gmail.com', 1, now(), '1');
INSERT INTO organization_user (organization_id, user_id, member_id, registered_on)
    VALUES (1, 1, 'ORG1-001', now());
INSERT INTO organization_user (organization_id, user_id, member_id, registered_on)
    VALUES (2, 2, 'ORG2-001', now());

--Assign security profiles to user
INSERT INTO user_security_profile (user_id, profile_id) VALUES (1, 'Administrator');
INSERT INTO user_security_profile (user_id, profile_id) VALUES (2, 'OrganizationAdmin');

-- SELECT * FROM role;
-- SELECT * FROM security_profile;
-- SELECT * FROM security_profile_role;
-- SELECT * FROM user_login;
-- SELECT * FROM users;
-- SELECT * FROM organization;
-- SELECT * FROM organization_user;