import { Entity, Fields } from "remult";

@Entity('estado_unidad', { allowApiCrud: true })
export class EstadoUnidad {
    @Fields.autoIncrement()
    id_estado = 0;
    @Fields.string()
    estado = '';
}