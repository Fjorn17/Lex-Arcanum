# Cuerpo del PR — Astronomía como sección única

Pégalo en <https://github.com/Fjorn17/Lex-Arcanum/compare/main...feat/cover-page-and-site-restructure>.

Título sugerido: **Astronomía: una sección, un sistema de magia y 347 conjuros reclasificados**

---

## Qué hace

Reorganiza toda la magia del suplemento alrededor del sistema de magia propio (astronomía y sus
tres Disciplinas) y la reúne bajo una sola pestaña.

### La sección

Conjuros y Disciplinas eran dos pestañas y dos carpetas. Ahora son una: `<lang>/pages/astronomy/`,
con 347 conjuros, 31 páginas de taxonomía y un índice que lleva el árbol arriba y la tabla
filtrable de todos los conjuros debajo. Los dos árboles de idioma siguen siendo espejo ruta por
ruta.

### La página de Astronomía

Deja de ser la ficha de una Disciplina más y pasa a explicar **el arte entero**: qué es el Éter,
cómo lo dirige el cuerpo, qué es una Estrella, las cinco operaciones, la Constelación, las cuatro
cualidades, en qué se paga, la regla de que nada dura solo, y los tres umbrales que abren las
Disciplinas. Trece secciones, sacadas de `Reglas_Sistema_de_Magia_v0.5`.

### Descatalogados

Sección nueva. 77 conjuros que **existen y tienen página pero no cuelgan de ninguna Disciplina**,
agrupados en cinco tablas: sin Disciplina, invocaciones, veneno, cromáticos y resurrección. Cada
uno lleva escrito en su propia página por qué está fuera.

Con esto vuelven los 44 conjuros que se habían borrado por incompatibles. Un suplemento que borra
en silencio lo que no le encaja no enseña nada; uno que escribe qué no supo colocar, y por qué, es
un documento con el que se puede discutir.

### Fuera lo sagrado

Este mundo no tiene dioses que repartan magia, así que ningún conjuro puede llamarse por uno. Doce
renombrados en los dos idiomas:

| Antes | Ahora (en) | Ahora (es) |
| --- | --- | --- |
| Divine Favor | Starlit Weapon | Arma estelar |
| Divine Smite | Radiant Strike | Golpe radiante |
| Searing Smite | Searing Strike | Golpe abrasador |
| Shining Smite | Shining Strike | Golpe fulgurante |
| Shield of Faith | Aegis | Égida |
| Sacred Flame | Astral Flame | Llama astral |
| Prayer of Healing | Vigil of Healing | Vigilia sanadora |
| Bless | Emboldening | Coraje |
| Bane | Dread | Desánimo |
| Hellish Rebuke | Scalding Rebuke | Reprensión abrasadora |
| Grease | Mud Slick | Charco de barro |
| Water Breathing | Gills | Branquias |

Y con ellos los componentes y descripciones que invocaban símbolos sagrados, pergaminos de
oraciones o escalas morales.

### Reglas y catálogo

- **Vuelve el Principio de Porvenir** a la cosmología, mucho más pequeño que antes: no lee el
  futuro —nadie lo ha escrito— sino un desenlace probable de lo que ya está en marcha. Lo habitan
  *Impacto certero* y *Guía*.
- **Respirar bajo el agua se parte en dos** conjuros de nivel 2: *Burbuja de aire* (alquimia ›
  aire) y *Branquias* (espiritismo › naturaleza).
- **Daños fijados**: *Estallido mágico* solo fuerza; *Espíritus guardianes* solo necrótico;
  *Palabra de poder: matar* pasa de psíquico a necrótico.
- **Movimientos**: *Lluvia de meteoritos* → gravedad; *Tormenta de la venganza* → alquimia sin
  elemento; *Arma vinculada* → paso; *Contrato mágico* → astronomía.
- **`cruces.txt`**, nuevo: marca cuándo un conjuro cruza un segundo umbral (Reglas 6.4). Estrena
  *Golpe flamígero*.
- Ocho iconos nuevos de bg3.wiki.

### Presentación

En las páginas de Disciplina y subdisciplina los conjuros se listan en **tablas separadas por nivel
de conjuro**, no en una tabla larga. Las Estrellas de cada Disciplina quedan aparcadas tras un flag
(`$SHOW_STARS`): el dato sigue en `taxonomia.pl`, no se publica.

## Comprobado

- Cero enlaces internos rotos en todo el sitio.
- Los dos árboles de idioma, espejo ruta por ruta.
- Nada de inglés colado en el árbol español.
- Los generadores vuelven a producir el sitio entero desde los datos.

## Lo que conviene mirar

- **Se commitea `doc/spells/`**, que `CLAUDE.md` marca como material de trabajo que no se sube sin
  preguntar. Va aquí porque el sitio ya no se puede regenerar sin esos ficheros.
- Los doce nombres nuevos son propuesta: cambiarlos es una línea en `nombres-en.txt` y otra en
  `nombres-es.txt`.
- *Telaraña* se dejó como estaba. Renombrarla a *Pantanal* pedía además reescribir la cláusula de
  inflamabilidad, que es una decisión de reglas y no de nombre.
- La lista de conjuros del Magistrado todavía incluye conjuros que ahora están descatalogados.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
