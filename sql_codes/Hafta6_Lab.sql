-- IT departmanında çalışıp hiç unvanı değişmeyen kişileri bulunuz.
SELECT * FROM employees ust
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE department_name='IT')
  AND NOT EXISTS (SELECT 'X'
                  FROM job_history
                  WHERE employee_id=ust.employee_id)
                  
select employee_id,count(*) from job_history 
where department_id =(select department_id from departments where department_name='IT') 
group by employee_id having count(*)<2


-- IT departmanında çalışıp unvanı değişen kişileri bulunuz.

SELECT * FROM employees ust
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE department_name='IT')
  AND EXISTS (SELECT 'X'
                  FROM job_history
                  WHERE employee_id=ust.employee_id)


--Birden fazla birimin olduğu ülkeleri bulunuz.

SELECT ulke FROM (SELECT (SELECT country_id
        FROM locations l
        WHERE d.location_id=l.location_id) ulke,department_id 
        FROM departments d)
GROUP BY ulke
HAVING COUNT(*)>1

-- Birden fazla departmana sahip lokasyonlar olan ülkeleri bulunuz.
SELECT *
FROM countries
WHERE country_id IN
                    (SELECT country_id
                    FROM locations
                    WHERE location_id IN
                                    (SELECT location_id
                                    FROM departments
                                    GROUP BY location_id
                                    HAVING count(*)>1))


-- Maaşı 10000'den yüksek kişilerin çalıştığı lokasyonları bulunuz.

SELECT * FROM locations
WHERE location_id IN 
      (SELECT location_id FROM departments
      WHERE department_id IN
          (SELECT department_id FROM employees
                        WHERE salary>10000))

-- Hiç kimsenin çalışmadığı lokasyonları bulunuz.

SELECT * 
FROM locations
WHERE location_id NOT IN (SELECT location_id 
                          FROM departments
                          WHERE department_id IN (SELECT department_id FROM employees)
                          )

-- En düşük ve en yüksek maaşı arasında %10'dan az fark olan birimleri bulunuz.

SELECT * FROM departments
WHERE department_id IN (SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING  (MIN(salary) > 0.9*MAX(salary)))


--En düşük ve en yüksek maaşı arasında %10'dan az fark olan unvanları bulunuz.

SELECT * FROM jobs
WHERE job_id IN (SELECT job_id
                        FROM employees
                        GROUP BY job_id
                        HAVING  (MIN(salary) > 0.9*MAX(salary)))
--
SELECT * FROM jobs
WHERE  min_salary > 0.9*max_salary


select * from departments
where department_id IN (select department_id
                        from employees emp
                        where 'x' IN (select 'x' 
                                      from jobs
                                      where emp.job=jobs.job_id
                                      AND max_salary-min_salary<max_salary*10/100))
