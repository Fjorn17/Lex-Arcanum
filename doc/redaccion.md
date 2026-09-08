# Guía de redacción de Lex Arcanum

Cómo se escriben las reglas de este suplemento, para que todo suene al mismo manual.

**La norma es el *Manual del Jugador 2024*.** Si algo de esta guía y el manual se contradicen, gana el
manual. Las convenciones en español de este documento están comprobadas contra
`doc/Manual del Jugador 2024.pdf`; las inglesas salen del PHB 2024 / SRD 5.2 y no se han verificado
contra un PDF local.

---

## 1. Lo que hay que tener delante antes de escribir una regla

1. **Segunda persona y presente.** «Obtienes», «Cuando lanzas», «Puedes usar». Nunca «el Magistrado
   obtiene» ni «podrás».
2. **Disparador antes que efecto.** Primero cuándo pasa, luego qué pasa.
   `Cuando [disparador], [efecto].`
3. **Una regla por frase.** Si una frase tiene dos condiciones y una excepción, son tres frases.
4. **Nada de literatura dentro de la regla.** La ambientación va en el párrafo de arriba, en cursiva o
   suelta; el bloque de reglas es seco.
5. **Sin ambigüedad de agente.** Si en la frase hay dos criaturas, ninguna se llama «ella».

---

## 2. Estructura de un rasgo

```
<h3><span class="lvltag">Nivel 7</span> Nombre del rasgo</h3>
<p>Una frase de ambientación, opcional.</p>
<p><b>Subrasgo.</b> Regla.</p>
<p><b>Otro subrasgo.</b> Regla.</p>
```

