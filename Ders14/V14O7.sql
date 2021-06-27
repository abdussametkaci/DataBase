--Aynı maaşı alan kişilere ödenen toplam maaşları gösteriniz.

DECLARE
  p_onceki_maas NUMBER:=2100;
  p_toplam_maas NUMBER:=0;
BEGIN
  FOR r_personel IN (SELECT * FROM employees ORDER BY salary) LOOP
    DBMS_OUTPUT.PUT_LINE(r_personel.first_name||' '||r_personel.last_name||' '||r_personel.salary);
    IF  p_onceki_maas=r_personel.salary THEN
      p_toplam_maas:=p_toplam_maas+r_personel.salary;
      DBMS_OUTPUT.PUT_LINE('----Toplam maas = '||p_toplam_maas);
    ELSE 
      p_onceki_maas:=r_personel.salary; 
      p_toplam_maas:=r_personel.salary; 
    END IF;
  END LOOP;
END;

