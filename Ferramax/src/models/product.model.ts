/* import { Knex } from 'knex';
import { knexConfig } from '../config/database';

const Producto = (): Promise<void> => {
  return knexConfig.schema.createTable('producto', (table: Knex.TableBuilder) => {
    table.increments('cod_producto').primary();
    table.string('nombre_producto').notNullable();
    table.string('precio_actual').notNullable();
    table.string('descripcion_producto');
    table.integer('id_categoria').notNullable();
    table.string('marca').notNullable();
  });
};

export default Producto; */