-- Create a new database
CREATE DATABASE telegraf;

-- Create a new user with a password
CREATE USER telegraf_user WITH PASSWORD '!24e1cdvfas';

-- Grant all privileges on the 'telegraf' database to the 'telegraf_user'
GRANT ALL PRIVILEGES ON DATABASE telegraf TO telegraf_user;
