import { Entity, Fields, Validators } from "remult";

@Entity("employees", { allowApiCrud: true })
export class Employee {
    @Fields.autoIncrement()
    id = 0;

    @Fields.string({
        validate: Validators.required
    })
    name = "";

    @Fields.string({
        validate: (employee) => {
            if (employee.prod_name.length < 3) throw "Nombre demasiado corto"
        },
        allowApiUpdate: "admin",
    })
    last_name = "";

    @Fields.string({
        validate: (employee) => {
            if (employee.prod_name.length < 3) throw "Nombre demasiado corto"
        },
        allowApiUpdate: "admin",
    })
    mail = "";
    
    @Fields.date()
    birthday = new Date();
}