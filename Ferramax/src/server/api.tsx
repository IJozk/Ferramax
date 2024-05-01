import { Task } from '@/shared/task'
import {remultExpress} from 'remult/remult-express'
export const api = remultExpress({
    entities: [Task],
})