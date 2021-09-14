## Create procedure AudLoginTrigger
### Login trigger to write login info into aud_login table 

drop procedure if exists dbadmin.AudLoginTrigger;

DELIMITER //
CREATE PROCEDURE dbadmin.AudLoginTrigger()
SQL SECURITY DEFINER
BEGIN
  INSERT INTO aud_login (user, host, tstamp)
  VALUES (SUBSTR(USER(), 1, instr(USER(), '@')-1), substr(USER(), instr(USER(), '@')+1), NOW())
  ON DUPLICATE KEY UPDATE tstamp = NOW();
END;
//
DELIMITER ;

### set init_connect to enable procedure AudLoginTrigger on each user login
SET GLOBAL init_connect="CALL dbadmin.AudLoginTrigger()";
# init_connect="CALL dbadmin.AudLoginTrigger()" ---> my.cnf

## CREATE PROCEDURE GrantUAud
### This procedure grants AudLoginTrigger to every user, if not granted in user creation

DROP PROCEDURE IF EXISTS dbadmin.GrantUAud();

DELIMITER //
CREATE PROCEDURE dbadmin.GrantUAud()
BEGIN
DECLARE s varchar(128);
DECLARE done BOOL DEFAULT FALSE;
DECLARE v_user varchar(18);
DECLARE v_host varchar(18);
DECLARE udata CURSOR FOR
  SELECT user,host
  FROM mysql.user;
  
OPEN udata;
read_loop: LOOP
  FETCH udata into v_user,v_host;
  IF done THEN
    LEAVE read_loop;
  END IF;

SET s = CONCAT("GRANT EXECUTE ON PROCEDURE dbadmin.AudLoginTrigger TO ", v_user, "@", v_host);
PREPARE stmnt from s;
EXECUTE stmnt;
DEALLOCATE PREPARE stmnt;

SELECT concat("User ", v_user, '@', v_host, " is now granted Aud.") AS '';

END LOOP;
CLOSE udata;
END //
DELIMITER ;


