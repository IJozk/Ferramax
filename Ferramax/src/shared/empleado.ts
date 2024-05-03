import { Entity, Fields } from "remult";

@Entity("empleados", { allowApiCrud: true })
export class Empleados {
    @Fields.autoIncrement()
    id = 0;
    @Fields.string()
    name = "";
    @Fields.date()
    fechanacimiento = new Date();
}