USE empresaDeTurismoDB ;

INSERT INTO EstadoVenta(nombre,descripcion) 
VALUES ("Reservado","Se tiene una reservacion se pago %10 del valor del producto"),
       ("Perdido","El paquete se perdio por no cancelar oportunamente"),
       ("Cancelado","Se encuentra cancelada total o parcialmente la venta");

INSERT INTO Medio(nombre)
VALUES ("Telefonico"),("Internet"),("Presencial");

INSERT INTO TipoPuesto(nombre)
VALUES ("Vendedor"),("Secretaria"),("Gerente"),("Conserje");

INSERT INTO Puesto(idTipoPuesto,hrsLaborarxDia,PorcentajeComision,salario)
values ((select idTipoPuesto from TipoPuesto where TipoPuesto.nombre = "Vendedor"),8,10,800),
       ((select idTipoPuesto from TipoPuesto where TipoPuesto.nombre = "Secretaria"),8,8,800),
	   ((select idTipoPuesto from TipoPuesto where TipoPuesto.nombre = "Gerente"),6,7,5000),
	   ((select idTipoPuesto from TipoPuesto where TipoPuesto.nombre = "Conserje"),8,5,700);

INSERT INTO TipoTransporte(nombre)
VALUES("Avion"),("Automovil"),("Caballo"),("Barco"),("Tren"),("Bicicleta"),("Motocicleta");

INSERT INTO Empresa(nombre) values("Destinos TV");
/*
LOAD DATA local INFILE 'C:\\Proyecto1Bases\\empresas.txt' INTO TABLE Empresa
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idEmpresa, nombre);
*/

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\puestos.txt' INTO TABLE TipoPuesto
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idTipoPuesto, nombre);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\telefonos.txt' INTO TABLE Telefono
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idTelefono, numero);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\direccionesCorreoElectronico.txt' INTO TABLE CorreoElectronico
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idCorreoElectronico, dirCorreo);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\alergias.txt' INTO TABLE Alergia
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idAlergia, nombre, descripcion);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\paises.txt' INTO TABLE Pais
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idPais, nombre);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\estados.txt' INTO TABLE Estado
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idEstado, idPais, nombre);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\ciudades.txt' INTO TABLE Ciudad
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idCiudad,idEstado,nombre);


DROP TEMPORARY TABLE IF EXISTS ListaNombres;

CREATE TEMPORARY TABLE ListaNombres(
idListaNombres int primary key not null AUTO_INCREMENT,
nombre VARCHAR(50)
);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\nombresPersonas.txt' INTO TABLE ListaNombres
FIELDS TERMINATED BY '	' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idListaNombres,nombre);

DROP TEMPORARY TABLE IF EXISTS ListaEmpresas;

CREATE TEMPORARY TABLE ListaEmpresas(
idListaEmpresas int primary key not null AUTO_INCREMENT,
nombre VARCHAR(50)
);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\empresasGrande.txt' INTO TABLE ListaEmpresas
FIELDS TERMINATED BY '	' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idListaEmpresas,nombre);

DROP TEMPORARY TABLE IF EXISTS ListaPasaportes;

CREATE TEMPORARY TABLE ListaPasaportes(
idListaPasaportes int primary key not null auto_increment,
numero VARCHAR(50)
);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\pasaportes.txt' INTO TABLE ListaPasaportes
FIELDS TERMINATED BY '	' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idListaPasaportes,numero);

DROP TEMPORARY TABLE IF EXISTS ListaDescripciones;

CREATE TEMPORARY TABLE ListaDescripciones(
idListaDescripciones int primary key not null auto_increment,
descripcion VARCHAR(100)
);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\descripciones.txt' INTO TABLE ListaDescripciones
FIELDS TERMINATED BY '	' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idListaDescripciones,descripcion);

DROP TEMPORARY TABLE IF EXISTS ListaLugares;

CREATE TEMPORARY TABLE ListaLugares(
idListaLugares int primary key not null auto_increment,
nombre VARCHAR(100)
);

LOAD DATA local INFILE 'C:\\Proyecto1Bases\\lugares.txt' INTO TABLE ListaLugares
FIELDS TERMINATED BY '	' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idListaLugares,nombre);


CALL SP_INSERTAR_DIRECCIONES(10);
CALL SP_INSERTAR_PUESTOS(10);
CALL SP_INSERTAR_SUCURSALES(10);
#CALL SP_INSERTAR_PLANILLAS(10);
CALL SP_INSERTAR_EMPLEADOS(10);
CALL SP_INSERTAR_CLIENTES(10);
CALL SP_INSERTAR_HOTELES(10);
CALL SP_INSERTAR_LUGARES(10);
CALL SP_INSERTAR_TRANSPORTES(10);
CALL SP_INSERTAR_PAQUETES(10);

DROP TEMPORARY TABLE ListaNombres;
DROP TEMPORARY TABLE ListaEmpresas;
DROP TEMPORARY TABLE ListaPasaportes;
DROP TEMPORARY TABLE ListaDescripciones;
DROP TEMPORARY TABLE ListaLugares;
