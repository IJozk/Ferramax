import { Entity, Fields } from "remult";


@Entity('stock_tienda', { allowApiCrud: true })
export class StockTienda {
    @Fields.number()
    stock_prod = 0;
    @Fields.number()
    descuento_tienda = 0;
    @Fields.number()
    id_sucursal = 0;
    @Fields.number()
    cod_producto = 0;
}