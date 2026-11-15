// Página "Sacar turno": servicios, días y horarios de atención.
// Editá esta lista para cambiar lo que se muestra en /turno.
module.exports = {
  // Foto de fondo de la portada de la página
  portada: "/img/inicio/cortes/corte-08.jpg",
  servicios: [
    { id: "corte", foto: "/img/inicio/cortes/corte-09.jpg", nombre: "Corte", detalle: "Clásico, fade o degradé", minutos: 40 },
    { id: "corte-barba", foto: "/img/inicio/cortes/corte-06.jpg", nombre: "Corte + barba", detalle: "Corte completo y perfilado de barba", minutos: 60 },
    { id: "barba", foto: "/img/inicio/cortes/corte-02.jpg", nombre: "Barba", detalle: "Perfilado, toalla caliente y navaja", minutos: 30 },
    { id: "color", foto: "/img/inicio/cortes/corte-01.jpg", nombre: "Color / mechas", detalle: "Platinado, fantasía o reflejos", minutos: 120 },
    { id: "diseno", foto: "/img/inicio/cortes/corte-05.jpg", nombre: "Diseño / freestyle", detalle: "Líneas y dibujos a navaja", minutos: 20 },
  ],
  // 0 = domingo … 6 = sábado
  diasAbiertos: [1, 2, 3, 4, 5, 6],
  // Franjas de atención (hora de inicio de cada turno)
  franjas: [
    ["09:00", "13:00"],
    ["18:00", "22:00"],
  ],
  intervaloMinutos: 30,
  // Cuántos días para adelante se puede reservar
  diasAdelante: 14,
};
