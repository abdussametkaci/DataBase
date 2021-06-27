-- DDL komutları
CREATE TABLE calisan
(
    calisan_id NUMBER(10),
    adi VARCHAR2(30),
    soyadi VARCHAR2(30),
    ise_giris_tarihi DATE
);

ALTER TABLE calisan ADD (maas NUMBER(10,2));

DROP table calisan;


-- Tarih ve veritabanı

SELECT TO_CHAR(hire_date,'DAY/MONTH/YYYY HH24:MI ff') FROM EMPLOYEES;

SELECT TO_CHAR(hire_date,'YYYY/MONTH/DAY HH24:MI') FROM EMPLOYEES;

SELECT TO_CHAR(SYSDATE,'DAY/MONTH/YYYY HH24:MI ss') FROM dual

SELECT (SYSDATE-hire_date)/365 FROM employees

SELECT sysdate-3 FROM dual

SELECT TO_DATE('01/01/2020','DD/MM/YYYY') FROM dual

--DDL ile script yazma

ALTER TABLE birim ADD (kayit_tarihi DATE);
ALTER TABLE calisan ADD (kayit_tarihi DATE);


SELECT 'ALTER TABLE '||table_name||' ADD (kayit_tarihi DATE);' FROM user_tables;


ALTER TABLE REGIONS ADD (kayit_tarihi DATE);
ALTER TABLE LOCATIONS ADD (kayit_tarihi DATE);
ALTER TABLE DEPARTMENTS ADD (kayit_tarihi DATE);
ALTER TABLE JOBS ADD (kayit_tarihi DATE);
ALTER TABLE EMPLOYEES ADD (kayit_tarihi DATE);
ALTER TABLE JOB_HISTORY ADD (kayit_tarihi DATE);
ALTER TABLE PERSONEL ADD (kayit_tarihi DATE);
ALTER TABLE BIRIM ADD (kayit_tarihi DATE);
ALTER TABLE MY_EMPLOYEES ADD (kayit_tarihi DATE);
ALTER TABLE MY_DEPARTMENTS ADD (kayit_tarihi DATE);
ALTER TABLE CALISAN ADD (kayit_tarihi DATE);
ALTER TABLE COUNTRIES ADD (kayit_tarihi DATE);

-- Tablodaki tüm veriyi silmek için kullanılır.
TRUNCATE TABLE birim;

ALTER TABLE BIRIM
ADD CONSTRAINT uniq_birim_adi UNIQUE (birim_adi);

ALTER TABLE BIRIM
ADD CONSTRAINT fk_birim_ik FOREIGN KEY (birim_id) REFERENCES departments(department_id);

DROP TABLE birim CASCADE CONSTRAINTS;

CREATE TABLE birim
(
    birim_id NUMBER(10),
    birim_adi VARCHAR2(30)
);


ALTER TABLE MY_EMPLOYEES
ADD CONSTRAINT ck_tarih_kontrol
CHECK ( hire_date >= kayit_tarihi )


-- View Nesnesi


CREATE VIEW emp_dept AS (SELECT e.EMPLOYEE_ID,e.FIRST_NAME,e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID(+))


SELECT * FROM emp_dept


CREATE view job_view  AS (SELECT * FROM jobs WHERE job_title like 'A%' )

CREATE view emp_view  AS (SELECT * FROM MY_EMPLOYEES)

DELETE FROM emp_view
WHERE EMPLOYEE_ID=100


INSERT INTO MY_EMPLOYEES
(SELECT EMPLOYEE_ID-10000, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id, kayit_tarihi FROM MY_EMPLOYEES)


SELECT * FROM MY_EMPLOYEES e
JOIN MY_EMPLOYEES d on d.EMPLOYEE_ID = E.MANAGER_ID
WHERE e.employee_id= 1453

CREATE INDEX idx_emp_id
ON MY_EMPLOYEES(EMPLOYEE_ID)

CREATE USER minor_hr identified by hr
GRANT CREATE SESSION TO minor_hr

GRANT SELECT ON employees TO minor_hr

REVOKE SELECT ON employees FROM minor_hr

CREATE ROLE minor_hr_role
GRANT SELECT ON employees TO minor_hr_role
GRANT SELECT ON DEPARTMENTS  TO minor_hr_role
GRANT SELECT ON JOBS  TO minor_hr_role

GRANT minor_hr_role TO minor_hr