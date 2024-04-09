create database DBCrud
go

use DBCrud

go

create table Departamento(
IdDepartamento int primary key identity,
Nombre varchar(50)
)

create table Empleado(
IdEmpleado  int primary key identity,
NombreCompleto varchar(50),
IdDepartamento int references Departamento(IdDepartamento),
Sueldo decimal(10,2),
FechaContrato date
)



insert into Departamento(Nombre) values
('Administracion'),
('Marketing')

insert into Empleado(NombreCompleto,IdDepartamento,Sueldo,FechaContrato)
values
('Maria Mendez',1,4500,'2024-01-12')

select * from Departamento
select * from Empleado


create procedure sp_listaEmpleados
as
begin
	select
	e.IdEmpleado,
	e.NombreCompleto,
	e.Sueldo,
	convert(char(10),e.FechaContrato,103)[FechaContrato],

	d.IdDepartamento,
	d.Nombre
	from Empleado e
	inner join Departamento d on e.IdDepartamento = d.IdDepartamento
end

create procedure sp_crearEmpleado
(
@NombreCompleto varchar(50),
@IdDepartamento int,
@Sueldo decimal(10,2),
@FechaContrato varchar(10)
)
as
begin
	set dateformat dmy

	insert into Empleado(
	NombreCompleto,
	IdDepartamento,
	Sueldo,
	FechaContrato
	)
	values
	(
	@NombreCompleto,
	@IdDepartamento,
	@Sueldo,
	convert(date,@FechaContrato)
	)

end



create procedure sp_editarEmpleado
(
@IdEmpleado int,
@NombreCompleto varchar(50),
@IdDepartamento int,
@Sueldo decimal(10,2),
@FechaContrato varchar(10)
)
as
begin
	set dateformat dmy

	Update Empleado
	set 
	NombreCompleto = @NombreCompleto,
	IdDepartamento = @IdDepartamento,
	Sueldo = @Sueldo,
	FechaContrato = convert(date,@FechaContrato)
	where IdEmpleado = @IdEmpleado
end



create procedure sp_eliminarEmpleado
(
@IdEmpleado int
)
as
begin
	
	delete from Empleado where IdEmpleado = @IdEmpleado
end


