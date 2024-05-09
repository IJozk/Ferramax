// src/server/api.ts

import { remultExpress } from 'remult/remult-express'
import { Client } from '../shared/Client'
import { Employee } from '../shared/Employee'
import { Product } from '../shared/Product'
import { ProductsController } from '../shared/ProductsController'
import { createPostgresDataProvider } from 'remult/postgres'

export const api = remultExpress({
    entities: [Client, Employee, Product],
    admin: true,
    controllers: [ProductsController],
    getUser: req => req.session!["user"],
    dataProvider: createPostgresDataProvider({
        connectionString: ""
    })
})
