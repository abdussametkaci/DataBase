/*En yüksek maaş alan kişiyi bulunuz*/
DECLARE
  CURSOR c_emp IS 
    SELECT * 
    FROM employees
    ORDER BY salary DESC;
  r_emp c_emp%ROWTYPE;
BEGIN
  OPEN c_emp;
  FETCH c_emp INTO r_emp;
  CLOSE c_emp;
  DBMS_OUTPUT.PUT_LINE('Merhaba '||r_emp.first_name||' '||r_emp.last_name||' '||r_emp.salary);
END;