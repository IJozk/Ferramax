-- Drop tables

DROP TABLE IF EXISTS boleta CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS consulta_cliente CASCADE;
DROP TABLE IF EXISTS detalle_boleta CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS estado_unidad CASCADE;
DROP TABLE IF EXISTS historial_producto CASCADE;
DROP TABLE IF EXISTS metodo_pago CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS producto_asignado_pedido CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS rol CASCADE;
DROP TABLE IF EXISTS stock_tienda CASCADE;
DROP TABLE IF EXISTS sucursal CASCADE;
DROP TABLE IF EXISTS tipo_empleado CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS unidad_producto CASCADE;

-- Create tables

DROP SEQUENCE IF EXISTS boleta_id_boleta_seq;
CREATE SEQUENCE boleta_id_boleta_seq START 1;

CREATE TABLE boleta (
    id_boleta           SMALLINT DEFAULT nextval('boleta_id_boleta_seq') NOT NULL,
    valor_total         BIGINT NOT NULL,
    id_metodo           SMALLINT NOT NULL,
    id_pedido           SMALLINT NOT NULL,
    fecha_emision       TIMESTAMP(0) NOT NULL,
    documento_vinculado INTEGER
);

ALTER TABLE boleta ADD CONSTRAINT boleta_pk PRIMARY KEY ( id_boleta );


DROP SEQUENCE IF EXISTS categoria_id_categoria_seq;
CREATE SEQUENCE categoria_id_categoria_seq START 1;

CREATE TABLE categoria (
    id_categoria     SMALLINT DEFAULT nextval('categoria_id_categoria_seq') NOT NULL,
    nombre_categoria VARCHAR(50) NOT NULL,
    id_tipo_empleado SMALLINT
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );


DROP SEQUENCE IF EXISTS cliente_id_cliente_seq;
CREATE SEQUENCE cliente_id_cliente_seq START 1;

CREATE TABLE cliente (
    rut_cliente INTEGER NOT NULL,
    dv          VARCHAR(1) NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    apellido    VARCHAR(100) NOT NULL,
    direccion   VARCHAR(100),
    id_usuario  BIGINT DEFAULT nextval('cliente_id_cliente_seq') NOT NULL
);

COMMENT ON COLUMN cliente.rut_cliente IS
    'todo menos dv';

CREATE UNIQUE INDEX cliente__idx ON
    cliente (
        id_usuario
    ASC );

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );


DROP SEQUENCE IF EXISTS consulta_cliente_id_consulta_seq;
CREATE SEQUENCE consulta_cliente_id_consulta_seq START 1;

CREATE TABLE consulta_cliente (
    id_consulta    BIGINT DEFAULT nextval('consulta_cliente_id_consulta_seq') NOT NULL,
    fecha_creacion TIMESTAMP(0) NOT NULL,
    consulta       VARCHAR(500) NOT NULL,
    respuesta      VARCHAR(500),
    rut_cliente    INTEGER NOT NULL,
    rut_empleado   INTEGER NOT NULL
);

ALTER TABLE consulta_cliente ADD CONSTRAINT consulta_cliente_pk PRIMARY KEY ( id_consulta );


DROP SEQUENCE IF EXISTS detalle_boleta_id_detalle_boleta_seq;
CREATE SEQUENCE detalle_boleta_id_detalle_boleta_seq START 1;

CREATE TABLE detalle_boleta (
    id_boleta    SMALLINT NOT NULL,
    cantidad     INTEGER NOT NULL,
    subvalor     INTEGER NOT NULL,
    id_sucursal  SMALLINT NOT NULL,
    cod_producto BIGINT NOT NULL,
    id_detalle   BIGINT DEFAULT nextval('detalle_boleta_id_detalle_boleta_seq') NOT NULL
);

ALTER TABLE detalle_boleta
    ADD CONSTRAINT detalle_boleta_pk PRIMARY KEY ( id_boleta,
                                                   id_sucursal,
                                                   cod_producto );


DROP SEQUENCE IF EXISTS empleado_id_empleado_seq;
CREATE SEQUENCE empleado_id_empleado_seq START 1;

CREATE TABLE empleado (
    rut_empleado        INTEGER NOT NULL,
    dv                  VARCHAR(1) NOT NULL,
    direccion           VARCHAR(100) NOT NULL,
    nombre              VARCHAR(50) NOT NULL,
    apellido            VARCHAR(100) NOT NULL,
    id_tipo_empleado    SMALLINT NOT NULL,
    fecha_nacimiento    TIMESTAMP(0) NOT NULL,
    fecha_incorporacion TIMESTAMP(0) NOT NULL,
    id_usuario          BIGINT DEFAULT nextval('empleado_id_empleado_seq') NOT NULL
);

