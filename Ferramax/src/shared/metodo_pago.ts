import { Entity, Fields } from "remult";

@Entity('metodo_pago', { allowApiCrud: true })
export class MetodoPago {
    @Fields.autoIncrement()
    id_metodo = 0;
    @Fields.string()
    nombre_metodopago = '';
}