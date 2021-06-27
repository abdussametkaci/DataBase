-- �al��t��� birimin ayn� zamanda y�neticisi olan ki�ileri bulunuz
SELECT *
FROM employees
WHERE (employee_id, department_id) IN (
    SELECT manager_id, department_id
    FROM departments
)

-- �stten alta veri ge�i�i
-- �al��t��� birimin ayn� zamanda y�neticisi olan ki�ileri bulunuz
SELECT *
FROM employees
WHERE employee_id = (
    SELECT manager_id
    FROM departments
    WHERE departments.department_id = employees.department_id
)

-- Alias ile ��z�m
SELECT *
FROM employees ust
WHERE employee_id = (
    SELECT manager_id
    FROM departments
    WHERE departments.department_id = ust.department_id
)

-- kendi biriminin ortalamas� �zerinde maa� alan ki�ileri bulunuz
SELECT *
FROM employees ust
WHERE salary > (
    SELECT AVG(salary)
    FROM employees alt
    WHERE alt.department_id = ust.department_id
)

-- kendi �nvan aral��� d���nda maa� alan ki�ileri bulunuz
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
-- Personel �al��an birimleri bulunuz
SELECT *
FROM departments ust
WHERE EXISTS (
    SELECT * 
    FROM employees e 
    WHERE e.department_id = ust.department_id
)

-- Hi� personel �al��mayan birimleri bulunuz
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
    SELECT NVL(department_id, 0) -- bunu yapmazsak e�er kay�tta 1 tane bile NULL varsa, kay�t bo� d�ner
    FROM employees e 
)

-- FROM k�sm�nda alt sorgu kullanmak
SELECT employee_id
FROM (
    SELECT employee_id, first_name, last_name
    FROM employees
)

-- Birimlerin en y�ksek maa� ortalamas�n� bulunuz
SELECT MAX(ortalama_maas) FROM (SELECT department_id, AVG(salary) ortalama_maas
FROM employees
GROUP BY department_id)

-- En y�ksek ortalama maa�a sahip birimi bulunuz
SELECT department_id, MAX(salary) ortalama_maas
FROM employees
HAVING AVG(salary) = (
    SELECT MAX(ortalama_maas) 
    FROM (SELECT department_id, AVG(salary) ortalama_maas
        FROM employees
        GROUP BY department_id)
)
GROUP BY department_id

-- Personellerin departman isimlerini personel isimleriyle g�steriniz
-- SELECT ile FROM aras�nda alt sorgu kullanarak
SELECT first_name, last_name, (SELECT department_name 
                                FROM departments d 
                                WHERE d.department_id = e.department_id) 
FROM employees e

