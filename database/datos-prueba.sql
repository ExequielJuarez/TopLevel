-- ==========================================================
-- ONEBARBER — Datos de prueba
--
-- Cargar DESPUÉS de schema.sql (borra y vuelve a cargar todo).
-- Las fechas de los pedidos son relativas al momento de la carga,
-- así el panel siempre muestra ventas recientes.
--
-- Catálogo de OneBarber: 50 productos tomados del catálogo de WhatsApp
-- (nombre, precio, descripción y foto). El stock arranca en 10 y el costo en 0:
-- se ajustan desde Panel → Productos.
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

-- ── Categorías ───────────────────────────────────────────
INSERT INTO categorias (id, nombre, slug, orden) VALUES
  (1, 'Máquinas', 'maquinas', 1),
  (2, 'Patilleras y shavers', 'patilleras-y-shavers', 2),
  (3, 'Combos', 'combos', 3),
  (4, 'Repuestos', 'repuestos', 4),
  (5, 'Insumos', 'insumos', 5),
  (6, 'Accesorios', 'accesorios', 6);

INSERT INTO subcategorias (id, categoria_id, nombre, slug, orden) VALUES
  (1, 2, 'Patilleras', 'patilleras', 1),
  (2, 2, 'Shavers', 'shavers', 2),
  (3, 4, 'Cuchillas y cabezales', 'cuchillas-y-cabezales', 1),
  (4, 4, 'Alzas', 'alzas', 2),
  (5, 4, 'Piezas y baterías', 'piezas-y-baterias', 3),
  (6, 5, 'Ceras y estilizado', 'ceras-y-estilizado', 1),
  (7, 5, 'Coloración', 'coloracion', 2),
  (8, 5, 'Afeitado y cuidado', 'afeitado-y-cuidado', 3),
  (9, 5, 'Limpieza de máquinas', 'limpieza-de-maquinas', 4),
  (10, 5, 'Descartables', 'descartables', 5),
  (11, 6, 'Tijeras y navajas', 'tijeras-y-navajas', 1),
  (12, 6, 'Peines y cepillos', 'peines-y-cepillos', 2),
  (13, 6, 'Capas', 'capas', 3),
  (14, 6, 'Tapetes y bolsos', 'tapetes-y-bolsos', 4),
  (15, 6, 'Sillones y mobiliario', 'sillones-y-mobiliario', 5),
  (16, 6, 'Equipamiento', 'equipamiento', 6);

INSERT INTO colores (id, valor, nombre, hex, orden) VALUES
  (1, 'negro', 'Negro', '#111111', 1),
  (2, 'blanco', 'Blanco', '#f4f4f4', 2),
  (3, 'dorado', 'Dorado', '#c9a24a', 3),
  (4, 'plateado', 'Plateado', '#b8b9bd', 4),
  (5, 'verde', 'Verde', '#1e8f7a', 5),
  (6, 'tornasolado', 'Tornasolado', '#8a5cf6', 6);

