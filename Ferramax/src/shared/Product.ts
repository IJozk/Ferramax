import { Entity, Fields, Allow } from "remult";

@Entity("products", { allowApiCrud: true})
export class Product {

    @Fields.autoIncrement()
    id = 0;

    @Fields.string<Product>({
        validate: (product) => {
            if (product.prod_name.length < 3) throw "Nombre demasiado corto"
        },
    })
    prod_name = "";

    @Fields.integer()
    current_price = 0;
    
    @Fields.createdAt()
    createdAt?: Date
}
