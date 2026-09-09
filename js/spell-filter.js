/* Buscador de conjuros / Spell finder.
 *
 * Las tablas salen del generador ya completas y agrupadas por nivel, así que
 * sin JavaScript la página sigue sirviendo: aquí solo se añade la posibilidad
 * de filtrar por nombre, nivel, Disciplina y subdisciplina, y de ordenar por
 * columna dentro de cada nivel.
 *
 * Las claves de filtrado viajan en los data-* de cada fila y van SIEMPRE en
 * inglés (data-discipline="alchemy"), igual que data-type en los daños: el
 * texto visible cambia de idioma, la clave no.
 */
(function () {
  "use strict";

  var bar = document.getElementById("spellfilter");
  var secs = Array.prototype.slice.call(document.querySelectorAll(".lvlsec"));
  if (!bar || !secs.length) return;

  var empty = document.getElementById("sf-empty");
  var count = document.getElementById("sf-count");
  var q = document.getElementById("sf-q");
  var level = document.getElementById("sf-level");
  var disc = document.getElementById("sf-discipline");
  var sub = document.getElementById("sf-sub");
  var reset = document.getElementById("sf-reset");
  var tree = document.querySelector(".treepanel");

  /* Cada sección guarda sus filas y su cabecera de recuento. */
  var groups = secs.map(function (sec) {
    return {
      sec: sec,
      level: sec.getAttribute("data-level"),
      table: sec.querySelector("table"),
      body: sec.querySelector("tbody"),
      rows: Array.prototype.slice.call(sec.querySelectorAll("tbody tr")),
      num: sec.querySelector(".lvlsec-n b")
    };
  });

  var countLabel = count ? count.getAttribute("data-label") || "" : "";
  var countOne = count ? count.getAttribute("data-label-one") || countLabel : "";

  bar.hidden = false;

  /* --- filtrado ------------------------------------------------------- */

  /* Sin acentos y en minúscula, para que "alquimia" encuentre "Alquimia". */
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

    for (var g = 0; g < groups.length; g++) {
      var grp = groups[g];
      var here = 0;
      if (lv !== "" && grp.level !== lv) {
        grp.sec.hidden = true;
        continue;
      }
      for (var i = 0; i < grp.rows.length; i++) {
        var r = grp.rows[i];
        var ok = true;
        if (text && fold(r.getAttribute("data-name")).indexOf(text) === -1) ok = false;
        if (ok && dc !== "" && r.getAttribute("data-discipline") !== dc) ok = false;
        if (ok && sb !== "" && r.getAttribute("data-sub") !== sb) ok = false;
        r.hidden = !ok;
        if (ok) here++;
      }
      grp.sec.hidden = here === 0;
      if (grp.num) grp.num.textContent = here;
      shown += here;
    }

    if (empty) empty.hidden = shown !== 0;
    if (count) count.textContent = shown + " " + (shown === 1 ? countOne : countLabel);
  }

  /* --- ordenación, dentro de cada nivel -------------------------------- */

  var sortKey = "name";
  var sortAsc = true;

  function valueOf(row, key) {
    return row.getAttribute("data-" + key) || "";
  }

  function sortBy(key) {
    if (sortKey === key) sortAsc = !sortAsc;
    else { sortKey = key; sortAsc = true }
    var dir = sortAsc ? 1 : -1;

    for (var g = 0; g < groups.length; g++) {
      var grp = groups[g];
      grp.rows.sort(function (a, b) {
        var va = valueOf(a, sortKey);
        var vb = valueOf(b, sortKey);
        if (va < vb) return -1 * dir;
        if (va > vb) return 1 * dir;
        /* A igualdad, siempre por nombre: el orden queda estable. */
        var na = valueOf(a, "name");
        var nb = valueOf(b, "name");
        return na < nb ? -1 : na > nb ? 1 : 0;
      });
      var frag = document.createDocumentFragment();
      for (var i = 0; i < grp.rows.length; i++) frag.appendChild(grp.rows[i]);
      grp.body.appendChild(frag);

      var heads = grp.table.tHead.rows[0].cells;
      for (var j = 0; j < heads.length; j++) {
        var k = heads[j].getAttribute("data-sort");
        if (!k) continue;
        if (k === sortKey) heads[j].setAttribute("aria-sort", sortAsc ? "ascending" : "descending");
        else heads[j].removeAttribute("aria-sort");
      }
    }
  }

  /* Las dos primeras columnas ordenan; las demás son datos sueltos. */
  var SORTABLE = { 0: "name", 1: "discipline" };
  for (var g = 0; g < groups.length; g++) {
    var heads = groups[g].table.tHead.rows[0].cells;
    for (var j = 0; j < heads.length; j++) {
      var key = SORTABLE[j];
      if (!key) continue;
      (function (th, k) {
        th.setAttribute("data-sort", k);
        th.tabIndex = 0;
        th.setAttribute("role", "button");
        th.classList.add("sortable");
        th.addEventListener("click", function () { sortBy(k) });
        th.addEventListener("keydown", function (e) {
          if (e.key === "Enter" || e.key === " ") { e.preventDefault(); sortBy(k) }
        });
      })(heads[j], key);
    }
  }

  /* --- el árbol filtra ------------------------------------------------- */

  /* Cada rama es también un enlace a su página, y eso se conserva: pinchar
     filtra aquí mismo, y ctrl-clic o clic central abren la página como
     siempre. Sin JavaScript solo queda el enlace, que es lo que había. */
  function markBranch(el) {
    if (!tree) return;
    var all = tree.querySelectorAll("a.tb");
    for (var i = 0; i < all.length; i++) all[i].classList.toggle("here", all[i] === el);
  }

  function syncBranch() {
    if (!tree) return;
    var dc = disc.value, sb = sub.value;
    var all = tree.querySelectorAll("a.tb");
    var match = null;
    for (var i = 0; i < all.length; i++) {
      var a = all[i];
      if ((a.getAttribute("data-disc") || "") === dc && (a.getAttribute("data-sub") || "") === sb) {
        match = a;
        break;
      }
    }
    markBranch(match);
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
    });
  }

  /* --- enganches ------------------------------------------------------ */

  q.addEventListener("input", apply);
  level.addEventListener("change", apply);
  disc.addEventListener("change", function () { syncBranch(); apply() });
  sub.addEventListener("change", function () { syncBranch(); apply() });
  reset.addEventListener("click", function () {
    q.value = "";
    level.value = "";
    disc.value = "";
    sub.value = "";
    syncBranch();
    apply();
    q.focus();
  });

  syncBranch();
  apply();
})();
