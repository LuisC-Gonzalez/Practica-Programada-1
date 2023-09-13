--CREACION DE LA BASE DE DATOS--
CREATE DATABASE PP1
GO

USE PP1;

--INICIO DE LA CREACION DE LAS TABLAS--
--Las tablas vienen en orden para; la categoria de los productos, la subcategoria de los productos, territorios en los que se localizan los proveedores, 
--informacion sobre los proveedores, informacion de los productos, informacion de los clientes y la informacion de las facturas.-- 

--Las tablas se crearon de forma que algunas de las entradas futuras tengan que cumplir con determinadas restricciones
--si el atributo tiene una instruccion NOT NULL el valor de la entrada no puede quedar vacio al llenarlo
--si el atributo tiene una instruccion IDENTITY entonces la entrada se va a llenar automaticamente empezando en 1 y aumentando 1 por cada entrada nueva 
--si el atributo tiene una instruccion PRIMARY KEY esto indica que las entradas son indicadores unicos de esa tabla
--si el atributo tiene una instruccion FOREIGN KEY la entrada se utiliza para establecer relaciones entre tablas

CREATE TABLE Categoria (
  NOMBRE_CATEGORIA VARCHAR(20) NOT NULL UNIQUE,
  ID_CATEGORIA VARCHAR(20) NOT NULL PRIMARY KEY
)

CREATE TABLE Subcategorias ( 
  ID_SUBCATEGORIA INT NOT NULL PRIMARY KEY,
  NOMBRE_SUBCATEGORIA VARCHAR(25) NOT NULL, 
  COD_CATEGORIA VARCHAR(20) NOT NULL,
  FOREIGN KEY (COD_CATEGORIA) REFERENCES Categoria (ID_CATEGORIA)
)

--Para la creacion de la tabla territorio se va a obligar a los proveedores a brindar una unica ubicacion. 
--Se sabe que si se quiere darle la opcion a los proveedores de tener mas de una unica ubicacion entonces se necesitaria de una tabla intermedia
--que conecte los territorios con los proveedores y asi tener la relacion de muchos a muchos.
CREATE TABLE Territorio (  
  PROVINCIA VARCHAR(15) NOT NULL,
  CANTON VARCHAR(15) NOT NULL, 
  DISTRITO VARCHAR (25) NOT NULL, 
  ID_TERRITORIO INT PRIMARY KEY
)

CREATE TABLE Proveedor (
  CEDULA BIGINT NOT NULL PRIMARY KEY, 
  TIPO_CEDULA VARCHAR(15),
  NOMBRE VARCHAR(25) NOT NULL, 
  TELEFONO VARCHAR(15), 
  EMAIL VARCHAR(100),
  UBICACION INT, 
  FOREIGN KEY (UBICACION) REFERENCES Territorio (ID_TERRITORIO)
)

CREATE TABLE Producto (
  ID_INTERNO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  ID_UNIVERSAL INT NOT NULL,
  TAM VARCHAR(10) NOT NULL,
  NOMBRE_PRODUCTO VARCHAR(25) NOT NULL,
  PRECIO DECIMAL(10,2) NOT NULL,
  COLOR VARCHAR(10) NOT NULL,
  PROVEEDOR BIGINT,
  SUBCATEGORIA INT NOT NULL,
  FOREIGN KEY (SUBCATEGORIA) REFERENCES Subcategorias (ID_SUBCATEGORIA),
  FOREIGN KEY (PROVEEDOR) REFERENCES Proveedor (CEDULA)
)

CREATE TABLE Cliente(
  CEDULA BIGINT NOT NULL PRIMARY KEY,
  TIPO_CEDULA VARCHAR(15),
  NOMBRE VARCHAR(40) NOT NULL, 
  DIRECCION VARCHAR(50) NOT NULL,
  EMAIL VARCHAR(100) ,
  TELEFONO VARCHAR(15) NOT NULL
)

