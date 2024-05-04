import { Entity, Fields } from "remult";

@Entity('products',{ allowApiCrud: true })
export class Product {
    @Fields.autoIncrement()
    id = 0;
    @Fields.string()
    prod_name = '';
    @Fields.integer()
    current_price = 0;
    @Fields.createdAt()
    createdAt?: Date
}

