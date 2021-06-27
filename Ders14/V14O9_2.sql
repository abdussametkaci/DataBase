CREATE OR REPLACE PROCEDURE DELETE_CALISAN
(
    p_emp_id IN NUMBER,
    p_silinen_kayit_sayisi OUT PLS_INTEGER
) AS

BEGIN
    DELETE CALISAN
    WHERE EMPLOYEE_ID = p_emp_id;
    p_silinen_kayit_sayisi := SQL%ROWCOUNT;
END DELETE_CALISAN;
