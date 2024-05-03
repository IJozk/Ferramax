import { Entity, Fields } from "remult";

@Entity("clients", { allowApiCrud: true })
export class Client {
    @Fields.autoIncrement()
    id = 0;
    @Fields.string()
    name = "";
    @Fields.string()
    mail = "";
    @Fields.createdAt()
    createdAt?: Date
}