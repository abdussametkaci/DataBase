--SET SERVEROUTPUT ON
DECLARE
  p_adi VARCHAR2(100):='AHMET AK';
  p_maas NUMBER(10,2);
  p_id PLS_INTEGER;
BEGIN
  p_maas:=100000;
  DBMS_OUTPUT.PUT_LINE('Merhaba '||p_adi);
END;