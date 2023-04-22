﻿/* Poner en uso base de datos master para eliminar la base de datos db_SalesClothes */
USE master;

/* Eliminar y crear la base de datos db_SalesClothes */
DROP DATABASE IF EXISTS db_SalesClothes;

CREATE DATABASE db_SalesClothes;

/* Poner en uso la base de datos db_SalesClothes */
USE db_SalesClothes;




/* Configurar el idioma español el motor de base de datos */
SELECT @@language AS 'Idioma'

GO

EXEC sp_helplanguage
GO

SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO




/* Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos */
SELECT sysdatetime() as 'Fecha y  hora'
GO

SET DATEFORMAT dmy
GO




/* Creamos la tabla client */
CREATE TABLE client
(
	id int,
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);

/* Quitamos la Primary Key en tabla client */
ALTER TABLE client
	DROP CONSTRAINT client_pk
GO

/* Quitamos la columna id en tabla cliente */
ALTER TABLE client
	DROP COLUMN id
GO

/* Agregamos la columna client */
ALTER TABLE client
	ADD id int identity(1,1)
GO

/* Restricción primary key */
ALTER TABLE client
	ADD CONSTRAINT client_pk 
	PRIMARY KEY (id)
GO

/* Restricción de tipo de documento puede ser DNI o CNE */
ALTER TABLE client
	DROP COLUMN type_document
GO

/* Restricción para tipo documento */
ALTER TABLE client
	ADD type_document char(3)
	CONSTRAINT type_document_client 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

/* Eliminar columna number_document de tabla client */
ALTER TABLE client
	DROP COLUMN number_document
GO

/* Permitir digitos de 0 - 9 */
ALTER TABLE client
	ADD number_document char(9)
	CONSTRAINT number_document_client
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

/* Eliminar columna email de tabla client */
ALTER TABLE client
	DROP COLUMN email
GO

/* Agregar columna email */
ALTER TABLE client
	ADD email varchar(80)
	CONSTRAINT email_client
	CHECK(email LIKE '%@%._%')
GO

/* Eliminar columna celular */
ALTER TABLE client
	DROP COLUMN cell_phone
GO

/* Validar que el celular esta conformado por 9 números */
ALTER TABLE client
	ADD cell_phone char(9)
	CONSTRAINT cellphone_client
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

/* Eliminar columna fecha de nacimiento */
ALTER TABLE client
	DROP COLUMN birthdate
GO

/* Solo debe permitir el registro de clientes mayores de edad */
ALTER TABLE client
	ADD  birthdate date
	CONSTRAINT birthdate_client
	CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18)
GO

/* Eliminar columna active de tabla client */
ALTER TABLE client
	DROP COLUMN active
GO

/* El valor predeterminado sera activo al registrar clientes */
ALTER TABLE client
	ADD active bit DEFAULT (1)
GO

/* Crear tabla seller */
CREATE TABLE seller (
    id int ,
    type_document char(3) ,
    number_document char(15),
    names varchar(60),
    last_name varchar(90) ,
    salary decimal(8,2),
    cell_phone char(9),
    email varchar(80),
    active bit ,
    CONSTRAINT seller_pk PRIMARY KEY (id)
);

/* Quitar Primary Key en tabla seller */
ALTER TABLE seller
	DROP CONSTRAINT seller_pk
GO

/* Quitar columna id en tabla seller */
ALTER TABLE seller
	DROP COLUMN id
GO

/* Agregar columna seller */
ALTER TABLE seller
	ADD id int identity(1,1)
GO

/* Restricción primary key */
ALTER TABLE seller
	ADD CONSTRAINT seller_pk 
	PRIMARY KEY (id)
GO

/* El tipo de documento puede ser DNI o CNE */
ALTER TABLE seller
	DROP COLUMN type_document
GO

/* Restricción para tipo documento */
ALTER TABLE seller
	ADD type_document char(3)
	CONSTRAINT type_document_seller 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

/* Eliminar columna number_document de tabla seller */
ALTER TABLE seller
	DROP COLUMN number_document
GO

/* Permitir digitos de 0 - 9 */
ALTER TABLE seller
	ADD number_document char(9)
	CONSTRAINT number_document_seller
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

/* Eliminar columna salary de tabla seller */
ALTER TABLE seller
	DROP COLUMN salary
GO

/* Crear columna salary   */
ALTER TABLE seller
	ADD salary decimal(8,2)
GO

/* Poner como default En la columna salary solo valor predeterminado 1025 */
ALTER TABLE seller 
    ADD DEFAULT 1025�FOR�salary
GO

/* Eliminar columna celular */
ALTER TABLE seller
	DROP COLUMN cell_phone
GO

/* Validar que el celular esta conformado por 9 números */
ALTER TABLE seller
	ADD cell_phone char(9)
	CONSTRAINT cellphone_seller
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

/* Eliminar columna email de tabla seller */
ALTER TABLE seller
	DROP COLUMN email
GO

/* Agregar columna email */
ALTER TABLE seller
	ADD email varchar(80)
	CONSTRAINT email_seller
	CHECK(email LIKE '%@%._%')
GO

/* Eliminar columna active de tabla seller */
ALTER TABLE seller
	DROP COLUMN active
GO

/* El valor predeterminado ser� activo al registrar seller */
ALTER TABLE seller
	ADD active bit DEFAULT (1)
GO

/* Crear tabla clothes */
CREATE TABLE clothes (
    id int,
    descriptions varchar(60),
    brand varchar(60),
    amount int,
    size varchar(10),
    price decimal(8,2),
    active bit,
    CONSTRAINT clothes_pk PRIMARY KEY (id)
);

