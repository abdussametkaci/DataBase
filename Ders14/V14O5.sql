DECLARE

BEGIN
  FOR r_personel IN (SELECT * FROM employees WHERE department_id=90) LOOP
      DBMS_OUTPUT.PUT_LINE(r_personel.first_name||' '||r_personel.last_name);
  END LOOP;
END;