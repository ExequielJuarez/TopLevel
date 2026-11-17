-- ==========================================================
-- ONEBARBER — Datos de prueba
--
-- Cargar DESPUÉS de schema.sql (borra y vuelve a cargar todo).
-- Las fechas de los pedidos son relativas al momento de la carga,
-- así el panel siempre muestra ventas recientes.
--
-- Catálogo de barbería: máquinas, shavers, kits y accesorios.
-- Los PRECIOS son de ejemplo: se ajustan desde Panel → Productos.
--
-- Usuarios de prueba:
--   Cliente  demo@tienda.com   /  Demo1234
--   Admin    admin@tienda.com  /  Admin1234
--   Super    super@tienda.com  /  Super1234
--
-- Uso:  npm run db:instalar   (carga schema.sql + este archivo)
-- ==========================================================

USE tienda_onebarber;
SET NAMES utf8mb4;
SET time_zone = '-03:00';

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE notificaciones;
TRUNCATE TABLE arrepentimientos;
TRUNCATE TABLE pedido_items;
TRUNCATE TABLE pedidos;
TRUNCATE TABLE favoritos;
TRUNCATE TABLE especificaciones;
TRUNCATE TABLE producto_imagenes;
TRUNCATE TABLE producto_colores;
TRUNCATE TABLE productos;
TRUNCATE TABLE colores;
TRUNCATE TABLE subcategorias;
TRUNCATE TABLE categorias;
TRUNCATE TABLE cupones;
TRUNCATE TABLE usuarios;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE pedidos AUTO_INCREMENT = 1001;

-- ── Usuarios ─────────────────────────────────────────────
INSERT INTO usuarios (id, nombre, apellido, email, telefono, password, google_id, rol, newsletter) VALUES
  (1, 'Cliente', 'Demo', 'demo@tienda.com', '385 555 4444', '$2b$10$jX3V6AhKp.Par41X/kOWfelfguSzaU4z/IZkvYOv0UHGBQ/6Rl2Oy', NULL, 'cliente', 1),
  (2, 'Admin', 'OneBarber', 'admin@tienda.com', NULL, '$2b$10$OUwf1N16MEgHBa5jhFt6K.cGjo4yUyiF/cOwUOBsyttSBQqgwMRYq', NULL, 'admin', 0),
  (3, 'Ana', 'Pérez', 'ana.perez@gmail.com', NULL, NULL, 'demo-ana.perez@gmail.com', 'cliente', 0),
  (4, 'Super', 'Admin', 'super@tienda.com', NULL, '$2b$10$AhElj/1kwG2mSrQCEpRKI.eaaUIicEpYgvqxK2sckmrfVXodWJpke', NULL, 'superadmin', 0);

-- ── Categorías y colores ─────────────────────────────────
INSERT INTO categorias (id, nombre, slug, orden) VALUES
  (1, 'Máquinas', 'maquinas', 1),
  (2, 'Shavers', 'shavers', 2),
  (3, 'Kits y combos', 'kits-y-combos', 3),
  (4, 'Accesorios', 'accesorios', 4);

INSERT INTO colores (id, valor, nombre, hex, orden) VALUES
  (1, 'negro', 'Negro', '#111111', 1),
  (2, 'blanco', 'Blanco', '#f4f4f4', 2),
  (3, 'dorado', 'Dorado', '#c9a24a', 3),
  (4, 'plateado', 'Plateado', '#b8b9bd', 4),
  (5, 'verde', 'Verde', '#1e8f7a', 5),
  (6, 'tornasolado', 'Tornasolado', '#8a5cf6', 6);

