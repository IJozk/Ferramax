import { Entity, Fields } from "remult";

@Entity("employees", { allowApiCrud: true })
export class Employee {
    @Fields.autoIncrement()
    id = 0;

    @Fields.string()
    name = "";
    
    @Fields.date()
    birthday = new Date();
}