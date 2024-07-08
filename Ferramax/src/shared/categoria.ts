import { Entity, Fields } from "remult";

@Entity('categoria', { allowApiCrud: true })
export class Categoria {
    @Fields.autoIncrement()
    id_categoria = 0;
    @Fields.string()
    nombre_categoria = '';
}