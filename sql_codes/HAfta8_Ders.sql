--Küme işlemleri
--UNION

-- 100 ve 80 nolu birimlerde çalışan ünvanları bulunuz.
SELECT job_id FROM employees WHERE department_id=100
UNION
SELECT job_id FROM employees WHERE department_id=80

SELECT job_id FROM employees WHERE department_id=100
UNION ALL
SELECT job_id FROM employees WHERE department_id=80

--Eşleniği
SELECT job_id FROM employees WHERE department_id=80 or department_id=100
SELECT job_id FROM employees WHERE department_id IN (80,100)


 
-- INTERSECT
-- Hem 70 ve hem de 50 nolu birimlerde çalışan ortak ünvanları bulunuz.
SELECT job_id FROM employees WHERE department_id=70
INTERSECT
SELECT job_id FROM employees WHERE department_id=50


--MINUS 
--Çalışanı olmayan birimleri bulunuz.

SELECT * FROM departments 
WHERE department_id in (SELECT department_id FROM departments
                        MINUS
                        SELECT department_id FROM employees)

-- Örnekler
-- Hem 70 ve hem de 50 nolu birimlerde çalışanların ortak comiston oranlarını bulunuz.
SELECT commission_pct FROM employees WHERE department_id=70
INTERSECT
SELECT commission_pct FROM employees WHERE department_id=50

-- Hem 100 ve hem 90 nolu birimde kullanılan ancak 80 nolu birimde hiç kullanılmayan ünvanları bulunuz.

(SELECT job_id FROM employees WHERE department_id=100 
INTERSECT 
SELECT job_id FROM employees WHERE department_id=90)
MINUS
SELECT job_id FROM employees WHERE department_id=80


-- Kendi biriminin amiri olan kişileri bulunuz.
 SELECT employee_id, department_id FROM employees
 INTERSECT
 SELECT manager_id, department_id FROM departments
 
 -- Amir olan personelleri bulunuz.
 
 SELECT employee_id FROM employees
 INTERSECT
 SELECT manager_id FROM employees
 
--Kümesel işlemlerde sıralama
 SELECT employee_id, department_id FROM employees
 INTERSECT
 SELECT manager_id, department_id FROM departments
 ORDER BY employee_id
 
-- Ara işlem
CREATE TABLE my_employees AS SELECT * FROM employees
CREATE TABLE my_departments AS SELECT * FROM departments
-- DML işlemleri

-- INSERT


INSERT INTO my_departments
(department_id, department_name, manager_id)
VALUES
(301, 'IT Admin',101)

SELECT * FROM MY_DEPARTMENTS

--Küme Insert
INSERT INTO my_departments
(department_id, department_name, manager_id)
(SELECT 1000+department_id, 'New '||department_name, manager_id
 FROM departments
 WHERE department_id<50)

--Tablo ile aynı yapıda küme insert
INSERT INTO my_departments
(SELECT 2000+department_id, 'Ultra New '||department_name, manager_id,location_id
 FROM departments
 WHERE department_id<50)

-- Yapılan DML işlemlerini kaydeder / DML işlemleri kalıcı değildir 
 COMMIT
 
 -- UPDATE
 
 UPDATE my_employees
 SET salary = salary * 2
 WHERE salary<6000
  
 -- Ortalamanın altında maaş alan kişilere %20 zam yapınız.
 
 UPDATE my_employees
 SET salary=1.2*salary
 WHERE salary < (SELECT AVG(salary) FROM my_employees)
 
 -- Ortalamanın altında maaş alan kişilerin maaşını ortalama maaşla eşitleyiniz 

 
 UPDATE my_employees
 SET salary=(SELECT AVG(salary) FROM my_employees)
 WHERE salary < (SELECT AVG(salary) FROM my_employees)


-- Görüntülenen kayıtların update edilebilmesi.

--1700 nolu lokasyonda çalışanlara %20 zam yapınız.
-- tabloda primary key bulunmazsa hata verir
UPDATE (SELECT * FROM my_employees e, my_departments d
        WHERE e.department_id=d.department_id
          AND d.location_id=1700)
SET salary=1.2*salary

-- DELETE 
DELETE my_departments
WHERE department_id >= 300

--Hiç çalışanı olmayan birimleri siliniz.
DELETE my_departments
WHERE department_id NOT IN (SELECT NVL(department_id,0) FROM my_employees)


-- Kendi biriminin maaş ortalaması altında maaş alan çalışanlara %10 zam yapınız.

UPDATE my_employees ust
SET salary=1.1*salary
WHERE salary<(SELECT AVG(salary) FROM my_employees
              WHERE department_id=ust.department_id)


-- Kendi biriminin maaş ortalaması altında maaş alan çalışanların maaşını biriminin ortalmasına eşitleyiniz.

UPDATE my_employees ust
SET salary= (SELECT AVG(salary) FROM my_employees
              WHERE department_id=ust.department_id)
WHERE salary<(SELECT AVG(salary) FROM my_employees
              WHERE department_id=ust.department_id)

-- Herkezi kendi birim maaş ortalamasına eşitleyiniz.

UPDATE my_employees ust
SET salary= (SELECT AVG(salary) FROM my_employees
              WHERE department_id=ust.department_id)

-- Hiç birim değiştirmeyen çalışanları siliniz.
DELETE my_employees
WHERE employee_id IN (SELECT employee_id FROM my_employees
                      MINUS
                     SELECT employee_id FROM job_history)
                     
DELETE my_employees
WHERE employee_id NOT IN (SELECT employee_id FROM job_history)