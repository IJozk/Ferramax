import { Entity, Fields } from "remult";

@Entity('producto_asignado_pedido', { allowApiCrud: true })
export class ProductoAsignadoPedido {
    @Fields.autoIncrement()
    id = 0; // Adding an id field as primary key
    @Fields.number()
    precio_prod = 0;
    @Fields.number()
    id_pedido = 0;
    @Fields.number()
    cod_producto = 0;
}