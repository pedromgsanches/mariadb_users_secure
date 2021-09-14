## Enable Event Scheduler
SET GLOBAL event_scheduler=ON
# event_scheduler=ON ---> my.cnf


## Create job/event to auto-execute CheckPwTimeout and GrantUAud
DELIMITER //
CREATE EVENT NoLoginTimeout
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO
    BEGIN
      CALL dbadmin.CheckPwTimeout();
      CALL dbadmin.GrantUAud();
    END //

DELIMITER ;
