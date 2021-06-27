
-- Çalıştığı birimin aynı zamanda yöneticisi olan kişileri bulunuz.
  
  SELECT * FROM employees
  WHERE (employee_id,department_id) IN (SELECT manager_id,department_id
                                        FROM departments)
                                        
                                        
  SELECT * FROM employees
  WHERE (employee_id) IN (SELECT manager_id
                           FROM departments)
  AND  (department_id) IN (SELECT department_id
                           FROM departments)
                           
-- Üstten alta veri geçişi
-- Çalıştığı birimin aynı zamanda yöneticisi olan kişileri bulunuz.

SELECT * 
FROM employees
WHERE employee_id=(kişinin departmanının managerini bul (department_id))

SELECT * 
FROM employees 
WHERE employee_id = (SELECT manager_id 
                     FROM departments 
                     WHERE departments.department_id=employees.department_id )  
-- Alias'lı çözüm

SELECT * 
FROM employees ust
WHERE employee_id = (SELECT manager_id 
                     FROM departments 
                     WHERE departments.department_id=ust.department_id ) 
                     
-- Kendi biriminin ortalamasının üzerinde maaaş alan kişileri bulunuz.

SELECT * 
FROM employees ust
WHERE salary > (SELECT AVG(salary) 
                FROM employees alt
                WHERE alt.department_id=ust.department_id)

-- Kendi ünvan aralığı dışında maaş alan kişileri bulunuz.

SELECT * 
FROM employees e
WHERE salary NOT BETWEEN (SELECT min_salary FROM jobs j WHERE j.job_id=e.job_id )
                     AND  (SELECT max_salary FROM jobs j WHERE j.job_id=e.job_id )           
SELECT *
FROM HR.employees e
WHERE job_id = (SELECT job_id FROM jobs j 
                WHERE j.job_id=e.job_id 
                AND e.salary NOT BETWEEN min_salary AND max_salary)
                
SELECT *
FROM HR.employees e
WHERE 'x' = (SELECT 'x' FROM jobs j 
             WHERE j.job_id=e.job_id 
             AND e.salary NOT BETWEEN min_salary AND max_salary)
             
             
SELECT *
FROM HR.employees e
WHERE job_id IN (SELECT job_id FROM jobs j 
             WHERE e.salary NOT BETWEEN min_salary AND max_salary)

-- EXISTS

-- Personel çalışan birimleri bulunuz.

SELECT * FROM departments ust
WHERE EXISTS (SELECT * FROM employees e WHERE e.department_id=ust.department_id)

-- Personel çalışmayan birimleri bulunuz.

SELECT * FROM departments ust
WHERE NOT EXISTS (SELECT 'x' FROM employees e WHERE e.department_id=ust.department_id)

SELECT * FROM departments ust
WHERE department_id NOT IN (SELECT NVL(department_id,-1) FROM employees)

-- FROM kısmında alt sorgu kullanmak

SELECT employee_id FROM (SELECT employee_id,first_name,last_name FROM employees)

-- Birimlerin en yüksek maaş ortalamasını bulunuz.

SELECT max(ortalama_maas) FROM 
                          (SELECT department_id, AVG(salary) ortalama_maas
                           FROM employees
                           GROUP BY department_id)
-- İkinci Yöntem
(SELECT MAX(AVG(salary)) ortalama_maas
 FROM employees
 GROUP BY department_id)

-- En yüksek ortalama maaşa sahip birimi bulunuz.


(SELECT department_id, AVG(salary) ortalama_maas
FROM employees
HAVING AVG(salary) = (en_yuksek_ortalama)
GROUP BY department_id)

SELECT department_id, AVG(salary) ortalama_maas
FROM employees
HAVING AVG(salary) = (
    SELECT max(ortalama_maas) FROM 
                          (SELECT department_id, AVG(salary) ortalama_maas
                           FROM employees
                           GROUP BY department_id)
)
GROUP BY department_id

-- Viev üzerinden ikinci çözüm
CREATE VIEW dept_ort AS (SELECT department_id, AVG(salary) ortalama_maas
                          FROM employees 
                          GROUP BY department_id) 

SELECT * FROM dept_ort
WHERE ortalama_maas = (SELECT max(ortalama_maas) FROM dept_ort)


-- Personellerin departman isimlerini personel isimleriyle birlikte gösteriniz.
-- SELECT ile FROM arasında alt sorgu kullanarak.

SELECT first_name, last_name, (SELECT department_name 
                               FROM departments d 
                               WHERE d.department_id=e.department_id) departman_name
FROM employees e

--Alt sorgularda üstten gönderilen kolonlar çok doğru kullanılmalıdır.
--Aşağıda hatalı bir örnek vardır.
SELECT * 
FROM (SELECT job_id unvan FROM employees) ust
WHERE job_id IN (SELECT job_id FROM departments)