-- ── Productos ────────────────────────────────────────────
INSERT INTO productos (id, nombre, categoria_id, subcategoria_id, color_id, precio, costo, stock, talles, etiqueta, resumen, descripcion, destacados) VALUES
  (1, 'Clipper Kemei KM-90-4', 1, NULL, 2, 65000, 38000, 14, NULL, 'Más vendido', 'Máquina de corte inalámbrica con cuchilla de precisión y palanca de ajuste. Ideal para fades.', 'Una clipper pensada para el trabajo diario en la barbería: motor potente, cuchilla ajustable con palanca y batería de larga duración.

Viene con peines guía y cargador.', 'Inalámbrica
Palanca de ajuste
Cuchilla de precisión
Incluye peines guía'),
  (2, 'Clipper VGR V-880C', 1, NULL, 2, 72000, 42000, 10, NULL, NULL, 'Clipper profesional VGR con motor DC y cuchilla ajustable. Liviana y silenciosa.', 'Diseño blanco con detalles cromados, motor DC de alto rendimiento y palanca de ajuste para trabajar degradés sin cambiar de peine.

Cuerpo liviano y agarre cómodo para jornadas largas.', 'Motor DC
Palanca de ajuste
Bajo ruido
Inalámbrica'),
  (3, 'Clipper Viggo Volt', 1, NULL, 1, 89000, 52000, 8, NULL, 'Nuevo', 'Clipper Viggo Volt de alto torque para cortes de precisión y desvanecidos.', 'Una máquina con potencia de sobra para cualquier tipo de pelo. Cuchilla de acero y ajuste fino para fades limpios.', 'Alto torque
Cuchilla de acero
Ajuste fino
Inalámbrica'),
  (4, 'Wahl Magic Clip', 1, NULL, 1, 185000, 120000, 3, NULL, 'Últimas unidades', 'El clásico de las barberías: cuchilla stagger-tooth para cortes texturizados y fades.', 'La Magic Clip de Wahl es una referencia en el oficio. Cuchilla stagger-tooth que corta parejo y texturiza al mismo tiempo.

Quedan pocas unidades.', 'Cuchilla stagger-tooth
Inalámbrica
Incluye 8 peines
Uso profesional'),
  (5, 'Shaver Kemei KM-2024', 2, NULL, 1, 38000, 22000, 16, NULL, NULL, 'Afeitadora de lámina para terminaciones al ras y desvanecidos en cero.', 'La shaver ideal para cerrar el degradé: lámina fina que deja la piel lisa sin irritar.', 'Lámina doble
Al ras
Recargable
Compacta'),
  (6, 'Shaver Kemei TX5', 2, NULL, 1, 45000, 26000, 12, NULL, NULL, 'Shaver Kemei TX5 con lámina doble y batería de larga duración.', 'Pensada para terminaciones finas: deja el cero perfecto en nuca y laterales. Cuerpo compacto y carga rápida.', 'Lámina doble
Carga rápida
Compacta
Bajo ruido'),
  (7, 'Shaver VGR', 2, NULL, 1, 42000, 24000, 9, NULL, NULL, 'Shaver VGR con pantalla digital y lámina de precisión.', 'Afeitadora de lámina con indicador de batería en pantalla. Ideal para el acabado de fades y barba.', 'Pantalla digital
Lámina de precisión
Recargable'),
  (8, 'Babyliss Pro Gold Duo', 3, NULL, 3, 420000, 290000, 4, NULL, 'Nuevo', 'Set dorado Babyliss Pro: trimmer + shaver en estuche.', 'El dúo más buscado por los barberos: trimmer de terminación y shaver de lámina, ambos en acabado dorado y con estuche rígido.', 'Trimmer + shaver
Acabado dorado
Estuche incluido
Uso profesional'),
  (9, 'Babyliss Pro Rainbow Duo', 3, NULL, 6, 420000, 290000, 4, NULL, NULL, 'Set Babyliss Pro tornasolado: trimmer + shaver en estuche.', 'Mismo rendimiento que el Gold Duo con un acabado tornasolado que no pasa desapercibido.', 'Trimmer + shaver
Acabado tornasolado
Estuche incluido'),
  (10, 'Kit VGR Trimmers (3 piezas)', 3, NULL, 5, 135000, 82000, 6, NULL, 'Nuevo', 'Kit VGR con clipper, trimmer y shaver con pantallas digitales.', 'Todo lo necesario para arrancar o renovar tu set: clipper para el corte, trimmer para los detalles y shaver para el acabado.', 'Clipper + trimmer + shaver
Pantallas digitales
Recargables'),
  (11, 'Combo Iniciados', 3, NULL, 1, 160000, 98000, 5, NULL, 'Combo', 'El combo para empezar en la barbería: máquinas, tijeras, capa, peines y más.', 'Pensado para quienes arrancan en el oficio: clipper, trimmer y shaver Kemei, tijeras de corte y entresacar, capa, pulverizador, peines, cepillo y navaja.', 'Clipper, trimmer y shaver
Tijeras y navaja
Capa y pulverizador
Peines y cepillo'),
  (12, 'Tijeras Viggo', 4, NULL, 4, 28000, 15000, 18, NULL, NULL, 'Tijeras de corte en acero inoxidable con apoyadedo.', 'Filo duradero y buen balance para trabajar la parte de arriba y los detalles con tijera.', 'Acero inoxidable
Apoyadedo
Filo duradero'),
  (13, 'Líquido sanitizante', 4, NULL, 2, 9500, 4500, 30, NULL, NULL, 'Sanitizante para cuchillas: limpia, desinfecta y lubrica.', 'Mantené tus máquinas siempre listas: rociá las cuchillas entre cliente y cliente para desinfectarlas y alargar su vida útil.', 'Desinfecta
Lubrica
Prolonga la vida de las cuchillas');

-- Color de cada producto
INSERT INTO producto_colores (producto_id, color_id, orden) VALUES
  (1, 2, 0),
  (2, 2, 0),
  (3, 1, 0),
  (4, 1, 0),
  (5, 1, 0),
  (6, 1, 0),
  (7, 1, 0),
  (8, 3, 0),
  (9, 6, 0),
  (10, 5, 0),
  (11, 1, 0),
  (12, 4, 0),
  (13, 2, 0);

-- Fotos (la primera es la principal)
INSERT INTO producto_imagenes (producto_id, ruta, orden) VALUES
  (1, '/img/productos/clipper-kemei-90-4-1.jpg', 0),
  (1, '/img/productos/clipper-kemei-90-4-2.jpg', 1),
  (1, '/img/productos/clipper-kemei-90-4-3.jpg', 2),
  (2, '/img/productos/vgr-v880c-1.jpg', 0),
  (2, '/img/productos/vgr-v880c-2.jpg', 1),
  (3, '/img/productos/viggo-volt-clipper-1.jpg', 0),
  (3, '/img/productos/viggo-volt-clipper-2.jpg', 1),
  (4, '/img/productos/wahl-magic-clip-1.jpg', 0),
  (5, '/img/productos/shaver-kemei-km2024-1.jpg', 0),
  (6, '/img/productos/shaver-kemei-tx5-1.jpg', 0),
  (6, '/img/productos/shaver-kemei-tx5-2.jpg', 1),
  (7, '/img/productos/shaver-vgr-1.jpg', 0),
  (7, '/img/productos/shaver-vgr-2.jpg', 1),
  (8, '/img/productos/babyliss-gold-duo-1.jpg', 0),
  (9, '/img/productos/babyliss-rainbow-duo-1.jpg', 0),
  (10, '/img/productos/kit-vgr-trimmers-1.jpg', 0),
  (11, '/img/productos/combo-iniciados-1.jpg', 0),
  (12, '/img/productos/tijeras-viggo-1.jpg', 0),
  (12, '/img/productos/tijeras-viggo-2.jpg', 1),
  (13, '/img/productos/liquido-sanitizante-1.jpg', 0);

-- ── Ficha técnica ────────────────────────────────────────
INSERT INTO especificaciones (producto_id, clave, valor, orden) VALUES
  (1, 'Tipo', 'Clipper', 1),
  (1, 'Alimentación', 'Batería recargable', 2),
  (1, 'Uso', 'Profesional', 3),
  (2, 'Tipo', 'Clipper', 1),
  (2, 'Motor', 'DC', 2),
  (2, 'Alimentación', 'Batería recargable', 3),
  (3, 'Tipo', 'Clipper', 1),
  (3, 'Marca', 'Viggo', 2),
  (3, 'Alimentación', 'Batería recargable', 3),
  (4, 'Tipo', 'Clipper', 1),
  (4, 'Marca', 'Wahl', 2),
  (4, 'Alimentación', 'Batería recargable', 3),
  (5, 'Tipo', 'Shaver', 1),
  (5, 'Lámina', 'Doble', 2),
  (5, 'Alimentación', 'Batería recargable', 3),
  (6, 'Tipo', 'Shaver', 1),
  (6, 'Marca', 'Kemei', 2),
  (6, 'Alimentación', 'Batería recargable', 3),
  (7, 'Tipo', 'Shaver', 1),
  (7, 'Marca', 'VGR', 2),
  (7, 'Alimentación', 'Batería recargable', 3),
  (8, 'Incluye', 'Trimmer y shaver', 1),
  (8, 'Marca', 'Babyliss Pro', 2),
  (8, 'Acabado', 'Dorado', 3),
  (9, 'Incluye', 'Trimmer y shaver', 1),
  (9, 'Marca', 'Babyliss Pro', 2),
  (9, 'Acabado', 'Tornasolado', 3),
  (10, 'Incluye', 'Clipper, trimmer y shaver', 1),
  (10, 'Marca', 'VGR', 2),
  (11, 'Ideal para', 'Principiantes', 1),
  (11, 'Incluye', 'Más de 10 piezas', 2),
  (12, 'Material', 'Acero inoxidable', 1),
  (12, 'Marca', 'Viggo', 2),
  (13, 'Uso', 'Cuchillas y peines', 1),
  (13, 'Presentación', 'Spray', 2);

-- ── Cupones ─────────────────────────────────────────────
INSERT INTO cupones (codigo, descripcion, porcentaje, activo, vence_en) VALUES
  ('BIENVENIDA', '10% off en tu primera compra', 0.1000, 1, NULL),
  ('ONEBARBER5', '5% off de prueba', 0.0500, 1, NULL),
  ('VERANO20', '20% off de temporada (vencido)', 0.2000, 1, CURDATE() - INTERVAL 10 DAY);

-- ── Favoritos del cliente demo ──────────────────────────
INSERT INTO favoritos (usuario_id, producto_id) VALUES
  (1, 8),
  (1, 3),
  (1, 12);

-- ── Pedidos de los últimos 30 días (70) ─────────────────
INSERT INTO pedidos (id, usuario_id, cliente, email, telefono, entrega, calle, altura, piso, codigo_postal, ciudad, provincia, medio_pago, estado, subtotal, descuento, envio, total, costo, ganancia, creado_en) VALUES
  (1001, NULL, 'Agustina Torres', 'agustina.torres@mail.com', '385 4061981', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 420000, 0, 0, 420000, 290000, 130000, TIMESTAMP(CURDATE() - INTERVAL 29 DAY, '17:27:00')),
  (1002, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4123514', 'domicilio', 'Av. Belgrano (S)', '1816', NULL, '4220', 'Termas de Río Hondo', 'Santiago del Estero', 'tarjeta', 'entregado', 89000, 0, 6500, 95500, 52000, 37000, TIMESTAMP(CURDATE() - INTERVAL 28 DAY, '11:34:00')),
  (1003, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4649078', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 173000, 0, 0, 173000, 104000, 69000, TIMESTAMP(CURDATE() - INTERVAL 28 DAY, '18:03:00')),
  (1004, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '385 4536800', 'domicilio', 'Av. Belgrano (S)', '2594', NULL, '4220', 'Termas de Río Hondo', 'Santiago del Estero', 'transferencia', 'entregado', 163000, 0, 0, 163000, 97000, 66000, TIMESTAMP(CURDATE() - INTERVAL 27 DAY, '10:07:00')),
  (1005, 1, 'Cliente Demo', 'demo@tienda.com', '385 4600861', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 127000, 0, 0, 127000, 74000, 53000, TIMESTAMP(CURDATE() - INTERVAL 27 DAY, '21:35:00')),
  (1006, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '385 4372731', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 93000, 0, 0, 93000, 53000, 40000, TIMESTAMP(CURDATE() - INTERVAL 26 DAY, '09:29:00')),
  (1007, NULL, 'Lucas Herrera', 'lucas.herrera@mail.com', '385 4471007', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 61000, 0, 0, 61000, 33000, 28000, TIMESTAMP(CURDATE() - INTERVAL 26 DAY, '10:10:00')),
  (1008, 1, 'Cliente Demo', 'demo@tienda.com', '385 4871464', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 37500, 0, 0, 37500, 19500, 18000, TIMESTAMP(CURDATE() - INTERVAL 25 DAY, '09:31:00')),
  (1009, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4686782', 'domicilio', 'Av. Belgrano (S)', '2928', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'entregado', 38000, 0, 6500, 44500, 22000, 16000, TIMESTAMP(CURDATE() - INTERVAL 25 DAY, '17:39:00')),
  (1010, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '385 4158612', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 72000, 0, 0, 72000, 42000, 30000, TIMESTAMP(CURDATE() - INTERVAL 24 DAY, '09:36:00')),
  (1011, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4120956', 'domicilio', 'Av. Belgrano (S)', '1591', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'entregado', 76000, 0, 6500, 82500, 44000, 32000, TIMESTAMP(CURDATE() - INTERVAL 24 DAY, '16:07:00')),
  (1012, 1, 'Cliente Demo', 'demo@tienda.com', '385 4379324', 'domicilio', 'Av. Belgrano (S)', '194', NULL, '5000', 'Córdoba', 'Córdoba', 'transferencia', 'entregado', 163000, 0, 0, 163000, 97000, 66000, TIMESTAMP(CURDATE() - INTERVAL 23 DAY, '12:33:00')),
  (1013, NULL, 'Joaquín Acosta', 'joaquin.acosta@mail.com', '385 4233876', 'domicilio', 'Av. Belgrano (S)', '2159', NULL, '3500', 'Resistencia', 'Chaco', 'transferencia', 'cancelado', 185000, 0, 0, 185000, 120000, 65000, TIMESTAMP(CURDATE() - INTERVAL 23 DAY, '14:40:00')),
  (1014, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4203051', 'domicilio', 'Av. Belgrano (S)', '1244', NULL, '3500', 'Resistencia', 'Chaco', 'tarjeta', 'entregado', 131000, 0, 6500, 137500, 76000, 55000, TIMESTAMP(CURDATE() - INTERVAL 22 DAY, '16:16:00')),
  (1015, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4654381', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 103000, 0, 0, 103000, 60000, 43000, TIMESTAMP(CURDATE() - INTERVAL 22 DAY, '12:30:00')),
  (1016, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4666728', 'domicilio', 'Av. Belgrano (S)', '831', NULL, '4000', 'San Miguel de Tucumán', 'Tucumán', 'transferencia', 'entregado', 504000, 0, 0, 504000, 338000, 166000, TIMESTAMP(CURDATE() - INTERVAL 21 DAY, '15:50:00')),
  (1017, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '385 4761654', 'domicilio', 'Av. Belgrano (S)', '187', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'cancelado', 185000, 0, 0, 185000, 120000, 65000, TIMESTAMP(CURDATE() - INTERVAL 21 DAY, '09:51:00')),
  (1018, NULL, 'Valentina López', 'valentina.lopez@mail.com', '385 4948223', 'domicilio', 'Av. Belgrano (S)', '2813', NULL, '4000', 'San Miguel de Tucumán', 'Tucumán', 'tarjeta', 'entregado', 38000, 0, 6500, 44500, 22000, 16000, TIMESTAMP(CURDATE() - INTERVAL 20 DAY, '18:52:00')),
  (1019, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4341817', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 65500, 0, 0, 65500, 34500, 31000, TIMESTAMP(CURDATE() - INTERVAL 20 DAY, '17:03:00')),
  (1020, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4642282', 'domicilio', 'Av. Belgrano (S)', '359', NULL, '3500', 'Resistencia', 'Chaco', 'transferencia', 'entregado', 70000, 0, 6500, 76500, 39000, 31000, TIMESTAMP(CURDATE() - INTERVAL 19 DAY, '16:20:00')),
  (1021, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4252328', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 458000, 0, 0, 458000, 312000, 146000, TIMESTAMP(CURDATE() - INTERVAL 19 DAY, '10:42:00')),
  (1022, 1, 'Cliente Demo', 'demo@tienda.com', '385 4230254', 'domicilio', 'Av. Belgrano (S)', '1136', NULL, '4300', 'La Banda', 'Santiago del Estero', 'transferencia', 'entregado', 160000, 0, 0, 160000, 98000, 62000, TIMESTAMP(CURDATE() - INTERVAL 18 DAY, '11:29:00')),
  (1023, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '385 4480951', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 38000, 0, 0, 38000, 22000, 16000, TIMESTAMP(CURDATE() - INTERVAL 18 DAY, '14:35:00')),
  (1024, 1, 'Cliente Demo', 'demo@tienda.com', '385 4991954', 'domicilio', 'Av. Belgrano (S)', '1829', NULL, '3500', 'Resistencia', 'Chaco', 'tarjeta', 'entregado', 38000, 0, 6500, 44500, 18000, 20000, TIMESTAMP(CURDATE() - INTERVAL 17 DAY, '19:52:00')),
  (1025, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '385 4075931', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 72000, 0, 0, 72000, 42000, 30000, TIMESTAMP(CURDATE() - INTERVAL 17 DAY, '15:57:00')),
  (1026, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '385 4189945', 'domicilio', 'Av. Belgrano (S)', '761', NULL, '4200', 'Santiago del Estero', 'Santiago del Estero', 'tarjeta', 'entregado', 420000, 0, 0, 420000, 290000, 130000, TIMESTAMP(CURDATE() - INTERVAL 17 DAY, '13:03:00')),
  (1027, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '385 4468771', 'domicilio', 'Av. Belgrano (S)', '2044', NULL, '5000', 'Córdoba', 'Córdoba', 'transferencia', 'entregado', 56000, 0, 6500, 62500, 30000, 26000, TIMESTAMP(CURDATE() - INTERVAL 16 DAY, '12:59:00')),
  (1028, NULL, 'Martina Gómez', 'martina.gomez@mail.com', '385 4697541', 'domicilio', 'Av. Belgrano (S)', '768', NULL, '4000', 'San Miguel de Tucumán', 'Tucumán', 'tarjeta', 'entregado', 160000, 0, 0, 160000, 98000, 62000, TIMESTAMP(CURDATE() - INTERVAL 16 DAY, '09:05:00')),
  (1029, 1, 'Cliente Demo', 'demo@tienda.com', '385 4925251', 'domicilio', 'Av. Belgrano (S)', '1425', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'entregado', 420000, 0, 0, 420000, 290000, 130000, TIMESTAMP(CURDATE() - INTERVAL 15 DAY, '12:02:00')),
  (1030, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '385 4813944', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 19000, 0, 0, 19000, 9000, 10000, TIMESTAMP(CURDATE() - INTERVAL 15 DAY, '12:32:00')),
  (1031, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '385 4786998', 'domicilio', 'Av. Belgrano (S)', '2498', NULL, '4200', 'Santiago del Estero', 'Santiago del Estero', 'tarjeta', 'entregado', 65000, 0, 6500, 71500, 38000, 27000, TIMESTAMP(CURDATE() - INTERVAL 14 DAY, '17:54:00')),
  (1032, NULL, 'Martina Gómez', 'martina.gomez@mail.com', '385 4876422', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 65000, 0, 0, 65000, 38000, 27000, TIMESTAMP(CURDATE() - INTERVAL 14 DAY, '10:24:00')),
  (1033, 1, 'Cliente Demo', 'demo@tienda.com', '385 4069258', 'domicilio', 'Av. Belgrano (S)', '476', NULL, '5000', 'Córdoba', 'Córdoba', 'transferencia', 'cancelado', 56000, 0, 6500, 62500, 30000, 26000, TIMESTAMP(CURDATE() - INTERVAL 13 DAY, '19:33:00')),
  (1034, 1, 'Cliente Demo', 'demo@tienda.com', '385 4401143', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 131000, 0, 0, 131000, 76000, 55000, TIMESTAMP(CURDATE() - INTERVAL 13 DAY, '16:54:00')),
  (1035, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '385 4304985', 'domicilio', 'Av. Belgrano (S)', '991', NULL, '4400', 'Salta', 'Salta', 'transferencia', 'entregado', 127000, 0, 6500, 133500, 74000, 53000, TIMESTAMP(CURDATE() - INTERVAL 13 DAY, '19:31:00')),
  (1036, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4303655', 'domicilio', 'Av. Belgrano (S)', '451', NULL, '4220', 'Termas de Río Hondo', 'Santiago del Estero', 'transferencia', 'entregado', 84000, 0, 6500, 90500, 48000, 36000, TIMESTAMP(CURDATE() - INTERVAL 12 DAY, '16:01:00')),
  (1037, 1, 'Cliente Demo', 'demo@tienda.com', '385 4999020', 'domicilio', 'Av. Belgrano (S)', '3161', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'entregado', 93000, 0, 6500, 99500, 53000, 40000, TIMESTAMP(CURDATE() - INTERVAL 12 DAY, '17:16:00')),
  (1038, NULL, 'Agustina Torres', 'agustina.torres@mail.com', '385 4147542', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 509000, 0, 0, 509000, 342000, 167000, TIMESTAMP(CURDATE() - INTERVAL 11 DAY, '13:46:00')),
  (1039, 1, 'Cliente Demo', 'demo@tienda.com', '385 4012291', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 145000, 0, 0, 145000, 82000, 63000, TIMESTAMP(CURDATE() - INTERVAL 11 DAY, '12:45:00')),
  (1040, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '385 4054124', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 135000, 0, 0, 135000, 82000, 53000, TIMESTAMP(CURDATE() - INTERVAL 10 DAY, '13:06:00')),
  (1041, NULL, 'Martina Gómez', 'martina.gomez@mail.com', '385 4798653', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 9500, 0, 0, 9500, 4500, 5000, TIMESTAMP(CURDATE() - INTERVAL 10 DAY, '09:51:00')),
  (1042, 1, 'Cliente Demo', 'demo@tienda.com', '385 4435019', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 149000, 0, 0, 149000, 86000, 63000, TIMESTAMP(CURDATE() - INTERVAL 10 DAY, '11:30:00')),
  (1043, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '385 4674449', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 100000, 0, 0, 100000, 57000, 43000, TIMESTAMP(CURDATE() - INTERVAL 9 DAY, '10:10:00')),
  (1044, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '385 4358566', 'domicilio', 'Av. Belgrano (S)', '1099', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'cancelado', 9500, 0, 6500, 16000, 4500, 5000, TIMESTAMP(CURDATE() - INTERVAL 9 DAY, '10:11:00')),
  (1045, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4220206', 'domicilio', 'Av. Belgrano (S)', '1795', NULL, '4000', 'San Miguel de Tucumán', 'Tucumán', 'tarjeta', 'entregado', 429500, 0, 0, 429500, 294500, 135000, TIMESTAMP(CURDATE() - INTERVAL 8 DAY, '20:33:00')),
  (1046, 1, 'Cliente Demo', 'demo@tienda.com', '385 4889855', 'domicilio', 'Av. Belgrano (S)', '2678', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'cancelado', 28000, 0, 6500, 34500, 15000, 13000, TIMESTAMP(CURDATE() - INTERVAL 8 DAY, '21:55:00')),
  (1047, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '385 4800787', 'domicilio', 'Av. Belgrano (S)', '232', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'entregado', 89000, 0, 6500, 95500, 52000, 37000, TIMESTAMP(CURDATE() - INTERVAL 8 DAY, '15:45:00')),
  (1048, 1, 'Cliente Demo', 'demo@tienda.com', '385 4678793', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 9500, 0, 0, 9500, 4500, 5000, TIMESTAMP(CURDATE() - INTERVAL 7 DAY, '20:44:00')),
  (1049, 1, 'Cliente Demo', 'demo@tienda.com', '385 4667199', 'domicilio', 'Av. Belgrano (S)', '2666', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'entregado', 28000, 0, 6500, 34500, 15000, 13000, TIMESTAMP(CURDATE() - INTERVAL 7 DAY, '13:33:00')),
  (1050, 1, 'Cliente Demo', 'demo@tienda.com', '385 4246172', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 28000, 0, 0, 28000, 15000, 13000, TIMESTAMP(CURDATE() - INTERVAL 6 DAY, '16:33:00')),
  (1051, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4238908', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 38000, 0, 0, 38000, 22000, 16000, TIMESTAMP(CURDATE() - INTERVAL 6 DAY, '10:16:00')),
  (1052, 1, 'Cliente Demo', 'demo@tienda.com', '385 4529403', 'domicilio', 'Av. Belgrano (S)', '1296', NULL, '4200', 'Santiago del Estero', 'Santiago del Estero', 'tarjeta', 'enviado', 448000, 0, 0, 448000, 305000, 143000, TIMESTAMP(CURDATE() - INTERVAL 6 DAY, '20:54:00')),
  (1053, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '385 4940023', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 56000, 0, 0, 56000, 30000, 26000, TIMESTAMP(CURDATE() - INTERVAL 5 DAY, '18:11:00')),
  (1054, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '385 4746622', 'domicilio', 'Av. Belgrano (S)', '1711', NULL, '4300', 'La Banda', 'Santiago del Estero', 'transferencia', 'pagado', 135000, 0, 6500, 141500, 82000, 53000, TIMESTAMP(CURDATE() - INTERVAL 5 DAY, '16:57:00')),
  (1055, NULL, 'Joaquín Acosta', 'joaquin.acosta@mail.com', '385 4696705', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 504000, 0, 0, 504000, 338000, 166000, TIMESTAMP(CURDATE() - INTERVAL 4 DAY, '09:19:00')),
  (1056, 1, 'Cliente Demo', 'demo@tienda.com', '385 4795664', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 72000, 0, 0, 72000, 42000, 30000, TIMESTAMP(CURDATE() - INTERVAL 4 DAY, '10:35:00')),
  (1057, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '385 4940565', 'domicilio', 'Av. Belgrano (S)', '1424', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'entregado', 84000, 0, 6500, 90500, 48000, 36000, TIMESTAMP(CURDATE() - INTERVAL 4 DAY, '14:47:00')),
  (1058, 1, 'Cliente Demo', 'demo@tienda.com', '385 4783587', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'pagado', 19000, 0, 0, 19000, 9000, 10000, TIMESTAMP(CURDATE() - INTERVAL 3 DAY, '13:12:00')),
  (1059, NULL, 'Lucas Herrera', 'lucas.herrera@mail.com', '385 4003954', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'enviado', 135000, 0, 0, 135000, 82000, 53000, TIMESTAMP(CURDATE() - INTERVAL 3 DAY, '13:19:00')),
  (1060, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4158665', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'enviado', 56000, 0, 0, 56000, 30000, 26000, TIMESTAMP(CURDATE() - INTERVAL 3 DAY, '20:49:00')),
  (1061, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4167706', 'domicilio', 'Av. Belgrano (S)', '908', NULL, '5000', 'Córdoba', 'Córdoba', 'transferencia', 'pagado', 28000, 0, 6500, 34500, 15000, 13000, TIMESTAMP(CURDATE() - INTERVAL 2 DAY, '15:48:00')),
  (1062, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '385 4441513', 'domicilio', 'Av. Belgrano (S)', '444', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'enviado', 9500, 0, 6500, 16000, 4500, 5000, TIMESTAMP(CURDATE() - INTERVAL 2 DAY, '12:06:00')),
  (1063, 1, 'Cliente Demo', 'demo@tienda.com', '385 4194758', 'domicilio', 'Av. Belgrano (S)', '1899', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'pendiente', 429500, 0, 0, 429500, 294500, 135000, NOW() - INTERVAL 268 MINUTE),
  (1064, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '385 4038821', 'domicilio', 'Av. Belgrano (S)', '511', NULL, '4400', 'Salta', 'Salta', 'tarjeta', 'pagado', 9500, 0, 6500, 16000, 4500, 5000, NOW() - INTERVAL 490 MINUTE),
  (1065, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '385 4390318', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'pagado', 91000, 0, 0, 91000, 51000, 40000, NOW() - INTERVAL 91 MINUTE),
  (1066, 3, 'Ana Pérez', 'ana.perez@gmail.com', '385 4356533', 'domicilio', 'Av. Belgrano (S)', '253', NULL, '4300', 'La Banda', 'Santiago del Estero', 'transferencia', 'pendiente', 65000, 0, 6500, 71500, 38000, 27000, NOW() - INTERVAL 392 MINUTE),
  (1067, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '385 4213288', 'domicilio', 'Av. Belgrano (S)', '1378', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'pagado', 65000, 0, 6500, 71500, 38000, 27000, NOW() - INTERVAL 94 MINUTE),
  (1068, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '385 4438142', 'domicilio', 'Av. Belgrano (S)', '2835', NULL, '4220', 'Termas de Río Hondo', 'Santiago del Estero', 'tarjeta', 'pagado', 509000, 0, 0, 509000, 342000, 167000, NOW() - INTERVAL 329 MINUTE),
  (1069, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '385 4015554', 'domicilio', 'Av. Belgrano (S)', '765', NULL, '4000', 'San Miguel de Tucumán', 'Tucumán', 'tarjeta', 'pendiente', 89000, 0, 6500, 95500, 52000, 37000, NOW() - INTERVAL 148 MINUTE),
  (1070, NULL, 'Valentina López', 'valentina.lopez@mail.com', '385 4970456', 'domicilio', 'Av. Belgrano (S)', '2234', NULL, '4300', 'La Banda', 'Santiago del Estero', 'tarjeta', 'pendiente', 134000, 0, 6500, 140500, 78000, 56000, NOW() - INTERVAL 190 MINUTE);

-- Cobro: los pedidos pagados/enviados/entregados tienen el pago aprobado
UPDATE pedidos SET pago_estado = 'aprobado', pagado_en = creado_en
WHERE estado IN ('pagado', 'enviado', 'entregado');
UPDATE pedidos
SET pago_detalle = ELT(1 + MOD(id, 4), 'Visa terminada en 4242 · 3 cuotas', 'Mastercard terminada en 5100 · 1 cuota',
                       'Naranja terminada en 6019 · 6 cuotas', 'Dinero en cuenta de Mercado Pago'),
    pago_id = CONCAT('demo-', id)
WHERE medio_pago = 'tarjeta' AND pago_estado = 'aprobado';
UPDATE pedidos SET pago_detalle = 'Transferencia acreditada'
WHERE medio_pago = 'transferencia' AND pago_estado = 'aprobado';

-- Dirección guardada del cliente demo (se usa para completar el checkout)
UPDATE usuarios SET dni = '30111222', calle = 'Av. Belgrano (S)', altura = '1450', codigo_postal = '4200',
       ciudad = 'Santiago del Estero', provincia = 'Santiago del Estero'
WHERE email = 'demo@tienda.com';

UPDATE pedidos SET actualizado_en = creado_en;

-- ── Renglones de los pedidos (100) ─────────────────────────
INSERT INTO pedido_items (pedido_id, producto_id, nombre, color, talle, precio, costo, cantidad) VALUES
  (1001, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1002, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1003, 10, 'Kit VGR Trimmers (3 piezas)', 'Verde', NULL, 135000, 82000, 1),
  (1003, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1004, 10, 'Kit VGR Trimmers (3 piezas)', 'Verde', NULL, 135000, 82000, 1),
  (1004, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1005, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1005, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1006, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1006, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1007, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 2),
  (1007, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 1),
  (1008, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1008, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1009, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1010, 2, 'Clipper VGR V-880C', 'Blanco', NULL, 72000, 42000, 1),
  (1011, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 2),
  (1012, 10, 'Kit VGR Trimmers (3 piezas)', 'Verde', NULL, 135000, 82000, 1),
  (1012, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1013, 4, 'Wahl Magic Clip', 'Negro', NULL, 185000, 120000, 1),
  (1014, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 1),
  (1014, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1015, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1015, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1016, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1016, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 2),
  (1017, 4, 'Wahl Magic Clip', 'Negro', NULL, 185000, 120000, 1),
  (1018, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1019, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 2),
  (1019, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1020, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1020, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 1),
  (1021, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1021, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1022, 11, 'Combo Iniciados', 'Negro', NULL, 160000, 98000, 1),
  (1023, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1024, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 2),
  (1024, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 2),
  (1025, 2, 'Clipper VGR V-880C', 'Blanco', NULL, 72000, 42000, 1),
  (1026, 8, 'Babyliss Pro Gold Duo', 'Dorado', NULL, 420000, 290000, 1),
  (1027, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 2),
  (1028, 11, 'Combo Iniciados', 'Negro', NULL, 160000, 98000, 1),
  (1029, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1030, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1030, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1031, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1032, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1033, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 2),
  (1034, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 1),
  (1034, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1035, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1035, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1036, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 2),
  (1037, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1037, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1038, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1038, 8, 'Babyliss Pro Gold Duo', 'Dorado', NULL, 420000, 290000, 1),
  (1039, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 2),
  (1039, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1040, 10, 'Kit VGR Trimmers (3 piezas)', 'Verde', NULL, 135000, 82000, 1),
  (1041, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1042, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 2),
  (1042, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1043, 2, 'Clipper VGR V-880C', 'Blanco', NULL, 72000, 42000, 1),
  (1043, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1044, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1045, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1045, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1046, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1047, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1048, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1049, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1050, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1051, 5, 'Shaver Kemei KM-2024', 'Negro', NULL, 38000, 22000, 1),
  (1052, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1052, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1053, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 2),
  (1054, 10, 'Kit VGR Trimmers (3 piezas)', 'Verde', NULL, 135000, 82000, 1),
  (1055, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1055, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 2),
  (1056, 2, 'Clipper VGR V-880C', 'Blanco', NULL, 72000, 42000, 1),
  (1057, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 1),
  (1057, 7, 'Shaver VGR', 'Negro', NULL, 42000, 24000, 1),
  (1058, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 2),
  (1059, 10, 'Kit VGR Trimmers (3 piezas)', 'Verde', NULL, 135000, 82000, 1),
  (1060, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 2),
  (1061, 12, 'Tijeras Viggo', 'Plateado', NULL, 28000, 15000, 1),
  (1062, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1063, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1063, 8, 'Babyliss Pro Gold Duo', 'Dorado', NULL, 420000, 290000, 1),
  (1064, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 1),
  (1065, 13, 'Líquido sanitizante', 'Blanco', NULL, 9500, 4500, 2),
  (1065, 2, 'Clipper VGR V-880C', 'Blanco', NULL, 72000, 42000, 1),
  (1066, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1067, 1, 'Clipper Kemei KM-90-4', 'Blanco', NULL, 65000, 38000, 1),
  (1068, 9, 'Babyliss Pro Rainbow Duo', 'Tornasolado', NULL, 420000, 290000, 1),
  (1068, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1069, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1070, 3, 'Clipper Viggo Volt', 'Negro', NULL, 89000, 52000, 1),
  (1070, 6, 'Shaver Kemei TX5', 'Negro', NULL, 45000, 26000, 1);

ALTER TABLE pedidos AUTO_INCREMENT = 1071;

-- ── Notificaciones para el admin (las 2 compras más recientes, sin leer) ──
INSERT INTO notificaciones (tipo, titulo, mensaje, url, pedido_id, leida, creado_en)
SELECT 'pedido',
       CONCAT('Nueva compra #', id),
       CONCAT(cliente, ' · $', FORMAT(total, 2, 'es_AR')),
       CONCAT('/admin/pedidos?q=', id),
       id, 0, creado_en
  FROM pedidos
 ORDER BY creado_en DESC
 LIMIT 2;
