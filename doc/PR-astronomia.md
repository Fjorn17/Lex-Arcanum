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

---

## Añadido después (commits 0e60cd9 … 0125bbc)

### El árbol tiene tres alturas

Mente y Naturaleza vuelven a existir como subdisciplinas de Espiritismo, y lo que antes colgaba
directamente de Espiritismo ahora cuelga de ellas:

    Mente      → Ilusiones, Sujeción, Sentidos, Ánimo, Memoria
    Naturaleza → Animales, Plantas, Hongos
    Cosmología → Tiempo, Espacio, Gravedad

*Sujeción* se llama así y no *control mental* a propósito: controlar sugiere una mano en una
palanca, y lo que se impone es el acto, no la persona. *Hongos* está vacía a posta, y lo dice.

Los dos generadores aprenden la tercera altura: la página de Mente lista los 71 conjuros de sus
cinco Ramas, la ficha de un conjuro enseña la cadena entera (Espiritismo › Mente › Ilusiones), y
en el buscador `data-sub` lleva la cadena completa, de modo que filtrar por Mente trae sus Ramas.

### Una página nueva: cómo se escribe un conjuro

`pages/astronomy/rules.html`, generada como las demás. Dos mitades:

- **Un filtro de diez preguntas** sacadas de la doctrina. Un conjuro que falla una no llega a
  tener números: llega a tener una línea en los descatalogados diciendo por qué.
- **Los números**, que no son convenios inventados sino medidas sobre las fichas ya escritas:
  mediana y techo de daño por nivel, qué salvación toca según lo que le hace a un cuerpo, tamaños
  de área, alcances, cuánta Concentración pide cada nivel, y cómo escala el catálogo.

En medio queda escrito el árbol de decisión de la clasificación, con la regla que lo gobierna:
**lo que se pone encima de algo que ya existe es astronomía, y solo es alquimia si la materia pasa
a ser otra cosa.**

`doc/spells/audita.pl` vuelve a pasar el catálogo por ese filtro y avisa de lo que se sale.

### La doctrina, reescrita

El texto decía lo que tenía que decir y lo decía como un manifiesto: cada párrafo cerraba con una
máxima en negrita. Mismos hechos, mismas diez secciones, misma fuente (las *Reglas del Sistema de
Magia* v0.5), contado como lo contaría alguien que sabe del oficio.

### Conjuros

- **spellchanges.txt aplicado**: siete descatalogados con su motivo, tres movidos de sitio, la
  runa explosiva de *glifo custodio* pasa a daño de fuerza y nada más, y *tirón gravitatorio* deja
  de ser truco (nivel 1, 2d6, escala con el espacio).
- **Doce conjuros recuperados de ediciones viejas**, entre ellos *devolución de conjuros*, y tres
  nuevos —*erupción volcánica*, *tormenta de arena*, *torbellino*— que cierran el juego de
  cataclismos de nivel 8 y llenan Lava y Arena, que estaban vacías.
- **Once fichas dejan de ser permanentes.** Un ritual repetido ya no vuelve permanente nada:
  mantiene algo en pie mientras alguien siga volviendo. Un círculo de teletransportación que se
  salta un día desaparece.
- **43 candidatos de Pathfinder** en `doc/propuestas/`, con ficha completa en los dos idiomas y
  una lista con casillas para elegir. Escritos de cero: ni una línea de texto de Paizo.

### Un arreglo visual

Las etiquetas de los umbrales del diagrama tenían la línea base del texto en el borde de la caja,
así que las mayúsculas se salían por arriba.

---

## Lo que sigue pendiente

- La lista del Magistrado apunta a cuatro conjuros descatalogados (*siervo invisible*, *corcel
  fantasma*, *protección contra energía*, *mastín fiel*), y ahora también a *telaraña* y
  *telequinesis*. Quitarlos cambia el presupuesto de la clase, así que está sin tocar.
- *Vapor* e *Incandescencia* siguen vacías y no hay nada en ninguna edición que las llene: hay que
  escribirlas de cero.
- `doc/spells/` se commitea, contra lo que dice CLAUDE.md, porque el sitio ya no se puede
  regenerar sin ello.
