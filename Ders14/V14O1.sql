DECLARE
  CURSOR c_personel(p_emp_id IN NUMBER) IS
    SELECT * FROM employees WHERE employee_id=p_emp_id;
  r_personel c_personel%ROWTYPE;
BEGIN
  OPEN c_personel(100);  
  FETCH c_personel INTO r_personel;
  IF c_Personel%FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Personel bulundu : '||r_personel.first_name||' '||r_personel.last_name);
  END IF;
  CLOSE c_personel;  
END;