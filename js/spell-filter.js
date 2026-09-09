/* Filtro y ordenación del índice de conjuros / Spell index filter and sorting.
 *
 * La tabla sale del generador ya completa y ordenada por nivel, así que
 * sin JavaScript la página sigue sirviendo: aquí solo se añade la posibilidad
 * de filtrar por nombre, nivel, Disciplina y subdisciplina, y de ordenar por columna.
 *
 * Las claves de filtrado viajan en los data-* de cada fila y van SIEMPRE en
 * inglés (data-discipline="alchemy"), igual que
 * data-type en los daños: el texto visible cambia de idioma, la clave no.
 */
(function () {
  "use strict";

  var table = document.getElementById("spelltable");
  var bar = document.getElementById("spellfilter");
  if (!table || !bar) return;

  var tbody = table.tBodies[0];
  var rows = Array.prototype.slice.call(tbody.rows);
  var empty = document.getElementById("sf-empty");
  var count = document.getElementById("sf-count");
  var q = document.getElementById("sf-q");
  var level = document.getElementById("sf-level");
  var disc = document.getElementById("sf-discipline");
  var sub = document.getElementById("sf-sub");
  var reset = document.getElementById("sf-reset");

  /* El texto del contador se compone con la etiqueta que ya trae la página. */
  var countLabel = count ? count.getAttribute("data-label") || "" : "";

  bar.hidden = false;

  /* --- filtrado ------------------------------------------------------- */

  /* Sin acentos y en minúscula, para que "alquimia" encuentre
     "Alquimia". */
  function fold(s) {
    s = String(s).toLowerCase();
    return s.normalize ? s.normalize("NFD").replace(/[̀-ͯ]/g, "") : s;
  }

  function apply() {
    var text = fold(q.value.trim());
    var lv = level.value;
    var dc = disc.value;
    var sb = sub.value;
    var shown = 0;

    for (var i = 0; i < rows.length; i++) {
      var r = rows[i];
      var ok = true;
      if (text && fold(r.getAttribute("data-name")).indexOf(text) === -1) ok = false;
      if (ok && lv !== "" && r.getAttribute("data-level") !== lv) ok = false;
      if (ok && dc !== "" && r.getAttribute("data-discipline") !== dc) ok = false;
      if (ok && sb !== "" && r.getAttribute("data-sub") !== sb) ok = false;
      r.hidden = !ok;
      if (ok) shown++;
    }

    if (empty) empty.hidden = shown !== 0;
    if (count) count.textContent = shown + " " + countLabel;
  }

  /* --- ordenación ----------------------------------------------------- */

  var sortKey = "level";
  var sortAsc = true;

  function valueOf(row, key) {
    if (key === "level") return Number(row.getAttribute("data-level"));
    return row.getAttribute("data-" + key) || "";
  }

  function sortBy(key) {
    if (sortKey === key) {
      sortAsc = !sortAsc;
    } else {
      sortKey = key;
      sortAsc = true;
    }

    var dir = sortAsc ? 1 : -1;
    rows.sort(function (a, b) {
      var va = valueOf(a, sortKey);
      var vb = valueOf(b, sortKey);
      if (va < vb) return -1 * dir;
      if (va > vb) return 1 * dir;
      /* A igualdad, siempre por nombre: así el orden es estable y previsible. */
      var na = valueOf(a, "name");
      var nb = valueOf(b, "name");
      return na < nb ? -1 : na > nb ? 1 : 0;
    });

    var frag = document.createDocumentFragment();
    for (var i = 0; i < rows.length; i++) frag.appendChild(rows[i]);
    tbody.appendChild(frag);

    var heads = table.tHead.rows[0].cells;
    for (var j = 0; j < heads.length; j++) {
      var k = heads[j].getAttribute("data-sort");
      if (!k) continue;
      if (k === sortKey) {
        heads[j].setAttribute("aria-sort", sortAsc ? "ascending" : "descending");
      } else {
        heads[j].removeAttribute("aria-sort");
      }
    }
  }

  var heads = table.tHead.rows[0].cells;
  for (var j = 0; j < heads.length; j++) {
    (function (th) {
      var key = th.getAttribute("data-sort");
      if (!key) return;
      th.tabIndex = 0;
      th.setAttribute("role", "button");
      th.classList.add("sortable");
      th.addEventListener("click", function () { sortBy(key) });
      th.addEventListener("keydown", function (e) {
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          sortBy(key);
        }
      });
    })(heads[j]);
  }

  /* La tabla llega ordenada por nivel: se refleja en la cabecera. */
  heads[1].setAttribute("aria-sort", "ascending");

  /* --- el árbol filtra la tabla --------------------------------------- */

  /* Cada rama es también un enlace a su página, y eso se conserva: pinchar
     filtra aquí mismo, y ctrl-clic o clic central abren la página como
     siempre. Sin JavaScript solo queda el enlace, que es lo que había. */
  var tree = document.querySelector(".disctree");

  function markBranch(el) {
    var all = tree.querySelectorAll("a.tb");
    for (var i = 0; i < all.length; i++) all[i].classList.toggle("here", all[i] === el);
  }

  if (tree) {
    tree.addEventListener("click", function (e) {
      if (e.metaKey || e.ctrlKey || e.shiftKey || e.button !== 0) return;
      var a = e.target.closest ? e.target.closest("a.tb") : null;
      if (!a) return;
      e.preventDefault();
      disc.value = a.getAttribute("data-disc") || "";
      sub.value = a.getAttribute("data-sub") || "";
      markBranch(a);
      apply();
      var t = document.getElementById("spelltable");
      if (t) t.scrollIntoView({ block: "start", behavior: "smooth" });
    });
  }

  /* Cambiar un desplegable a mano deshace la marca del árbol. */
  function clearBranch() { if (tree) markBranch(null) }

  /* --- enganches ------------------------------------------------------ */

  q.addEventListener("input", apply);
  level.addEventListener("change", apply);
  disc.addEventListener("change", function () { clearBranch(); apply() });
  sub.addEventListener("change", function () { clearBranch(); apply() });
  reset.addEventListener("click", function () {
    q.value = "";
    level.value = "";
    disc.value = "";
    sub.value = "";
    clearBranch();
    apply();
    q.focus();
  });

  apply();
})();
