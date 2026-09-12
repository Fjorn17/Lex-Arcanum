# Preguntas abiertas

Cosas que están decididas a medias y que necesitan una respuesta tuya, con mi recomendación
y lo que costaría aplicarla. No he tocado ninguna.

---

## 1. ¿Pueden coexistir *arma espiritual* y *espada arcana*?

**Son el mismo conjuro escrito dos veces.** Las dos crean una forma de Éter denso que flota, se
mueve con una acción adicional y golpea con daño de fuerza. En la ficción no hay ninguna diferencia
entre ellas: una Estrella apretada hasta tener presencia, a la que se le da un perfil y que se
sostiene a distancia de la mano que no la ha soltado. Es astronomía pura en los dos casos.

Y los números tampoco las distinguen. *Arma espiritual* subida a un espacio de nivel 7 hace 6d8,
que son 27 de media. *Espada arcana* hace 4d12, que son 26. Es la misma curva.

> **Recomendación: fundirlas.** Se queda *arma espiritual* (nivel 2, escalando), y *espada arcana*
> se descataloga con el motivo «dos nombres para una sola operación», que es exactamente el motivo
> por el que se fueron *elementalismo* y *saber druídico*.
>
> Si prefieres conservar el nombre *espada arcana* por sabor, la otra forma de hacerlo es al revés:
> que *arma espiritual* llegue hasta nivel 6 y que a partir de 7 el conjuro se llame *espada
> arcana*, como dos entradas del mismo trazado. Es más bonito y es más trabajo.

Aplicarlo son dos líneas en `descatalogados.txt` y `disciplinas.txt`.

---

## 2. ¿Incandescencia debería llamarse Plasma?

**Mi respuesta es que no.** Tres motivos:

1. **El vocabulario de este mundo es de oficio, no de laboratorio.** La doctrina dice, sobre el
   nombre del arte entero, que «nadie bautizó nada de esto con imaginación; se le puso a las cosas
   el nombre de lo que se veía». *Plasma* es una palabra de física del siglo XX y se nota.
2. **La taxonomía ya cuenta la historia del nombre**, y es buena: este cruce se llamaba *Luz* y
   perdió el nombre cuando se entendió que el Éter denso alumbra solo, de modo que la luz no es algo
   que la alquimia tenga que fabricar. Lo que sobrevivió del cruce fue «materia que brilla por su
   propio calor», y esa es literalmente la definición de *incandescencia*. El nombre está ganado.
3. **Plasma tampoco sería exacto.** Fuego más rayo da un gas ionizado si estamos haciendo física de
   verdad, y entonces habría que decidir qué le pasa al resto de la tabla, que no está hecha de
   física de verdad.

Si aun así lo quieres, es un cambio en `taxonomia.pl` y el generador se encarga del resto.

---

## 3. Los conjuros de revivir

Esta no es una pregunta de clasificación. **Es una pregunta sobre la premisa**, y por eso no la he
resuelto yo.

Ahora mismo la doctrina dice, sin matices: *al morir un cuerpo, su alma se reparte en el Éter igual
que se reparte cualquier otra concentración*. Si eso es verdad, no hay nada que traer de vuelta, y
los seis conjuros de la tabla «deshacer la muerte» están fuera por una razón y no por descuido.

Hay tres salidas, y solo una de ellas me parece buena.

### (a) Dejarlo como está

La muerte es definitiva. Es lo que hay hoy y es lo que más peso le da a todo lo demás: a la
Intoxicación, a la Fatiga, a que un Pacto sea un trato y no una herramienta.

### (b) La ventana, antes de que termine de repartirse *(recomendada)*

El propio sistema da la salida sin inventar nada. Una concentración de Éter **no desaparece de
golpe**: se deshace, y cuánto tarda lo decide cuántas veces por encima de su mínimo está (§ *Nada
dura solo*). Un alma es la concentración más densa que un cuerpo llega a sostener, así que **tarda
en bajar de su mínimo**, igual que tarda cualquier otra cosa.

De ahí sale una regla entera, y sale sola:

> **Se puede volver a reunir lo que todavía no ha acabado de repartirse.** La ventana es corta, se
> mide en minutos, y el conjuro es más caro cuanto más tarde llega, porque cada instante que pasa
> hay menos que reunir y más que reponer. Pasada la ventana no hay nada ahí, y ninguna cantidad de
> Éter la alarga.

Consecuencias, que me gustan todas:

- Va a **Espiritismo › Vida**, no a Muerte. Lo que se hace no es actuar sobre un muerto: es volver a
  juntar un pulso que todavía no se ha ido. Muerte sigue siendo lo que se le hace a lo que ya paró.
- Vuelve **un solo conjuro**: *revivificar*, que ya tiene una ventana de 1 minuto escrita. *Alzar a
  los muertos* (10 días), *resurrección* y *resurrección verdadera* siguen fuera, y ahora con un
  motivo mejor que «la muerte es definitiva»: **llegan tarde**.
- Y el mundo no cambia de forma. Sigue sin haber templos que devuelvan gente por dinero, sigue sin
  haber héroes que vuelvan una generación después, y sigue siendo verdad que quien se va, se va.
  Lo único que aparece es el minuto en que todavía se puede correr.

Aplicarlo: sacar *revivificar* de `descatalogados.txt`, ponerlo en Vida, y añadirle a la sección
*Nada dura solo* de la doctrina un párrafo con la regla de la ventana. Media hora.

### (c) Abrirlo del todo

Devolver los seis. No lo recomiendo: se lleva por delante el párrafo del Éter, el sentido de la
tabla «deshacer la muerte» y buena parte de por qué este sistema pesa.

---

## 4. La lista del Magistrado apunta a conjuros descatalogados

Seis, a estas alturas: *siervo invisible*, *corcel fantasma*, *protección contra energía*, *mastín
fiel*, *telaraña* y *telequinesis*.

No lo he tocado porque quitar seis conjuros de la lista de una clase le cambia el presupuesto, y el
análisis vigente ya dice que el Magistrado va por delante del paladín y del explorador en daño
sostenido. Quitarle opciones no es neutro: puede estar bien, pero hay que medirlo.

Las opciones son (i) quitarlos y no reponer, (ii) quitarlos y reponer con conjuros equivalentes del
catálogo, o (iii) recuperar alguno de los seis si encontramos una lectura que pase el filtro. De los
seis, el que más fácil volvería es *telequinesis*, si acabamos abriendo una Rama de fuerza mental.
