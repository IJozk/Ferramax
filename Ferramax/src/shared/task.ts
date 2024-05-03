import { Entity, Fields } from "remult";

@Entity("products", { allowApiCrud: true })
export class Product {
    @Fields.autoIncrement()
    id = 0;
    @Fields.string()
    title = "";
    @Fields.boolean()
    completed = false;
    @Fields.createdAt()
    createdAt?: Date
}


@Entity("clients", { allowApiCrud: true })
export class Client {
    @Fields.autoIncrement()
    id = 0;
    @Fields.string()
    title = "";
    @Fields.boolean()
    completed = false;
    @Fields.createdAt()
    createdAt?: Date
}