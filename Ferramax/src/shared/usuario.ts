import { Entity, Fields } from "remult";

@Entity('usuario', { allowApiCrud: true })
export class Usuario {
    @Fields.autoIncrement()
    id_usuario = 0;
    @Fields.string()
    correo = '';
    @Fields.string()
    clave = '';
    @Fields.string()
    api_key = '';
    @Fields.number()
    id_rol = 0;
}