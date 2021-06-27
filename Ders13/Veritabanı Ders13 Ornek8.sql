/*En yüksek maaş alan kişiyi bulunuz*/
DECLARE
  CURSOR c_emp IS 
    SELECT * 
    FROM employees WHERE 1=2
    ORDER BY salary DESC;
  r_emp c_emp%ROWTYPE;
BEGIN
  OPEN c_emp;
  FETCH c_emp INTO r_emp;
  IF c_emp%FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Kayit geldi');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Kayit gelmedi');
  END IF;
  CLOSE c_emp;
END;