- **Nombre del rasgo**: en mayúsculas iniciales de estilo título en inglés (*Wire's Edge*), y solo la
  primera en español (*Filo de alambre*).
- **Subrasgo**: en negrita, seguido de **punto**, nunca de dos puntos. `<b>Alcance de la línea.</b>`
- Si el rasgo no tiene partes, no se inventa un subrasgo: va la regla directamente.
- El orden dentro de un rasgo es: **qué te permite** → **cuándo** → **cuánto** → **límite de usos**.

---

## 3. Mayúsculas: el error más frecuente

**El manual en español NO capitaliza los términos de juego. El inglés SÍ.** Esto no es opinión;
está comprobado en el PDF.

| Concepto | Español (correcto) | Inglés (correcto) |
| --- | --- | --- |
| acción adicional | `acción adicional` | `Bonus Action` |
| acción de magia | `acción de magia` | `Magic action` |
| acción de atacar | `acción de atacar` | `Attack action` |
| reacción | `una reacción`, `tu reacción` | `a Reaction`, `your Reaction` |
| ventaja / desventaja | `ventaja`, `desventaja` | `Advantage`, `Disadvantage` |
| puntos de golpe | `puntos de golpe` | `Hit Points` |
| clase de armadura | `clase de armadura` | `Armor Class` |
| estados | `el estado de incapacitado` | `the Incapacitated condition` |
| descansos | `un descanso largo` | `a Long Rest` |
| bonificador por competencia | `bonificador por competencia` | `Proficiency Bonus` |
| terreno difícil | `terreno difícil` | `Difficult Terrain` |
| concentración | `concentración` | `Concentration` |

En los dos idiomas van **en minúscula**: `tirada de salvación` / `saving throw`, `tirada de ataque` /
`attack roll`, `prueba de característica` / `ability check`, `espacio de conjuro` / `spell slot`,
`truco` / `cantrip`.

**Características**: en mayúscula en los dos idiomas cuando se nombran (`Fuerza`, `Inteligencia`,
`Strength`, `Intelligence`).

**Estados en español**: van en minúscula y **concuerdan en género** con la criatura:
`tiene el estado de envenenada`.

---

## 4. Fórmulas fijas

Usa estas literalmente. No las reescribas «mejor».

### Usos limitados
- **ES**: `Puedes usar este rasgo una cantidad de veces igual a tu modificador por Inteligencia
  (mínimo una vez) y recuperas todos los usos tras finalizar un descanso largo.`
- **EN**: `You can use this feature a number of times equal to your Intelligence modifier
  (minimum of once), and you regain all expended uses when you finish a Long Rest.`

### Recarga de un solo uso
- **ES**: `Una vez uses este rasgo, no puedes volver a hacerlo hasta que termines un descanso largo.`
- **EN**: `Once you use this feature, you can't use it again until you finish a Long Rest.`

### Mínimos
- Valor numérico: `(mínimo de 1)` / `(minimum of 1)`
- Número de usos: `(mínimo una vez)` / `(minimum of once)`

### Tiradas de salvación
- **ES**: `El objetivo hace una tirada de salvación de Fuerza contra tu CD de salvación de conjuros.`
- **EN**: `The target makes a Strength saving throw against your spell save DC.`
- Resultado, en párrafos separados y con la etiqueta en cursiva:
  `*Fallo:* …` / `*Éxito:* …` — en inglés `*Failure:* …` / `*Success:* …`
- Si el efecto es el mismo con éxito y fallo, una sola línea: `*Fallo o éxito:*`.

### Alcances y distancias
Siempre métrico primero, imperial entre paréntesis, y espacio duro antes de la unidad:
`9&nbsp;m (30&nbsp;ft)`. En español la coma decimal: `1,5&nbsp;m`. En inglés el punto: `1.5&nbsp;m`.

### Duración
`durante 1 minuto`, `hasta el final de tu siguiente turno`, `hasta el inicio de su siguiente turno`.

### Daño
`<span class="dmg-calc" data-dice="2d8" data-type="Force">2d8 de fuerza</span>`
El atributo `data-type` **siempre en inglés** (`Force`, `Slashing`…): es la clave con la que
`js/wiki-api.js` pide el icono a bg3.wiki. El texto visible va en el idioma de la página.

---

## 5. Conjuros

- En el cuerpo del texto, **en cursiva y minúscula**: *escudo*, *inmovilizar persona*, *fireball*.
- En listas y tablas, con su mayúscula inicial: `Inmovilizar persona`.
- Los nombres en español son los del *Manual del Jugador 2024*. Si un conjuro no está en el manual, se
  traduce y se deja anotado en la página.
- **Referirse a un conjuro no es lo mismo que depender de él.** Un rasgo de nivel 7, 15 o 20 no
  debería empezar por «Cuando lanzas *X*…» salvo que esa sea toda su gracia.

---

## 6. Verbos: los que sí y los que no

| No escribas | Escribe |
| --- | --- |
| «puedes elegir hacer X» | «puedes hacer X» |
| «deberás superar» | «hace una tirada de salvación» |
| «el ataque impactará» | «el ataque acierta» |
| «podrás usar» | «puedes usar» |
| «se considera que…» | «cuenta como…» |
| «a efectos de todo» | «a todos los efectos» |
| «hasta un máximo de» | «hasta» |
| «adicionalmente» | «además» |

En inglés: `you can` nunca `you may`; `on a hit` nunca `if the attack hits`; `you can't` nunca
`you cannot`.

---

## 7. Lo que hace que un rasgo esté mal redactado

Lista de comprobación. Si un rasgo falla en cualquiera de estos puntos, se reescribe.

1. **Dos reglas en una frase.** Sobre todo la trampa de «X, de modo que también Y».
2. **El disparador va al final.** «Ganas Z cuando pasa W» → «Cuando pasa W, ganas Z».
3. **Explica en vez de reglar.** Frases del tipo «lo cual significa que…», «de modo que funciona con…»
   son notas de diseño, no reglas. Van a un `<div class="rulebox">` aparte, no dentro del rasgo.
4. **Metáfora dentro de la regla.** «el cordón lleva el filo» es ambientación; fuera del párrafo de
   reglas.
5. **Enumera rasgos propios dentro de la regla.** Si hace falta decir con qué interactúa, va en una
   frase corta y aparte, o en el `rulebox`.
6. **Falta el límite.** Todo rasgo que se pueda repetir necesita decir cuántas veces y cómo se
   recupera, aunque la respuesta sea «sin límite».
7. **No dice de quién es la CD.** Siempre `contra tu CD de salvación de conjuros`.

---

## 7 bis. Estructura de una página de conjuro

Todas las páginas de `pages/spells/` siguen el mismo molde. El orden **no** es opcional: la ficha
lateral se lee en diagonal y los lectores esperan las claves siempre en el mismo sitio.

```
<div class="spellbody">
  <main>
    <section><h2>Descripción</h2>        …  obligatoria
    <section><h2>A niveles superiores</h2>  … solo si escala
    <section><h2>Notas</h2>              … solo si hay una aclaración de reglas
    <section><h2>Cómo se aprende</h2>    … obligatoria, <ul class="sendlist">
  </main>
  <aside class="infobox">
    <div class="ibhead">  icono + <h2>Nombre del conjuro</h2>
    <div class="ibrows">  las claves, en este orden exacto
    <p class="ibfoot">    origen del texto, si procede
  </aside>
</div>
```

**Orden de las claves de la ficha** (`<span class="ibk">`), sin saltarse ninguna que aplique:

`Origen` · `Nivel` · `Componentes` · `Tiempo de lanzamiento` · `Alcance` · `Duración` ·
`Tirada de salvación` · `Daño` / `Ataque`

En inglés: `Origin` · `Level` · `Components` · `Casting time` · `Range` · `Duration` ·
`Saving throw` · `Damage` / `Attack`.

**Reglas de contenido de la ficha**

- `Nivel`: `3, conjuración` / `Truco, evocación` — número o «truco», coma, escuela en minúscula.
- `Alcance`: `Personal`, `Toque`, `18 m / 60 ft`, `Personal (cono de 4,5 m / 15 ft)`.
- `Duración`: `Instantáneo`, `Concentración, hasta 10 minutos`, `8 horas o permanente`.
- `Tirada de salvación`: `Destreza, la anula` — característica, coma, qué pasa. `Ninguna` si no hay.
- Si el conjuro no tiene icono propio todavía, va el marcador:
  `<div class="spell-icon ph" aria-hidden="true">icono</div>`

**En las listas de conjuros** (`<ul class="spells">`), la clase del `<li>` dice de dónde sale:
`class="phb"` para los del manual, `class="lex"` para los originales del suplemento. No se mezclan
en el mismo `<li>` ni se omiten.

---

## 8. Estructura de las páginas del sitio

- Una subclase: aviso de estado → ambientación (`.subclass-intro`) → conjuros de subclase → rasgos por
  nivel → notas de diseño (`#design-notes`).
- Las **notas de diseño y las de balance nunca se mezclan con las reglas**: van al final, en
  `<div class="rulebox">`.
- Los enlaces de reglas apuntan a bg3.wiki; los de contenido propio, a la página del sitio.
- Cada página existe en `en/` y en `es/` **con la misma ruta**. El nombre visible puede cambiar
  (Forgeknight / Caballero de la Forja); el nombre de archivo, no.

---

## 8 bis. Vocabulario prohibido

No son cuestión de estilo: son términos de Wizards of the Coast y este es un suplemento de fan.

| No uses | Por qué | Usa |
| --- | --- | --- |
| **la Urdimbre**, **el Tejido**, *the Weave* | Es la traducción de *the Weave*, propiedad de WotC | «magia», «energía arcana», o nada |
| **Trama** con mayúscula, en sentido mágico | Mismo problema por la vía del sinónimo | reformula |
| Nombres de deidades, planos o entidades del canon | No hacen falta y arrastran marca | inventa los tuyos |

Los nombres de reglas y estados (*acción adicional*, *apresado*) sí se usan: son mecánicas, están en el
SRD 5.2 bajo CC BY 4.0 y el sitio ya lo atribuye en el pie legal.

**Ojo con esto: «urdidor» sí se usa, «urdimbre» no.** *Urdidor* es el nombre original de la subclase en
el manual de Nivel20 — material propio — y da nombre al **Maestro Urdidor**. *Urdimbre* es la
traducción de *the Weave*. No las confundas ni «corrijas» la una por la otra.

---

## 9. Glosario de nombres propios del suplemento

| Inglés | Español |
| --- | --- |
| Magister | Magistrado |
| Forgeknight | Caballero de la Forja |
| Threadmarshal | Maestro Urdidor |
| Gematurge | Gematurgo |
| Arcane Swordplay | Esgrima arcana |
| Spellsword | Espada conjuradora |
| En Garde | En Garde |
| Touché | Touché |
| Instinctive Trance | Trance instintivo |
| Armored Mind | Mente acorazada |
| Unquestionable Authority | Autoridad intelectual |
| Esoteric Archives | Archivos esotéricos |
| Perfect Concentration | Concentración perfecta |
| Twofold Discipline | Doble disciplina |
| Magic Contract | Contrato mágico |
| Ravaging Cleave | Hendidura arrasadora |
| Chains of Custody | Cadenas de custodia |
| Arcane Thrust | Estocada arcana |
| Bound Weapon | Arma vinculada |
| Gravitational Pull | Tirón gravitatorio |
| Magic Armor | Armadura mágica |

---

## 10. Ejemplo: antes y después

**Antes** (mal — metáfora dentro de la regla, dos reglas en una frase, enumeración de rasgos propios,
sin límite declarado):

> **Reach of the Line.** Your reach with Finesse melee weapons extends to any creature Strung by you
> within 9 m (30 ft): the cord carries the edge. Attacks made this way are melee weapon attacks in
> every respect, which means they work with Arcane Swordplay, En Garde, Touché and your Weapon Mastery
> properties exactly as if you were standing in front of the target.

**Después**:

> El cordón lleva el filo hasta donde no llega el brazo.
>
> **Alcance de la línea.** Tu alcance con armas cuerpo a cuerpo de finura es de 9 m (30 ft) contra
> criaturas hiladas por ti.
>
> **Sigue siendo cuerpo a cuerpo.** Un ataque hecho a ese alcance cuenta a todos los efectos como un
> ataque de arma cuerpo a cuerpo.

Y la nota de que eso habilita Arcane Swordplay, En Garde y Touché baja al `rulebox` de diseño.
