CREATE OR REPLACE TRIGGER UNVAN_LOG_TRIGGER 
AFTER DELETE OR INSERT OR UPDATE ON UNVAN 
FOR EACH ROW 
BEGIN
   CASE WHEN INSERTING THEN
    INSERT INTO unvan_log
      (job_id,job_title,min_salary,max_salary,kayit_tarihi,islem)
      VALUES
      (:new.job_id,:new.job_title,:new.min_salary,:new.max_salary,:new.kayit_tarihi,'INSERT');
    WHEN UPDATING THEN
    INSERT INTO unvan_log
      (job_id,job_title,min_salary,max_salary,kayit_tarihi,islem)
      VALUES
      (:old.job_id,:old.job_title,:old.min_salary,:old.max_salary,:old.kayit_tarihi,'UPDATE');
    WHEN DELETING THEN
    INSERT INTO unvan_log
      (job_id,job_title,min_salary,max_salary,kayit_tarihi,islem)
      VALUES
      (:old.job_id,:old.job_title,:old.min_salary,:old.max_salary,:old.kayit_tarihi,'DELETE');
    END CASE;
END;