-- ── Productos (catálogo de WhatsApp) ─────────────────────
INSERT INTO productos (id, nombre, categoria_id, subcategoria_id, color_id, precio, costo, stock, talles, etiqueta, resumen, descripcion, destacados) VALUES
  (1, 'Combo Wahl cordless', 3, NULL, 1, 389900, 0, 10, NULL, NULL, 'No incluye base de carga', 'No incluye base de carga', NULL),
  (2, 'VGR v-001', 1, NULL, 1, 130000, 0, 10, NULL, NULL, 'Disponible en colores dorado', 'Disponible en colores dorado', NULL),
  (3, 'Máquina Profesional Kemei 2296', 1, NULL, 1, 61000, 0, 10, NULL, NULL, 'incluye peines límite del 1 al 8, cepillo de limpieza , base de carga, cargador con conexión USB y cable cargador / disponible también en blanca', 'incluye peines límite del 1 al 8, cepillo de limpieza , base de carga, cargador con conexión USB y cable cargador / disponible también en blanca', NULL),
  (4, 'Kemei -2293', 2, 1, 1, 45000, 0, 10, NULL, NULL, 'CON CUERPO METALICO Y PANTALLA LED', 'CON CUERPO METALICO Y PANTALLA LED', NULL),
  (5, 'Afeitadora Viggo profesional', 2, 2, 1, 85000, 0, 10, NULL, NULL, 'Shaver para dejar el cero perfecto.', 'Shaver para dejar el cero perfecto.', NULL),
  (6, 'Kemei 2026', 2, 2, 1, 75000, 0, 10, NULL, NULL, 'Shaver para dejar el cero perfecto.', 'Shaver para dejar el cero perfecto.', NULL),
  (7, 'Alza guía 0,5 reforzada', 4, 4, 1, 5000, 0, 10, NULL, NULL, 'Alzas para trabajar las medidas con precisión.', 'Alzas para trabajar las medidas con precisión.', NULL),
  (8, 'Combo kemei 1', 3, NULL, 1, 125000, 0, 10, NULL, NULL, 'km 2296 km 2299 km 3382 20 filos (una cajita)', 'km 2296 km 2299 km 3382 20 filos (una cajita)', NULL),
  (9, 'Combo Kemei 3', 3, NULL, 1, 69000, 0, 10, NULL, NULL, 'kn 2293 km 2024', 'kn 2293 km 2024', NULL),
  (10, 'Maletín Everest', 6, 14, 1, 150000, 0, 10, NULL, NULL, '55 de largo por 30 de alto', '55 de largo por 30 de alto', NULL),
  (11, 'Tijera de pulir KAIZEN by EMA MEDINA', 6, 11, 1, 190000, 0, 10, NULL, NULL, '5p / ideal para pulir', '5p / ideal para pulir', NULL),
  (12, 'Alfombra IMANTADA Everest', 6, 14, 1, 55000, 0, 10, NULL, NULL, 'Bastante grande', 'Bastante grande', NULL),
  (13, 'Peine símil Wahl distintos colores', 6, 12, 1, 3000, 0, 10, NULL, NULL, 'Accesorio para el trabajo diario en el sillón.', 'Accesorio para el trabajo diario en el sillón.', NULL),
  (14, 'Cepillo fade ragnar', 6, 12, 1, 5000, 0, 10, NULL, NULL, 'Accesorio para el trabajo diario en el sillón.', 'Accesorio para el trabajo diario en el sillón.', NULL),
  (15, 'Capa para niño', 6, 13, 1, 20000, 0, 10, NULL, NULL, 'Capa para trabajar cómodo y prolijo.', 'Capa para trabajar cómodo y prolijo.', NULL),
  (16, 'Agua de primont vol 30', 5, 7, 1, 14000, 0, 10, NULL, NULL, '1 litro', '1 litro', NULL),
  (17, 'Combo Vgr de calidad', 3, NULL, 1, 313900, 0, 10, NULL, NULL, 'Incluye Máquina vgr 001 Patillera vgr 977 Rasuradora vgr 307 Capa eco Rociador eco 1 rollo de Papel de cuello Navaja afilable Sacapelo eco Set de tijeras punto azul Abrojos viggo', 'Incluye Máquina vgr 001 Patillera vgr 977 Rasuradora vgr 307 Capa eco Rociador eco 1 rollo de Papel de cuello Navaja afilable Sacapelo eco Set de tijeras punto azul Abrojos viggo', NULL),
  (18, 'Tijeras de corte viggo vg10', 6, 11, 1, 130000, 0, 10, NULL, NULL, '5.5 o 6 pulgadas', '5.5 o 6 pulgadas', NULL),
  (19, 'Ceras marca yilho de 100 gramos', 5, 6, 1, 10000, 0, 10, NULL, NULL, 'Para peinar y dar textura al terminar el corte.', 'Para peinar y dar textura al terminar el corte.', NULL),
  (20, 'Rovra super cut', 1, NULL, 1, 297000, 0, 10, NULL, NULL, 'Máquina profesional para corte y fades.', 'Máquina profesional para corte y fades.', NULL),
  (21, 'Tubo de papel negro', 5, 10, 1, 16000, 0, 10, NULL, NULL, 'Descartable para trabajar con higiene.', 'Descartable para trabajar con higiene.', NULL),
  (22, 'Capas Everest cuello de silicona', 6, 13, 1, 25000, 0, 10, NULL, NULL, 'Capa para trabajar cómodo y prolijo.', 'Capa para trabajar cómodo y prolijo.', NULL),
  (23, 'VGR 325 afeitadora de 3 rodillos', 2, 2, 1, 42000, 0, 10, NULL, NULL, 'Se consigue repuestos también', 'Se consigue repuestos también', NULL),
  (24, 'Combo inicial de calidad 26', 3, NULL, 1, 285000, 0, 10, NULL, NULL, 'El combo incluye Combo de máquinas vgr Rasuradora Everest Gel de afeitar Sacapelo Cubre cuello 20 Filos (una cajita) Par de tijeras Capa Navaja Peine venado Rociador continuo Lubricante yhilo Aceite de la maquna Alzas de la maquina', 'El combo incluye Combo de máquinas vgr Rasuradora Everest Gel de afeitar Sacapelo Cubre cuello 20 Filos (una cajita) Par de tijeras Capa Navaja Peine venado Rociador continuo Lubricante yhilo Aceite de la maquna Alzas de la maquina', NULL),
  (25, 'Combo Kemei 15', 3, NULL, 1, 92000, 0, 10, NULL, NULL, 'km 2296 km 2299 cepillo fade eco', 'km 2296 km 2299 cepillo fade eco', NULL),
  (26, 'Combo inicial premium', 3, NULL, 1, 305000, 0, 10, NULL, NULL, 'Incluye Capa cuellos de silicona ,set de tijeras, navaja eco ,peine, alzas premium+alzas de la maquina , Sacapelo de cristal , cuellito , 1 caja de filos rasur , after shaver , rociador eco ,cera y máquinas', 'Incluye Capa cuellos de silicona ,set de tijeras, navaja eco ,peine, alzas premium+alzas de la maquina , Sacapelo de cristal , cuellito , 1 caja de filos rasur , after shaver , rociador eco ,cera y máquinas', NULL),
  (27, 'Banda antideslizante para máquina', 4, 5, 1, 6000, 0, 10, NULL, NULL, 'Azul , negro ,rojo', 'Azul , negro ,rojo', NULL),
  (28, 'Sillón california', 6, 15, 1, 850000, 0, 10, NULL, NULL, '3 disponibles', '3 disponibles', NULL),
  (29, 'Repuesto cabezal Kemei 1102 clasico', 4, 3, 1, 17000, 0, 10, NULL, NULL, 'Compatible con otras marcas .consultame', 'Compatible con otras marcas .consultame', NULL),
  (30, 'Cuchilla cerámica Wahl detailer', 4, 3, 1, 8000, 0, 10, NULL, NULL, 'Compatible con otras marcas', 'Compatible con otras marcas', NULL),
  (31, 'Combo insumos 18', 3, NULL, 1, 27550, 0, 10, NULL, NULL, '3 rollos de papel 5 cajas de filos (rasur) 1 lubricante yhilo', '3 rollos de papel 5 cajas de filos (rasur) 1 lubricante yhilo', NULL),
  (32, 'Espejo doble valija Fortex', 6, 16, 1, 38000, 0, 10, NULL, NULL, 'Bastante grande', 'Bastante grande', NULL),
  (33, 'Matizadores Opcion x MAYOR', 5, 7, 1, 84900, 0, 10, NULL, NULL, 'Para la reventa o para uso del salon.', 'Para la reventa o para uso del salon.', NULL),
  (34, 'Aceite Andis', 5, 9, 1, 14000, 0, 10, NULL, NULL, 'Limpia, lubrica y protege las cuchillas.', 'Limpia, lubrica y protege las cuchillas.', NULL),
  (35, 'Trimmer shock Viggo', 2, 1, 1, 90000, 0, 10, NULL, NULL, '• MOTOR MAGNÉTICO CON MICROCHIP DE 9.000 RPM • CUCHILLA ULTRA-HARD BLACK DIAMOND (DLC). • PANTALLA LED: MUESTRA LA CAPACIDAD DE LA BATERÍA. • INALÁMBRICA – CARGA USB (TIPO C) • 180 MINUTOS DE CARGA Y 90 MINUTOS DE AUTOΝΟΜΙΑ • Incluye: Cable USB – 4', '• MOTOR MAGNÉTICO CON MICROCHIP DE 9.000 RPM • CUCHILLA ULTRA-HARD BLACK DIAMOND (DLC). • PANTALLA LED: MUESTRA LA CAPACIDAD DE LA BATERÍA. • INALÁMBRICA – CARGA USB (TIPO C) • 180 MINUTOS DE CARGA Y 90 MINUTOS DE AUTOΝΟΜΙΑ • Incluye: Cable USB – 4 guías (1, 2, 3,4 mm) – Cepillo de limpieza y aceite lubricante.', NULL),
  (36, 'Clipper viggo MAGNÉTIC', 1, NULL, 1, 165000, 0, 10, NULL, NULL, 'Motor Magnético con Microchip superveloz de 10.000 RPM Cuchilla externa Diamond Like Carbòn, plana. Cuchilla interna de acero 440 c El Kit incluye un par extra de cuchillas Còncavas de acero 440c 190 min de autonimìa Incluye base de carga y cable de ', 'Motor Magnético con Microchip superveloz de 10.000 RPM Cuchilla externa Diamond Like Carbòn, plana. Cuchilla interna de acero 440 c El Kit incluye un par extra de cuchillas Còncavas de acero 440c 190 min de autonimìa Incluye base de carga y cable de carga Carcasa extra intercambiable Lightblue 13 accesorios : 6 alzas premium, destornillador para ajuste ya cambio de cuchillas , peine de corte, Banda antideslizante , Base de carga', NULL),
  (37, 'Máquina Babyliss lo-pro FX one', 1, NULL, 1, 279900, 0, 10, NULL, NULL, 'Cada una', 'Cada una', NULL),
  (38, 'Aceite de coco', 5, 8, 1, 7000, 0, 10, NULL, NULL, 'Cuidado de la piel y el cabello.', 'Cuidado de la piel y el cabello.', NULL),
  (39, 'Cool care andis', 5, 9, 1, 29000, 0, 10, NULL, NULL, 'De primera calidad', 'De primera calidad', NULL),
  (40, 'Wahl Professional 5 Star Cordless Legend bordó', 1, NULL, 1, 209900, 0, 10, NULL, NULL, 'Voltaje: 220V • Es inalámbrica y funciona con batería recargable. • Podés utilizarla durante un tiempo máximo de 100 m. • Se carga al 100% en aproximadamente 60 m. • Es silenciosa. • Tiene display digital. • Corta hasta 1.7 mm. • Viene con 8 peines. ', 'Voltaje: 220V • Es inalámbrica y funciona con batería recargable. • Podés utilizarla durante un tiempo máximo de 100 m. • Se carga al 100% en aproximadamente 60 m. • Es silenciosa. • Tiene display digital. • Corta hasta 1.7 mm. • Viene con 8 peines. • Accesorio incluido: 1 cepillo limpiador.', NULL),
  (41, 'Polo de barberia blanco y negro', 6, 15, 1, 200000, 0, 10, NULL, NULL, 'Para equipar tu barbería.', 'Para equipar tu barbería.', NULL),
  (42, 'Trimmer blast Viggo', 2, 1, 1, 155900, 0, 10, NULL, NULL, '• PRIMERA TRIMMER VIGGO CON MOTOR MAGNÉTICO • POTENCIA SILENCIOSA: 10.000 RPM Y CON VIBRACIÓN MÍNIMA • CUCHILLA X-PRO ultra finas. • CUCHILLA INTERNA A 0.01 MM para mayor precisión. • INALÁMBRICA CON BASE DE CARGA • AUTONOMÍA DE 120 MINUTOS • Incluye', '• PRIMERA TRIMMER VIGGO CON MOTOR MAGNÉTICO • POTENCIA SILENCIOSA: 10.000 RPM Y CON VIBRACIÓN MÍNIMA • CUCHILLA X-PRO ultra finas. • CUCHILLA INTERNA A 0.01 MM para mayor precisión. • INALÁMBRICA CON BASE DE CARGA • AUTONOMÍA DE 120 MINUTOS • Incluye: Cargador tipo USB y cable USB – Cepillo de limpieza y aceite lubricante', NULL),
  (43, 'Polvo de textura pimp paradise', 5, 6, 1, 16000, 0, 10, NULL, NULL, 'Precio por menor', 'Precio por menor', NULL),
  (44, 'Máquina vgr 003', 1, NULL, 1, 99900, 0, 10, NULL, NULL, 'Misma que la del combo vgr', 'Misma que la del combo vgr', NULL),
  (45, 'Kemei 809-A', 1, NULL, 1, 50000, 0, 10, NULL, NULL, 'con alzas intermedias de regalo', 'con alzas intermedias de regalo', NULL),
  (46, 'Set de alzas reforzadas x4', 4, 4, 1, 16500, 0, 10, NULL, NULL, 'Alzas 0,5 / 1 / 1,5 / 2', 'Alzas 0,5 / 1 / 1,5 / 2', NULL),
  (47, 'Trimmer viggo DEEP', 2, 1, 1, 62000, 0, 10, NULL, NULL, 'Cuchilla REGULABLE “Zero GAP” para corte al ras, de acero de alta resistencia. • POTENCIA 7000 RPM. • Inalámbrica con BASE DE CARGA y cable USB incluído. • Duración de batería 2.5 hs. • Diseño ergonómico de alta resistencia. • Incluye DESTORNILLADOR ', 'Cuchilla REGULABLE “Zero GAP” para corte al ras, de acero de alta resistencia. • POTENCIA 7000 RPM. • Inalámbrica con BASE DE CARGA y cable USB incluído. • Duración de batería 2.5 hs. • Diseño ergonómico de alta resistencia. • Incluye DESTORNILLADOR REGULADOR. • El Kit Incluye: 3 guías de corte: 1, 2 y 3 mm. – Cepillo de Limpieza.', NULL),
  (48, 'Minoxidil regeneración de cabello', 5, 8, 1, 15000, 0, 10, NULL, NULL, 'tratamiento para la regeneración del cabello para hombres. Diseñada para quienes luchan contra el adelgazamiento y la caída del cabello', 'tratamiento para la regeneración del cabello para hombres. Diseñada para quienes luchan contra el adelgazamiento y la caída del cabello', NULL),
  (49, 'Cuchillas Wahl ORIGINAL', 4, 3, 1, 50000, 0, 10, NULL, NULL, 'Cóncavas o planas', 'Cóncavas o planas', NULL),
  (50, 'Base Cargadora Wahl + Adaptador de Corte', 4, 5, 1, 85000, 0, 10, NULL, NULL, 'Base ORIGINAL Wahl ideal para cargar tus máquinas de forma práctica y segura. Incluye adaptador de corte intercambiable. Diseño compacto, resistente y perfecto para uso profesional en barberías o peluquerías.', 'Base ORIGINAL Wahl ideal para cargar tus máquinas de forma práctica y segura. Incluye adaptador de corte intercambiable. Diseño compacto, resistente y perfecto para uso profesional en barberías o peluquerías.', NULL);

