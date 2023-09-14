CREATE TABLE Empleados (
    codigo_empleado INT PRIMARY KEY,
    nombre VARCHAR(255),
    apellido1 VARCHAR(255),
    apellido2 VARCHAR(255),
    extension VARCHAR(10),
    email VARCHAR(255),
    codigo_oficina INT,
    codigo_jefe INT,
    puesto VARCHAR(50)
);

CREATE TABLE Oficinas (
   codigo_oficina INT PRIMARY KEY,
   ciudad VARCHAR(255),
   pais VARCHAR(255),
   region VARCHAR(255),
   codigo_postal VARCHAR(10),
   telefono VARCHAR(20),
   direccion VARCHAR(255)
);

CREATE TABLE Clientes (
    codigo_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(255),
    nombre_contacto VARCHAR(255),
    apellido_contacto VARCHAR(255),
    telefono VARCHAR(20),
    fax VARCHAR(20),
    direccion1 VARCHAR(255),
    direccion2 VARCHAR(255),
    ciudad VARCHAR(255),
    region VARCHAR(255),
    pais VARCHAR(255),
    codigo_postal VARCHAR(10),
    codigo_empleado INT,
    limite_credito DECIMAL(10, 2),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleados(codigo_empleado)
);

CREATE TABLE Pedidos (
    codigo_pedido INT PRIMARY KEY,
    fecha_pedido DATE,
    fecha_esperada DATE,
    fecha_entrega DATE,
    estado VARCHAR(50),
    comentarios TEXT,
    codigo_cliente INT,
    FOREIGN KEY (codigo_cliente) REFERENCES Clientes(codigo_cliente)
);

CREATE TABLE Pagos (
    codigo_cliente INT,
    forma_pago VARCHAR(50),
    id_transaccion INT PRIMARY KEY,
    fecha_pago DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (codigo_cliente) REFERENCES Clientes(codigo_cliente)
);

CREATE TABLE Gama_Productos (
   gama VARCHAR(50) PRIMARY KEY,
   descripcion TEXT,
   imagen BLOB
);

CREATE TABLE Productos (
   codigo_producto INT PRIMARY KEY,
   nombre VARCHAR(255),
   gama VARCHAR(50),
   dimensiones TEXT,
   proveedor VARCHAR(255),
   descripcion TEXT,
   cantidad_stock INT,
   precio_venta DECIMAL(10, 2),
   precio_proveedor DECIMAL(10, 2),
   FOREIGN KEY (gama) REFERENCES Gama_Productos(gama)
);

CREATE TABLE Detalle_Pedidos (
   codigo_pedido INT,
   codigo_producto INT,
   cantidad INT,
   precio_unidad DECIMAL(10, 2),
   PRIMARY KEY (codigo_pedido, codigo_producto),
   FOREIGN KEY (codigo_pedido) REFERENCES Pedidos(codigo_pedido),
   FOREIGN KEY (codigo_producto) REFERENCES Productos(codigo_producto)
);
 insert 