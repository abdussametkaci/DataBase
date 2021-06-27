-- Lab 5

-- Alt sorgular
-- Tek bir sonuç döndüren ve parametre almayan alt sorgular
-- Shipping de çalýþan kiþileri bulunuz
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

-- Çok kayýt sorgu döndüren alt sorgu örneði
-- Europe da çalýþan kiþileri bulunuz
-- NOT: bir sorgudan birden fazla kayýt dönerse = çalýþmaz, onun yerine IN kulanýlmalý
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

-- Ortalama maaþ üzerinde maaþ alan kiþileribulunuz
SELECT first_name, last_name, salary
FROM employees
WHERE salary>(
    SELECT AVG(salary)
    FROM employees   
)

-- Shipping de çalýþan en yüksek maaaþ alan kiþiyi bulunuz
-- Shippingdeki en yüksek maaþý bulup daha sonra
-- o kiþinin shippin de çalýþtýðýný da kontrol ettik
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

-- Employee_id = 102 olan kiþinin görevlerini ayný departmanda bugün yapan kiþileri bulunuz
-- Birden fazla kolonu karþýlaþtýrýrken () içine yazmak lazým
SELECT *
FROM employees
WHERE (job_id, department_id) = (
    SELECT job_id, department_id
    FROM job_history
    WHERE employee_id = 102
)

-- Shipping en yüksek salary
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

-- çalýþtýðý birimin ayný zamanda yöneticisi olan kiþileri bulunuz


