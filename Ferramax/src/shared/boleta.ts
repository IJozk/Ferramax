import { Entity, Fields } from "remult";

@Entity('boleta', { allowApiCrud: true })
export class Boleta {
    @Fields.autoIncrement()
    id_boleta = 0;
    @Fields.number()
    valor_total = 0;
    @Fields.date()
    fecha_emision = new Date();
    @Fields.string()
    documento_vinculado = '';
    @Fields.number()
    id_pedido = 0;
}