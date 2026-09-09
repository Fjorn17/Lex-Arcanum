# Los 339 conjuros del SRD 5.2.1, en los dos idiomas

Cierra la sección de conjuros: además de los siete originales del suplemento, el sitio tiene ahora
una página por cada conjuro del *System Reference Document 5.2.1*, en inglés y en español, y un
índice que se puede filtrar y ordenar.

## Qué trae

**678 páginas de conjuro** (339 × 2 idiomas) más los dos índices. Siguen el molde de
`doc/redaccion.md` §7 bis: descripción → a niveles superiores → cómo se aprende, y la ficha lateral
con las claves en el orden fijado. Métrico delante del imperial (`18 m / 60 ft` en la ficha,
`18 m (60 ft)` en el cuerpo) y `data-type` siempre en inglés en los `.dmg-calc`, como manda
`CLAUDE.md`.

**Nombres arreglados** en las listas de la clase y las subclases: 186 entradas repasadas. Se han
corregido los calcos de Baldur's Gate 3 (*Colour Spray* → Color Spray, *Mage Armour* → Mage Armor,
*Enhance Leap* → Jump, *Otiluke's Resilient Sphere* → Resilient Sphere) y una veintena de
traducciones que no eran las del *Manual del Jugador 2024* (*Premura* → Acelerar, *Descerrajar* →
Abrir, *Lenguas* → Don de lenguas, *Esfera resistente* → Esfera elástica…). Cada entrada enlaza ya a
su página local y lleva el icono de bg3.wiki cuando existe: 186 de los 339 lo tienen.

**Índice ordenable.** La tabla del SRD se puede buscar por nombre (sin distinguir acentos) y filtrar
por nivel, escuela y clase; las cabeceras de Nombre, Nivel, Escuela y Clases ordenan al pulsarlas.
Sin JavaScript la tabla sigue completa y ordenada por nivel.

## Licencias

El texto inglés es el del SRD 5.2.1, bajo CC BY 4.0, y el pie de cada página ya lo atribuye.

**La traducción al español es propia.** Del *Manual del Jugador 2024* se han tomado solo los nombres
de los conjuros y el vocabulario de reglas (comprobado contra el PDF: *apresado* = Restrained,
*agarrado* = Grappled, términos de juego en minúscula), nunca su texto, que sí tiene derechos
reservados de su editorial.

A los conjuros que el SRD renombró para quitarles un nombre propio de Wizards se les ha quitado
también en español: *Mano de Bigby* → **Mano arcana**, *Tentáculos negros de Evard* → **Tentáculos
negros**, y así con doce más.

## Cómo se regenera

Las páginas del SRD **no se editan a mano**:

```bash
perl doc/spells/build-pages.pl
```

| Qué cambiar | Dónde |
| --- | --- |
| Texto inglés | `doc/spells/srd-en.txt` (lo regenera `extract-srd.pl`) |
| Traducción | `doc/spells/es/NN.txt` |
| Nombre en español | `doc/spells/nombres-es.txt` |
| Tablas y perfiles | `doc/spells/arreglos-en.txt`, `arreglos-es.txt` |
| Iconos | `doc/spells/iconos-bg3.txt` |
| Lista del Magistrado | `doc/spells/magister.txt` |

Los catorce conjuros con tabla o perfil (*teletransporte*, *muro prismático*, *hallar corcel*,
*invocar dragón*…) llevan la tabla maquetada a mano, porque `pdftotext` los devuelve como un párrafo
aplastado.

## Comprobado

- Enlaces internos rotos: **solo los cuatro que ya existían** antes de esta rama (tres imágenes
  `.webp` que faltan en páginas propias y un marcador en `items/index.html`). Ninguno de lo generado.
- Inglés colado en el árbol español: **cero**.
- Filtro y ordenación probados en el navegador: 218 conjuros de mago, 42 de nivel 3, 27 de
  nigromancia; orden por escuela de abjuración a transmutación, alternando ascendente y descendente.

## Queda pendiente

Siete conjuros de las listas del Magistrado están en el *Manual del Jugador* pero **no en el SRD**:
Friends, Blade Ward, Compelled Duel, Arcane Vigor, Elemental Weapon, Steel Wind Strike y Circle of
Power. Llevan el nombre correcto en los dos idiomas y se han dejado sin enlace, porque no hay página
que enlazar ni se puede publicar su texto. Habría que decidir si se cambian por equivalentes del SRD.
