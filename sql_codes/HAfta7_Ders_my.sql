SELECT ROWNUM, ROWID, employees.*
FROM employees
---------------------------------
SELECT ROWNUM, LENGTH(ROWID), employees.*
FROM employees
------------------------------
SELECT ROWNUM, employees.*
FROM employees
ORDER BY salary DESC
------------------------------
-- �nce s�rala daha sonra rownum ver
-- �yle yapmazsak s�ralar kar��aca�� i�in do�ru veri alamay�z
-- En y�ksek maa�� alan ilk 5 ki�i
SELECT ROWNUM, e.* FROM (SELECT employees.*
FROM employees
ORDER BY salary DESC) e
WHERE ROWNUM < 6

-- 5. en y�ksek maa�� alan ki�i
SELECT * FROM (SELECT ROWNUM sira_no, e.* FROM 
    (SELECT employees.*
    FROM employees
    ORDER BY salary DESC) e)
WHERE sira_no = 5

-- Bile�ke
-- ANSI syntax
SELECT first_name, last_name, department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id

-- Klasik syntax
SELECT first_name, last_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id

-- 
SELECT first_name, last_name, department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 10000
-- OR 
SELECT first_name, last_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary > 10000

-- Kartezyen �arp�m
SELECT first_name, last_name, department_name
FROM employees e, departments d

-- Departmanlardaki ki�i say�s�n� bulunuz
-- NOT = gruplamalar ayn� tablodaki elemanlar aras�nda olabilir
SELECT d.department_id, d.department_name, COUNT(*)
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name

-- 10 dan fazla �al��an� olan departmanlar� bulunuz
SELECT d.department_id, d.department_name, COUNT(*)
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(*) > 10

-- INNER JOIN
-- Ayn� ada sahip kolonlar� e�le�tirir - biz department_id verdik ortak kolona
SELECT first_name, last_name, department_name
FROM employees
INNER JOIN departments USING (department_id) -- INNER demesek de olur

-- NATURAL JOIN
SELECT first_name, last_name, department_name
FROM employees
NATURAL JOIN departments

-- �lkelerdeki �al��an say�s�n� bulunuz
-- ANSI syntax
SELECT c.country_id, c.country_name, COUNT(*)
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
GROUP BY c.country_id, c.country_name

-- Kalsik syntax
SELECT c.country_id, c.country_name, COUNT(*)
FROM employees e, departments d, locations l, countries c
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.country_id = c.country_id
GROUP BY c.country_id, c.country_name
-- Kendi biriminin maa� ortalamas� �zerinde maa� alan ki�ileri bulunuz
SELECT e.first_name, e.last_name, e.salary, avg_sal 
FROM employees e
JOIN (SELECT department_id, AVG(salary) avg_sal
      FROM employees 
      GROUP BY department_id) d 
ON (e.department_id= d.department_id AND e.salary > avg_sal)

-- Kendi y�neticisinden fazla maa� alan ki�ileri bulunuz
SELECT e.first_name, e.last_name, e.salary, m.first_name, m.last_name,m.salary
FROM employees e
JOIN employees m
ON (e.manager_id = m.employee_id AND e.salary > m.salary)

---
SELECT e.first_name, e.last_name, e.salary, m.first_name, m.last_name,m.salary
FROM employees e
JOIN employees m
ON (e.manager_id = m.employee_id)
WHERE e.salary > m.salary

-- Kendi �nvan maa� aral���n�n �st s�n�r�nda maa� alan ki�ileri bulunuz
SELECT e.first_name, e.last_name, e.salary, j.max_salary
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND e.salary = j.max_salary

-- LAB7
-- Outer JOIN
-- Eşleşmeyen kayıtların getirilmesi

-- Departmnlardaki çalışan sayılarını bulunuz
SELECT FIRST_NAME, LAST_NAME, e.department_id, DEPARTMENT_NAME
FROM EMPLOYEES e
LEFT OUTER JOIN DEPARTMENTS d ON e.department_id = d.department_id

SELECT FIRST_NAME, LAST_NAME, e.department_id, DEPARTMENT_NAME
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.department_id = d.department_id (+)

 -- Departmanlardaki personel sayılarını bulunuz
 -- Personeli olmayan departmanların karşısına sıfır yazınız
SELECT d.department_id, COUNT(e.department_id)
FROM DEPARTMENTS d
LEFT OUTER JOIN EMPLOYEES e ON d.department_id = e.department_id
GROUP BY  d.department_id

-- Hiç çalışanı olmayan birimleri outer join ile bulunuz
SELECT d.department_id, COUNT(e.department_id), COUNT(e.employee_id)
FROM DEPARTMENTS d
LEFT OUTER JOIN EMPLOYEES e ON d.department_id = e.department_id
GROUP BY  d.department_id
HAVING  COUNT(e.department_id) = 0

SELECT d.department_id, d.department_name
FROM DEPARTMENTS d
LEFT OUTER JOIN EMPLOYEES e ON d.department_id = e.department_id
WHERE e.department_id IS NULL

-- Her ülkedeki en yüksek maaş alan kişileri bulunuz
SELECT c.country_id, MAX(e.salary)
FROM employees e, departments d, locations l, countries c
WHERE e.department_id = d.department_id
 AND d.location_id = l.location_id
 AND l.country_id = c.country_id
GROUP BY c.country_id

-- Çalıştığı birimin amiri kendi amiri olan kişileri bulunuz
SELECT *
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON (e.department_id = d.department_id AND e.manager_id = d.manager_id)
-- Çalıştığı birimde kendi ünvanında  kendisiyle aynı ücretialan kişileri bulunuz
SELECT *
FROM EMPLOYEES k, EMPLOYEES h
WHERE k.department_id = h.department_id
 AND k.job_id = h.job_id
 AND k.salary = h.salary
 AND k.employee_id > h.employee_id
-- Tüm çalışanları aynı ücerti alan birimleri bulunuz 
SELECT DEPARTMENT_ID, COUNT(DISTINCT salary)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(DISTINCT salary) = 1
-- OR
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) = MIN(SALARY)
