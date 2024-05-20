import { Entity, Fields } from "remult";

@Entity('empleado', { allowApiCrud: true })
export class Empleado {
    @Fields.string()
    rut_empleado = '';
    @Fields.string()
    dv = '';
    @Fields.string()
    direccion = '';
    @Fields.string()
    nombre = '';
    @Fields.string()
    apellido = '';
    @Fields.date()
    fecha_nacimiento = new Date();
    @Fields.date()
    fecha_incorporacion = new Date();
    @Fields.number()
    id_tipo_empleado = 0;
}