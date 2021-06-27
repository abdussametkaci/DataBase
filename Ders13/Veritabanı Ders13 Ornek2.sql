DECLARE
  p_employee_id employees.employee_id%TYPE;
  p_employee employees%ROWTYPE;
BEGIN
  p_employee_id:=1000;
  p_employee.first_name:='Ahmet';
  DBMS_OUTPUT.PUT_LINE('Merhaba '||p_employee_id||' '||p_employee.first_name);
END;