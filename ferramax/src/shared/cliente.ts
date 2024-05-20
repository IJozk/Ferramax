import { Entity, Fields } from "remult";

@Entity('cliente', { allowApiCrud: true })
export class Cliente {
    @Fields.string()
    rut_cliente = '';
    @Fields.string()
    dv = '';
    @Fields.string()
    nombre = '';
    @Fields.string()
    apellido = '';
    @Fields.string()
    direccion = '';
}