DECLARE 
  p_first_name VARCHAR2(50);
  e_hata EXCEPTION;
BEGIN -- Executable part (required)
  SELECT first_name INTO p_first_name
  FROM employees
  WHERE department_id = 70; 
  IF p_first_name='Hermann' THEN
    RAISE e_hata;
  END IF;
  
EXCEPTION 
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.put_LINE('Birden fazla kayit dondu') ;
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.put_LINE('Kayıt donmedi') ;
  WHEN e_hata THEN
    DBMS_OUTPUT.put_LINE('Bu kisi sistemi kullanamaz') ;
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_LINE('Bir hata oldu.') ;
END;
