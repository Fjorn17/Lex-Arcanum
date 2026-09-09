# Prompt para Claude Design — la sección de Astronomía

Escrito para pasárselo a Claude Design tal cual. Lo que hay debajo de la línea es el prompt;
lo de arriba es el contexto de por qué se le pide esto.

**Contexto.** *Lex Arcanum* es una wiki estática de un suplemento casero para D&D 2024. Toda su
magia se ha reorganizado según un sistema propio: la **astronomía** es el arte entero, y dentro de
ella hay tres **Disciplinas** —alquimia, espiritismo y cosmología— a las que se llega forzando una
Estrella más allá de un umbral. Cada Disciplina se divide a su vez en **subdisciplinas** (los quince
elementos de la alquimia, los Principios del espiritismo y de la cosmología). La sección entera vive
bajo una sola pestaña, `pages/astronomy/`, con 332 páginas por idioma.

Lo que falta es el diseño: hoy las páginas usan el molde genérico del sitio y no comunican ni la
jerarquía ni la excepción más importante del sistema.

---

## Prompt

Diseña las páginas de la sección **Astronomía** de una wiki de rol. Tema oscuro, tipografía Cinzel
para títulos y Spectral para texto, fondo `#0a1420`, paneles `#0d1b2a`, acento `#00a8e8`, enlaces
`#4ea8de`, texto `#c7d5e3`, texto apagado `#8ba3ba`, filetes `#1b4965`. Es una wiki: densidad de
información alta, nada de tarjetas gigantes con mucho aire.

Necesito **cuatro artboards**, en este orden.

### 1. Página de Astronomía (la raíz)

Es la página que explica la magia entera y, a la vez, la raíz de la taxonomía. Lleva unas 3.000
palabras de doctrina en trece secciones (`El Éter`, `El cuerpo`, `La Estrella`, `Las cinco
operaciones`, `La Constelación`, `Las cuatro cualidades`, `Lo que cuesta`, `Nada dura solo`, …).

Lo importante del diseño de esta página es **un diagrama** que enseñe dos cosas a la vez:

1. **La astronomía contiene a las tres Disciplinas.** No son cuatro cosas al mismo nivel: alquimia,
   espiritismo y cosmología están *dentro* de la astronomía, y se llega a cada una cruzando un
   umbral con nombre — **el Crisol** (a la materia), **el Abismo** (al espacio y el tiempo) y un
   tercer umbral **todavía sin nombre** (a la vida). El diagrama tiene que dejar ver que ese tercero
   está sin bautizar, no esconderlo.
2. **Hay conjuros que no cruzan ningún umbral y son solo astronomía.** Son 70 de 302 — luz, fuerza
   cinética, guardas, y todo lo que detecta, estorba o deshace magia. No son «los que sobran»: son
   el fondo del arte, lo que se hace con el Éter sin dirigirlo a nada. El diagrama tiene que dar a
   esa región el mismo peso visual que a las tres Disciplinas, o más.

Propuestas de forma, elige o mezcla: un círculo grande (la astronomía) con tres lóbulos dentro
separados por sus umbrales y una corona interior que es la región «solo astronomía»; o un diagrama
de conjunto donde el marco exterior está etiquetado y numerado. Cada región lleva su recuento de
conjuros y es un enlace. Que funcione en SVG inline, sin librerías, y que se lea en móvil.

Debajo del diagrama va el cuerpo doctrinal. Necesito una solución para leer trece secciones largas:
índice lateral pegajoso, o secciones plegables, o las dos. Y una ficha lateral con los datos fijos
(material, estado base, marca, techo de dos Estrellas, en qué se paga).

### 2. Página de Disciplina (usa **Alquimia** de ejemplo)

Lleva: doctrina propia (4–5 párrafos), su ficha lateral (estado base «el Crisol», a qué fenómeno
estelar imita, su marca, cómo se ordena), **la rejilla de sus quince subdisciplinas** —los cinco
elementos primarios y los diez cruces— y sus conjuros.

- La rejilla de subdisciplinas es lo que más se va a usar: quince entradas con nombre, una línea de
  qué son y su recuento. Los cinco primarios y los diez secundarios son cosas distintas y hay que
  distinguirlos. Los secundarios nacen del encuentro de dos primarios (Lava = Tierra + Fuego), y
  enseñar esa procedencia sería una victoria de diseño.
- Cuatro subdisciplinas tienen **cero conjuros** y eso es intencionado: hay que enseñarlo como dato,
  no esconderlas ni dejarlas rotas.

### 3. Página de subdisciplina (usa **Fuego** de ejemplo)

Corta: nombre, una línea de qué es, ficha lateral (clase de elemento, de qué encuentro nace) y sus
conjuros.

### 4. El índice de la sección y su buscador

Hoy es una sola página con el árbol entero arriba y, debajo, una tabla filtrable de los 302
conjuros con buscador por nombre y dos desplegables (Disciplina y subdisciplina). Es funcional y
fea, y el árbol y la tabla no se hablan.

Decide qué hacer con ella. Lo que quiero resolver:

- Que elegir una rama del árbol filtre la tabla, en vez de ser dos cosas separadas.
- Que se vea de un vistazo cuánto pesa cada rama (mente tiene 72 conjuros, edad tiene 0).
- Buscar por nombre tiene que seguir siendo instantáneo y sin acentos.
- Sin JavaScript la página tiene que seguir sirviendo: hoy la tabla sale completa y ordenada por
  nivel, y eso no se puede perder.

### Regla que atraviesa las cuatro

**Los conjuros se listan siempre en tablas separadas por nivel de conjuro**, no en una sola tabla
larga: una tabla para trucos, otra para nivel 1, otra para nivel 2, y así. Cada tabla con su
encabezado. Diséñalo para que aguante tanto un caso de 2 conjuros como uno de 72, y para que en la
página de Astronomía —que tiene 70 repartidos por todos los niveles— no se convierta en un muro.

### Fuera de alcance por ahora

**Las Estrellas.** Cada Disciplina y cada subdisciplina tiene su catálogo de Estrellas (las
operaciones del sistema de magia) y hoy salen listadas en las páginas. Ignóralas por completo: no
las diseñes, no les hagas sitio. Se retoman más adelante.
