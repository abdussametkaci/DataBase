DECLARE
  p_employee employees%ROWTYPE;
  p_employee1 employees%ROWTYPE;
BEGIN
  SELECT * INTO p_employee
  FROM employees
  WHERE employee_id=100;
  
  p_employee1:=p_employee;
  
  DBMS_OUTPUT.PUT_LINE('Merhaba '||p_employee1.first_name||' '||p_employee1.last_name);
END;