DECLARE 
  p_silinen_kayitlar PLS_INTEGER;
BEGIN
  DELETE_CALISAN(101,p_silinen_kayitlar);
  DBMS_OUTPUT.PUT_LINE(p_silinen_kayitlar||' adet kayit silindi');
END;