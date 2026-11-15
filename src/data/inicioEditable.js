// ==========================================================
// Qué se puede editar del inicio desde el panel (Admin → Inicio)
// y el valor original de cada cosa.
//
// Este esquema arma solo el formulario del panel, limpia lo que
// se guarda y completa lo que falta. Para sumar un campo nuevo
// alcanza con agregarlo acá y usarlo en views/inicio.ejs.
//
// Tipos: texto (una línea) · lineas (varios renglones) · parrafo
//        numero · link · imagen · opciones · lista (fija o variable)
// En los textos, *palabra* se resalta.
// ==========================================================

const FONDOS = { oscuro: "Oscuro", medio: "Gris", claro: "Claro" };

const texto = (etiqueta, defecto, max = 80, extra = {}) => ({ tipo: "texto", etiqueta, defecto, max, ...extra });
const parrafo = (etiqueta, defecto, max = 300, extra = {}) => ({ tipo: "parrafo", etiqueta, defecto, max, ...extra });
const link = (etiqueta, defecto, extra = {}) => ({ tipo: "link", etiqueta, defecto, max: 255, ancho: "medio", ...extra });
const imagen = (etiqueta, defecto, extra = {}) => ({ tipo: "imagen", etiqueta, defecto, ...extra });
const etiquetaSeccion = (defecto) => texto("Texto chico de arriba", defecto, 40);
const tituloSeccion = (defecto) =>
  texto("Título", defecto, 70, { ayuda: "Poné *entre asteriscos* la parte que queda resaltada." });

