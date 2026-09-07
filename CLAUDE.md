# Lex Arcanum

Wiki estática de un suplemento casero para D&D 2024 / Baldur's Gate 3. Sin build, sin dependencias:
HTML plano, un CSS y tres JS (`lang.js`, `wiki-api.js` y `spell-filter.js`). Se publica con
GitHub Pages.

## Antes de escribir o tocar cualquier regla

**Lee `doc/redaccion.md`.** Define cómo se redactan las reglas de este suplemento siguiendo el
*Manual del Jugador 2024*: estructura de un rasgo, fórmulas fijas de usos y salvaciones, mayúsculas
(el manual en español **no** capitaliza los términos de juego; el inglés **sí**), y el glosario de
nombres propios en los dos idiomas. No improvises redacción de reglas sin haberla leído.

La fuente normativa está en `doc/Manual del Jugador 2024.pdf`. Se puede consultar con
`pdftotext -f N -l M -layout -enc UTF-8`.

## Estructura

```
index.html          puerta de idioma (redirige a /en/ o /es/)
en/  es/            dos árboles espejo, MISMAS rutas dentro
analysis/           documentos internos de balance, solo español, noindex
css/ js/ assets/    compartidos por los dos árboles
doc/                notas de desarrollo, fuera del sitio publicado
```

**Los dos árboles son espejo ruta por ruta.** El selector de idioma cambia `en/` por `es/` en la ruta
actual, así que un archivo que se mueve o se renombra hay que moverlo en los dos. El nombre visible sí
puede diferir (`forgeknight.html` es *Forgeknight* y *Caballero de la Forja*).

## Reglas de la casa

- **Nunca traduzcas el atributo `data-type`** de `.dmg-calc` / `.dmg-type`: es la clave con la que
  `js/wiki-api.js` pide el icono a bg3.wiki. Va siempre en inglés.
- **Nunca renombres `id=""` de rasgos** (`#f-arcane-swordplay`, `#progression`): hay enlaces internos
  y desde el análisis apuntando a ellos.
- Toda página nueva necesita: `lang`, `canonical`, los tres `hreflang`, favicon, el selector
  `.langsw`, `js/lang.js`, el pie legal y el enlace discreto `.backstage` al análisis.
- Después de tocar rutas, comprueba enlaces rotos antes de dar nada por hecho.

## Trabajo en paralelo

`doc/spells/` es el material de trabajo de la importación de conjuros del SRD 5.2.1
(`extract-srd.pl` y sus volcados). **No es parte del sitio publicado y no se commitea sin
preguntar**: puede haber otra sesión escribiendo ahí a la vez.

Si vas a tocar `en/pages/spells/` o `es/pages/spells/`, comprueba antes si hay trabajo en curso en
`doc/spells/`, porque esas páginas son justo lo que se genera desde ahí.

**Las páginas de conjuros del SRD no se editan a mano: se generan.** Todo `en/pages/spells/*.html` y
`es/pages/spells/*.html` (menos los siete conjuros propios del suplemento) sale de
`perl doc/spells/build-pages.pl`. Si hay que cambiar el texto de un conjuro, se cambia el dato y se
vuelve a generar:

| Qué cambiar | Dónde |
| --- | --- |
| Texto inglés | `doc/spells/srd-en.txt` (lo regenera `extract-srd.pl`) |
| Traducción | `doc/spells/es/NN.txt` |
| Nombre en español | `doc/spells/nombres-es.txt` |
| Tablas y perfiles | `doc/spells/arreglos-en.txt` y `arreglos-es.txt` |
| Iconos | `doc/spells/iconos-bg3.txt` (lo regeneran los `iconos-bg3*.sh`) |
| Lista del Magistrado | `doc/spells/magister.txt` |
| Molde de la página | `doc/spells/build-pages.pl` |

`doc/spells/listas.pl` es lo que repasa las listas `<ul class="spells">` de la clase y las subclases:
pone el nombre del SRD en inglés, el del *Manual del Jugador* en español, el enlace a la página local
y el icono de bg3.wiki.

## Comprobaciones útiles

```bash
# enlaces internos rotos en todo el sitio
for f in $(find . -name "*.html" -not -path "./.git/*" -not -path "./doc/*"); do d=$(dirname $f); grep -o '\(href\|src\)="[^"#][^"]*"' $f | sed 's/.*="//;s/"//' | grep -v '^http' | while read l; do t="${l%%#*}"; [ -z "$t" ] && continue; [ -e "$d/$t" ] || echo "ROTO: $f -> $l"; done; done
```

```bash
# inglés que se ha colado en el árbol español
for f in $(find es -name "*.html"); do n=$(perl -0ne 's{<script.*?</script>}{}gs; s{<footer.*?</footer>}{}gs; s{<[^>]+>}{ }g; s{&[a-z]+;}{ }g; my $x=0; $x++ while /\b(?:the|you|your|with|that|when|which|must|damage|spell|creature|attack|from)\b/gi; print $x;' $f); [ "$n" != "0" ] && echo "$f: $n"; done
```

## Estado

Ver `README.md` para el estado de cada sección y `analysis/` para las mediciones de balance. El
análisis vigente concluye que el Magistrado va por delante del paladín y del explorador en daño
sostenido sin gastar recursos: **cualquier rasgo nuevo que añada daño hay que justificarlo contra
eso.**
