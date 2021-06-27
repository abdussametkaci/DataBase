DECLARE
  TYPE dept_count_type IS RECORD (
    p_dept_id PLS_INTEGER,
    p_count NUMBER
  );
  dept_count dept_count_type;
BEGIN
  SELECT department_id,COUNT(*) INTO dept_count
  FROM employees
  WHERE department_id=90
  GROUP BY department_id; 
  
  DBMS_OUTPUT.PUT_LINE('Merhaba '||dept_count.p_dept_id||' '||dept_count.p_count);
END;