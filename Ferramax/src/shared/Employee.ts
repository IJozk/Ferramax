import { Entity, Fields, Validators } from "remult";

@Entity("employees", { allowApiCrud: true })
export class Employee {
    @Fields.autoIncrement()
    id = 0;

    @Fields.string({
        validate: Validators.required
    })
    name = "";
    
    @Fields.date()
    birthday = new Date();
}