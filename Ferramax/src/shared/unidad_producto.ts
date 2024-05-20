import { Entity, Fields } from "remult";

@Entity('unidad_producto', { allowApiCrud: true })
export class UnidadProducto {
    @Fields.autoIncrement()
    cod_unidad = 0;
    @Fields.date()
    fecha_ingreso = new Date();
    @Fields.number()
    id_estado = 0;
    @Fields.number()
    cod_producto = 0;
}