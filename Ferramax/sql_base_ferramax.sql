-- Drop tables 

DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS unidad_producto;
DROP TABLE IF EXISTS historial_producto;
DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS boleta;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS metodo_pago;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS tipo_empleado;
DROP TABLE IF EXISTS stock_tienda;
DROP TABLE IF EXISTS consulta_cliente;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS sucursal;

-- Create tables

CREATE TABLE boleta (
    id_boleta           SMALLINT NOT NULL,
    valor_total         BIGINT NOT NULL,
    id_metodo           SMALLINT NOT NULL,
    id_pedido           SMALLINT NOT NULL,
    fecha_emision       TIMESTAMP(0) NOT NULL,
    documento_vinculado INTEGER
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX boleta__idx ON
    boleta (
        id_pedido
    ASC );

ALTER TABLE boleta ADD CONSTRAINT boleta_pk PRIMARY KEY ( id_boleta );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE categoria (
    id_categoria     SMALLINT NOT NULL,
    nombre_categoria VARCHAR(50) NOT NULL,
    id_tipo_empleado SMALLINT
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX categoria__idx ON
    categoria (
        id_tipo_empleado
    ASC );

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE cliente (
    rut_cliente INTEGER NOT NULL,
    dv          VARCHAR(1) NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    apellido    VARCHAR(100) NOT NULL,
    direccion   VARCHAR(100),
    id_usuario  BIGINT NOT NULL
);

COMMENT ON COLUMN cliente.rut_cliente IS
    'todo menos dv';

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX cliente__idx ON
    cliente (
        id_usuario
    ASC );

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE consulta_cliente (
    id_consulta    BIGINT NOT NULL,
    fecha_creacion TIMESTAMP(0) NOT NULL,
    consulta       VARCHAR(500) NOT NULL,
    respuesta      VARCHAR(500),
    rut_cliente    INTEGER NOT NULL,
    rut_empleado   INTEGER NOT NULL
);

ALTER TABLE consulta_cliente ADD CONSTRAINT consulta_cliente_pk PRIMARY KEY ( id_consulta );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE detalle_boleta (
    id_boleta    SMALLINT NOT NULL,
    cantidad     INTEGER NOT NULL,
    subvalor     INTEGER NOT NULL,
    id_sucursal  SMALLINT NOT NULL,
    cod_producto BIGINT NOT NULL
);

ALTER TABLE detalle_boleta
    ADD CONSTRAINT detalle_boleta_pk PRIMARY KEY ( id_boleta,
                                                   id_sucursal,
                                                   cod_producto );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE empleado (
    rut_empleado        INTEGER NOT NULL,
    dv                  VARCHAR(1) NOT NULL,
    direccion           VARCHAR(100) NOT NULL,
    nombre              VARCHAR(50) NOT NULL,
    apellido            VARCHAR(100) NOT NULL,
    id_tipo_empleado    SMALLINT NOT NULL,
    fecha_nacimiento    TIMESTAMP(0) NOT NULL,
    fecha_incorporacion TIMESTAMP(0) NOT NULL,
    id_usuario          BIGINT NOT NULL
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX empleado__idx ON
    empleado (
        id_usuario
    ASC );

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( rut_empleado );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE estado_unidad (
    id_estado INTEGER NOT NULL,
    estado    VARCHAR(100) NOT NULL
);

ALTER TABLE estado_unidad ADD CONSTRAINT estado_unidad_pk PRIMARY KEY ( id_estado );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE historial_producto (
    id_historial_producto INT NOT NULL,
    valor_actual          INT NOT NULL,
    fecha_cambio          TIMESTAMP(0) NOT NULL,
    cod_producto          BIGINT NOT NULL
);

ALTER TABLE historial_producto ADD CONSTRAINT historial_producto_pk PRIMARY KEY ( id_historial_producto );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE metodo_pago (
    id_metodo         SMALLINT NOT NULL,
    nombre_metodopago VARCHAR(100) NOT NULL
);

ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_pk PRIMARY KEY ( id_metodo );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE pedido (
    id_pedido      SMALLINT NOT NULL,
    fecha_creacion TIMESTAMP(0) NOT NULL,
    fecha_entrega  TIMESTAMP(0) NOT NULL,
    id_boleta      SMALLINT NOT NULL,
    rut_cliente    INTEGER NOT NULL,
    rut_empleado   INTEGER
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX pedido__idx ON
    pedido (
        id_boleta
    ASC );

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( id_pedido );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE producto (
    cod_producto         BIGINT NOT NULL,
    nombre_producto      VARCHAR(100) NOT NULL,
    precio_actual        BIGINT NOT NULL,
    descripcion_producto VARCHAR(100),
    id_categoria         SMALLINT NOT NULL,
    marca                VARCHAR(100) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( cod_producto );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE producto_asignado_pedido (
    precio_prod BIGINT NOT NULL,
    id_pedido   SMALLINT NOT NULL,
    cod_unidad  BIGINT NOT NULL
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX producto_asignado_pedido__idx ON
    producto_asignado_pedido (
        cod_unidad
    ASC );

ALTER TABLE producto_asignado_pedido ADD CONSTRAINT producto_asignado_pedido_pk PRIMARY KEY ( id_pedido );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE rol (
    id_rol     INTEGER NOT NULL,
    nombre_rol VARCHAR(50) NOT NULL,
    desc_rol   VARCHAR(100)
);

ALTER TABLE rol ADD CONSTRAINT rol_pk PRIMARY KEY ( id_rol );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE stock_tienda (
    stock_prod       SMALLINT NOT NULL,
    descuento_tienda DOUBLE PRECISION NOT NULL,
    id_sucursal      SMALLINT NOT NULL,
    cod_producto     BIGINT NOT NULL
);

ALTER TABLE stock_tienda ADD CONSTRAINT stock_tienda_pk PRIMARY KEY ( id_sucursal,
                                                                      cod_producto );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE sucursal (
    id_sucursal SMALLINT NOT NULL,
    nombre_sucursal   VARCHAR(100) NOT NULL
);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_pk PRIMARY KEY ( id_sucursal );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE tipo_empleado (
    id_tipo_empleado         SMALLINT NOT NULL,
    nombre_tipoempleado      VARCHAR(50) NOT NULL,
    descripcion_tipoempleado VARCHAR(500),
    id_categoria             SMALLINT
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX tipo_empleado__idx ON
    tipo_empleado (
        id_categoria
    ASC );

ALTER TABLE tipo_empleado ADD CONSTRAINT tipo_empleado_pk PRIMARY KEY ( id_tipo_empleado );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE unidad_producto (
    cod_unidad    BIGINT NOT NULL,
    fecha_ingreso TIMESTAMP(0) NOT NULL,
    id_sucursal   SMALLINT NOT NULL,
    cod_producto  BIGINT NOT NULL,
    id_pedido     SMALLINT NOT NULL,
    id_estado     INTEGER NOT NULL
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX unidad_producto__idx ON
    unidad_producto (
        id_pedido
    ASC );

ALTER TABLE unidad_producto ADD CONSTRAINT unidad_producto_pk PRIMARY KEY ( cod_unidad );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE usuario (
    id_usuario   BIGINT NOT NULL,
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

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX usuario__idx ON
    usuario (
        rut_cliente
    ASC );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX usuario__idxv1 ON
    usuario (
        rut_empleado
    ASC );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

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
    ADD CONSTRAINT pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE unidad_producto
    ADD CONSTRAINT prod_asignado_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES producto_asignado_pedido ( id_pedido );

ALTER TABLE stock_tienda
    ADD CONSTRAINT producto_fk FOREIGN KEY ( cod_producto )
        REFERENCES producto ( cod_producto );

ALTER TABLE detalle_boleta
    ADD CONSTRAINT stock_tienda_fk FOREIGN KEY ( id_sucursal,
                                                 cod_producto )
        REFERENCES stock_tienda ( id_sucursal,
                                  cod_producto );

ALTER TABLE stock_tienda
    ADD CONSTRAINT sucursal_fk FOREIGN KEY ( id_sucursal )
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

ALTER TABLE producto_asignado_pedido
    ADD CONSTRAINT unidad_producto_fk FOREIGN KEY ( cod_unidad )
        REFERENCES unidad_producto ( cod_unidad );

ALTER TABLE unidad_producto
    ADD CONSTRAINT up_stock_tienda_fk FOREIGN KEY ( id_sucursal,
                                                    cod_producto )
        REFERENCES stock_tienda ( id_sucursal,
                                  cod_producto );





-- INSERT DATA

-- CATEGORIA

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

-- TIPOS DE EMPLEADOS

INSERT INTO public.tipo_empleado(id_tipo_empleado, nombre_tipoempleado, descripcion_tipoempleado, id_categoria)
    VALUES ('1', 'Vendedor herramientas manuales', 'Especialista en martillos, destornilladores, llaves, herramientas eléctricas, taladros, sierras, lijadoras y materiales de construcción', '1'), 
    ('2', 'Vendedor materiales básicos', 'Especialista en cemento, arena, ladtrillos, acabados, pinturas, barnices y cerámicos', '2'),
    ('3', 'Vendedor equipos de seguridad', 'Especialista en cascos, guantes, lentes de seguridad y accesorios varios', '3'),
    ('4', 'Tornillos y anclajes', '', '4'),
    ('5', 'Fijaciones y adhesivos', '', '5'),
    ('6', 'Equipos de medición', '', '6');

-- ROL

INSERT INTO rol (id_rol, nombre_rol, dec_rol)
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