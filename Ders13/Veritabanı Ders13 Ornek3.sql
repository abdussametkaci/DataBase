DECLARE
  p_employee employees%ROWTYPE;
BEGIN
  SELECT * INTO p_employee
  FROM employees
  WHERE employee_id=100;
  
  DBMS_OUTPUT.PUT_LINE('Merhaba '||p_employee.first_name||' '||p_employee.last_name);
END;