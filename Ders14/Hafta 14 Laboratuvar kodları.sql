create or replace package calisan_pack AS
  FUNCTION get_personel_adet RETURN PLS_INTEGER ;
  FUNCTION get_personel_adi_from_max_maas RETURN VARCHAR2;
  FUNCTION get_per_record_from_max_maas RETURN calisan%ROWTYPE;
  PROCEDURE update_calisan_birim; 
END;

create or replace PACKAGE BODY CALISAN_PACK AS 
  FUNCTION get_personel_adet RETURN PLS_INTEGER AS
    p_adet PLS_INTEGER:=0;
  BEGIN 
    FOR p_personel IN (SELECT * FROM calisan) LOOP
      p_adet:=p_adet+1;
    END LOOP;
    RETURN p_adet;
  END;
  FUNCTION get_personel_adi_from_max_maas RETURN VARCHAR2 AS
    CURSOR c_personel IS
      SELECT first_name||' '||last_name isim
      FROM calisan
      ORDER BY salary desc;
    isim VARCHAR2(100);
  BEGIN
    OPEN c_personel;
    FETCH c_personel INTO isim;
    CLOSE c_personel;
    RETURN isim;
  END;
  FUNCTION get_per_record_from_max_maas RETURN calisan%ROWTYPE AS
    CURSOR c_personel IS
      SELECT *
      FROM calisan
      ORDER BY salary desc;
   r_personel calisan%ROWTYPE;
  BEGIN
    OPEN c_personel;
    FETCH c_personel INTO r_personel;
    CLOSE c_personel;
    RETURN r_personel;
  END;
  
PROCEDURE update_calisan_birim AS
   CURSOR c_dept (p_dept_id IN NUMBER) IS
      SELECT department_name
      FROM departments
      WHERE DEPARTMENT_ID = p_dept_id;
    p_dept_name VARCHAR2(50);
  BEGIN
    FOR r_calisan IN (SELECT * FROM calisan) LOOP
      OPEN c_dept(r_calisan.department_id);
      FETCH c_dept INTO p_dept_name;
      CLOSE c_dept;
      UPDATE calisan
      SET department_name = p_dept_name
      WHERE employee_id = r_calisan.employee_id;
    END LOOP;
    COMMIT;
  END;

END;


DECLARE
  v_Return BINARY_INTEGER;
BEGIN

  v_Return := CALISAN_PACK.GET_PERSONEL_ADET();
  DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);

END;


SELECT CALISAN_PACK.GET_PERSONEL_ADET() FROM dual