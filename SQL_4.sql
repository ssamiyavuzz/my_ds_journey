--------------DAY 4 NT-------------------
--22-AGGREGATE Fonk.:toplamsal fonk

CREATE TABLE calisanlar3 (
id INT, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id INT UNIQUE, 
marka_isim VARCHAR(20), 
calisan_sayisi INT
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--calisanlar3 tablosunda max maaşı görüntüleyelim.
SELECT MAX(maas) FROM calisanlar3;
--calisanlar3 tablosunda min maaşı görüntüleyelim.
SELECT MIN(maas) FROM calisanlar3;
--calisanlar3 tablosunda ortalama maaşı görüntüleyelim.
SELECT AVG(maas) FROM calisanlar3;
SELECT ROUND(AVG(maas),2) FROM calisanlar3;
--calisanlar3 tablosunda toplam maaşı görüntüleyelim.
SELECT SUM(maas) FROM calisanlar3;
--calisanlar3 tablosundaki kayıt sayısını görüntüleyelim.
SELECT COUNT(*) FROM calisanlar3;
--calisanlar3 tablosundaki maaşı 2500 olanların sayısını görüntüleyiniz
SELECT COUNT(*) FROM calisanlar3 WHERE maas=2500;

--23-ALIASES:rumuz/etiket/takma isim:tablo veya sütunlara geçici isim verebiliriz.

CREATE TABLE workers(
calisan_id CHAR(9),
calisan_isim VARCHAR(50),
calisan_dogdugu_sehir VARCHAR(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');


SELECT * FROM workers AS w;
SELECT calisan_id AS id FROM workers;

SELECT calisan_isim AS isim FROM workers AS w;
SELECT calisan_isim isim FROM workers w; 

--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

--marka_id si 100 olan markada çalışanları listeleyiniz.
SELECT marka_isim FROM markalar WHERE marka_id=100;--Vakko
SELECT * FROM calisanlar3 WHERE isyeri='Vakko';
--2.yol

SELECT *
FROM calisanlar3
WHERE isyeri=( SELECT marka_isim 
			   FROM markalar 
			   WHERE marka_id=100 )

--INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

SELECT *
FROM calisanlar3
WHERE maas=( SELECT MAX(maas) 
			 FROM calisanlar3 )

--Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.ÖDEV

SELECT MAX(maas)
FROM calisanlar3
WHERE maas < (SELECT MAX(maas)
              FROM calisanlar3)

--peki kimler?:)
SELECT * 
FROM calisanlar3
WHERE maas=(SELECT MAX(maas)
            FROM calisanlar3
            WHERE maas < (SELECT MAX(maas)
                           FROM calisanlar3))




--calisanlar3 tablosunda max veya min maaşı alan çalışanların
-- tüm fieldlarını gösteriniz.

SELECT *
FROM calisanlar3
WHERE maas=( SELECT MAX(maas) FROM calisanlar3 ) OR maas= (SELECT MIN(maas) FROM calisanlar3)

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN ('Vakko','Pierre Cardin','Adidas');
-----

SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN ( SELECT isyeri 
					  FROM calisanlar3 
					  WHERE sehir='Ankara');

--marka_id’si 101’den büyük olan marka çalişanlarinin tüm bilgilerini listeleyiniz.

SELECT *
FROM calisanlar3
WHERE isyeri IN ( SELECT marka_isim FROM markalar WHERE marka_id>101);

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.
SELECT isim,maas,isyeri
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000)

--24-b-SUBQUERY: SELECT komutundan sonra kullanımı
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

SELECT marka_id,marka_isim, (SELECT COUNT(DISTINCT(sehir)) 
							 FROM calisanlar3 
							 WHERE isyeri=marka_isim) AS sehir_sayisi--correlated query
FROM markalar;

SELECT DISTINCT(isyeri) FROM calisanlar3;--DISTINCT sadece tekrarsız değerleri gösterir

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum 
--ve min maaşını listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi,(SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas,
                                 (SELECT MIN(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS min_maas
FROM markalar;

--25-EXISTS Cond.
-- =,!=(<>),<,>,...,AND,OR,BETWEEN..AND..,IN...
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.

CREATE TABLE mart
(     
urun_id INT,      
musteri_isim VARCHAR(50),
urun_isim VARCHAR(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(     
urun_id INT ,
musteri_isim VARCHAR(50),
urun_isim VARCHAR(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

--Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT *
FROM nisan
WHERE EXISTS (SELECT * FROM mart WHERE urun_isim='Toyota')

--Mart ayında 'Volvo' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT *
FROM nisan
WHERE EXISTS (SELECT * FROM mart WHERE urun_isim='Volvo')


--Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, 
--eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 

SELECT urun_id,musteri_isim
FROM mart AS m
WHERE EXISTS (SELECT * FROM nisan AS n WHERE n.urun_isim=m.urun_isim)

---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

SELECT urun_isim,musteri_isim
FROM nisan n
WHERE EXISTS (SELECT * FROM mart m WHERE m.urun_isim=n.urun_isim )

--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. ÖDEV

SELECT musteri_isim,urun_isim
FROM mart m
WHERE NOT EXISTS (SELECT * FROM nisan n WHERE n.urun_isim=m.urun_isim)


