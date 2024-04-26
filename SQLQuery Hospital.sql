CREATE DATABASE Meditrak;
GO

USE Meditrak;

DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Departamento;
DROP TABLE IF EXISTS Municipio;
DROP TABLE IF EXISTS Ciudad;
DROP TABLE IF EXISTS Direccion;

DROP TABLE IF EXISTS CentroMedico;
DROP TABLE IF EXISTS Cargo;
DROP TABLE IF EXISTS Especialidad;
DROP TABLE IF EXISTS PersonalMedico;
DROP TABLE IF EXISTS Persona;

DROP TABLE IF EXISTS General;
DROP TABLE IF EXISTS JornadaLAboral;
DROP TABLE IF EXISTS Fechas;

DROP TABLE IF EXISTS InscripcionSAR;
DROP TABLE IF EXISTS EmisorFactura;
DROP TABLE IF EXISTS Caja;
DROP TABLE IF EXISTS Facturas;
DROP TABLE IF EXISTS Pago;
DROP TABLE IF EXISTS FormaPago;
DROP TABLE IF EXISTS DetalleFactura;
DROP TABLE IF EXISTS Expediente;
DROP TABLE IF EXISTS Cirujias;
DROP TABLE IF EXISTS Vacunas;
DROP TABLE IF EXISTS Citas;
DROP TABLE IF EXISTS Examenes;
DROP TABLE IF EXISTS Enfermedades;
DROP TABLE IF EXISTS Tratamientos;
DROP TABLE IF EXISTS Medicamentos;
DROP TABLE IF EXISTS TratamientoMedicamento;
DROP TABLE IF EXISTS Diagnosticos;

CREATE TABLE Usuario (
Id INT PRIMARY KEY IDENTITY(1,1),
Admin BIT,
Usuario VARCHAR(80) UNIQUE NOT NULL,
Contraseña VARCHAR(255) NOT NULL,
UrlImagen VARCHAR(255) NOT NULL,
Nombre VARCHAR(255) NOT NULL,
);

INSERT INTO Usuario (Admin, Usuario, Contraseña, UrlImagen)
VALUES (1, 'Kere', '123456', 'https://storage.googleapis.com/meditrak/DarkGrepher.jpg', 'Kevin Rivera'),
	   (0, 'Jcre', '123456', 'https://storage.googleapis.com/meditrak/DarkGrepher.jpg', 'Julio Rivera');

SELECT * FROM Usuario;

CREATE TABLE Departamento(
Id INT PRIMARY KEY IDENTITY(1,1),
Codigo VARCHAR(80) UNIQUE NOT NULL,
Nombre VARCHAR(80) NOT NULL
);
INSERT INTO Departamento (Codigo, Nombre)
VALUES ('HN01', 'Francisco Morazan');

CREATE TABLE Municipio(
Id INT PRIMARY KEY IDENTITY(1,1),
IdDepartamento INT,
Codigo VARCHAR(80) UNIQUE NOT NULL,
Nombre VARCHAR(80) NOT NULL,
FOREIGN KEY (IdDepartamento) REFERENCES Departamento(Id)
);
INSERT INTO Municipio (IdDepartamento, Codigo, Nombre)
VALUES (1, '01', 'Distrito Central');

CREATE TABLE Ciudad(
Id INT PRIMARY KEY IDENTITY(1,1),
IdMunicipio INT,
Codigo VARCHAR(80) UNIQUE NOT NULL,
Nombre VARCHAR(80) NOT NULL,
FOREIGN KEY (IdMunicipio) REFERENCES Municipio(Id)
);
INSERT INTO Ciudad (IdMunicipio, Codigo, Nombre)
VALUES (1, '01', 'Tegucigalpa'),
	   (1, '02', 'Comayaguela');

SELECT 
    CONCAT(D.Codigo, M.Codigo, C.Codigo) AS Codigo,
    D.Nombre AS Departamento,
    M.Nombre AS Municipio,
    C.Nombre AS Ciudad
FROM 
    Departamento D
JOIN 
    Municipio M ON D.Id = M.IdDepartamento
JOIN 
    Ciudad C ON M.Id = C.IdMunicipio
GROUP BY
    CONCAT(D.Codigo, M.Codigo, C.Codigo),
    D.Nombre,
    M.Nombre,
    C.Nombre;

CREATE TABLE Direccion(
Id INT PRIMARY KEY IDENTITY(1,1),
IdCiudad INT,
Colonia VARCHAR(80),
NumeroCasa INT,
Referencia VARCHAR(255),
FOREIGN KEY (IdCiudad) REFERENCES Ciudad(Id)
);
INSERT INTO Direccion (IdCiudad, Colonia, NumeroCasa, Referencia)
VALUES (1, 'Col. Los Llanos', '4439', 'Frente a cancha.');