CREATE UNIQUE INDEX empleado__idx ON
    empleado (
        id_usuario
    ASC );

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( rut_empleado );

CREATE SEQUENCE estado_unidad_id_estado_seq START 1;

CREATE TABLE estado_unidad (
    id_estado  INTEGER DEFAULT nextval('estado_unidad_id_estado_seq') NOT NULL,
    estado VARCHAR(50) NOT NULL
);

ALTER TABLE estado_unidad ADD CONSTRAINT estado_unidad_pk PRIMARY KEY (id_estado);

DROP SEQUENCE IF EXISTS historial_producto_id_historial_producto_seq;
CREATE SEQUENCE historial_producto_id_historial_producto_seq START 1;

CREATE TABLE historial_producto (
    id_historial_producto INT DEFAULT nextval('historial_producto_id_historial_producto_seq') NOT NULL,
    valor_actual          INT NOT NULL,
    fecha_cambio          TIMESTAMP(0) NOT NULL,
    cod_producto          BIGINT NOT NULL
);

ALTER TABLE historial_producto ADD CONSTRAINT historial_producto_pk PRIMARY KEY ( id_historial_producto );


DROP SEQUENCE IF EXISTS metodo_pago_id_metodo_seq;
CREATE SEQUENCE metodo_pago_id_metodo_seq START 1;

CREATE TABLE metodo_pago (
    id_metodo         SMALLINT DEFAULT nextval('metodo_pago_id_metodo_seq') NOT NULL,
    nombre_metodopago VARCHAR(100) NOT NULL
);

ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_pk PRIMARY KEY ( id_metodo );


DROP SEQUENCE IF EXISTS pedido_id_pedido_seq;
CREATE SEQUENCE pedido_id_pedido_seq START 1;

CREATE TABLE pedido (
    id_pedido      SMALLINT DEFAULT nextval('pedido_id_pedido_seq') NOT NULL,
    fecha_creacion TIMESTAMP(0) NOT NULL,
    fecha_entrega  TIMESTAMP(0) NOT NULL,
    id_boleta      SMALLINT NOT NULL,
    rut_cliente    INTEGER NOT NULL,
    rut_empleado   INTEGER
);

CREATE UNIQUE INDEX pedido__idx ON
    pedido (
        id_boleta
    ASC );

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( id_pedido );


DROP SEQUENCE IF EXISTS producto_cod_producto_seq;
CREATE SEQUENCE producto_cod_producto_seq START 100000;