CREATE TABLE Factura(
  NUM_FACTURA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  FECHA DATE NOT NULL,
  PRECIO DECIMAL(10,2) NOT NULL,
  DESCUENTO VARCHAR(15),
  IMPUESTOS VARCHAR(15) NOT NULL,
  COSTO_FINAL DECIMAL(10,2) NOT NULL,
  CLIENTE BIGINT,
  FOREIGN KEY (CLIENTE) REFERENCES Cliente(CEDULA)
  
)

CREATE TABLE ProductoXFactura ( 
  ID_PROD INT NOT NULL,
  ID_FACTURA INT NOT NULL,
  CANTIDAD_PROD SMALLINT NOT NULL,
  ID_PxF  SMALLINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  FOREIGN KEY (ID_PROD) REFERENCES Producto (ID_INTERNO),
  FOREIGN KEY (ID_FACTURA) REFERENCES Factura (NUM_FACTURA)

)


--FIN DE LA CREACION DE LAS TABLAS--



--INICIO DEL LLENADO DE LAS TABLAS--
--El "negocio" de ejemplo va a centrarse en vender camisetas estampadas, de ahi las categorias y subcategorias de los productos

INSERT INTO Categoria (NOMBRE_CATEGORIA, ID_CATEGORIA)
VALUES
('Ropa casual', 1),
('Ropa deportiva', 2),
('Ropa de fiesta', 3),
('Ropa de trabajo', 4),
('Ropa de verano', 5);


INSERT INTO Subcategorias (ID_SUBCATEGORIA, NOMBRE_SUBCATEGORIA, COD_CATEGORIA)
VALUES
(11, 'Manga corta', 1),
(12, 'Manga corta', 2),
(13, 'Manga corta', 3),
(14, 'Manga corta', 4),
(15, 'Manga corta', 5),
(21,'Manga larga', 1),
(22,'Manga larga', 2),
(23,'Manga larga', 3),
(24,'Manga larga', 4),
(25,'Manga larga', 5),
(31, 'Sin mangas', 1),
(32, 'Sin mangas', 2),
(33, 'Sin mangas', 3),
(34, 'Sin mangas', 4),
(35, 'Sin mangas', 5),
(41, 'Cuello redondo', 1),
(42, 'Cuello redondo', 2),
(43, 'Cuello redondo', 3),
(44, 'Cuello redondo', 4),
(45, 'Cuello redondo', 5),
(51, 'Cuello en V', 1),
(52, 'Cuello en V', 2),
(53, 'Cuello en V', 3),
(54, 'Cuello en V', 4),
(55, 'Cuello en V', 5);


INSERT INTO Territorio (PROVINCIA, CANTON, DISTRITO, ID_TERRITORIO)
VALUES
('SAN JOSE','MORAVIA','SAN JERONIMO', 111),
('ALAJUELA','SAN RAMON','SAN ISIDRO', 221),
('HEREDIA','FLORES','SAN JOAQUIN', 431),
('HEREDIA','SAN PABLO','RINCON DE SABANILLA', 441),
('SAN JOSE','MONTES DE OCA','MERCEDES', 121),
('LIMON', 'SIQUIRRES', 'FLORIDA', 714),
('LIMON', 'GUACIMO', 'GUACIMO', 726), 
('PUNTARENAS', 'ESPARZA', 'SAN RAFAEL', 619),
('PUNTARENAS', 'BUENOS AIRES', 'COLINAS', 627),
('ALAJUELA', 'SAN MATEO', 'SAN MATEO', 236),
('GUANACASTE', 'LIBERIA', 'LIBERIA', 501),
('GUANACASTE', 'TILARAN', 'TILARAN', 539),
('SAN JOSE', 'SANTA ANA', 'URUCA', 164),
('CARTAGO', 'LA UNION', 'SAN DIEGO', 318);


