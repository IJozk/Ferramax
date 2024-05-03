import { Product } from '../shared/product'
import { Client } from '../shared/client'
import { Empleados } from '../shared/empleado'
import {remultExpress} from 'remult/remult-express'
export const api = remultExpress({
    entities: [Product, Client, Empleados], // adding entities to app
    admin: true, // Enable the Admin UI
})