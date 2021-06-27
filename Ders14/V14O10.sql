CREATE OR REPLACE PACKAGE personel_pack AS
  CURSOR personel_cursor IS SELECT * FROM calisan;
  FUNCTION get_emp_salary(p_emp_id IN NUMBER) RETURN NUMBER;
  FUNCTION get_emp_name(p_emp_id IN NUMBER) RETURN VARCHAR2;
  PROCEDURE delete_dept_employees(p_dept_id IN NUMBER); 
END;

CREATE OR REPLACE PACKAGE BODY personel_pack
AS
  FUNCTION get_emp_salary(
      p_emp_id IN NUMBER)
    RETURN NUMBER
  AS
    CURSOR c_emp
    IS
      SELECT salary FROM employees WHERE employee_id = p_emp_id;
    p_salary NUMBER;
  BEGIN
    OPEN c_emp;
    FETCH c_emp INTO p_salary;
    CLOSE c_emp;
    RETURN (p_salary);
  END;
  FUNCTION get_emp_name(
      p_emp_id IN NUMBER)
    RETURN VARCHAR2
  AS
    CURSOR c_emp
    IS
      SELECT first_name||' '||last_name FROM employees WHERE employee_id = p_emp_id;
    p_isim VARCHAR2(50);
  BEGIN
    OPEN c_emp;
    FETCH c_emp INTO p_isim;
    CLOSE c_emp;
    RETURN (p_isim);
  END;
  PROCEDURE delete_dept_employees(
      p_dept_id IN NUMBER)
  AS
  BEGIN
    DELETE calisan WHERE department_id=p_dept_id;
  END delete_dept_employees;
END;
  
  SELECT PERSONEL_PACK.GET_EMP_NAME(103) FROM dual
