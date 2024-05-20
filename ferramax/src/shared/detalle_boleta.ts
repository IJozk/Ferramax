import { Entity, Fields } from "remult";

@Entity('detalle_boleta', { allowApiCrud: true })
export class DetalleBoleta {
    @Fields.autoIncrement()
    id = 0; // Adding an id field as primary key
    @Fields.number()
    cantidad = 0;
    @Fields.number()
    subvalor = 0;
    @Fields.number()
    id_boleta = 0;
    @Fields.number()
    cod_producto = 0;
}