create or replace TRIGGER CALISAN_UPDATE
BEFORE UPDATE OF department_id,salary ON calisan
FOR EACH ROW

BEGIN
IF :new.department_id=:old.department_id THEN
  UPDATE birim
  SET toplam_maas=toplam_maas+(:new.salary-:old.salary)
  WHERE birim_id=:new.department_id;
ELSE
  UPDATE birim
  SET toplam_maas=toplam_maas+(:new.salary)
  WHERE birim_id=:new.department_id;
  UPDATE birim
  SET toplam_maas=toplam_maas-(:old.salary)
  WHERE birim_id=:old.department_id;
END IF;
END;				 
 
UPDATE CALISAN
SET SALARY=SALARY+1000, DEPARTMENT_ID = 70
WHERE EMPLOYEE_ID=104