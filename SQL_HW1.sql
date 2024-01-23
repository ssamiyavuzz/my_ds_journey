----- 1.HOMEWORK ÇÖZÜMLERİ -----
--1-tablo olusturma---
--filmler isminde bir tablo oluşturunuz.
--film_isim(varchar(50)), tür(varchar(20)), 
--süre(real), imdb(numeric(2,1)) 
--sütunları olsun.

CREATE TABLE filmler(
film_isim VARCHAR(50),
tur VARCHAR(20),
sure REAL,
imdb numeric(2,1)
);


--2-Data ekleme--
--a-filmler tablosuna tüm fieldlarıyla 3 tane kayıt ekleyiniz.
INSERT INTO filmler VALUES('The Prestige','Gizem,Dram',115,9.8);
INSERT INTO filmler VALUES('Sherlock Holmes','Polisiye',240,9.5);
INSERT INTO filmler VALUES('Inception','Bilim kurgu',180,8.1);


--b-“ ogretmenler” isminde tablo olusturun.
/*Icinde “kimlik_no”, “isim”, “brans” ve “cinsiyet” field’lari olsun
(uygun data tiplerini kullanınız.).
“ogretmenler” tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.*/

CREATE TABLE ogretmenler(
kimlik_no INTEGER,
isim VARCHAR(30),
brans VARCHAR(30),
cinsiyet VARCHAR(5)
);
INSERT INTO ogretmenler VALUES(234431223, 'Ayse Guler', 'Matematik', 'kadin');
INSERT INTO ogretmenler VALUES(234431224, 'Ali Guler', 'Fizik', 'erkek');

--3-Var olan tablodan yeni tablo oluşturmak
-- “film_imdb” isminde bir tabloyu  “filmler” tablosundan oluşturunuz.
--İçinde “film_isim” ve “imdb” field’lari olsun

CREATE TABLE film_imdb AS SELECT film_isim,imdb FROM filmler;

--4-bazı fieldları olan kayıt ekleme
--a-"filmler" tablosuna 
--film_isim:"Ayla", “imdb”:9.87,
--film_isim:"Shrek", “imdb”:9.83
--olan kayıtları ekleyiniz.

INSERT INTO filmler(film_isim, imdb) VALUES('Ayla', 9.87);
INSERT INTO filmler(film_isim, imdb) VALUES('Shrek', 9.83);

--NOT:imdb numeric(2,1) olduğu için imdb değerleri 9.9 ve 9.8 e yuvarlanır. 

--b-“ogretmenler” tablosuna bilgileri 
--kimlik_no: 567597624, isim: Veli Guler
--olan kişiyi ekleyiniz.

INSERT INTO ogretmenler(kimlik_no, isim) VALUES(567597624, 'Veli Guler');

SELECT * FROM filmler;
SELECT * FROM ogretmenler;