const SECCIONES = {
  portada: {
    titulo: "Banner de cortes",
    descripcion: "Lo primero que se ve al entrar: las fotos de los cortes van pasando solas, con el título y los botones encima.",
    siempreVisible: true,
    campos: {
      etiqueta: texto("Texto chico de arriba", "Top Level · Barber Shop", 70),
      titulo: {
        tipo: "lineas",
        etiqueta: "Título",
        defecto: "Tu estilo\nen otro *nivel*",
        max: 60,
        maxLineas: 2,
        ayuda: "*Entre asteriscos* queda en cursiva.",
      },
      bajada: parrafo("Texto debajo del título", "Cortes, fades, color y barba. Reservá tu lugar en el sillón.", 160),
      botonTexto: texto("Botón principal", "Sacar turno", 30, { ancho: "medio" }),
      botonLink: link("Link del botón principal", "/turno", {
        ayuda: "/turno abre la página para sacar turno (se confirma por WhatsApp: configurá TIENDA_WHATSAPP en el .env).",
      }),
      secundarioTexto: texto("Botón secundario", "Ver insumos", 30, { ancho: "medio" }),
      secundarioLink: link("A dónde lleva", "/insumos"),
      segundos: { tipo: "numero", etiqueta: "Segundos por foto", defecto: 5, max: 30, ancho: "medio" },
      fotos: {
        tipo: "lista",
        etiqueta: "Fotos de cortes",
        item: "Foto",
        cantidad: 12,
        ayuda: "Se muestran en orden y van pasando solas. Las vacías no se usan.",
        campos: { imagen: imagen("Foto", "", { fondo: "oscuro" }) },
        defecto: Array.from({ length: 11 }, (_, i) => ({ imagen: `/img/inicio/cortes/corte-${String(i + 1).padStart(2, "0")}.jpg` })),
      },
    },
  },

  cinta: {
    titulo: "Cinta en movimiento",
    descripcion: "La franja con palabras que se desplazan debajo de la portada.",
    campos: {
      palabras: {
        tipo: "lineas",
        etiqueta: "Palabras",
        defecto: "Cortes clásicos\n*Fades*\nBarba y navaja\n*Top Level*\nProductos de cuidado\n*Barber Shop*",
        max: 240,
        maxLineas: 10,
        ayuda: "Una por renglón. *Entre asteriscos* va resaltada.",
      },
    },
  },

  categorias: {
    titulo: "Categorías",
    descripcion: "Las cuatro tarjetas grandes que llevan a cada sección del catálogo.",
    campos: {
      etiqueta: etiquetaSeccion("Insumos para barberos"),
      titulo: tituloSeccion("Equipate *como un pro*"),
      items: {
        tipo: "lista",
        etiqueta: "Tarjetas",
        item: "Categoría",
        cantidad: 4,
        campos: {
          nombre: texto("Nombre", "", 30, { ancho: "medio" }),
          link: link("Link", "", { ayuda: "Ej: /categoria/maquinas abre esa sección." }),
          frase: parrafo("Frase", "", 90),
          imagen: imagen("Foto", ""),
        },
        defecto: [
          { nombre: "Máquinas", link: "/categoria/maquinas", frase: "Clippers Kemei, VGR, Viggo y Wahl.", imagen: "/img/inicio/categorias/maquinas.jpg" },
          { nombre: "Shavers", link: "/categoria/shavers", frase: "Para dejar el cero perfecto.", imagen: "/img/inicio/categorias/shavers.jpg" },
          { nombre: "Kits y combos", link: "/categoria/kits-y-combos", frase: "Babyliss, VGR y el combo para iniciados.", imagen: "/img/inicio/categorias/kits.jpg" },
          { nombre: "Accesorios", link: "/categoria/accesorios", frase: "Tijeras, sanitizante y más.", imagen: "/img/inicio/categorias/accesorios.jpg" },
        ],
      },
    },
  },

  nuevos: {
    titulo: "Nuevos ingresos",
    descripcion: "Fila de productos recién cargados (se arma sola con el catálogo).",
    campos: {
      etiqueta: etiquetaSeccion("Insumos"),
      titulo: tituloSeccion("Lo último *en la vitrina*"),
      cantidad: { tipo: "numero", etiqueta: "Cuántos mostrar", defecto: 8, max: 12, ancho: "medio" },
      linkTexto: texto("Texto del link", "Ver todos los insumos", 30, { ancho: "medio" }),
      linkUrl: link("A dónde lleva", "/insumos"),
    },
  },

  lookbook: {
    titulo: "Lookbook",
    descripcion: "Mosaico de fotos del local y de los cortes. Solo se muestra si cargás al menos una foto.",
    campos: {
      etiqueta: etiquetaSeccion("En el sillón"),
      titulo: tituloSeccion("Así se ve *Top Level*"),
      redTexto: texto("Link a redes", "@toplevel.barbershop", 30, { ancho: "medio" }),
      redLink: link("A dónde lleva", "https://www.instagram.com/"),
      fotos: {
        tipo: "lista",
        etiqueta: "Fotos",
        item: "Foto",
        cantidad: 4,
        ayuda: "La 1 es la alta; las otras son cuadradas.",
        campos: {
          imagen: imagen("Foto", ""),
          texto: texto("Epígrafe", "", 30, { ancho: "medio" }),
        },
        defecto: [],
      },
    },
  },

  beneficios: {
    titulo: "Beneficios",
    descripcion: "Cuatro avisos cortos de envío, pago y retiro.",
    campos: {
      items: {
        tipo: "lista",
        etiqueta: "Avisos",
        item: "Aviso",
        cantidad: 4,
        campos: {
          titulo: texto("Título", "", 36),
          texto: parrafo("Texto", "", 110),
        },
        defecto: [
          { titulo: "Envío gratis", texto: "En compras desde $150.000 a todo el país." },
          { titulo: "10% off", texto: "Pagando por transferencia bancaria." },
          { titulo: "Hasta 6 cuotas", texto: "Con tarjeta de crédito, por Mercado Pago." },
          { titulo: "Retiro sin costo", texto: "En nuestros locales del Centro y del Sur." },
        ],
      },
    },
  },

  local: {
    titulo: "El local",
    descripcion: "Foto del local de fondo, con las sucursales y los horarios en el medio. Las direcciones se editan en src/data/turnos.js.",
    campos: {
      etiqueta: etiquetaSeccion("Visitanos"),
      titulo: tituloSeccion("Te esperamos *en los locales*"),
      bajada: parrafo("Texto", "Sentate en el sillón, pedí tu corte y llevate tus insumos.", 200),
      horarios: texto("Horarios", "Lunes a sábado · 9 a 13 y 18 a 22 hs", 60, { ancho: "medio" }),
      imagen: imagen("Foto de fondo", "/img/inicio/local.jpg", { ayuda: "Foto horizontal del local. Se oscurece para que se lean los datos.", fondo: "oscuro" }),
    },
  },

  cierre: {
    titulo: "Cierre",
    descripcion: "La invitación final antes del pie de página.",
    campos: {
      etiqueta: etiquetaSeccion("Siempre hay algo nuevo"),
      titulo: {
        tipo: "lineas",
        etiqueta: "Título",
        defecto: "Seguinos y\nenterate *primero*",
        max: 60,
        maxLineas: 3,
        ayuda: "*Entre asteriscos* queda resaltado.",
      },
      botonTexto: texto("Botón", "Ir al Instagram", 30, { ancho: "medio" }),
      botonLink: link("Link del botón", "https://www.instagram.com/"),
      secundarioTexto: texto("Link secundario", "Ver los insumos", 40, { ancho: "medio" }),
      secundarioLink: link("A dónde lleva", "/insumos"),
    },
  },
};

module.exports = { SECCIONES, FONDOS };
