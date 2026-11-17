// Local de OneBarber: sale en el inicio ("El local"), el pie de página y el menú del celular.
// "mapa" es opcional: si falta se arma el link de Google Maps con la dirección.
module.exports = [
  {
    id: "onebarber",
    nombre: "OneBarber",
    // TODO: poner la dirección exacta (calle y número)
    direccion: "Santiago del Estero",
    mapa: "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent("OneBarber barbería Santiago del Estero"),
  },
];
