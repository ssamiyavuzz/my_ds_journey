--------------DAY'8 NT-----------------
--tekrar

-- NOT LIKE :belirli bir karakter desenine benzemeyenleri getirir
--  !~(REGEXP_LIKE) :belirli bir regex i içermeyenleri getirir

-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

SELECT *
FROM words
WHERE word NOT ILIKE 'h%'

------regex

SELECT *
FROM words
WHERE word !~* '^h'


--39-String Fonksiyonlar

CREATE TABLE teachers(
id int,
firstname varchar(50),
lastname varchar(50),
age int,	
city varchar(20),
course_name varchar(20),
salary real	
);
INSERT INTO teachers VALUES(111,'AhmeT  ','  Han',35,'Istanbul','SpringMVC',5000);
INSERT INTO teachers VALUES(112,'Mehmet','Ran ',33,'Van','HTML',4000);
INSERT INTO teachers VALUES(113,' Bilal','Fan ',34,'Bursa','SQL',3000);
INSERT INTO teachers VALUES(114,'Celal',' San',30,'Bursa','Java',3000);
INSERT INTO teachers VALUES(115,'Deniz',' Can',30,'Istanbul','SQL',3500);
INSERT INTO teachers VALUES(116,'ekreM','Demir',36,'Istanbul','Java',4000.5);
INSERT INTO teachers VALUES(117,'Fatma','Celik',38,'Van','SpringBOOT',5550);
INSERT INTO teachers VALUES(118,'Hakan','Cetin',44,'Izmir','Java',3999.5);
INSERT INTO teachers VALUES(119,'mert','Cetin',32,'Izmir','HTML',2999.5);
INSERT INTO teachers VALUES(120,'Nilay','Cetin',32,'Izmir','CSS',2999.5);
INSERT INTO teachers VALUES(121,'Selma','Celik',40,'Ankara','SpringBOOT',5550);
INSERT INTO teachers VALUES(122,'fatiH','Can',32,'Ankara','HTML',2550.22);
INSERT INTO teachers VALUES(123,'Nihat','Keskin',32,'Izmir','CSS',3000.5);
INSERT INTO teachers VALUES(124,'Hasan','Temel',37,'Istanbul','S.Security',3000.5);

SELECT * FROM teachers;

--teachers tablosundaki tüm kayıtların 
--firstname değerlerini büyük harfe 
-- lastname değerlerinin küçük harfe çevirerek 
--uzunlukları ile birlikte listeleyiniz.

SELECT UPPER(firstname) AS fname,LENGTH(firstname),LOWER(lastname) AS lname,LENGTH(lastname)
FROM teachers

--teachers tablosunda firstname ve lastname değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırınız.

UPDATE teachers
SET firstname=TRIM(firstname),lastname=TRIM(lastname)

--teachers tablosunda tüm kayıtların firstname değerlerini
-- ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

SELECT INITCAP(firstname)
FROM teachers

--teachers tablosunda firstname değerlerinde 'Celal' kelimesini 'Cemal' ile değiştiririnz.

UPDATE teachers
SET firstname=REPLACE(firstname,'Celal','Cemal')

SELECT * FROM calisanlar4;

--calisanlar4 tablosunda isyeri='Vakko' olan kayıtlarda 
--son ' Şubesi' ifadesini siliniz.

UPDATE calisanlar4
SET sehir=SUBSTRING(sehir,1,LENGTH(sehir)-7)
WHERE isyeri='Vakko'

SUBSTRING('sqlsonders',1,3)-->sql

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.

SELECT word,SUBSTRING(word,1,2)
FROM words


--40-FETCH NEXT n ROW ONLY:sadece sıradaki ilk n satırı getirir--SQL standardı
--                  LIMIT n:sadece sıradaki ilk n satırı getirir--PostgreSQL ve bazı DBMS
--                  OFFSET n: n satırı atlayıp sonrakileri getirir


--developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;

--ya da

SELECT * 
FROM developers
LIMIT 3;

--developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
OFFSET 2 ROW--ROW zorunlu değil
LIMIT 3;

--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
ORDER BY salary 
LIMIT 3;

--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.

SELECT * 
FROM developers
ORDER BY salary DESC
OFFSET 1
LIMIT 1


--41-ALTER TABLE:tabloyu güncellemek için kullanılır:DDL
/*
add column ==> yeni sutun ekler
drop column ==> mevcut olan sutunu siler
rename column.. to.. ==> sutunun ismini degistirir      
rename.. to.. ==> tablonun ismini degistirir*/


--calisanlar4 tablosuna yas (int) seklinde yeni sutun ekleyiniz.

ALTER TABLE calisanlar4
ADD COLUMN yas INTEGER

--calisanlar4 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun

ALTER TABLE calisanlar4
ADD COLUMN remote BOOLEAN DEFAULT TRUE

--calisanlar4 tablosunda yas sutununu siliniz.

ALTER TABLE calisanlar4
DROP COLUMN yas

--calisanlar4 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.

ALTER TABLE calisanlar4
ALTER COLUMN maas TYPE REAL


--calisanlar4 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.

ALTER TABLE calisanlar4
RENAME COLUMN maas TO gelir

--calisanlar4 tablosunun ismini employees olarak güncelleyiniz.

ALTER TABLE calisanlar4 RENAME TO employees

--employees tablosunda id sütunun data tipini varchar(20) olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20)

--employees tablosunda id sütunun data tipini int olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN id TYPE INTEGER USING id::INTEGER

--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.

ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL

--INSERT INTO employees(id,sehir) VALUES(123,'Ankara')--artık isim NOT NULL

--NOT:içinde kayıtlar bulunan bir tabloyu güncellerken
--NOT NULL,PK,FK,UNIQUE,CHECK kısıtlamalarını ekleyebilmek için
--bu sütunun değerleri ilgili kısıtlamayı sağlıyor olmalı


SELECT * FROM employees;

--sirketler tablosunda sirket_id sütununa PRIMARY KEY constrainti ekleyiniz.

SELECT * FROM sirketler;

ALTER TABLE sirketler
ADD /*CONSTRAINT sirketler_pk*/ PRIMARY KEY(sirket_id)

--sirketler tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.

ALTER TABLE sirketler
ADD UNIQUE(sirket_isim)

--siparis tablosunda sirket_id sütununa FOREIGN KEY constrainti ekleyiniz.

ALTER TABLE siparis
ADD FOREIGN KEY(sirket_id) REFERENCES sirketler(sirket_id)

DELETE FROM siparis WHERE sirket_id IN (104,105)
SELECT * FROM siparis;


--siparis tablosundaki FK constrainti kaldırınız.

ALTER TABLE siparis
DROP CONSTRAINT siparis_sirket_id_fkey


--employees tablosunda isim sütununda NOT NULL constraintini kaldırınız.
ALTER TABLE employees
ALTER COLUMN isim DROP NOT NULL



--42-TRANSACTION:databasede en küçük işlem birimi 
--       BEGIN:transactionı başlatır
--       COMMIT:transactionı onaylar ve sonlandırır
--       SAVEPOINT: kayıt noktası oluşturur
--       ROLLBACK:değişikleri mevcut duruma geri döndürür,transactionı sonlandırır

--PGADMIN:auto-commit


CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemsel hata oluştu
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;

SELECT * FROM hesaplar;
-------------------------------------------------------------------

BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SAVEPOINT x;

--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemsel hata oluştu
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
COMMIT;
--catch{

--ROLLBACK;--en son commitlenmiş haline döner 
ROLLBACK TO x;

--}
SELECT * FROM hesaplar;

-------------------------------------------------------------------

BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SAVEPOINT x;

--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı
COMMIT;
--}catch{

ROLLBACK;--en son commitlenmiş haline döner 
ROLLBACK TO x;

--}
SELECT * FROM hesaplar;




