-- Color de cada producto
INSERT INTO producto_colores (producto_id, color_id, orden) VALUES
  (1, 1, 0),
  (2, 1, 0),
  (3, 1, 0),
  (4, 1, 0),
  (5, 1, 0),
  (6, 1, 0),
  (7, 1, 0),
  (8, 1, 0),
  (9, 1, 0),
  (10, 1, 0),
  (11, 1, 0),
  (12, 1, 0),
  (13, 1, 0),
  (14, 1, 0),
  (15, 1, 0),
  (16, 1, 0),
  (17, 1, 0),
  (18, 1, 0),
  (19, 1, 0),
  (20, 1, 0),
  (21, 1, 0),
  (22, 1, 0),
  (23, 1, 0),
  (24, 1, 0),
  (25, 1, 0),
  (26, 1, 0),
  (27, 1, 0),
  (28, 1, 0),
  (29, 1, 0),
  (30, 1, 0),
  (31, 1, 0),
  (32, 1, 0),
  (33, 1, 0),
  (34, 1, 0),
  (35, 1, 0),
  (36, 1, 0),
  (37, 1, 0),
  (38, 1, 0),
  (39, 1, 0),
  (40, 1, 0),
  (41, 1, 0),
  (42, 1, 0),
  (43, 1, 0),
  (44, 1, 0),
  (45, 1, 0),
  (46, 1, 0),
  (47, 1, 0),
  (48, 1, 0),
  (49, 1, 0),
  (50, 1, 0);

