--2. çözüm
DECLARE

BEGIN
 -- c personeli �a��r�rken parametre geçilmesi gerekir.
    FOR r_department IN (SELECT * FROM departments) LOOP
        FOR r_personel IN (SELECT * FROM employees WHERE department_id=r_department.department_id) LOOP
        -- FETCH c_personel INTO r_personel; Fetch etmeye gerek yok
            DBMS_OUTPUT.PUT_LINE(r_personel.first_name||' '||r_personel.last_name|| ' '|| r_department.department_name);
        -- FOR KISMINDA CURSOUR I AÇMAYA KAPATMAYA GEREK YOK
        END LOOP;
    END LOOP; 
END;
