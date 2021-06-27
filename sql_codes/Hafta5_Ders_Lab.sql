-- Tüm kayıtları ve sütunları seçmek
SELECT *
FROM employees

--Belli sütunları seçmek

SELECT first_name,last_name
FROM employees

-- BElli satırları seçmek

SELECT * 
FROM employees
WHERE salary>10000
AND department_id=90


-- BElli satırları ve sütunları seçmek

SELECT first_name,last_name,salary 
FROM employees
WHERE salary>10000
AND department_id=90

SELECT first_name,last_name,salary+1000 AS inc_salary
FROM employees

-- LIKE operatörü
-- İsmi A harfi ile başlayan kişileri bulunuz.
SELECT *
FROM employees
WHERE first_name LIKE 'A%'


-- İkinci harfi a harfi ile başlayan kişileri bulunuz.
SELECT *
FROM employees
WHERE first_name LIKE '_a%'

--ESCAPE karakter tanımı
SELECT *
FROM employees
WHERE first_name LIKE '%#_%' ESCAPE '#'

SELECT *
FROM employees
WHERE first_name = "AHMET"

SELECT first_name ||' '||last_name isim
FROM employees


SELECT first_name ||' '||salary isim_maas
FROM employees

-- Between 
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000

-- NULL kullanımı

SELECT * FROM employees
WHERE NULL!=NULL

SELECT * 
FROM employees
WHERE commission_pct IS NULL

-- Boş değerleri bulmak için bir yöntem
SELECT * 
FROM employees
WHERE NVL(commission_pct,-1) = -1;

SELECT commission_pct, NVL(commission_pct,-1) 
FROM employees


-- In liste kıyaslaması

SELECT *
FROM employees
WHERE job_id IN ('AD_PRES','AD_VP','PU_MAN')

--Eşleniği
SELECT *
FROM employees
WHERE job_id = 'AD_PRES' OR job_id = 'AD_VP' OR job_id = 'PU_MAN'


SELECT *
FROM employees
WHERE job_id NOT IN ('AD_PRES','AD_VP','PU_MAN',NULL)


SELECT *
FROM employees
ORDER BY salary DESC, first_name DESC

-- ORDER BY ve takma isim kullanımı
SELECT first_name||' '||last_name isim
FROM employees
ORDER BY isim

--Yanlış kod.
SELECT first_name||' '||last_name AS isim
FROM employees
WHERE isim='Alberto Errazuriz'
ORDER BY isim


--GROUP BY 

SELECT COUNT(*) AS adet
FROM employees

SELECT department_id,COUNT(*) AS adet
FROM employees
GROUP BY department_id

--Departmanda çalışan kişi sayısı
SELECT department_id,first_name,COUNT(*) AS adet
FROM employees
GROUP BY department_id,first_name

SELECT * 
FROM employees
WHERE department_id=80
AND first_name='Peter'


SELECT (department_id+5)+5,COUNT(*) AS adet
FROM employees
GROUP BY department_id+5


--İçinde 5 kişiden fazla kişi çalışan birimleri bulunuz.

SELECT department_id,COUNT(*) AS adet
FROM employees
GROUP BY department_id
HAVING count(*)>5 


--Having'te sadece grup fonksiyonları veya gruplanan kolonlar kullanılabilir.
SELECT department_id,COUNT(*) AS adet
FROM employees
HAVING count(*)>5  AND last_name='King'
GROUP BY department_id


-- İsmi tekrar eden kişilerin isimlerini (first_name+last_name) bulunuz.

SELECT first_name||' '||last_name,COUNT(*)
FROM employees
GROUP BY first_name,last_name
HAVING count(*)>1

--Sadece first_name
SELECT first_name,COUNT(*)
FROM employees
GROUP BY first_name
HAVING count(*)>1
-- Maaş ortalaması 10000 üzerinde olan birimleri bulunuz.

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING  AVG(salary)>10000


-- Aynı birimde ismi tekrar eden kişilerin çalıştığı departmanları bulunuz.

SELECT department_id,first_name,COUNT(first_name)
FROM employees
GROUP BY department_id,first_name
HAVING count(*)>1

--Laboratuvar

-- Alt sorgu

--TEk bir sonuç döndüren, tek bir kolon seçen ve parametre almayan alt sorgular.

-- Shipping'de çalışan kişileri bulunuz
SELECT * 
FROM employees
WHERE department_id = (Shipping Id)

-- Shipping Id
SELECT department_id
FROM departments 
WHERE department_name='Shipping'


SELECT * 
FROM employees
WHERE department_id = (SELECT department_id
                        FROM departments 
                        WHERE department_name='Shipping')

-- Çok kayıt döndüren alt sorgu örneği
-- Europe'da çalışan kişileri bulunuz.
SELECT * 
FROM employees
WHERE department_id IN 
     (SELECT department_id
      FROM departments
      WHERE location_id IN 
                (SELECT location_id
                FROM locations
                WHERE country_id IN (SELECT country_id
                                     FROM countries
                                     WHERE region_id IN (SELECT region_id
                                                         FROM regions
                                                         WHERE region_name='Europe'))))


-- Ortalama maaşın üzerinde maaş alan kişileri hesaplamak isteyelim.

SELECT first_name,last_name,salary
FROM employees
WHERE salary > ( SELECT AVG(salary)
   	               FROM employees)


-- Shipping'de çalışan en yüksek maaş alan kişiyi bulunuz.
SELECT *
FROM employees
WHERE salary= (shipping en y?ksek salary)
AND department_id= (shipping_id)

-- shipping en yüksek salary

SELECT max(salary)
FROM employees
WHERE department_id = (SELECT department_id FROM departments
                       WHERE department_name='Shipping')


SELECT * 
FROM employees
WHERE salary=(SELECT max(salary)
              FROM employees
              WHERE department_id = (SELECT department_id FROM departments
                                     WHERE department_name='Shipping'))
 AND department_id = (SELECT department_id FROM departments
                      WHERE department_name='Shipping')
                      
-- Employee_id = 102 olan kişinin görevlerini aynı departmanda  bugün yapan kişileri bulunuz.


SELECT *
FROM job_history
WHERE employee_id=102

SELECT *
FROM employees
WHERE (job_id,department_id) IN (SELECT job_id,department_id
                                 FROM job_history
                                 WHERE employee_id=102) 
-- shipping en yüksek salary
SELECT * 
FROM employees
WHERE (salary, department_id) =(SELECT max(salary), department_id
                                FROM employees
                                WHERE department_id = (SELECT department_id 
                                                       FROM departments
                                                       WHERE department_name='Shipping')
                                GROUP BY department_id)

-- Çalıştığı birimin aynı zamanda yöneticisi olan kişileri bulunuz.
  