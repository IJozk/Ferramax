import { Entity, Fields } from "remult";

@Entity('rol', { allowApiCrud: true })
export class Rol {
    @Fields.autoIncrement()
    id_rol = 0;
    @Fields.string()
    nombre_rol = '';
    @Fields.string()
    desc_rol = '';
}