# MariaDB/MySQL secure users
This bunch of scripts was created to secure MySQL/MariaDB users.
Purporses:  
  a- password expires > 120d  
  b- account lock on >3 authentication fails  
  c- account lock if not logged in for more than 30d  

## Files description:
### 00_create_db_user.sql
Create admin database, tables and users and define init settings for "a" and "b"

### 01_AuditLoginTrigger.sql
Create Audit Login Trigger for enabling "c"

### 02_LockInactiveUsers.sql
Procedure that locks user accounts not logged in for more than 30d and displayed in "dbadmin.aud_login", as required in "c"

### 03_extra_grants.sql
Extra grants to dbadmin user

### 04_EventScheduler.sql
Create Event to schedule Lock inactive users and grant audit to users that were created without audit-login. Automate "c".
