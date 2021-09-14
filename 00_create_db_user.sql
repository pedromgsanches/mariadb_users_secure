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
