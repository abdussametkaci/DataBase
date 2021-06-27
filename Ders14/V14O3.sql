DECLARE
  CURSOR c_personel(p_dept_id IN NUMBER) IS
    SELECT * FROM employees WHERE department_id=p_dept_id;
  r_personel c_personel%ROWTYPE;
BEGIN
  OPEN c_personel(90);  
  LOOP
     FETCH c_personel INTO r_personel;
     EXIT WHEN c_personel%NOTFOUND; 
     DBMS_OUTPUT.PUT_LINE(r_personel.first_name||' '||r_personel.last_name);
  END LOOP;
  CLOSE c_personel;  
END;
