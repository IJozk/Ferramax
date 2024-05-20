import { Entity, Fields } from "remult";

@Entity('tipo_empleado', { allowApiCrud: true })
export class TipoEmpleado {
    @Fields.autoIncrement()
    id_tipo_empleado = 0;
    @Fields.string()
    nombre_tipoempleado = '';
    @Fields.string()
    descripcion_tipoempleado = '';
    @Fields.number()
    id_categoria = 0;
}