/* Quitar Primary Key en tabla clothes */
ALTER TABLE clothes
	DROP CONSTRAINT clothes_pk
GO

/* Quitar columna id en tabla clothes */
ALTER TABLE clothes
	DROP COLUMN id
GO

/* Agregar columna clothes */
ALTER TABLE clothes
	ADD id int identity(1,1)
GO

/* Restricción primary key */
ALTER TABLE clothes
	ADD CONSTRAINT clothes_pk 
	PRIMARY KEY (id)
GO 

/* Eliminar columna active de tabla clothes */
ALTER TABLE clothes
	DROP COLUMN active
GO

/* El valor predeterminado sera activo al registrar clothes */
ALTER TABLE clothes
	ADD active bit DEFAULT (1)
GO

/* Crear tabla sale */
CREATE TABLE sale (
    id int,
    date_time datetime,
	seller_id int ,
    client_id int,
	active bit,
    CONSTRAINT sale_pk PRIMARY KEY (id)
);

/* Quitar Primary Key en tabla sale */
ALTER TABLE sale
	DROP CONSTRAINT sale_pk
GO

/* Quitar columna id en tabla sale */
ALTER TABLE sale
	DROP COLUMN id
GO

/* Agregar columna sale */
ALTER TABLE sale
	ADD id int identity(1,1)
GO

/* Restricción primary key */
ALTER TABLE sale
	ADD CONSTRAINT sale_pk 
	PRIMARY KEY (id)
GO

/* Eliminar columna sale de tabla sale */
ALTER TABLE sale
	DROP COLUMN date_time
GO

/* Crear columna sale */
ALTER TABLE sale
	ADD date_time datetime
GO

/* Poner como default debe tener como valor predeterminado la fecha y hora del servidor */
ALTER TABLE sale
    ADD CONSTRAINT date_time_sale DEFAULT (GETDATE()) FOR date_time
GO

/* Eliminar columna active de tabla sale */
ALTER TABLE sale
	DROP COLUMN active
GO

/* El valor predeterminado sera activo al registrar sale */
ALTER TABLE sale
	ADD active bit DEFAULT (1)
GO

/* Crear tabla sale_detail */
CREATE TABLE sale_detail (
    id int,
    sale_id int,
    clothes_id int,
	amount int,
    CONSTRAINT sale_detail_pk PRIMARY KEY (id)
);

/* Relacionar tabla sale con seller */
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
GO

/* Relacionar tabla sale con sale_detail */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale_detail con clothes */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Crear o insertar registros client*/
INSERT INTO client 
    (type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
    ('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
    ('DNI', '14782536', 'Marcos', 'D�vila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
    ('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
    ('CNE', '352514789', 'Claudia Mar�a', 'Mart�nez Rodr�guez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
    ('CNE', '142536792', 'Mario Tadeo', 'Farf�n Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
    ('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992'),
    ('DNI', '15223369', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@yahoo.com', '977112234', '27/05/1990'),
    ('CNE', '442233698', 'Rosario', 'Prada Vel�squez', 'rosarioprada@outlook.com', '971144782', '05/11/1990')
GO

/* Listar registros de tabla client */
SELECT * FROM client

/* Crear o insertar registros seller*/
INSERT INTO seller
    (type_document, number_document, names, last_name, cell_phone, email)
VALUES
    ('DNI', '11224578', 'Oscar', 'Paredes Flores', '985566251', 'oparedes@miemrpesa.com'),
    ('CNE', '889922365', 'Azucena', 'Valle Alcazar', '966338874', 'avalle@miemrpesa.com'),
    ('DNI', '44771123', 'Rosario', 'Huarca Tarazona', '933665521', 'rhuaraca@miempresa.com')
GO

/* Listar registros de tabla seller */
SELECT * FROM seller

/* Crear o insertar registros  clothes*/
INSERT INTO  clothes
    (descriptions, brand, amount, size, price)
VALUES
    ('Polo camisero', 'Adidas', '20', 'Medium', '40.50'),
    ('Short playero', 'Nike', '30', 'Medium', '55.50'),
    ('Camisa sport', 'Adams', '60', 'Large', '60.80'),
    ('Camisa sport', 'Adams', '70', 'Medium', '58.75'),
    ('buzo de verano', 'Reebok', '45', 'Small', '62.90'),
    ('Pantal�n Jean', 'Lewis', '35', 'Large', '73.60')
GO

/* Listar registros de tabla clothes */
SELECT * FROM clothes

/* Listar tipo de documento DNI de client */
SELECT *
FROM client
WHERE type_document like'DNI'
GO

/* Listar cuyo servidor de correo electronico sea outlook.com */
SELECT *
FROM client
WHERE email like '%@outlook.com'
GO

/* Listar tipo de documento DNI de client */
SELECT *
FROM seller
WHERE type_document LIKE 'CNE'
GO

/*Listar todas las prendas de ropa clothes  cuyo costo sea menor e igual que S/. 55.00 */
SELECT *
FROM clothes
WHERE price <= 55.00
GO

/* Listar todas las prendas de ropa clothes cuya marca sea Adams */
SELECT *
FROM clothes
WHERE brand LIKE 'Adams'
GO

/*Eliminar logicamente los datos de un cliente (client) de acuerdo a un determinado id*/

UPDATE client
SET active = '0' 
WHERE id = '6'
GO

/*Eliminar logicamente los datos de un cliente (seller) de acuerdo a un determinado id*/

UPDATE seller
SET active = '0' 
WHERE id = '2'
GO

/*Eliminar logicamente los datos de un cliente (clothes) de acuerdo a un determinado id*/

UPDATE clothes
SET active = '0' 
WHERE id = '5'
GO