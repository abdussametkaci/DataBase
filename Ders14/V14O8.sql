CREATE OR REPLACE FUNCTION get_dept_name (p_dept_id IN NUMBER)
RETURN VARCHAR2 AS
  CURSOR c_dept IS 
    SELECT department_name FROM departments WHERE department_id = p_dept_id;
  p_department_name departments.department_name%TYPE;
BEGIN
  OPEN c_dept;
  FETCH c_dept INTO p_department_name;
  CLOSE c_dept;
  
  RETURN (p_department_name);
END;


SELECT employee_id, first_name||' '||last_name, get_dept_name(department_id) 
FROM employees
WHERE get_dept_name(department_id) ='Shipping'