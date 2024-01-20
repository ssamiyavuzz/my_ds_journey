--------------DAY'7 NT---------------------
--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.


CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');

CREATE TABLE siparis (
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');


--33-INNER JOIN:baz aldığımız sütundaki sadece ortak olan kayıtları getirir

--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler INNER JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id


SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM siparis INNER JOIN sirketler
ON sirketler.sirket_id=siparis.sirket_id


--NOT:INNER JOINde ortak olan kayıtları birleştirdiğinden tablo sırası önemli değildir.

--34-LEFT JOIN:baz aldığımız sütundaki, SOL(ilk) tablodaki tüm kayıtları getirir.
   --RIGHT JOIN:baz aldığımız sütundaki, SAĞ(ikinci) tablodaki tüm kayıtları getirir.
   
--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.    
   
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler LEFT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id
   
--siparis tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.    
   
SELECT siparis.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler RIGHT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id   
 
SELECT siparis.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM siparis LEFT JOIN sirketler
ON sirketler.sirket_id=siparis.sirket_id 
 
--NOT:LEFT/RIGHT JOIN tablo sırası değiştirilerek birbirinin yerine alternatif olarak kullanılabilir. 
 
   
--35-FULL JOIN:baz aldığımız sütundaki, her iki tablodaki tüm kayıtları getirir.

SELECT sirketler.sirket_id,sirket_isim, siparis.sirket_id,siparis_id,siparis_tarihi
FROM sirketler FULL JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id 

--veya
SELECT *
FROM sirketler FULL JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id 

--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 

CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;

--herbir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.

SELECT p.isim AS personel,m.isim AS yonetici
FROM personeller p INNER JOIN personeller m
ON p.yonetici_id=m.id


--37-LIKE Cond.:WHERE komutu ile birlikte kullanılır
--sorgularda belirli bir karakter deseni(pattern-dizisi) kullanarak filtreleme yapmayı sağlar
--ILIKE:LIKE gibi çalışır, CASE-INSENSITIVE dir.


CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;

SELECT * FROM developers WHERE name='Enes Can';
--SELECT * FROM developers WHERE name='E...';

-- wildcard(joker-%):0 veya daha fazla karakteri temsil eder

SELECT *
FROM developers
WHERE name LIKE 'A%';--A,Ab,Abc,...,abc

--Küçük/büyük harf duyarlılığı olmasın 
SELECT *
FROM developers
WHERE name ILIKE 'a%';

--Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary
FROM developers
WHERE name LIKE 'T%n'; --Tn,Tan gelirdi

--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary
FROM developers
WHERE name LIKE '%an%'; --anıl

--Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin
--kemal,hande
SELECT *
FROM developers
WHERE name LIKE '%e%a%' OR name LIKE '%a%e%'

--alternatif
SELECT *
FROM developers
WHERE name LIKE '%e%' AND name LIKE '%a%'

-- underscore(_)=sadece 1 karakteri temsil eder.

--Isminin ikinci harfi ü olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM developers
WHERE name LIKE '_ü%'

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM developers
WHERE prog_lang LIKE '__v_';


--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV
--Isminin 2. harfi e,4. harfi y olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV


--38-REGEXP_LIKE(~):belirli bir karakter deseni(regex) içeren kayıtları filtrelemeyi sağlar

-- words tablosu ile çalışalım.

-- [] :içerisindeki harflerden sadece 1 tanesini temsil eder


--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--hat/hit
--ahata,ahit,hatip

SELECT *
FROM words
WHERE word ~ 'h[ai]t';

--CASE-INSENSITIVE
SELECT *
FROM words
WHERE word ~* 'h[ai]t';

--[-]:iki harf arasındaki harflerden sadece 1 tanesini temsil eder.

 --h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.

SELECT *
FROM words
WHERE word ~* 'h[a-k]t'

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
--mat,ilk

SELECT *
FROM words
WHERE word ~* '[mi]'

-- ^:kelimenin başlangıcını gösterir
-- $:kelimenin sonunu gösterir 

--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^a';

--m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* 'm$';

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^[as]';--a,s gelirdi

-- (.*):0 veya daha fazla karakteri temsil eder.
-- (.):sadece 1 karakteri temsil eder.

--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y(.*)f$'

--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y.f$'

