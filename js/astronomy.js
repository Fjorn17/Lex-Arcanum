/* Doctrina de la página de Astronomía / Astronomy doctrine page.
 *
 * Dos cosas, las dos prescindibles: los botones de abrir y plegar todas las
 * secciones, y el subrayado de la sección que se está leyendo en el índice
 * lateral. Sin JavaScript las secciones salen abiertas y el índice sigue
 * siendo una lista de enlaces que funciona.
 */
(function () {
  "use strict";

  var toc = document.querySelector(".doctrine-toc");
  var secs = Array.prototype.slice.call(document.querySelectorAll("details.sec"));
  if (!secs.length) return;

  /* --- abrir y plegar todo ------------------------------------------- */

  if (toc) {
    toc.addEventListener("click", function (e) {
      var a = e.target.closest ? e.target.closest("a[data-all]") : null;
      if (!a) return;
      e.preventDefault();
      var open = a.getAttribute("data-all") === "open";
      for (var i = 0; i < secs.length; i++) secs[i].open = open;
    });
  }

  /* Un enlace del índice a una sección plegada la abre antes de saltar. */
  if (toc) {
    toc.addEventListener("click", function (e) {
      var a = e.target.closest ? e.target.closest('a[href^="#s-"]') : null;
      if (!a) return;
      var s = document.getElementById(a.getAttribute("href").slice(1));
      if (s && !s.open) s.open = true;
    });
  }

  /* --- qué sección se está leyendo ----------------------------------- */

  var links = {};
  if (toc) {
    var as = toc.querySelectorAll('ol a[href^="#"]');
    for (var j = 0; j < as.length; j++) links[as[j].getAttribute("href").slice(1)] = as[j];
  }

  if (!window.IntersectionObserver || !toc) return;

  var seen = {};
  var io = new IntersectionObserver(function (entries) {
    for (var k = 0; k < entries.length; k++) {
      seen[entries[k].target.id] = entries[k].isIntersecting;
    }
    /* la primera visible en orden de documento manda */
    var current = null;
    for (var m = 0; m < secs.length; m++) {
      if (seen[secs[m].id]) { current = secs[m].id; break }
    }
    for (var id in links) {
      if (Object.prototype.hasOwnProperty.call(links, id)) {
        links[id].classList.toggle("here", id === current);
      }
    }
  }, { rootMargin: "-10% 0px -70% 0px" });

  for (var n = 0; n < secs.length; n++) io.observe(secs[n]);
})();