SELECT
    CONCAT(D.Codigo, M.Codigo, C.Codigo) AS Codigo,
    D.Nombre AS Departamento,
    M.Nombre AS Municipio,
    C.Nombre AS Ciudad,
	Di.Colonia AS Colonia,
	Di.NumeroCasa AS NumeroCasa,
	Di.Referencia AS Referencia
FROM
    Direccion Di
JOIN 
    Ciudad C ON Di.IdCiudad = C.Id
JOIN 
    Municipio M ON C.IdMunicipio = M.Id
JOIN 
    Departamento D ON M.IdDepartamento = D.Id


CREATE TABLE CentroMedico(
Id INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(80) NOT NULL,
Telefono VARCHAR(80),
Correo VARCHAR(80),
IdDireccion INT,
FOREIGN KEY (IdDireccion) REFERENCES Direccion(Id),
);
INSERT INTO CentroMedico(Nombre, Telefono, Correo, IdDireccion)
VALUES ('Meditrak', '33024439', 'meditrak@meditrak.hn', 1);

CREATE TABLE Cargo(
Id INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(80) UNIQUE NOT NULL,
Descripcion VARCHAR(255)
);
INSERT INTO Cargo(Nombre, Descripcion)
VALUES ('Medico Residente', 'Profesional de la medicina que se encuentra en un programa de residencia para especializarse en una determinada area médica.');

CREATE TABLE Especialidad(
Id INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(60) UNIQUE NOT NULL,
Descripcion VARCHAR(255)
);
INSERT INTO Especialidad(Nombre, Descripcion)
VALUES ('Cardiología', 'Especialidad medica que se encarga del diagnóstico y tratamiento de enfermedades del corazón y del aparato circulatorio.');

CREATE TABLE PersonalMedico(
Id INT PRIMARY KEY IDENTITY(1,1),
IdUsuario int,
FechaRegistro VARCHAR(80),
NumeroColegiado INT,
IdCentroMedico INT,
IdCargo INT,
NumeroConsultorio INT,
IdEspecialidad INT,
FOREIGN KEY (IdCentroMedico) REFERENCES CentroMedico(Id),
FOREIGN KEY (IdCargo) REFERENCES Cargo(Id),
FOREIGN KEY (IdEspecialidad) REFERENCES Especialidad(Id),
FOREIGN KEY (IdUsuario) REFERENCES Usuario(Id)
);

CREATE TABLE Persona(
Id INT PRIMARY KEY IDENTITY(1,1),
Nombre1 VARCHAR(80) NOT NULL,
Nombre2 VARCHAR(80),
Apellido1 VARCHAR(80) NOT NULL,
Apellido2 VARCHAR(80),
Sexo VARCHAR(80),
Dni VARCHAR(80) UNIQUE NOT NULL,
Telefono VARCHAR(80) NOT NULL,
Correo VARCHAR(80) NOT NULL,
UrlImagen VARCHAR(255),
IdDireccion INT,
IdPersonalMedico INT,
FOREIGN KEY (IdDireccion) REFERENCES Direccion(Id)
);



	INSERT INTO Persona (Nombre1, Apellido1, DNI, Telefono, Correo, UrlImagen)
	VALUES ('Juan', NULL, 'Pérez', NULL, NULL, '12345678', '555-1234', 'juan@example.com', 'http://ejemplo.com/imagen.jpg', NULL, NULL);

	SELECT * FROM Persona;
	SELECT * FROM Departamento;
	SELECT * FROM Municipio;
	SELECT * FROM Ciudad;
	SELECT * FROM Direccion;
	SELECT * FROM Cargo;

	SELECT *
FROM Persona AS p
JOIN Direccion AS d ON p.IdDireccion = d.Id
JOIN Ciudad AS c ON d.IdCiudad = c.Id
JOIN Municipio AS m ON c.IdMunicipio = m.Id
JOIN Departamento AS dep ON m.IdDepartamento = dep.Id
WHERE p.Nombre1 = 'ttt' AND p.Apellido1 = 'ttt';


CREATE TABLE General(
Id INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR (60),
Tipo varchar (60),
Descripcion  varchar (80)
);

create table JornadaLAboral(
Id int primary key identity(1,1),
FecharEntrada varchar(60),
FecharSalidaa varchar(60),
HoraEntrada varchar(60),
HoraSalida varchar(60),
Jornada varchar(60)
);

create table Fechas(
Id int primary key identity(1,1),
Fecha varchar(60),
Hora varchar(60)
);


create table InscripcionSAR (
Id INT PRIMARY KEY,
CAI VARCHAR(60),
RangoAutorizadoInicio VARCHAR(60),
RangoAutorizadoActual VARCHAR(60),
RangoAutorizadoFinal VARCHAR(60),
TipoDocumento VARCHAR(60)
);

create table EmisorFactura(
Id int primary key identity(1,1),
IdCentroMedico int,
IdInscripcionSAR int,
NIT varchar(60),
foreign key (IdCentroMedico) references CentroMedico(Id),
foreign key (IdInscripcionSAR) references InscripcionSAR(Id)
);