INSERT INTO Proveedor (CEDULA, TIPO_CEDULA, NOMBRE, TELEFONO, EMAIL, UBICACION)
VALUES
(3789456123,'JURIDICA','UNIQLO','2280-8082','emailprovedor1@gmail.com',111),
(3123456789,'JURIDICA','banana republic', '1515-1512','emailprovedor2@gmail.com',221),
(3159482613,'JURIDICA','HyM', '4978-1111','emailprovedor3@gmail.com',627),
(119734652,'FISICA','GILDAN', '1178-9428','emailprovedor4@gmail.com',431),
(120304050,'FISICA','GAP', '2512-4897','emailprovedor5@gmail.com',714);


INSERT INTO Producto (ID_UNIVERSAL, TAM, NOMBRE_PRODUCTO, PRECIO, COLOR, PROVEEDOR, SUBCATEGORIA)
VALUES
(1001, 'S', 'prod 1',19.99, 'rojo',3789456123,11),
(1002, 'S', 'prod 2',13.99, 'azul',3123456789,13),
(1003, 'M', 'prod 3',9.99, 'amarillo',3159482613,21),
(1004, 'M', 'prod 4',12.99, 'rojo',3159482613,23),
(1005, 'L', 'prod 5',19.49, 'verde',3123456789,31),
(1006, 'L', 'prod 6',5.99, 'purpura',3789456123,33),
(1007, 'XL', 'prod 7',10.00, 'azul',119734652,41),
(1008, 'XL', 'prod 8',11.99, 'verde',3789456123,44),
(1009, 'S oversize', 'prod 9',25.49, 'negro',120304050,51),
(1000, 'M oversize', 'prod 10',10.99, 'gris',119734652,52);


INSERT INTO Cliente (CEDULA, TIPO_CEDULA, NOMBRE, DIRECCION, EMAIL, TELEFONO)
VALUES
(123456789,'FISICA','C1','aqui','emailcliente1@gmail.com','0015-4862'),
(134567891,'FISICA','C2','alla','emailcliente2@gmail.com','0879-4620'),
(145678912,'FISICA','C3','ahi','emailcliente3@gmail.com','0123-8080'),
(156789123,'FISICA','C4','aqui otra vez','emailcliente4@gmail.com','0809-0705'),
(167891234,'FISICA','C5','por alla','emailcliente5@gmail.com','1020-3040'),
(178912345,'FISICA','C6','lejos','emailcliente6@gmail.com','0897-5050'),
(189123456,'FISICA','C7','cerca','emailcliente7@gmail.com','4080-4500'),
(191234567,'FISICA','C8','muy lejos','emailcliente8@gmail.com','7070-8080'),
(212345678,'FISICA','C9','demasiado lejos','emailcliente9@gmail.com','2520-2025'),
(223456789,'FISICA','C10','todavia mas lejos','emailcliente10@gmail.com','9090-9060'),
(234567891,'FISICA','C11','alla de nuevo','emailcliente11@gmail.com','3692-5814'),
(245678912,'FISICA','C12','far far away','emailcliente12@gmail.com','7418-5296');


INSERT INTO Factura (FECHA, PRECIO, DESCUENTO, IMPUESTOS, COSTO_FINAL, CLIENTE)
VALUES

('2020-06-14',29.98,'Sin Descuento','5%',31.48,123456789),
('2021-01-29',32.48, 'Sin Descuento', '6%',34.43,189123456),
('2021-12-10',31.98, '10%', '6%',30.70,234567891),
('2022-06-15',31.97, '10%', '10%',31.97,167891234),
('2023-04-11',21.98, 'Sin Descuento', '10%',24.18,189123456);

INSERT INTO ProductoXFactura (ID_PROD, ID_FACTURA, CANTIDAD_PROD)
VALUES
(1, 1, 1), 
(3, 1, 1),
(4, 2, 1),
(5, 2, 1), 
(10, 3, 2), 
(7, 3, 1), 
(6, 4, 1),
(2, 4, 1), 
(8, 4, 1), 
(8, 5, 1), 
(3, 5, 1);


--FIN DEL LLENADO DE LAS TABLAS