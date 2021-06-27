CREATE or REPLACE TRIGGER BIRIM_MAAS_KONTROL
BEFORE INSERT OR UPDATE ON BIRIM
FOR EACH ROW
DECLARE 
  e_maas_hata EXCEPTION;
BEGIN
  -- bir birimde 10000'den fazla maas olamaz
  IF :new.toplam_maas > 10000 THEN
    --RAISE e_maas_hata;
    Raise_application_error(-20001, 'Toplam Mass 10000''i asamaz!');
  END IF;

EXCEPTION WHEN e_maas_hata THEN
    DBMS_OUTPUT.put_LINE('Maas toplami 10000''i gecemez.') ;
END;		
				