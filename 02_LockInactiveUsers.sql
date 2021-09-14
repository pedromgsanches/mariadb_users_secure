## Procedure to LOCK users not logged in for more than 30 days

DROP PROCEDURE IF EXISTS dbadmin.CheckPwTimeout;
DELIMITER //
CREATE PROCEDURE dbadmin.CheckPwTimeout()
BEGIN
DECLARE s varchar(128);
DECLARE done BOOL DEFAULT FALSE;
DECLARE v_user varchar(18);
DECLARE v_host varchar(18);
DECLARE udata CURSOR FOR 
	SELECT user,host 
	FROM dbadmin.aud_login 
	WHERE tstamp < (NOW() - INTERVAL 30 DAY)
  AND user not in ('mariadb','mariadb.sys','root','dbadmin');

OPEN udata;
read_loop: LOOP
  FETCH udata into v_user,v_host;
  IF done THEN
    LEAVE read_loop;
  END IF;

SET s = CONCAT("ALTER USER ", v_user, "@", v_host, " ACCOUNT LOCK");
PREPARE stmnt from s;
EXECUTE stmnt;
DEALLOCATE PREPARE stmnt;

UPDATE dbadmin.aud_login
 SET tstamp = NOW() + INTERVAL 100 YEAR
 WHERE user = v_user and host = v_host;

SELECT concat("User ", v_user, '@', v_host, " is now Locked!") AS '';

END LOOP;
CLOSE udata;

END //

DELIMITER ;
