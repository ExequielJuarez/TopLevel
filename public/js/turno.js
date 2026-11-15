// Sacar turno: arma los días y horarios, muestra el resumen y abre WhatsApp con el pedido.
(() => {
  const raiz = document.querySelector("[data-turno]");
  if (!raiz) return;
  const config = JSON.parse(document.getElementById("turnoConfig").textContent);
  const form = document.getElementById("turnoForm");
  const cajaDias = document.getElementById("dias");
  const cajaHoras = document.getElementById("horas");
  const horasVacio = document.getElementById("horasVacio");
  const error = document.getElementById("turnoError");
  const estado = { dia: null, hora: null };

  const DIAS = ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"];
  const MESES = ["ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic"];
  const aMin = (h) => { const [a, b] = h.split(":").map(Number); return a * 60 + b; };
  const aHora = (m) => `${String(Math.floor(m / 60)).padStart(2, "0")}:${String(m % 60).padStart(2, "0")}`;
  const mismoDia = (a, b) => a.toDateString() === b.toDateString();

  // Horarios de un día (si es hoy, solo los que faltan, con 30 min de margen)
  function horariosDe(fecha) {
    const ahora = new Date();
    const minimo = mismoDia(fecha, ahora) ? ahora.getHours() * 60 + ahora.getMinutes() + 30 : -1;
    return config.franjas.map(([desde, hasta]) => {
      const lista = [];
      for (let m = aMin(desde); m < aMin(hasta); m += config.intervaloMinutos) if (m >= minimo) lista.push(aHora(m));
      return { desde, lista };
    });
  }

  // Días: los próximos N días abiertos con algún horario libre
  const dias = [];
  for (let i = 0; dias.length < config.diasAdelante && i < 60; i++) {
    const f = new Date(); f.setHours(0, 0, 0, 0); f.setDate(f.getDate() + i);
    if (!config.diasAbiertos.includes(f.getDay())) continue;
    if (!horariosDe(f).some((g) => g.lista.length)) continue;
    dias.push(f);
  }
  const hoy = new Date();
  const manana = new Date(); manana.setDate(hoy.getDate() + 1);
  cajaDias.innerHTML = dias.map((f, i) => `
    <button type="button" class="dia" role="radio" aria-checked="false" data-i="${i}">
      <small>${mismoDia(f, hoy) ? "Hoy" : mismoDia(f, manana) ? "Mañana" : DIAS[f.getDay()]}</small>
      <strong>${f.getDate()}</strong>
      <span>${MESES[f.getMonth()]}</span>
    </button>`).join("");

  function pintarHoras() {
    estado.hora = null;
    const grupos = horariosDe(estado.dia).filter((g) => g.lista.length);
    horasVacio.hidden = grupos.length > 0;
    cajaHoras.innerHTML = grupos.map((g) => `
      <p class="horas__grupo">${aMin(g.desde) < 12 * 60 ? "Mañana" : "Tarde"}</p>
      ${g.lista.map((h) => `<button type="button" class="hora" role="radio" aria-checked="false" data-hora="${h}">${h}</button>`).join("")}`).join("");
  }

  cajaDias.addEventListener("click", (e) => {
    const b = e.target.closest(".dia");
    if (!b) return;
    cajaDias.querySelectorAll(".dia").forEach((x) => x.setAttribute("aria-checked", String(x === b)));
    estado.dia = dias[Number(b.dataset.i)];
    pintarHoras();
    resumen();
  });
  cajaHoras.addEventListener("click", (e) => {
    const b = e.target.closest(".hora");
    if (!b) return;
    cajaHoras.querySelectorAll(".hora").forEach((x) => x.setAttribute("aria-checked", String(x === b)));
    estado.hora = b.dataset.hora;
    resumen();
  });

  // Sucursal → muestra sus barberos y marca "El primero libre"
  const sucursalElegida = () => config.sucursales.find((s) => s.id === form.sucursal.value);
  const barberoElegido = () => {
    const marcado = form.querySelector('.barberos:not([hidden]) input[name="barbero"]:checked');
    return marcado?.value ? sucursalElegida().barberos.find((b) => b.id === marcado.value) : null;
  };
  form.querySelectorAll('input[name="sucursal"]').forEach((r) => r.addEventListener("change", () => {
    form.querySelectorAll(".barberos").forEach((g) => {
      const visible = g.dataset.sucursal === form.sucursal.value;
      g.hidden = !visible;
      g.querySelectorAll("input").forEach((i) => { i.checked = visible && !i.value; });
    });
  }));

  const servicioElegido = () => config.servicios.find((s) => s.id === form.servicio.value);
  const textoDia = (f) => `${["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"][f.getDay()]} ${f.getDate()} de ${["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"][f.getMonth()]}`;

  function resumen() {
    document.getElementById("rSucursal").textContent = sucursalElegida()?.nombre || "—";
    document.getElementById("rBarbero").textContent = barberoElegido()?.nombre || "El primero libre";
    document.getElementById("rServicio").textContent = servicioElegido()?.nombre || "—";
    document.getElementById("rDia").textContent = estado.dia ? textoDia(estado.dia) : "Elegí un día";
    document.getElementById("rHora").textContent = estado.hora ? `${estado.hora} hs` : "Elegí una hora";
    error.hidden = true;
  }
  form.addEventListener("change", resumen);

  // Arranca con el primer día elegido
  cajaDias.querySelector(".dia")?.click();
  resumen();

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const nombre = form.nombre.value.trim();
    const telefono = form.telefono.value.trim();
    const falta = !estado.dia ? "Elegí un día." : !estado.hora ? "Elegí la hora del turno." : !nombre ? "Escribí tu nombre." : telefono.replace(/\D/g, "").length < 8 ? "Escribí un celular válido." : "";
    if (falta) {
      error.textContent = falta;
      error.hidden = false;
      const campo = !nombre ? form.nombre : form.telefono;
      if (estado.dia && estado.hora) campo.focus();
      return;
    }
    const s = servicioElegido();
    const suc = sucursalElegida();
    const barbero = barberoElegido();
    const nota = form.nota.value.trim();
    const mensaje = [
      "¡Hola Top Level! Quiero sacar un turno 💈",
      "",
      `• Sucursal: ${suc.nombre} (${suc.direccion})`,
      `• Barbero: ${barbero ? barbero.nombre : "el primero libre"}`,
      `• Servicio: ${s.nombre}`,
      `• Día: ${textoDia(estado.dia)}`,
      `• Hora: ${estado.hora} hs`,
      `• Nombre: ${nombre}`,
      `• Celular: ${telefono}`,
      nota ? `• Nota: ${nota}` : "",
    ].filter((x, i) => x || i === 1).join("\n");

    const wa = raiz.dataset.whatsapp;
    const listoTexto = document.getElementById("turnoListoTexto");
    if (wa) {
      window.open(`${wa}?text=${encodeURIComponent(mensaje)}`, "_blank", "noopener");
      listoTexto.textContent = `Te abrimos WhatsApp con tu pedido en ${suc.nombre} para el ${textoDia(estado.dia)} a las ${estado.hora} hs. Envialo y te confirmamos el turno.`;
    } else {
      listoTexto.textContent = `Anotamos tu pedido para el ${textoDia(estado.dia)} a las ${estado.hora} hs. Escribinos por Instagram para confirmarlo.`;
    }
    raiz.classList.add("enviado");
    document.getElementById("turnoListo").hidden = false;
    window.scrollTo({ top: 0, behavior: "smooth" });
  });
})();
