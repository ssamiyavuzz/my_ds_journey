------------------ DAY 3 NT -------------------
------------------   tekrar ------------------

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,--unique,not null,kayıtlar için tanımlayıcı,başka bir tablo ile ilişkilendirmek için ref.
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);--parent/referenced table

CREATE TABLE adresler(
adres_id char(5),--null,duplicate kabul eder
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id) 
);--child table



INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14');--başarılı 
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--başarılı 
--!!!unıque:NULL değer kabul eder.
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim:UNIQUE
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--başarılı
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--maas:NOT NULL
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--maas:INTEGER
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');
--PK:''(yani empty) NULL değildir
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--PK:unique
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--PK:unique
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--PK:NOT NULL
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');--başarılı
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');--başarılı
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');--başarılı

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');--başarılı
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');--başarılı
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');--başarılı

INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya');
--PK de böyle bir kayıt yok

INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');


SELECT * FROM calisanlar;--DQL
SELECT * FROM adresler;

--14-WHERE Condition(koşulu)
--calisanlar tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
SELECT * FROM calisanlar WHERE isim='Donatello';
--calisanlar tablosundan maaşı 5000den fazla olanların tüm bilgilerini listeleyelim
SELECT * FROM calisanlar WHERE maas>5000;
--calisanlar tablosundan maaşı 5000den fazla olanların isim ve maaşlarını listeleyelim
SELECT isim,maas FROM calisanlar WHERE maas>5000;

--adresler tablosundan sehiri 'Konya' ve 
--adres_id si 10002 olan kaydın tüm verileri getirelim
SELECT * FROM adresler
WHERE sehir='Konya' AND adres_id='10002';

--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
SELECT cadde,sehir 
FROM adresler
WHERE sehir='Konya' OR sehir='Bursa';

--15-tablodan kayıt silme:DELETE FROM...

CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);
INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;

--id=123 olan kaydı silelim.
DELETE FROM ogrenciler1 WHERE id=123;
--ismi Kemal Tan olan kaydı silelim
DELETE FROM ogrenciler1 WHERE isim='Kemal Tan';
--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran' OR isim='Veli Han';

--16-a-tablodaki tüm kayıtları silme:DELETE FROM ..:koşul belirtmeden kullanırız:DML
SELECT * FROM students;
DELETE FROM students;
--16-b-tablodaki tüm kayıtları silme:TRUNCATE TABLE-DDL-daha hızlı
SELECT * FROM doctors;
TRUNCATE TABLE doctors;--WHERE kullanılamaz,geri alınamaz

--17-parent-child ilişkisi olan tablolarda kayıt silme
SELECT * FROM calisanlar;--parent
SELECT * FROM adresler;---child

DELETE FROM calisanlar;
--ref alınan kayıtlar old için silmez
DELETE FROM calisanlar WHERE id='10002';
--id=10002 kayıt adresler tarafından ref alındığı için
--FK kısıtlaması silmeye izin vermez.

DELETE FROM adresler WHERE adres_id='10002';
DELETE FROM calisanlar WHERE id='10002';
--ref alınan kayıt silinerek ilişki koparıldı..
--artık ref olmadığından silmeye izin verir

DELETE FROM adresler;
DELETE FROM calisanlar;
--önce ref alan tüm kayıtlar silindiği için
--tüm ilişkiler de koparıldı ve 
--tüm kayıtların silinmesine izin verdi.

--18-ON DELETE CASCADE:kademeli silme işlemini otomatik gerçekleştirir

CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--parent

CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id) ON DELETE CASCADE
);--child

INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

--notlar tablosundan id=123 olan kaydı silelim
DELETE FROM notlar WHERE talebe_id=123;

--talebeler tablosundan id=126 olan kaydı silelim
DELETE FROM talebeler WHERE id=126;
--on delete cascade öz ile önce ref alan kayıt
--ardından ilgili kayıt tablodan silindi.

DELETE FROM talebeler;
--on delete cascade öz ile tüm referanslar silindi
--ilişkili kayıt kalmadığı için tüm kayıtları sildi.
DELETE FROM notlar;
--19-tabloyu SCHEMAdan silme:
DROP TABLE talebeler;
DROP TABLE talebeler CASCADE;
--notlar tablosunda tanımlı FK constrainti kaldırlır ardından
--tablo silinir.

DROP TABLE IF EXISTS talebeler1;

--20-IN condition

CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
SELECT * FROM musteriler
WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot'; 
--2.yol
SELECT * FROM musteriler
WHERE urun_isim IN ('Orange','Apple','Apricot');

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
SELECT * FROM musteriler
WHERE urun_isim NOT IN ('Orange','Apple','Apricot');

--21-BETWEEN .. AND ... komutu
--Müşteriler tablosunda urun_id 20 ile 30(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
SELECT * FROM musteriler
WHERE urun_id>=20 AND urun_id<=30;

--2.yol
SELECT * FROM musteriler
WHERE urun_id BETWEEN 20 AND 30;--20 ve 30 dahil

--Müşteriler tablosunda urun_id 20den küçük veya 30dan büyük olan urunlerin tum bilgilerini listeleyiniz
SELECT * FROM musteriler
WHERE urun_id NOT BETWEEN 20 AND 30;






