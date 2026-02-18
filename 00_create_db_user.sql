## Create user "dbadmin"
create user dbadmin@localhost;
grant select on mysql.user to dbadmin@localhost;

## Create database "dbadmin"
CREATE DATABASE dbadmin;
use dbadmin;

## Create table "aud_login"
DROP TABLE IF EXISTS dbadmin.aud_login;
CREATE TABLE dbadmin.aud_login (
  user VARCHAR(16)
, host VARCHAR(60)
, tstamp TIMESTAMP
, PRIMARY KEY (user, host)
);

## Install password check plugin
INSTALL SONAME 'simple_password_check';

SET GLOBAL max_password_errors=3
SET GLOBAL default_password_lifetime=120
SET GLOBAL simple_password_check_minimal_length=25
