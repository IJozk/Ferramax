import { Product } from '../shared/product'
import { Client } from '../shared/client'
import {remultExpress} from 'remult/remult-express'
export const api = remultExpress({
    entities: [Product, Client], // Add entities to app
    admin: true, // Enable the Admin UI
})