CREATE TABLE producto (
    cod_producto         BIGINT DEFAULT nextval('producto_cod_producto_seq') NOT NULL,
    nombre_producto      VARCHAR(100) NOT NULL,
    precio_actual        BIGINT NOT NULL,
    descripcion_producto VARCHAR(100),
    id_categoria         SMALLINT NOT NULL,
    marca                VARCHAR(100) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( cod_producto );

DROP SEQUENCE IF EXISTS producto_asignado_pedido_id_pedido_seq;
CREATE SEQUENCE producto_asignado_pedido_id_pedido_seq START 1;

CREATE TABLE producto_asignado_pedido (
    id_pedido   SMALLINT DEFAULT nextval('producto_asignado_pedido_id_pedido_seq') NOT NULL,
    precio_prod BIGINT NOT NULL
);

ALTER TABLE producto_asignado_pedido ADD CONSTRAINT producto_asignado_pedido_pk PRIMARY KEY (id_pedido);

DROP SEQUENCE IF EXISTS rol_id_rol_seq;
CREATE SEQUENCE rol_id_rol_seq START 1;

CREATE TABLE rol (
    id_rol     INTEGER DEFAULT nextval('rol_id_rol_seq') NOT NULL,
    nombre_rol VARCHAR(50) NOT NULL,
    desc_rol   VARCHAR(100)
);

ALTER TABLE rol ADD CONSTRAINT rol_pk PRIMARY KEY ( id_rol );


DROP SEQUENCE IF EXISTS stock_tienda_id_sucursal_seq;
CREATE SEQUENCE stock_tienda_id_sucursal_seq START 1;

CREATE TABLE stock_tienda (
    stock_prod       SMALLINT NOT NULL,
    descuento_tienda DOUBLE PRECISION NOT NULL,
    id_sucursal      SMALLINT DEFAULT nextval('stock_tienda_id_sucursal_seq') NOT NULL,
    cod_producto     BIGINT NOT NULL
);

ALTER TABLE stock_tienda ADD CONSTRAINT stock_tienda_pk PRIMARY KEY ( id_sucursal,
                                                                      cod_producto );


DROP SEQUENCE IF EXISTS sucursal_id_sucursal_seq;
CREATE SEQUENCE sucursal_id_sucursal_seq START 1;

CREATE TABLE sucursal (
    id_sucursal SMALLINT DEFAULT nextval('sucursal_id_sucursal_seq') NOT NULL,
    nombre_sucursal   VARCHAR(100) NOT NULL
);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_pk PRIMARY KEY ( id_sucursal );


DROP SEQUENCE IF EXISTS tipo_empleado_id_tipo_empleado_seq;
CREATE SEQUENCE tipo_empleado_id_tipo_empleado_seq START 1;

CREATE TABLE tipo_empleado (
    id_tipo_empleado         SMALLINT DEFAULT nextval('tipo_empleado_id_tipo_empleado_seq') NOT NULL,
    nombre_tipoempleado      VARCHAR(50) NOT NULL,
    descripcion_tipoempleado VARCHAR(500),
    id_categoria             SMALLINT
);

ALTER TABLE tipo_empleado ADD CONSTRAINT tipo_empleado_pk PRIMARY KEY ( id_tipo_empleado );


DROP SEQUENCE IF EXISTS usuario_id_usuario_seq;
CREATE SEQUENCE usuario_id_usuario_seq START 1;

CREATE TABLE usuario (
    id_usuario   BIGINT DEFAULT nextval('usuario_id_usuario_seq') NOT NULL,
    correo       VARCHAR(100) NOT NULL,
    clave        VARCHAR(100) NOT NULL,
    api_key      VARCHAR(100),
    rut_cliente  INTEGER,
    id_rol       INTEGER NOT NULL,
    rut_empleado INTEGER
);

ALTER TABLE usuario
    ADD CONSTRAINT arc_2 CHECK ( ( ( rut_cliente IS NOT NULL )
                                   AND ( rut_empleado IS NULL ) )
                                 OR ( ( rut_empleado IS NOT NULL )
                                      AND ( rut_cliente IS NULL ) ) );

CREATE UNIQUE INDEX usuario__idx ON
    usuario (
        rut_cliente
    ASC );

CREATE UNIQUE INDEX usuario__idxv1 ON
    usuario (
        rut_empleado
    ASC );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );


DROP SEQUENCE IF EXISTS unidad_producto_cod_unidad_seq;
CREATE SEQUENCE unidad_producto_cod_unidad_seq START 1000000;

CREATE TABLE unidad_producto (
    cod_unidad    BIGINT DEFAULT nextval('unidad_producto_cod_unidad_seq') NOT NULL,
    fecha_ingreso TIMESTAMP(0) NOT NULL,
    id_sucursal   SMALLINT NOT NULL,
    cod_producto  BIGINT NOT NULL,
    id_pedido     SMALLINT NOT NULL,
    id_estado     INTEGER NOT NULL
);

CREATE UNIQUE INDEX unidad_producto__idx ON
    unidad_producto (
        id_pedido
    ASC );

ALTER TABLE unidad_producto ADD CONSTRAINT unidad_producto_pk PRIMARY KEY ( cod_unidad );

ALTER TABLE boleta
    ADD CONSTRAINT b_metodo_pago_fk FOREIGN KEY ( id_metodo )
        REFERENCES metodo_pago ( id_metodo );

ALTER TABLE boleta
    ADD CONSTRAINT b_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE detalle_boleta
    ADD CONSTRAINT boleta_fk FOREIGN KEY ( id_boleta )
        REFERENCES boleta ( id_boleta );

ALTER TABLE categoria
    ADD CONSTRAINT c_tipo_emp_fk FOREIGN KEY ( id_tipo_empleado )
        REFERENCES tipo_empleado ( id_tipo_empleado );

