
--Create some basic roles (This represents application wide features)
INSERT INTO role (id) VALUES (N'CreateOrganizations');
INSERT INTO role (id) VALUES (N'ManageOrganization');
INSERT INTO role (id) VALUES (N'Managesecurity_profiles');
INSERT INTO role (id) VALUES (N'AssignUsersToOrganization');
INSERT INTO role (id) VALUES (N'ManageUsers');
INSERT INTO role (id) VALUES (N'ManageEvents');
INSERT INTO role (id) VALUES (N'ViewUsers');
INSERT INTO role (id) VALUES (N'Basic');

--Create seed security profile (This can be dynamically created/updated by Organization Admins)
INSERT INTO security_profile (id, created_date) VALUES (N'Administrator', now());
INSERT INTO security_profile (id, created_date) VALUES (N'OrganizationAdmin', now());
INSERT INTO security_profile (id, created_date) VALUES (N'Executive', now());
INSERT INTO security_profile (id, created_date) VALUES (N'BoardMember', now());
INSERT INTO security_profile (id, created_date) VALUES (N'GeneralMember', now());

--security_profile_role Seed Data
--UnitedNepali Administrators (Create new organization and create new profiles)
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'Administrator', N'CreateOrganizations');

--Organization Administrator (Edit Organizations, Manage Security Profile, Assign roles, Manage Users);
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'OrganizationAdmin', N'ManageOrganization');
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'OrganizationAdmin', N'Managesecurity_profiles');

--Organization Board (e.g. Secretary, Treasurer, Vice-president);
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'Executive', N'AssignUsersToOrganization');
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'Executive', N'ManageUsers');
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'Executive', N'ManageEvents');
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'Executive', N'ViewUsers');

--All other users
INSERT INTO security_profile_role (profile_id, role_id) VALUES (N'GeneralMember', N'Basic');

--Create a mock login user
INSERT INTO user_login (id, user_name, temporary_password, created_by, created_date, is_active)
    VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'nepalcode', 'p@ssw0rd', 'admin', now(), '1');
INSERT INTO users (login_id,first_name,last_name,email) 
    VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'United', 'Nepali', 'userexample@gmail.com');

--Create a mock organization seed data
INSERT INTO organization (name, email, created_by, created_date, is_active )
    VALUES ('Test Organization', 'orgexample@gmail.com', 1, now(), '1');
INSERT INTO organization_user (organization_id, user_id, member_id, registered_on)
    VALUES (1, 1, 1, now());

-- SELECT * FROM role;
-- SELECT * FROM security_profile;
-- SELECT * FROM security_profile_role;
-- SELECT * FROM user_login;
-- SELECT * FROM users;
-- SELECT * FROM organization;
-- SELECT * FROM organization_user;