-- Fotos (la primera es la principal)
INSERT INTO producto_imagenes (producto_id, ruta, orden) VALUES
  (1, '/img/productos/combo-wahl-cordless.jpg', 0),
  (2, '/img/productos/vgr-v-001.jpg', 0),
  (3, '/img/productos/maquina-profesional-kemei-2296.jpg', 0),
  (4, '/img/productos/kemei-2293.jpg', 0),
  (5, '/img/productos/afeitadora-viggo-profesional.jpg', 0),
  (6, '/img/productos/kemei-2026.jpg', 0),
  (7, '/img/productos/alza-guia-0-5-reforzada.jpg', 0),
  (8, '/img/productos/combo-kemei-1.jpg', 0),
  (9, '/img/productos/combo-kemei-3.jpg', 0),
  (10, '/img/productos/maletin-everest.jpg', 0),
  (11, '/img/productos/tijera-de-pulir-kaizen-by-ema-medina.jpg', 0),
  (12, '/img/productos/alfombra-imantada-everest.jpg', 0),
  (13, '/img/productos/peine-simil-wahl-distintos-colores.jpg', 0),
  (14, '/img/productos/cepillo-fade-ragnar.jpg', 0),
  (15, '/img/productos/capa-para-nino.jpg', 0),
  (16, '/img/productos/agua-de-primont-vol-30.jpg', 0),
  (17, '/img/productos/combo-vgr-de-calidad.jpg', 0),
  (18, '/img/productos/tijeras-de-corte-viggo-vg10.jpg', 0),
  (19, '/img/productos/ceras-marca-yilho-de-100-gramos.jpg', 0),
  (20, '/img/productos/rovra-super-cut.jpg', 0),
  (21, '/img/productos/tubo-de-papel-negro.jpg', 0),
  (22, '/img/productos/capas-everest-cuello-de-silicona.jpg', 0),
  (23, '/img/productos/vgr-325-afeitadora-de-3-rodillos.jpg', 0),
  (24, '/img/productos/combo-inicial-de-calidad-26.jpg', 0),
  (25, '/img/productos/combo-kemei-15.jpg', 0),
  (26, '/img/productos/combo-inicial-premium.jpg', 0),
  (27, '/img/productos/banda-antideslizante-para-maquina.jpg', 0),
  (28, '/img/productos/sillon-california.jpg', 0),
  (29, '/img/productos/repuesto-cabezal-kemei-1102-clasico.jpg', 0),
  (30, '/img/productos/cuchilla-ceramica-wahl-detailer.jpg', 0),
  (31, '/img/productos/combo-insumos-18.jpg', 0),
  (32, '/img/productos/espejo-doble-valija-fortex.jpg', 0),
  (33, '/img/productos/matizadores-opcion-x-mayor.jpg', 0),
  (34, '/img/productos/aceite-andis.jpg', 0),
  (35, '/img/productos/trimmer-shock-viggo.jpg', 0),
  (36, '/img/productos/clipper-viggo-magnetic.jpg', 0),
  (37, '/img/productos/maquina-babyliss-lo-pro-fx-one.jpg', 0),
  (38, '/img/productos/aceite-de-coco.jpg', 0),
  (39, '/img/productos/cool-care-andis.jpg', 0),
  (40, '/img/productos/wahl-professional-5-star-cordless-legend-bordo.jpg', 0),
  (41, '/img/productos/polo-de-barberia-blanco-y-negro.jpg', 0),
  (42, '/img/productos/trimmer-blast-viggo.jpg', 0),
  (43, '/img/productos/polvo-de-textura-pimp-paradise.jpg', 0),
  (44, '/img/productos/maquina-vgr-003.jpg', 0),
  (45, '/img/productos/kemei-809-a.jpg', 0),
  (46, '/img/productos/set-de-alzas-reforzadas-x4.jpg', 0),
  (47, '/img/productos/trimmer-viggo-deep.jpg', 0),
  (48, '/img/productos/minoxidil-regeneracion-de-cabello.jpg', 0),
  (49, '/img/productos/cuchillas-wahl-original.jpg', 0),
  (50, '/img/productos/base-cargadora-wahl-adaptador-de-corte.jpg', 0);

-- ── Cupones ─────────────────────────────────────────────
INSERT INTO cupones (codigo, descripcion, porcentaje, activo, vence_en) VALUES
  ('BIENVENIDA', '10% off en tu primera compra', 0.1000, 1, NULL),
  ('ONEBARBER5', '5% off de prueba', 0.0500, 1, NULL),
  ('VERANO20', '20% off de temporada (vencido)', 0.2000, 1, CURDATE() - INTERVAL 10 DAY);

-- Dirección guardada del cliente demo (se usa para completar el checkout)
UPDATE usuarios SET dni = '30111222', calle = 'Av. Belgrano (S)', altura = '1450', codigo_postal = '4200',
       ciudad = 'Santiago del Estero', provincia = 'Santiago del Estero'
WHERE email = 'demo@tienda.com';

