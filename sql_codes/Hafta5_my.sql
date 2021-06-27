-- Lab 5

-- Alt sorgular
-- Tek bir sonu� d�nd�ren ve parametre almayan alt sorgular
-- Shipping de �al��an ki�ileri bulunuz
SELECT *
FROM employees
WHERE department_id = (Shipping Id)

SELECT department_id
FROM departments
WHERE department_name = 'Shipping'

SELECT *
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'Shipping')

-- �ok kay�t sorgu d�nd�ren alt sorgu �rne�i
-- Europe da �al��an ki�ileri bulunuz
-- NOT: bir sorgudan birden fazla kay�t d�nerse = �al��maz, onun yerine IN kulan�lmal�
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location_id IN (
        SELECT location_id
        FROM locations
        WHERE country_id IN (
            SELECT country_id
            FROM countries
            WHERE region_id IN ( -- burada = kullansak da olur
                SELECT region_id
                FROM regions
                WHERE region_name='Europe'
            )
        )
    )
)

-- Ortalama maa� �zerinde maa� alan ki�ileribulunuz
SELECT first_name, last_name, salary
FROM employees
WHERE salary>(
    SELECT AVG(salary)
    FROM employees   
)

-- Shipping de �al��an en y�ksek maaa� alan ki�iyi bulunuz
-- Shippingdeki en y�ksek maa�� bulup daha sonra
-- o ki�inin shippin de �al��t���n� da kontrol ettik
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = (
        SELECT department_id
        FROM departments
        WHERE department_name='Shipping'
    )
)
AND department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name='Shipping'
)

-- Employee_id = 102 olan ki�inin g�revlerini ayn� departmanda bug�n yapan ki�ileri bulunuz
-- Birden fazla kolonu kar��la�t�r�rken () i�ine yazmak laz�m
SELECT *
FROM employees
WHERE (job_id, department_id) = (
    SELECT job_id, department_id
    FROM job_history
    WHERE employee_id = 102
)

-- Shipping en y�ksek salary
SELECT first_name, last_name, salary
FROM employees
WHERE (salary, department_id) = (
    SELECT MAX(salary), department_id
    FROM employees
    WHERE department_id = (
        SELECT department_id
        FROM departments
        WHERE department_name='Shipping'
    )
    GROUP BY department_id
)

-- �al��t��� birimin ayn� zamanda y�neticisi olan ki�ileri bulunuz


