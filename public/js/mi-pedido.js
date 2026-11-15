// Detalle del pedido: botones "Copiar" de los datos de la transferencia.
document.querySelectorAll("[data-copiar]").forEach((b) =>
  b.addEventListener("click", async () => {
    const valor = b.parentElement.querySelector("[data-copiar-valor]")?.dataset.copiarValor;
    try { await navigator.clipboard.writeText(valor); window.TL.toast("Copiado ✓"); } catch { window.TL.toast("No se pudo copiar", "error"); }
  })
);
