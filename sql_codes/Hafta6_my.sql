-- çalýþtýðý birimin ayný zamanda yöneticisi olan kiþileri bulunuz
SELECT *
FROM employees
WHERE (employee_id, department_id) IN (
    SELECT manager_id, department_id
    FROM departments
)

-- Üstten alta veri geçiþi
-- çalýþtýðý birimin ayný zamanda yöneticisi olan kiþileri bulunuz
SELECT *
FROM employees
WHERE employee_id = (
    SELECT manager_id
    FROM departments
    WHERE departments.department_id = employees.department_id
)

-- Alias ile çözüm
SELECT *
FROM employees ust
WHERE employee_id = (
    SELECT manager_id
    FROM departments
    WHERE departments.department_id = ust.department_id
)

-- kendi biriminin ortalamasý üzerinde maaþ alan kiþileri bulunuz
SELECT *
FROM employees ust
WHERE salary > (
    SELECT AVG(salary)
    FROM employees alt
    WHERE alt.department_id = ust.department_id
)

-- kendi ünvan aralýðý dýþýnda maaþ alan kiþileri bulunuz
SELECT *
FROM employees e
WHERE salary NOT BETWEEN (SELECT min_salary FROM jobs j WHERE j.job_id = e.job_id)
                     AND (SELECT max_salaryFROM jobs jWHERE j.job_id = e.job_id)

SELECT *
FROM employees e
WHERE job_id = (SELECT job_id FROM jobs j 
                WHERE j.job_id = e.job_id
                AND e.salary NOT BETWEEN min_salary AND max_salary)

SELECT *
FROM employees e
WHERE 'x' = (SELECT 'x' FROM jobs j 
                WHERE j.job_id = e.job_id
                AND e.salary NOT BETWEEN min_salary AND max_salary)

SELECT *
FROM employees e
WHERE job_id IN (SELECT job_id FROM jobs j 
                 WHERE e.salary NOT BETWEEN min_salary AND max_salary)

-- EXISTS
-- Personel çalýþan birimleri bulunuz
SELECT *
FROM departments ust
WHERE EXISTS (
    SELECT * 
    FROM employees e 
    WHERE e.department_id = ust.department_id
)

-- Hiç personel çalýþmayan birimleri bulunuz
SELECT *
FROM departments ust
WHERE NOT EXISTS (
    SELECT 'x' 
    FROM employees e 
    WHERE e.department_id = ust.department_id
)

SELECT *
FROM departments ust
WHERE department_id NOT IN (
    SELECT NVL(department_id, 0) -- bunu yapmazsak eðer kayýtta 1 tane bile NULL varsa, kayýt boþ döner
    FROM employees e 
)

-- FROM kýsmýnda alt sorgu kullanmak
SELECT employee_id
FROM (
    SELECT employee_id, first_name, last_name
    FROM employees
)

-- Birimlerin en yüksek maaþ ortalamasýný bulunuz
SELECT MAX(ortalama_maas) FROM (SELECT department_id, AVG(salary) ortalama_maas
FROM employees
GROUP BY department_id)

-- En yüksek ortalama maaþa sahip birimi bulunuz
SELECT department_id, MAX(salary) ortalama_maas
FROM employees
HAVING AVG(salary) = (
    SELECT MAX(ortalama_maas) 
    FROM (SELECT department_id, AVG(salary) ortalama_maas
        FROM employees
        GROUP BY department_id)
)
GROUP BY department_id

-- Personellerin departman isimlerini personel isimleriyle gösteriniz
-- SELECT ile FROM arasýnda alt sorgu kullanarak
SELECT first_name, last_name, (SELECT department_name 
                                FROM departments d 
                                WHERE d.department_id = e.department_id) 
FROM employees e

