import { Product, Client } from '../shared/task'
import {remultExpress} from 'remult/remult-express'
export const api = remultExpress({
    entities: [Product, Client],
})