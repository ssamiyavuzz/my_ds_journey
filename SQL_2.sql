-------DAY 2 NT-----
-----tekrar-----
CREATE TABLE IF NOT EXISTS sairler(
id INTEGER,
name VARCHAR(30),
email VARCHAR(50)	
);

INSERT INTO sairler VALUES(1001,'Necip Fazıl','sair@mail.com');
INSERT INTO sairler VALUES(1001,'Nazım Hikmet','sair@mail.com');

INSERT INTO sairler(name) VALUES('Attila İlhan');

SELECT * FROM sairler;

--9-tabloya UNIQUE constrainti ekleme
CREATE TABLE programmers(
id SERIAL,--unıque olmasını garanti etmez
name VARCHAR(30),
email VARCHAR(50) UNIQUE,
salary REAL,
prog_lang VARCHAR(20)
);

INSERT INTO programmers(name,email,salary,prog_lang) VALUES('Tom','mail@mail.com',5000,'Java');
INSERT INTO programmers(name,email,salary,prog_lang) VALUES('Jerry','mail@mail.com',6000,'JavaScript');
---email unique olmalıydı
INSERT INTO programmers(name,email,salary,prog_lang) VALUES('Jerry','mail2@mail.com',6000,'JavaScript');

INSERT INTO programmers(email,salary,prog_lang) VALUES('mail3@mail.com',6000,'Python');

SELECT * FROM programmers;

--10-tabloya NOT NULL constrainti ekleme
CREATE TABLE doctors(
id SERIAL,
name VARCHAR(30) NOT NULL,
salary REAL,
email VARCHAR(50) UNIQUE	
);

INSERT INTO doctors(name,salary,email) VALUES('Dr. Gregory House',6000,'dr@mail.com');
INSERT INTO doctors(salary,email) VALUES(6000,'doctor@mail.com');
--name null olamazdı.
INSERT INTO doctors(name,salary,email) VALUES('',6000,'doc@mail.com');
--'' yani empty null ile aynı değildir.

SELECT * FROM doctors;

--11-tabloya PK constrainti ekleme
CREATE TABLE students2(
id INTEGER PRIMARY KEY,--not null,unique,başka bir tablo ile ilişkilendirmek için kullanılır
name VARCHAR(50),
grade REAL,
register_date DATE	
);

SELECT * FROM students2;

---tabloya PK constrainti ekleme:2.yöntem
--11-tabloya PK constrainti ekleme
CREATE TABLE students3(
id INTEGER,--not null,unique,başka bir tablo ile ilişkilendirmek için kullanılır
name VARCHAR(50),
grade REAL,
register_date DATE,
CONSTRAINT std_pk PRIMARY KEY(id)--CONSTRAINT ile kısıtlamaya özel isim verilebilir, zorunlu değildir
);

SELECT * FROM students3;

--composite key
CREATE TABLE students4(
id INTEGER,--PK
name VARCHAR(50),--PK
grade REAL,
register_date DATE,
CONSTRAINT std4_pk PRIMARY KEY(id,name)--CONSTRAINT ile kısıtlamaya özel isim verilebilir, zorunlu değildir
);

--12-tabloya FK constrainti ekleme
CREATE TABLE address3(
address_id INTEGER,
street VARCHAR(50),
city VARCHAR(20),
student_id INTEGER,
CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students3(id)	
);

CREATE TABLE address2(
address_id INTEGER,
street VARCHAR(50),
city VARCHAR(20),
student_id INTEGER,
FOREIGN KEY(student_id) REFERENCES students2(id)	
);

SELECT * FROM address3;

--13-tabloya CHECK constrainti ekleme
CREATE TABLE person(
id INTEGER,
name VARCHAR(50),
salary REAL CHECK(salary>5000),
age INTEGER CHECK(age>0)	
);

INSERT INTO person VALUES(11,'Ali Can',6000,23); 

