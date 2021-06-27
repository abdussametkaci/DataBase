/*En yüksek maaş alan kişiyi bulunuz*/
DECLARE
  CURSOR c_emp IS 
    SELECT * 
    FROM employees
    ORDER BY salary DESC;
  TYPE emp_table_type IS TABLE OF employees%ROWTYPE;
  r_emp_table emp_table_type;
BEGIN
  OPEN c_emp;
  FETCH c_emp BULK COLLECT INTO r_emp_table;
  CLOSE c_emp;
  DBMS_OUTPUT.PUT_LINE('Merhaba '||r_emp_table(1).first_name||' '||r_emp_table(1).last_name||' '||r_emp_table(1).salary);
END;