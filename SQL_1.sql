--yorum satırı
/*
çoklu yorum satırı
*/

-----------DAY 1 NT---------
--1-database oluşturma--DDL
CREATE DATABASE deneme;

--SQL komutlarında küçük/büyük harf duyarlılığı yoktur
create database test2;

--2-database silme--DDL
DROP DATABASE deneme;

--3-tablo oluşturma--DDL
CREATE TABLE students(
id CHAR(4),
name VARCHAR(20),
grade REAL,
register_date DATE
);

--4-mevcut bir tablodan yeni bir tablo oluşturma--DDL
CREATE TABLE grades AS SELECT name,grade FROM students;

--5-tabloyu silme--DDL
DROP TABLE grades;

--6-tabloya tüm fieldlarıyla data ekleme
INSERT INTO students VALUES('1001','Sherlock Holmes',99.8,'2023-12-11');
INSERT INTO students VALUES('1002','Harry Potter',99,now()); 

--7-data okuma/çekme
--a-tablodaki tüm kayıtları tüm fieldlarıyla okuma
SELECT * FROM students;

--b-tablodaki tüm kayıtları bazı fieldlarıyla okuma
SELECT name,grade FROM students;

--8-tabloya bazı filedlarıyla data ekleme
INSERT INTO students(name,grade) VALUES('Jack Sparrow',99.7);









