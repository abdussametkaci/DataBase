/*
Personelin adı soyadı ve birim isimlerini birlikte gösteren bir PL/SQL kodu yazınız.
*/

DECLARE
  CURSOR c_dept(p_id IN NUMBER) IS
    SELECT department_name FROM departments WHERE department_id=p_id;
  r_dept c_dept%ROWTYPE;  
BEGIN
  FOR r_personel IN (SELECT * FROM employees) LOOP
      OPEN c_dept(r_personel.department_id);
      FETCH c_dept INTO r_dept;
      CLOSE c_dept;
      DBMS_OUTPUT.PUT_LINE(r_personel.first_name||' '||r_personel.last_name||'-'||r_dept.department_name);
  END LOOP;
END;
