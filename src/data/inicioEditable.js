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
    titulo: "Portada",
    descripcion: "Lo primero que se ve al entrar: el título y los botones al costado del video del local (sin sonido).",
    siempreVisible: true,
    campos: {
      etiqueta: texto("Texto chico de arriba", "OneBarber · Barbería y venta de insumos", 70),
      titulo: {
        tipo: "lineas",
        etiqueta: "Título",
        defecto: "Todo para tu\n*barbería*",
        max: 60,
        maxLineas: 3,
        ayuda: "*Entre asteriscos* queda resaltado en naranja.",
      },
      bajada: parrafo("Texto debajo del título", "Máquinas, patilleras, repuestos e insumos originales. Vení a verlos al local o pedilos online.", 180),
      puntos: {
        tipo: "lineas",
        etiqueta: "Puntos (uno por renglón, se ven en PC)",
        defecto: "Productos originales\nEnvíos a todo el país\nTe asesoramos por WhatsApp",
        max: 160,
        maxLineas: 4,
      },
      botonTexto: texto("Botón principal", "Ver insumos", 30, { ancho: "medio" }),
      botonLink: link("Link del botón principal", "/insumos"),
      secundarioTexto: texto("Botón secundario", "Visitanos", 30, { ancho: "medio" }),
      secundarioLink: link("A dónde lleva", "/#local"),
      video: link("Video", "/video/insumos.mp4", { ayuda: "Video vertical (mp4) guardado en public/video. Se ve sin sonido y se repite." }),
    },
  },

  cinta: {
    titulo: "Cinta en movimiento",
    descripcion: "La franja con palabras que se desplazan debajo de la portada.",
    campos: {
      palabras: {
        tipo: "lineas",
        etiqueta: "Palabras",
        defecto: "Cortes clásicos\n*Fades*\nBarba y navaja\n*OneBarber*\nProductos de cuidado\n*Barber Shop*",
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
          { nombre: "Máquinas", link: "/categoria/maquinas", frase: "Clippers Wahl, Babyliss, Viggo, VGR y Kemei.", imagen: "/img/inicio/categorias/maquinas.jpg" },
          { nombre: "Patilleras y shavers", link: "/categoria/patilleras-y-shavers", frase: "Para las terminaciones y el cero perfecto.", imagen: "/img/inicio/categorias/shavers.jpg" },
          { nombre: "Combos", link: "/categoria/combos", frase: "Todo para arrancar, en un solo pedido.", imagen: "/img/inicio/categorias/kits.jpg" },
          { nombre: "Accesorios", link: "/categoria/accesorios", frase: "Tijeras, peines, capas y sillones.", imagen: "/img/inicio/categorias/accesorios.jpg" },
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
      titulo: tituloSeccion("Así se ve *OneBarber*"),
      redTexto: texto("Link a redes", "@onebarber", 30, { ancho: "medio" }),
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
    descripcion: "La dirección, los horarios y el video de cómo llegar. La dirección se edita en src/data/sucursales.js.",
    campos: {
      etiqueta: etiquetaSeccion("Visitanos"),
      titulo: tituloSeccion("Te esperamos *en el local*"),
      bajada: parrafo("Texto", "Sentate en el sillón, pedí tu corte y llevate tus insumos.", 200),
      horarios: texto("Horarios", "Lunes a sábado · 9 a 13 y 18 a 22 hs", 60, { ancho: "medio" }),
      video: link("Video de cómo llegar", "/video/como-llegar.mp4", { ayuda: "Video vertical (mp4) guardado en public/video." }),
    },
  },

  academia: {
    titulo: "One Academy",
    descripcion: "Los cursos de barbería: foto de los alumnos, el video y los datos para inscribirse.",
    campos: {
      titulo: tituloSeccion("Aprendé el oficio *con los que saben*"),
      bajada: parrafo("Texto", "Cursos de barbería desde cero: técnica, práctica con modelos reales y todo lo que necesitás para salir a trabajar.", 220),
      puntos: {
        tipo: "lineas",
        etiqueta: "Lo que incluye (un renglón por punto)",
        defecto: "Clases prácticas con modelos reales\nGrupos reducidos, te seguimos de cerca\nCertificado de finalización One Academy",
        max: 200,
        maxLineas: 5,
      },
      botonTexto: texto("Botón", "Quiero inscribirme", 30, { ancho: "medio" }),
      botonLink: link("Link del botón", "", { ayuda: "Vacío: abre el WhatsApp de la tienda (o el Instagram si no hay WhatsApp)." }),
      foto: imagen("Foto de los alumnos", "/img/inicio/academy.jpg", { ayuda: "Foto vertical de los alumnos." }),
      video: link("Video", "/video/academy.mp4", { ayuda: "Video vertical (mp4) guardado en public/video." }),
    },
  },
};

module.exports = { SECCIONES, FONDOS };
