// Inicio: banner de cortes que pasa solo (con flechas, puntos y deslizar en el celular).
(() => {
  // Vitrina: flechas que corren la fila de productos
  const pista = document.querySelector("[data-vit-pista]");
  if (!pista) return;
  const paso = () => (pista.querySelector(".vit")?.offsetWidth || 300) + 18;
  document.querySelector("[data-vit-anterior]")?.addEventListener("click", () => pista.scrollBy({ left: -paso(), behavior: "smooth" }));
  document.querySelector("[data-vit-siguiente]")?.addEventListener("click", () => pista.scrollBy({ left: paso(), behavior: "smooth" }));
})();

(() => {
  const banner = document.querySelector("[data-banner]");
  if (!banner) return;
  const fotos = [...banner.querySelectorAll("[data-slide]")];
  const puntos = [...banner.querySelectorAll("[data-punto]")];
  if (fotos.length < 2) return;

  const espera = Math.max(2, Number(banner.dataset.segundos) || 5) * 1000;
  const quieto = matchMedia("(prefers-reduced-motion: reduce)").matches;
  let actual = 0;
  let reloj;

  function mostrar(i) {
    actual = (i + fotos.length) % fotos.length;
    fotos.forEach((f, n) => f.classList.toggle("activa", n === actual));
    puntos.forEach((p, n) => {
      p.classList.toggle("activo", n === actual);
      p.setAttribute("aria-selected", n === actual);
    });
    // Precarga la que sigue para que no aparezca en blanco
    fotos[(actual + 1) % fotos.length].querySelectorAll("img").forEach((img) => { img.loading = "eager"; });
  }
  function arrancar() {
    if (quieto) return;
    clearInterval(reloj);
    reloj = setInterval(() => mostrar(actual + 1), espera);
  }
  const ir = (i) => { mostrar(i); arrancar(); };

  banner.querySelector("[data-anterior]")?.addEventListener("click", () => ir(actual - 1));
  banner.querySelector("[data-siguiente]")?.addEventListener("click", () => ir(actual + 1));
  puntos.forEach((p) => p.addEventListener("click", () => ir(Number(p.dataset.punto))));

  // Pausa con el mouse encima o con la pestaña oculta
  banner.addEventListener("mouseenter", () => clearInterval(reloj));
  banner.addEventListener("mouseleave", arrancar);
  document.addEventListener("visibilitychange", () => (document.hidden ? clearInterval(reloj) : arrancar()));

  // Deslizar con el dedo
  let x0 = null;
  banner.addEventListener("touchstart", (e) => { x0 = e.touches[0].clientX; }, { passive: true });
  banner.addEventListener("touchend", (e) => {
    if (x0 === null) return;
    const dx = e.changedTouches[0].clientX - x0;
    if (Math.abs(dx) > 40) ir(actual + (dx < 0 ? 1 : -1));
    x0 = null;
  });

  arrancar();
})();
