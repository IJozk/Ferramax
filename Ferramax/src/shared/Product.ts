import { Entity, Fields } from "remult";

@Entity('productos',{ allowApiCrud: true })
export class Product {
    @Fields.autoIncrement()
    cod_producto = 0;
    @Fields.string()
    nombre_producto = '';
    @Fields.number()
    precio_actual = 0;
    @Fields.string()
    descripcion_actual = '';
    @Fields.number()
    id_categoria = 0;
    @Fields.string()
    marca = '';
}