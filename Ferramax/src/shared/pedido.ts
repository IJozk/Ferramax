import { Entity, Fields } from "remult";

@Entity('pedido', { allowApiCrud: true })
export class Pedido {
    @Fields.autoIncrement()
    id_pedido = 0;
    @Fields.date()
    fecha_creacion = new Date();
    @Fields.date()
    fecha_entrega = new Date();
    @Fields.string()
    rut_cliente = '';
}