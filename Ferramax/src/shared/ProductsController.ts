import { BackendMethod, remult, Allow } from "remult";
import { Product } from "./Product";

export class ProductsController {
    @BackendMethod({ allowed: Allow.authenticated })
    static async setTo2000(current_price: number){
        const productRepo = remult.repo(Product)

        for (const product of await productRepo.find()) {
            await productRepo.save({ ...product, current_price })
        }
    }
}