CREATE PROCEDURE `SP_obtener_MejoresVendedoresxSucursal`(IN pNombreSucursal VARCHAR(50))
BEGIN

  DECLARE vIdEmpleado INT;
  DECLARE vNombre VARCHAR(50);
  DECLARE vCantVentas INT;
  
-- Variable para controlar el fin del bucle
  DECLARE fin INTEGER DEFAULT 0;
 
-- El SELECT que vamos a ejecutar
  DECLARE empleados_cursor CURSOR FOR 
    SELECT Empleado.idEmpleado,Empleado.nombre FROM Empleado inner join Sucursal 
    on Empleado.idSucursal = Sucursal.idSucursal where Sucursal.nombre = pNombreSucursal;

-- Condición de salida
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

DROP TEMPORARY TABLE IF EXISTS EmpleadoVentas;

CREATE TEMPORARY TABLE EmpleadoVentas(
idEmpleado int primary key not null auto_increment,
nombre Varchar(50) not null,
cantVentas int not null
);

  OPEN empleados_cursor;
  get_empleados: LOOP
    FETCH empleados_cursor INTO vIdEmpleado,vNombre;
    IF fin = 1 THEN
       LEAVE get_empleados;
    END IF;

SET vCantVentas = (Select count(Venta.idEmpleado) from Empleado inner join Venta on
  Empleado.idEmpleado = Venta.idEmpleado where Empleado.idEmpleado = vIdEmpleado);
  INSERT INTO EmpleadoVentas (idEmpleado,nombre,cantVentas) 
  values (vIdEmpleado,vNombre,vCantVentas);
# INSERT INTO ComisionxVenta(idEmpleado,idVenta,monto,fecha) 
# values (vIdEmpleado,vIdVenta,((vMontoTotal/100)*vPorcentajeComision),curdate());
 
  END LOOP get_empleados;

  CLOSE empleados_cursor;

Select * from EmpleadoVentas order by cantVentas DESC;

DROP TEMPORARY TABLE IF EXISTS EmpleadoVentas;

END