create table Caja (
Id int primary key identity(1,1),
IdPersonalMedico INT REFERENCES PersonalMedico(Id),
NumCaja INT,
CodigoCaja VARCHAR(60)
);

create table Facturas(
Id int primary key identity(1,1),
IdEmisorFactura int,
IdPersona int,
IdCaja int,
NumFactura int,
fechaEmicion varchar(60),
SubTotal int,
Total int,
foreign key (IdEmisorFactura) references EmisorFactura(Id)
);

create table DetalleFactura (
Id int primary key identity(1,1),
IdFactura int,
Descripcion varchar(100),
Cantidad int,
PrecioUnitario int,
SubTotal int,
foreign key (IdFactura) references Facturas(Id)
);

create table Pago (
Id int primary key identity(1,1),
IdDetalleFactura int,
SaldoPendiente int,
foreign key (IdDetalleFactura) references DetalleFactura(Id)
);

create table FormaPago (
Id int primary key identity(1,1),
IdPago INT,
FormaPago varchar(60),
CodigoPago varchar(60),
FechaPago varchar(60),
CantidadAbonada int,
foreign key (IdPago) references Pago(Id)
);

create table Expediente(
Id int primary key identity(1,1),
IdTipoPersona int,
NumExpediente varchar(60) not null unique,
FechaCreacion varchar(60)
);

create table Cirujias(
Id int primary key identity(1,1),
IdExpediente int,
IdGeneral int,
IdFechas int,
IdPersonalMedico int,
IdCentroMedico int,
IdFacturar int,
Observacion varchar(80),
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdGeneral) references General(Id),
foreign key (IdFechas) references Fechas(Id),
foreign key (IdPersonalMedico) references PersonalMedico(Id),
foreign key (IdCentroMedico) references CentroMedico(Id),
foreign key (IdFacturar) references Facturas(Id)
);

create table Vacunas(
Id int primary key identity(1,1),
IdExpediente int,
IdGeneral int,
FechaAplicacion varchar(60),
LugarAplicacion varchar(60),
NumLote varchar(60),
foreign key (IdGeneral) references General(Id),
foreign key (IdExpediente) references Expediente(Id)
);

create table Citas(
Id int primary key identity(1,1),
IdFechas int,
IdExpediente int,
IdPersonalMedico int,
IdPersona int,
Observaciones varchar(60),
foreign key (IdFechas) references Fechas(Id),
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdPersonalMedico) references PersonalMedico(Id),
foreign key (IdPersona) references Persona(Id)
);

create table Examenes(
Id int primary key identity(1,1),
IdFechas int,
IdCentroMedico int,
IdExpediente int,
IdGeneral int,
IdFacturas int,
IdCitas int,
CodigoExamen varchar(60),
NumeroExamen varchar(60),
Resultado varchar(60),
Observaciones varchar(60),
ImagenDoc VARBINARY(MAX),
Costo varchar(60),
foreign key (IdFechas) references Fechas(Id),
foreign key (IdCentroMedico) references CentroMedico(Id),
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdGeneral) references General(Id),
foreign key (IdFacturas) references Facturas(Id),
foreign key (IdCitas) references Citas(Id)
);

create table Enfermedades(
Id int primary key identity(1,1),
IdGeneral int,
IdExpediente int,
IdExamenes int,
Codigo varchar(60),
Observaciones varchar(60),
foreign key (IdGeneral) references General(Id),
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdExamenes) references Examenes(Id)
);

create table Tratamientos (
Id int primary key identity(1,1),
IdGeneral int,
IdExpediente int,
IdEnfermedades int,
Otros varchar(60),
Notas varchar(60),
foreign key (IdGeneral) references General(Id),
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdEnfermedades) references Enfermedades(Id)
);

create table Medicamentos (
Id int primary key identity(1,1),
IdExpediente int,
IdGeneral int,
IdFacturar int,
FechaInicio varchar(60),
FechaFin varchar(60),
Dosis varchar(60),
Frecuencia varchar(60),
Notas varchar(60)
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdGeneral) references General(Id),
foreign key (IdFacturar) references Facturas(Id)
);

create table TratamientoMedicamento (
Id int primary key identity(1,1),
IdTratamiento int,
IdMedicamento int,
foreign key (IdTratamiento) references Tratamientos(Id),
foreign key (IdMedicamento) references Medicamentos(Id),
);

create table Diagnosticos(
Id int primary key identity(1,1),
IdFechas int,
IdExpediente int,
IdPersonalMedico int,
IdTratamientos int,
IdExamenes int,
Notas text,
Observaciones varchar(60),
foreign key (IdFechas) references Fechas(Id),
foreign key (IdExpediente) references Expediente(Id),
foreign key (IdPersonalMedico) references PersonalMedico(Id),
foreign key (IdTratamientos) references Tratamientos(Id),
foreign key (IdExamenes) references Examenes(Id)
);


