create or replace TRIGGER CALISAN_UPDATE
BEFORE INSERT ON calisan
FOR EACH ROW

BEGIN
  UPDATE birim
  SET toplam_maas=toplam_maas+:new.salary
  WHERE birim_id=:new.department_id;

END;		
				