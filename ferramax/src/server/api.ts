
import { Boleta } from '../shared/boleta'
import { Categoria } from '../shared/categoria';
import { Cliente } from '../shared/cliente';
import { DetalleBoleta } from '../shared/detalle_boleta';
import { Empleado } from '../shared/empleado';
import { EstadoUnidad } from '../shared/estado_unidad';
import { MetodoPago } from '../shared/metodo_pago';
import { Pedido } from '../shared/pedido';
import { ProductoAsignadoPedido } from '../shared/producto_asignado_pedido';
import { Rol } from '../shared/rol';
import { StockTienda } from '../shared/stock_tienda';
import { Sucursal } from '../shared/sucursal';
import { TipoEmpleado } from '../shared/tipo_empleado';
import { UnidadProducto } from '../shared/unidad_producto';
import { Usuario } from '../shared/usuario';
import { remultExpress } from 'remult/remult-express'
import { createKnexDataProvider } from 'remult/remult-knex';
import dotenv from 'dotenv';
import { Categoria } from '../shared/categoria';
import { Cliente } from '../shared/cliente';


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
      entities: [
        Boleta,
        Categoria,
        Cliente,
        DetalleBoleta,
        Empleado,
        EstadoUnidad,
        MetodoPago,
        Pedido,
        ProductoAsignadoPedido,
        Rol,
        StockTienda,
        Sucursal,
        TipoEmpleado,
        UnidadProducto,
        Usuario
    ], // Add entities to app

    admin: true, // Enable the Admin UI
})

