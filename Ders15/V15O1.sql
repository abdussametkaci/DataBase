create or replace TRIGGER CALISAN_UPDATE
BEFORE UPDATE ON calisan
FOR EACH ROW

BEGIN
  UPDATE birim
  SET toplam_maas=:new.salary-:old.salary
  WHERE birim_id=:old.department_id;
END;
				