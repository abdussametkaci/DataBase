DECLARE
  e_toplam_hata EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_toplam_hata,-20001);
BEGIN
  UPDATE birim
  SET toplam_maas=20000;
  
EXCEPTION WHEN e_toplam_hata THEN
   DBMS_OUTPUT.PUT_LINE('Birim kazanc hata.');
END;