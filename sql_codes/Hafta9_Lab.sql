/*Birim_id, birim adi olan bir birim tablosu oluşturunuz.
Birim_id alanını PK olarak atayınız.
Birim adı NOT NULL olarak belirleyiniz.*/


CREATE TABLE birim (
    birim_id NUMBER(10),
    birim_adi VARCHAR2(30) NOT NULL,
    PRIMARY KEY (birim_id)
)


/*
Employee tablosundan çalışan tablosu oluşturunuz.
User_costraint tablosu kullanılarak oluşturulmuş bir script ile Çalışan tablosu tüm constraintlerini siliniz. (script ile)
Komisyon miktarı 10000 (commission_pct*salary) doları geçemez kuralı ekleyiniz.
Calisan tablosu department_id alanı üzerine department tablosu department_id alanına referans eden bir foreign key constraint oluşturunuz.


*/

CREATE TABLE calisan AS (SELECT * FROM EMPLOYEES)

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='CALISAN'


SELECT 'ALTER TABLE CALISAN DROP CONSTRAINTS  '||CONSTRAINT_NAME||';' FROM USER_CONSTRAINTS
WHERE TABLE_NAME='CALISAN'

ALTER TABLE CALISAN DROP CONSTRAINTS  SYS_C007110;
ALTER TABLE CALISAN DROP CONSTRAINTS  SYS_C007111;
ALTER TABLE CALISAN DROP CONSTRAINTS  SYS_C007112;
ALTER TABLE CALISAN DROP CONSTRAINTS  SYS_C007113;


ALTER TABLE calisan
ADD CONSTRAINT ck_commission
CHECK ( COMMISSION_PCT * SALARY < 10000 )

ALTER TABLE calisan
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments (department_id)

/*
Sistem kullanıcısı ile login olunuz
Egitim kullanıcısını oluşturunuz. Şifre eğitim
Bu kullanıcıya sisteme bağlanma ve tablo oluşturma hakkı veriniz.
İk rolü oluşturunuz
Egitim kullanıcısından hr tablolarının tümüne erişmek için gerekli tüm yetkileri bir ik rolüne veren scripti oluşturunuz.
İk rolünü egitm kullanıcısına atayınız.
Egitim kullanıcısı ile  hr tablolarını sorgulayınız.
*/

CREATE USER egitim identified by egitim

GRANT CREATE TABLE, CREATE SESSION TO egitim

CREATE ROLE IK

-- all_tables sistemin görebileceği tablolardır
SELECT 'GRANT ALL ON hr.'||table_name|| ' TO IK;' FROM ALL_TABLES
WHERE OWNER='HR'

-- Gelen scriptler buraya yazılacak
-- GRANT ALL ON hr.CALISAN TO IK; ...

GRANT IK TO egitim
