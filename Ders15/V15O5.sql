DECLARE 
  p_first_name VARCHAR2(50);
BEGIN -- Executable part (required)
  SELECT first_name INTO p_first_name
  FROM employees
  WHERE department_id = 70; 
EXCEPTION 
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.put_LINE('Birden fazla kayit dondu') ;
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.put_LINE('Kayit donmedi') ;
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_LINE('Bir hata oldu.') ;
END;
