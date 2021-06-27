-- En yüksek maaşı alan 5 kişi
SELECT rownum sira_no,e.* FROM (SELECT  employees.*
FROM employees
ORDER BY salary desc) e
WHERE rownum<=5



-- 5. en yüksek maaşı alan kişi
SELECT * FROM (SELECT rownum sira_no,e.* 
  FROM (SELECT  employees.*
        FROM employees
        ORDER BY salary desc) e)
WHERE sira_no=5

-- BİLEŞKE

-- ANSI
SELECT first_name,last_name,department_name
FROM employees
JOIN departments
 ON employees.department_id = departments.department_id
WHERE salary>10000

--Klasik

SELECT first_name,last_name,department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id


--Klasik Takma isimli

SELECT first_name,last_name,department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
  AND e.salary>10000

--Kartezyen çarpım
SELECT first_name,last_name,department_name
FROM employees e, departments d

-- Departmanlardaki kişi sayısını bulunuz.
SELECT d.department_id, d.department_name, COUNT(*)
FROM employees e
JOIN departments d
 ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name


-- 10'dan fazla çalışanı olan departmanlardaki kişi sayısını bulunuz.
SELECT d.department_id, d.department_name, COUNT(*)
FROM employees e
JOIN departments d
 ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING count(*)>10


--INNER JOIN

SELECT first_name,last_name,department_name
FROM employees
INNER JOIN departments USING (department_id)

-- NATURAL JOIN

SELECT first_name,last_name,department_name
FROM employees
NATURAL JOIN departments 

-- Aşağıdaki soruları bileşke ile yazınız.
-- Ülkelerdeki çalışan sayısını bulunuz.

-- ANSI

SELECT c.country_id, c.country_name, COUNT(*) 
FROM employees e
JOIN departments d ON e.department_id=d.department_id
JOIN locations l ON d.location_id=l.location_id
JOIN countries c ON c.country_id=l.country_id  
GROUP BY c.country_id, c.country_name

--Klasik
SELECT c.country_id, c.country_name, COUNT(*)  
FROM employees e, departments d,locations l, countries c
WHERE e.department_id=d.department_id
  AND d.location_id=l.location_id
  AND c.country_id=l.country_id  
GROUP BY c.country_id, c.country_name



-- Kendi biriminin maaş ortalması üzerinde maaş alan kişileri bulunuz.
SELECT first_name,last_name, salary,avg_sal
FROM employees e
JOIN (SELECT department_id,AVG(salary) avg_sal
      FROM employees 
      GROUP BY department_id) d
  ON (e.department_id=d.department_id AND e.salary>avg_sal)




-- Kendi yöneticisinden fazla maaş alan kişileri bulunuz.
SELECT *
FROM employees e
JOIN employees m
 ON (e.manager_id=m.employee_id AND e.salary>m.salary)
 

-- Kendi ünvan maaş aralığının üst sınırında maaş alan kişileri bulunuz.

SELECT * 
FROM employees e, jobs j
WHERE e.job_id = j.job_id
  AND e.salary = j.max_salary


SELECT manager_id FROM (SELECT e.manager_id,m.manager_id m_manager_id
                        from employees e 
                        JOIN employees m ON (e.manager_id=m.employee_id))

-- Outer Join

-- Kişilerin departman isimlerini bulunuz.

-- LEFT OUTER JOIN 

SELECT first_name,last_name,e.department_id,department_name
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id=d.department_id 


SELECT first_name,last_name,e.department_id,department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id(+) 

--DISTICT ve grup operatörleri
SELECT  COUNT(DISTINCT first_name)
FROM employees

-- 1. Departmanlardaki personel sayılarını bulunuz. 
   -- Personeli olmayan departmanların karşısına sıfır yazılsın.
   
   SELECT d.department_id, COUNT(e.department_id),COUNT(e.employee_id)
   FROM departments d
   LEFT OUTER JOIN employees e ON (d.department_id=e.department_id)
   GROUP BY d.department_id
   
   
   SELECT d.department_id, NVL(adet,0)  
   FROM departments d
   LEFT OUTER JOIN (SELECT department_id, COUNT(*) adet
                    FROM employees
                    GROUP BY department_id) e ON (d.department_id=e.department_id)
 
   SELECT d.department_id, COUNT(e.department_id)
   FROM departments d, employees e 
   WHERE (d.department_id=e.department_id(+))
   GROUP BY d.department_id
   
   
-- 2. Hiç çalışanı olmayan birimleri outer join ile bulunuz.
   SELECT d.department_id, COUNT(e.department_id),COUNT(e.employee_id)
   FROM departments d
   LEFT OUTER JOIN employees e ON (d.department_id=e.department_id)
   GROUP BY d.department_id
   HAVING COUNT(e.department_id)=0
   
   SELECT *
   FROM departments d
   LEFT OUTER JOIN employees e ON (d.department_id=e.department_id)
   WHERE e.department_id IS NULL
   
   SELECT *
   FROM departments d
   LEFT OUTER JOIN employees e ON (d.department_id=e.department_id)
   WHERE e.employee_id IS NULL

-- 3. Her ülkedeki en yüksek maaşı bulunuz.
   
   SELECT c.country_id, MAX(e.salary)
   FROM employees e,departments d, locations l, countries c
   WHERE e.department_id=d.department_id
     AND d.location_id=l.location_id
     AND l.country_id=c.country_id
   GROUP BY c.country_id

-- 3.1 Her ülkedeki en yüksek maaş alan kişiyi bulunuz.
   SELECT * FROM 
   (SELECT e.employee_id,e.first_name,e.last_name,c.country_name,c.country_id,e.salary
   FROM employees e,departments d, locations l, countries c
   WHERE e.department_id=d.department_id
     AND d.location_id=l.location_id
     AND l.country_id=c.country_id) emp
  JOIN
  (SELECT c.country_id, MAX(e.salary) max_salary
   FROM employees e,departments d, locations l, countries c
   WHERE e.department_id=d.department_id
     AND d.location_id=l.location_id
     AND l.country_id=c.country_id
   GROUP BY c.country_id) country_max
   ON (emp.salary=country_max.max_salary AND emp.country_id = country_max.country_id )


-- 4. Çalıştığı birimin amiri kendi amiri olan kişileri bulunuz.
   SELECT * 
   FROM employees e
   JOIN departments d ON (e.department_id=d.department_id AND e.manager_id=d.manager_id)

-- 5. Çalıştığı birimde kendi ünvanında kendisiyle aynı ücreti alan kişileri bulunuz.

  SELECT *
  FROM employees k,employees h
  WHERE k.department_id=h.department_id
   AND k.job_id=h.job_id
   AND k.salary=h.salary
   AND k.employee_id > h.employee_id


-- 6. Tüm çalışanları aynı ücreti alan birimleri bulunuz.
  SELECT department_id,COUNT(DISTINCT salary)
  FROM employees 
  GROUP BY department_id
  HAVING COUNT(DISTINCT salary)=1
  
  
  SELECT department_id,MAX(salary),MIN(salary)
  FROM employees 
  GROUP BY department_id
  HAVING MAX(salary)=MIN(salary)
  
-- 7. Birimlerde sadece tek bir kişiye verilen maaşları bulunuz.
  SELECT department_id,COUNT(*)
  FROM employees 
  GROUP BY department_id, salary
  HAVING COUNT(*)=1
  