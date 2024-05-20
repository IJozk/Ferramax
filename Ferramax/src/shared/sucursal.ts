import { Entity, Fields } from "remult";

@Entity('sucursal', { allowApiCrud: true })
export class Sucursal {
    @Fields.autoIncrement()
    id_sucursal = 0;
    @Fields.string()
    nombre_sucursal = '';
}