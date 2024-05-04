// src/server/api.ts

import { remultExpress } from 'remult/remult-express'
import { Client } from '../shared/Client'
import { Employee } from '../shared/Employee'
import { Product } from '../shared/Product'

export const api = remultExpress({
    entities: [Client, Employee, Product],
    admin: true,
})