ALTER TABLE cliente
    ADD CONSTRAINT c_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE producto
    ADD CONSTRAINT categoria_fk FOREIGN KEY ( id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE consulta_cliente
    ADD CONSTRAINT cc_cliente_fk FOREIGN KEY ( rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE consulta_cliente
    ADD CONSTRAINT cc_empleado_fk FOREIGN KEY ( rut_empleado )
        REFERENCES empleado ( rut_empleado );

ALTER TABLE empleado
    ADD CONSTRAINT e_tipo_empleado_fk FOREIGN KEY ( id_tipo_empleado )
        REFERENCES tipo_empleado ( id_tipo_empleado );

ALTER TABLE empleado
    ADD CONSTRAINT e_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE unidad_producto
    ADD CONSTRAINT estado_unidad_fk FOREIGN KEY ( id_estado )
        REFERENCES estado_unidad ( id_estado );

ALTER TABLE historial_producto
    ADD CONSTRAINT hp_producto_fk FOREIGN KEY ( cod_producto )
        REFERENCES producto ( cod_producto );

ALTER TABLE pedido
    ADD CONSTRAINT p_boleta_fk FOREIGN KEY ( id_boleta )
        REFERENCES boleta ( id_boleta );

ALTER TABLE pedido
    ADD CONSTRAINT p_cliente_fk FOREIGN KEY ( rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE pedido
    ADD CONSTRAINT p_empleado_fk FOREIGN KEY ( rut_empleado )
        REFERENCES empleado ( rut_empleado );

ALTER TABLE producto_asignado_pedido
    ADD CONSTRAINT pa_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE producto_asignado_pedido
    ADD CONSTRAINT pa_unidad_producto_fk FOREIGN KEY ( id_pedido )
        REFERENCES unidad_producto ( id_pedido );

ALTER TABLE stock_tienda
    ADD CONSTRAINT s_producto_fk FOREIGN KEY ( cod_producto )
        REFERENCES producto ( cod_producto );

ALTER TABLE detalle_boleta
    ADD CONSTRAINT db_stock_tienda_fk FOREIGN KEY ( id_sucursal,
                                                     cod_producto )
        REFERENCES stock_tienda ( id_sucursal,
                                  cod_producto );

ALTER TABLE stock_tienda
    ADD CONSTRAINT st_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE tipo_empleado
    ADD CONSTRAINT te_categoria_fk FOREIGN KEY ( id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE usuario
    ADD CONSTRAINT u_cliente_fk FOREIGN KEY ( rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE usuario
    ADD CONSTRAINT u_empleado_fk FOREIGN KEY ( rut_empleado )
        REFERENCES empleado ( rut_empleado );

ALTER TABLE usuario
    ADD CONSTRAINT u_rol_fk FOREIGN KEY ( id_rol )
        REFERENCES rol ( id_rol );

ALTER TABLE unidad_producto
    ADD CONSTRAINT up_stock_tienda_fk FOREIGN KEY ( id_sucursal,
                                                    cod_producto )
        REFERENCES stock_tienda ( id_sucursal,
                                  cod_producto );

								  
INSERT INTO categoria (id_categoria, nombre_categoria)
	VALUES 	(1,	'Herramientas manuales'),
			(2,	'Materiales básicos'),
			(3,	'Equipos de seguridad'),
			(4,	'Tornillos y anclajes'),
			(5,	'Fijaciones y adhesivos'),
			(6,	'Equipos de medición');

-- METODOS DE PAGO

INSERT INTO metodo_pago (id_metodo, nombre_metodopago)
	VALUES 	(1,	'Efectivo'),
			(2,	'Tarjeta credito'),
			(3,	'Tarjeta debito'),
			(4,	'Webpay'),
			(5,	'Cheque');

-- TIPO EMPLEADO

INSERT INTO public.tipo_empleado(id_tipo_empleado, nombre_tipoempleado, descripcion_tipoempleado, id_categoria)
    VALUES ('1', 'Vendedor herramientas manuales', 'Especialista en martillos, destornilladores, llaves, herramientas eléctricas, taladros, sierras, lijadoras y materiales de construcción', '1'), 
    ('2', 'Vendedor materiales básicos', 'Especialista en cemento, arena, ladtrillos, acabados, pinturas, barnices y cerámicos', '2'),
    ('3', 'Vendedor equipos de seguridad', 'Especialista en cascos, guantes, lentes de seguridad y accesorios varios', '3'),
    ('4', 'Tornillos y anclajes', '', '4'),
    ('5', 'Fijaciones y adhesivos', '', '5'),
    ('6', 'Equipos de medición', '', '6');
	
-- ROL

INSERT INTO rol (id_rol, nombre_rol, desc_rol)
	VALUES 	(1,	'Admin', ''),
			(2,	'Vendedor', ''),
			(3,	'Cliente', ''),
			(4,	'Bodeguero', '');

-- ESTADO UNIDAD

INSERT INTO estado_unidad (id_estado, estado)
	VALUES 	(1,	'Disponible'),
			(2,	'Reservado'),
			(3,	'Vendido'),
			(4,	'Disponible segunda mano');

-- SUCURSAL

INSERT INTO sucursal (id_sucursal, nombre_sucursal)
	VALUES 	(1,	'Ferramax  Santiago'),
			(2,	'Ferramax  Concepción'),
			(3,	'Ferramax  Arica'),
			(4,	'Ferramax  Punta Arenas');