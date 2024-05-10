import { Product } from '../shared/product'
import { Client } from '../shared/client'
import { remultExpress } from 'remult/remult-express'
import { createKnexDataProvider } from 'remult/remult-knex';
import dotenv from 'dotenv';

dotenv.config();

const DATABASE_URL = process.env["DATABASE_URL"];
const DB_NAME = process.env["DB_NAME"];
const DB_USER = process.env["DB_USER"];
const DB_PASSWD = process.env["DB_PASSWD"];
const DB_PORT = process.env["DB_PORT"];

export const api = remultExpress({
    dataProvider: await createKnexDataProvider({
        // Knex client configuration for Postgres
        client: "pg",
        connection: {
            host: String(DATABASE_URL),
            port: Number(DB_PORT),
            user: String(DB_USER),
            database: String(DB_NAME),
            password: String(DB_PASSWD),
            ssl: {
                rejectUnauthorized: false // Indica a Knex que acepte certificados no verificados
              }
          }
      }),
    entities: [Product, Client], // Add entities to app
    admin: true, // Enable the Admin UI
})


