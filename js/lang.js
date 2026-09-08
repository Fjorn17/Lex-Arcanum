/* Selección de idioma para Lex Arcanum / Language selection for Lex Arcanum.
 *
 * El sitio se sirve como dos árboles paralelos, /es/ y /en/, con las mismas
 * rutas dentro de cada uno. Este archivo solo hace dos cosas:
 *
 *   1. Recuerda el idioma que el visitante elige al pulsar una bandera.
 *   2. En la raíz del sitio, decide a cuál de los dos árboles mandarlo.
 *
 * Sin JavaScript el sitio sigue funcionando: la raíz trae enlaces visibles a
 * las dos versiones y las banderas son enlaces normales.
 */
(function () {
  "use strict";

  var KEY = "lexarcanum:lang";
  var LANGS = ["es", "en"];
  var FALLBACK = "en";

  function read() {
    try {
      var v = window.localStorage.getItem(KEY);
      return LANGS.indexOf(v) !== -1 ? v : null;
    } catch (e) {
      // Modo privado, cookies bloqueadas: seguimos sin recordar nada.
      return null;
    }
  }

  function write(lang) {
    try {
      window.localStorage.setItem(KEY, lang);
    } catch (e) {
      /* no pasa nada */
    }
  }

  /* Idioma preferido del navegador, si es uno de los que tenemos. */
  function fromBrowser() {
    var list = navigator.languages && navigator.languages.length
      ? navigator.languages
      : [navigator.language || navigator.userLanguage || ""];

    for (var i = 0; i < list.length; i++) {
      var tag = String(list[i]).toLowerCase();
      for (var j = 0; j < LANGS.length; j++) {
        if (tag === LANGS[j] || tag.indexOf(LANGS[j] + "-") === 0) return LANGS[j];
      }
    }
    return null;
  }

  /* La raíz redirige: elección guardada > idioma del navegador > inglés. */
  function redirectRoot() {
    var lang = read() || fromBrowser() || FALLBACK;
    var target = lang + "/index.html";
    window.location.replace(target);
  }

  /* En cualquier página, pulsar una bandera deja constancia de la elección. */
  function wireSwitcher() {
    var links = document.querySelectorAll(".langsw a[hreflang]");
    for (var i = 0; i < links.length; i++) {
      links[i].addEventListener("click", function () {
        write(this.getAttribute("hreflang"));
      });
    }
  }

  if (document.documentElement.hasAttribute("data-lang-root")) {
    redirectRoot();
    return;
  }

  /* Si la página declara su idioma, esa es la elección vigente. */
  var here = document.documentElement.getAttribute("lang");
  if (LANGS.indexOf(here) !== -1) write(here);

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", wireSwitcher);
  } else {
    wireSwitcher();
  }
})();
