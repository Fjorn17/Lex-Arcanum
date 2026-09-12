# Las Disciplinas del arte y sus subdisciplinas, con su doctrina y su catalogo
# de Estrellas. Lo lee build-disciplines.pl.
#
# Fuentes: Reglas_Sistema_de_Magia_v0.5.md (la base cerrada) y
# URD_NAR-MAGIA_v1.0.docx (el catalogo de las 79 Estrellas). Donde v0.5 retira
# algo que v1.0 tenia, la pagina lo dice en vez de callarlo.
#
# Campos de un nodo:
#   key      la clave, que es tambien el nombre del archivo
#   kind     art | discipline | sub
#   parent   la clave del padre
#   name     el nombre visible en los dos idiomas
#   lead     la linea bajo el titulo
#   info     filas de la ficha lateral: [ clave_en, clave_es, valor_en, valor_es ]
#   body     los parrafos, HTML crudo
#   stars    las Estrellas: { en, es, kind, note }
#            kind: substance | property | '' (las que no llevan clase)

use strict;
use warnings;
use utf8;

my @T = (

# ============================================================ EL ARTE ENTERO
{
  key => 'astronomy', kind => 'art', parent => undef,
  name => { en => 'Astronomy', es => 'Astronomía' },
  lead => { en => 'The whole art: what the Ether is, and what can be done to it',
            es => 'El arte entero: qu&eacute; es el &Eacute;ter y qu&eacute; se le puede hacer' },
  info => [
    [ 'Material', 'Material', 'The Ether, which is in everything', 'El &Eacute;ter, que est&aacute; en todo' ],
    [ 'Base state', 'Estado base', 'None', 'Ninguno' ],
    [ 'Mark', 'Marca', 'The unmarked circle', 'El c&iacute;rculo sin marcar' ],
    [ 'Ceiling', 'Techo', 'Two Stars, one per hand', 'Dos Estrellas, una por mano' ],
    [ 'Paid in', 'Se paga en', 'Concentration, Mental Fatigue, Intoxication',
      'Concentraci&oacute;n, Fatiga Mental, Intoxicaci&oacute;n' ],
    [ 'Subdivisions', 'Subdivisiones', 'The three Disciplines', 'Las tres Disciplinas' ],
  ],
  body => {
    en => [
'<p><b>Magic here is one art, and it has one material.</b> Every Discipline on this site and every spell in the catalogue is something done to the Ether. What follows is what the Ether is and what can be done to it; the three Disciplines are only the thresholds it can be forced past.</p>',

'<h2>The Ether</h2>',
'<p>It soaks all matter, living and inert, and always has. It has no origin to date and no source to run dry, and it crosses any body as constantly and as involuntarily as heat or the pressure of the air. Nobody who breathes has ever not been bathed in it.</p>',
'<p>Ambient, it cannot be seen. <b>Dense, it shines</b> &mdash; and that one fact named the whole art. A working in progress is a set of lit points joined by faint threads, which is what a constellation looks like; and <i>to light</i> a Constellation is not a pretty figure of speech, it is what happens. Nobody named any of this with imagination. People called things what they saw.</p>',
'<p>It is neither made nor destroyed: it is gathered, and gathering it here takes it from there. Every concentration leaves a thinned halo around it in which everyone &mdash; the one who gathered it included &mdash; channels worse.</p>',
'<p>It is a fluid and it has volume, so it can be sharpened, spread and pressed, and what it does depends on how densely it is packed. Very little of it gives <b>light</b>, and that is free. A middling density gives <b>movement and force</b>. A high density gives <b>presence</b>: it weighs, it strikes, it gets in the way &mdash; and that is ruinously expensive, which is the whole balance between this art and Alchemy. Astronomy can hit like a rock by paying far more than Alchemy pays to make the rock.</p>',
'<p><b>When a body dies its soul scatters into the Ether.</b> That is why death is final here, and why nothing in this supplement brings anyone back.</p>',

'<h2>The body</h2>',
'<p>Everyone carries an <b>Etheric system</b>: an inner network that gives the Ether shape, born in the brain and built to the same architecture as the nervous system. The brain gathers the Ether, orders it and drives it to a <b>termination</b> &mdash; an organ evolution reused, whose earlier job decides what it can produce. A specialised organ yields one fixed effect by instinct. <b>A human hand yields any of them</b>, and its versatility is one of holding, not of movement.</p>',
'<p>Two hands, two Stars. <b>Nobody holds more than two at once</b>, and no amount of mastery raises the number: the limit is the body, not the skill. The only way past it is a <b>Conjunction</b>, several people running one design with one entry point each, which is why the serious work of this world is collective.</p>',

'<h2>The Star</h2>',
'<p>A <b>Star</b> is a mass of Ether gathered and held. It exists for as long as somebody holds it, and it shines, because it is dense Ether.</p>',
'<p>It is born by <b>Accretion</b>: driving your own flow of Ether above its passive rate, at a speed set by your Will. Accretion does not stop once the Star exists, so <b>its size stays open until the instant it is handed over</b>. Left unfed it <b>wanes</b>, bleeding out into its own halo &mdash; holding a Star is not having a hand busy, it is going on pouring, and Focus sustains the trickle rather than the idea.</p>',
'<p>There is no such thing as stored power. Not because of the waning, which can be paid for, but because there are only two hands and everything carried has to be fed. <b>Nobody arrives anywhere already loaded.</b></p>',

'<h2>The five operations</h2>',
'<p>Four of them change how many Stars are in play, and those four are the points a written design gives a name to. The fifth changes not the count but what the Star is.</p>',
'<ul class="sendlist">
            <li><b>Gather</b> <i>(Lodestar)</i> &mdash; start piling up Ether. One per astronomer, and it is never written down: it is always the same act.</li>
            <li><b>Transform</b> <i>(the Filament)</i> &mdash; give the Ether a state, which is what decides what it will do when released. It is done with the mind: <b>there are no gestures</b>. Each Transformation has a word of its own, and the word helps but is never required &mdash; worked in silence it costs more Concentration and fails more often. <i>The apprentice speaks; the master does not.</i></li>
            <li><b>Split</b> <i>(Fork)</i> &mdash; share one Star between two, without duplicating the Ether. It needs a free hand, and it undoes nothing: both halves keep the whole state.</li>
            <li><b>Merge</b> <i>(Convergence)</i> &mdash; fuse two Stars, each of which must first have reached the minimum of its own state. The Ether adds up and the states meet, and what comes out was neither of the two. It is where anything new is found.</li>
            <li><b>Hand over</b> <i>(Verge)</i> &mdash; stop holding.</li>
          </ul>',
'<p><b>Handing over is not an act with rules of its own: it is the moment the spell ends.</b> What happens next is decided by the state the Star was carrying, not by the letting go &mdash; and with no Transformation of delivery it simply happens where the hand is. Gathering Ether and releasing it is still a complete spell; it is the poorest one there is.</p>',
'<p>Which gives the rule that governs everything: <b>what the Ether</b> is <b>acts always; what has been imposed on it acts on release.</b> A Star lights the hand from the first instant, and pressed hard enough it weighs and blocks in the hand &mdash; but a push put into it moves nothing until it is let go. A dense Star is a weapon before it is thrown.</p>',

'<h2>The Constellation</h2>',
'<p>A <b>Constellation</b> is the written record of the steps: points for states, Filaments for the steps between them. <b>It is a guide, not a circuit</b> &mdash; the paper conducts nothing. It says what and in what order, and <b>never how much or for how long</b>. Not one quantity is written anywhere in it, which is why the same Constellation performs differently in different hands.</p>',
'<p>Reading one is not enough to light it. A Transformation serves only someone who has already produced that state at least once, so what the guide supplies is the order, the splits and the convergences &mdash; the part nobody remembers. <b>A star chart is not a weapon in a bottle, it is a reminder</b>: stealing an Atlas gives information, not power, which is exactly what espionage needs and nothing more.</p>',
'<p>Hence three things that get confused for one. The <b>Repertoire</b> is what you have managed to produce at least once; it is written nowhere and cannot be stolen. The <b>Atlas</b> is the book of the Constellations you have charted: an object, so it can be copied, stolen, burnt or inherited. And what you have <b>memorised</b> is the part of the Atlas you can run without looking. That is why a master still carries a book &mdash; not to keep his skill in it, but to keep the long recipes.</p>',

'<h2>The four qualities</h2>',
'<p>They are human qualities and not magical ones, inherited by species and by line, and none of them stands in for another.</p>',
'<ul class="sendlist">
            <li><b>Will</b> &mdash; the speed of Accretion, and how well your Ether fares when imposed on someone else&rsquo;s. It adds force to nothing.</li>
            <li><b>Intellect</b> &mdash; the minimum needed to write or light a Constellation. <b>A threshold, not a modifier</b>: whoever falls short cannot, and whoever clears it is no better for clearing it by more.</li>
            <li><b>Resilience</b> &mdash; how much resistance each unit of Concentration buys when something tries to get in. It also decides how long and how badly an Intoxication runs.</li>
            <li><b>Focus</b> &mdash; how long a Star can be held without failing.</li>
          </ul>',

'<h2>What it costs</h2>',
'<p><b>The Ether is free and endless. There is no mana, no reservoir and no gauge.</b> What is paid for is not the material but the effort of moving it, and it is counted in the same three layers the body uses &mdash; breath, tiredness, injury. In the mind those are <b>Concentration</b>, which comes back in seconds; <b>Mental Fatigue</b>, which needs sleep; and <b>Ether Intoxication</b>, which is an injury and needs treatment.</p>',
'<p>Intoxication is Ether the network failed to steer, left piled up inside. Acute, it passes, and Resilience decides how hard and how long. Repeated or severe, it does not pass: it cuts down what a person can channel, then stops the Accretion, then takes it away for good &mdash; and because the Etheric system shares its architecture with the nervous one, it can kill.</p>',
'<p>Working two-handed is not poisonous by decree. It spends twice and tires twice, and therefore <b>reaches the point of injury in half the time</b>. At the other end, the everyday magic anybody does &mdash; <b>Asterism</b> &mdash; is simply the magic that never spends breath at all: it comes out of the passive flow, it does not tire, and everyone does it. It is step zero, not a separate gift.</p>',
'<p><b>Opposition</b> is not a skill either. It is what your own Ether does when something foreign tries to get in, and everyone has it, because every body is full of Ether: a farmhand resists, badly, but resists. The floor is free; pushing above it spends Concentration &mdash; the same Concentration that is holding your Stars up. <b>Which is why the most vulnerable astronomer is the one who is working.</b> You strike a mage while he is building, not before.</p>',

'<h2>Nothing lasts by itself</h2>',
'<p>Every gathering of Ether comes undone, in the hand and on the ground alike, and <b>not even matter is exempt</b>. What decides how long is not how much Ether a thing holds but how many times over its own minimum it is &mdash; so a large stone and a small one, each at twice what it needs, last exactly as long.</p>',
'<p>It can be fed: touch it and pour. Feeding costs precisely what is being lost, no more and no less, and it takes a hand, the same as holding. <b>So permanence stops being a property and becomes a job.</b> Nothing lasts on its own; it lasts as long as somebody is willing to keep it. There are no magical ruins in this world, no enchanted objects lying about and no traps left behind &mdash; you never find old magic, only the place where some once was.</p>',
'<p><i>That is the fiction. The spell entries here keep the game&rsquo;s own durations, so a ward on the page can still last an hour; where the two disagree, the entry is what you play and this is what it means.</i></p>',

'<h2>What Astronomy does, having crossed nothing</h2>',
'<p>Every Constellation begins here, because Astronomy has nothing to dispose of in advance &mdash; a spell is Astronomy before it is anything else, and it never stops being one.</p>',
'<p>What it does is what does not commit. It gathers the Ether, sharpens it, presses it until it weighs, pushes and pulls it, reads it, hinders it, takes it away. It forges nothing and closes no wound, because the difference between an astronomer and a star is one of quantity and that quantity is unreachable. What an astronomer has instead is <b>direction</b>.</p>',
'<p>In exchange it reaches Ether wherever the Ether is &mdash; including the Ether running inside another body, and the Ether another hand is holding. That is its one uncontested advantage and the reason it is what ends duels: a Star handed over inside someone imposes the same Intoxication an astronomer inflicts on himself by forcing the Accretion, put in from outside. It is cumulative, so it strikes hardest at whoever has been pushing hardest &mdash; and it does not aim to kill. It aims to take away the Accretion, which in this world is a kind of civil death.</p>',

'<h2>The three thresholds</h2>',
'<p><b>Astronomy has no subdivisions of its own.</b> Its subdivisions are the three Disciplines, each reached by forcing a Star past one threshold: <b>the Crucible</b>, where the mass is pressed until it crosses over into substance, opens Alchemy; <b>the Abyss</b>, where it collapses until it weighs more than it should, opens Cosmology; and the threshold that holds life, which is the one piece of this art still without a name, opens Spiritism. Each imitates something a star does, at a scale nobody will reach.</p>',
'<p>A Star that crosses one <b>does not leave Astronomy</b>. It enters a region of it with its own rules of stability, and it still answers to everything Astronomy can do &mdash; because it never stopped being Ether. Crossing a second threshold, in a Convergence, is the summit of the art, and it is paid for in all four coins at once.</p>',
    ],
    es => [
'<p><b>Aqu&iacute; la magia es un solo arte, y tiene un solo material.</b> Todas las Disciplinas de este sitio y todos los conjuros del cat&aacute;logo son cosas que se le hacen al &Eacute;ter. Lo que sigue es qu&eacute; es el &Eacute;ter y qu&eacute; se le puede hacer; las tres Disciplinas no son m&aacute;s que los umbrales que se le pueden forzar.</p>',

'<h2>El &Eacute;ter</h2>',
'<p>Impregna toda materia, viva e inerte, y lo ha hecho desde siempre. No tiene origen que datar ni fuente que agotar, y atraviesa cualquier cuerpo de forma tan constante e involuntaria como el calor o la presi&oacute;n del aire. Nadie que respire ha dejado nunca de estar ba&ntilde;ado en &eacute;l.</p>',
'<p>Ambiental, no se ve. <b>Denso, alumbra</b> &mdash; y de ese solo hecho sali&oacute; el nombre del arte entero. Un trazado en marcha es un pu&ntilde;ado de puntos de luz unidos por hilos tenues, que es exactamente lo que es una constelaci&oacute;n; y <i>Encender</i> una Constelaci&oacute;n no es una met&aacute;fora bonita, es lo que ocurre. Nadie bautiz&oacute; nada de esto con imaginaci&oacute;n. La gente llam&oacute; a las cosas por lo que ve&iacute;a.</p>',
'<p>Ni se crea ni se destruye: se re&uacute;ne, y reunirlo aqu&iacute; es apartarlo de all&aacute;. Toda concentraci&oacute;n deja alrededor un halo enrarecido en el que todos &mdash; incluido quien lo reuni&oacute; &mdash; canalizan peor.</p>',
'<p>Es un fluido y tiene volumen, de modo que se le puede afilar, extender y comprimir, y lo que hace depende de cu&aacute;n denso est&eacute;. Con muy poco da <b>luz</b>, y eso sale gratis. Con densidad media da <b>movimiento y fuerza</b>. Con densidad alta da <b>presencia</b>: pesa, golpea, estorba &mdash; y eso es car&iacute;simo, que es todo el equilibrio entre este arte y la alquimia. La astronom&iacute;a puede golpear como una roca pagando mucho m&aacute;s de lo que le cuesta a la alquimia hacer la roca.</p>',
'<p><b>Al morir un cuerpo, su alma se reparte en el &Eacute;ter.</b> Por eso aqu&iacute; la muerte es definitiva, y por eso nada de este suplemento devuelve a nadie.</p>',

'<h2>El cuerpo</h2>',
'<p>Todo el mundo lleva un <b>Sistema Et&eacute;reo</b>: una red interna que le da forma al &Eacute;ter, que nace en el cerebro y est&aacute; construida con la misma arquitectura que el sistema nervioso. El cerebro recoge el &Eacute;ter, lo ordena y lo dirige hacia una <b>terminaci&oacute;n</b> &mdash; un &oacute;rgano que la evoluci&oacute;n reaprovech&oacute;, y cuya funci&oacute;n anterior decide qu&eacute; puede producir. Un &oacute;rgano especializado da un efecto fijo por instinto. <b>La mano humana los da todos</b>, y su versatilidad es de albergar, no de movimiento.</p>',
'<p>Dos manos, dos Estrellas. <b>Nadie sostiene m&aacute;s de dos a la vez</b>, y no hay maestr&iacute;a que suba ese n&uacute;mero: el tope lo pone el cuerpo, no la habilidad. La &uacute;nica salida es una <b>Conjunci&oacute;n</b>, varias personas trazando un mismo dise&ntilde;o con un punto de entrada cada una, y de ah&iacute; que el trabajo serio de este mundo sea colectivo.</p>',

'<h2>La Estrella</h2>',
'<p>Una <b>Estrella</b> es una masa de &Eacute;ter reunida y sostenida. Existe mientras alguien la sostenga, y alumbra, por ser &Eacute;ter denso.</p>',
'<p>Nace por <b>Acreci&oacute;n</b>: acelerar el flujo propio de &Eacute;ter por encima de su ritmo pasivo, a la velocidad que marque la Voluntad. La Acreci&oacute;n no termina al formarla, as&iacute; que <b>su tama&ntilde;o sigue abierto hasta el instante de entregarla</b>. Sin suministro <b>mengua</b>, desangr&aacute;ndose hacia su propio halo &mdash; sostener una Estrella no es tener una mano ocupada, es seguir vertiendo, y el Enfoque sostiene el goteo, no una idea.</p>',
'<p>No existe el poder almacenado. No por la merma, que se puede compensar, sino porque solo hay dos manos y todo lo que se lleva encima hay que alimentarlo. <b>Nadie llega a ning&uacute;n sitio ya cargado.</b></p>',

'<h2>Las cinco operaciones</h2>',
'<p>Cuatro cambian cu&aacute;ntas Estrellas hay en juego, y esas cuatro son los puntos a los que un trazado escrito les pone nombre. La quinta no cambia la cuenta: cambia lo que la Estrella es.</p>',
'<ul class="sendlist">
            <li><b>Reunir</b> <i>(Lucero)</i> &mdash; empezar a acumular &Eacute;ter. Uno por astr&oacute;nomo, y no se escribe nunca: es siempre el mismo acto.</li>
            <li><b>Transformar</b> <i>(el Filamento)</i> &mdash; darle un estado al &Eacute;ter, que es lo que decide qu&eacute; har&aacute; al entregarse. Se hace con la mente: <b>no hay gestos</b>. Cada Transformaci&oacute;n tiene su palabra, y la palabra ayuda pero no es requisito &mdash; en silencio cuesta m&aacute;s Concentraci&oacute;n y falla m&aacute;s. <i>El aprendiz habla; el maestro no.</i></li>
            <li><b>Partir</b> <i>(Bifurcaci&oacute;n)</i> &mdash; repartir una Estrella en dos, sin duplicar el &Eacute;ter. Exige una mano libre, y no deshace nada: las dos mitades conservan el estado entero.</li>
            <li><b>Juntar</b> <i>(Convergencia)</i> &mdash; fusionar dos Estrellas que hayan alcanzado antes el m&iacute;nimo de su estado. El &Eacute;ter se suma y los estados se encuentran, y sale algo que no era ninguna de las dos. Es donde nace todo hallazgo.</li>
            <li><b>Entregar</b> <i>(Conf&iacute;n)</i> &mdash; dejar de sostener.</li>
          </ul>',
'<p><b>Entregar no es un acto con reglas propias: es el momento en que el conjuro termina.</b> Cuanto ocurre despu&eacute;s lo decide el estado que la Estrella llevaba encima, no la entrega &mdash; y sin Transformaci&oacute;n de reparto se manifiesta donde est&aacute; la mano. Reunir &Eacute;ter y soltarlo sigue siendo un conjuro completo; es el m&aacute;s pobre que existe.</p>',
'<p>De ah&iacute; la regla que lo gobierna todo: <b>lo que el &Eacute;ter</b> es <b>act&uacute;a siempre; lo que se le ha impuesto act&uacute;a al soltar.</b> Una Estrella alumbra en la mano desde el primer instante, y apretada lo bastante pesa y estorba en la mano &mdash; pero el empuje que se le haya puesto no mueve nada hasta que se entrega. Una Estrella densa es un arma antes de lanzarla.</p>',

'<h2>La Constelaci&oacute;n</h2>',
'<p>Una <b>Constelaci&oacute;n</b> es el registro escrito de los pasos: puntos para los estados, Filamentos para los pasos que van de uno a otro. <b>Es una gu&iacute;a, no un circuito</b> &mdash; el papel no conduce nada. Dice qu&eacute; y en qu&eacute; orden, y <b>nunca cu&aacute;nto ni cu&aacute;nto tiempo</b>. No hay una sola cantidad escrita en ella, y por eso la misma Constelaci&oacute;n rinde distinto en manos distintas.</p>',
'<p>Leerla no basta para Encenderla. Una Transformaci&oacute;n solo sirve a quien ya ha producido ese estado alguna vez, as&iacute; que lo que aporta la gu&iacute;a es el orden, las particiones y las convergencias &mdash; lo que nadie recuerda. <b>Una carta astral no es un arma embotellada, es un recordatorio</b>: robar un Atlas da informaci&oacute;n, no poder, que es justo lo que hace falta para el espionaje y nada m&aacute;s.</p>',
'<p>De ah&iacute; tres cosas que suelen confundirse en una. El <b>Repertorio</b> es lo que se ha llegado a producir alguna vez; no est&aacute; escrito en ninguna parte y no se puede robar. El <b>Atlas</b> es el libro de las Constelaciones Cartografiadas: un objeto, y por tanto se copia, se roba, se quema y se hereda. Y <b>lo memorizado</b> es la parte del Atlas que se ejecuta sin mirar. Por eso un maestro sigue llevando libro: no guarda en &eacute;l su habilidad, guarda las recetas largas.</p>',

'<h2>Las cuatro cualidades</h2>',
'<p>Son cualidades humanas y no m&aacute;gicas, se heredan por especie y por linaje, y ninguna sustituye a otra.</p>',
'<ul class="sendlist">
            <li><b>Voluntad</b> &mdash; la velocidad de la Acreci&oacute;n, y el rendimiento del &Eacute;ter propio al imponerse al de otro. No a&ntilde;ade fuerza a ning&uacute;n efecto.</li>
            <li><b>Intelecto</b> &mdash; el m&iacute;nimo para escribir o Encender una Constelaci&oacute;n. <b>Es requisito, no modificador</b>: quien no llega, no puede; y a quien le sobra no le sirve de nada que le sobre.</li>
            <li><b>Resiliencia</b> &mdash; cu&aacute;nta resistencia se obtiene por cada unidad de Concentraci&oacute;n cuando algo intenta entrar. Decide tambi&eacute;n la duraci&oacute;n y la intensidad de una Intoxicaci&oacute;n.</li>
            <li><b>Enfoque</b> &mdash; cu&aacute;nto se sostiene una Estrella sin fallar.</li>
          </ul>',

'<h2>Lo que cuesta</h2>',
'<p><b>El &Eacute;ter es gratis e infinito. No hay man&aacute;, ni dep&oacute;sito, ni barra.</b> Lo que se paga no es el material sino el esfuerzo de moverlo, y se contabiliza en las mismas tres capas que usa el cuerpo &mdash; aliento, cansancio, lesi&oacute;n. En la mente son <b>Concentraci&oacute;n</b>, que se recupera en segundos; <b>Fatiga Mental</b>, que exige dormir; e <b>Intoxicaci&oacute;n Et&eacute;rea</b>, que es una lesi&oacute;n y exige tratamiento.</p>',
'<p>La Intoxicaci&oacute;n es &Eacute;ter que la red no consigui&oacute; dirigir y se acumul&oacute; dentro. Aguda, pasa, y la Resiliencia decide cu&aacute;nto y con cu&aacute;nta fuerza. Repetida o grave, no pasa: reduce lo que una persona puede canalizar, luego le impide la Acreci&oacute;n, luego se la arranca &mdash; y como el Sistema Et&eacute;reo comparte arquitectura con el nervioso, puede matar.</p>',
'<p>Trabajar a dos manos no envenena el doble por decreto. Gasta el doble y cansa el doble, y por tanto <b>se llega al umbral de lesi&oacute;n en la mitad de tiempo</b>. Al otro extremo, la magia cotidiana que hace cualquiera &mdash; el <b>Asterismo</b> &mdash; es sencillamente la que no llega a gastar aliento: sale del flujo pasivo, no cansa, y la hace todo el mundo. Es el escal&oacute;n cero, no una capacidad aparte.</p>',
'<p>La <b>Oposici&oacute;n</b> tampoco se aprende. Es lo que hace el &Eacute;ter propio cuando algo ajeno intenta entrar, y la tiene todo el mundo, porque todo cuerpo est&aacute; lleno de &Eacute;ter: un aldeano resiste peor, pero resiste. El suelo es gratis; por encima se paga en Concentraci&oacute;n &mdash; la misma con la que se sostienen las Estrellas. <b>Y de ah&iacute; que el astr&oacute;nomo m&aacute;s vulnerable sea el que est&aacute; trabajando.</b> A un mago se le golpea mientras construye, no antes.</p>',

'<h2>Nada dura solo</h2>',
'<p>Todo &Eacute;ter reunido se deshace, lo mismo en la mano que en el suelo, y <b>ni siquiera la materia se libra</b>. Lo que decide cu&aacute;nto dura no es cu&aacute;nto &Eacute;ter tiene, sino cu&aacute;ntas veces por encima de su propio m&iacute;nimo est&aacute; &mdash; de modo que una piedra grande y una peque&ntilde;a, cada una al doble de lo que necesita, aguantan exactamente lo mismo.</p>',
'<p>Se puede alimentar: tocar y verter. Alimentar cuesta exactamente lo que se pierde, ni m&aacute;s ni menos, y ocupa una mano, igual que sostener. <b>Con lo cual la permanencia deja de ser una propiedad y pasa a ser un oficio.</b> Nada dura solo: dura lo que alguien est&eacute; dispuesto a mantener. En este mundo no hay ruinas m&aacute;gicas, ni objetos encantados por ah&iacute;, ni trampas dejadas atr&aacute;s &mdash; nunca se encuentra magia vieja, solo el sitio donde hubo alguna.</p>',
'<p><i>Eso es la ficci&oacute;n. Las fichas de conjuro de aqu&iacute; conservan las duraciones del juego, as&iacute; que sobre el papel una guarda puede seguir durando una hora; donde las dos cosas no coincidan, la ficha es lo que se juega y esto es lo que significa.</i></p>',

'<h2>Lo que hace la astronom&iacute;a sin haber cruzado nada</h2>',
'<p>Toda Constelaci&oacute;n empieza aqu&iacute;, porque la astronom&iacute;a no tiene nada que disponer de antemano &mdash; un conjuro es astronom&iacute;a antes de ser otra cosa, y nunca deja de serlo.</p>',
'<p>Lo que hace es lo que no compromete. Re&uacute;ne el &Eacute;ter, lo afila, lo aprieta hasta que pesa, lo empuja y tira de &eacute;l, lo lee, lo estorba, lo arrebata. No forja nada y no cierra ninguna herida, porque la diferencia entre un astr&oacute;nomo y una estrella es solo de cantidad y esa cantidad es inalcanzable. Lo que un astr&oacute;nomo tiene en su lugar es <b>direcci&oacute;n</b>.</p>',
'<p>A cambio alcanza el &Eacute;ter est&eacute; donde est&eacute; &mdash; incluido el que corre dentro de otro cuerpo y el que otra mano est&aacute; sosteniendo. Es su &uacute;nica ventaja indiscutible y la raz&oacute;n de que sea lo que cierra los duelos: una Estrella entregada dentro de alguien impone la misma Intoxicaci&oacute;n que un astr&oacute;nomo se hace a s&iacute; mismo al forzar la Acreci&oacute;n, metida desde fuera. Es acumulativa, as&iacute; que golpea peor a quien m&aacute;s ha estado forzando &mdash; y no busca matar. Busca quitar la Acreci&oacute;n, que en este mundo es una forma de muerte civil.</p>',

'<h2>Los tres umbrales</h2>',
'<p><b>La astronom&iacute;a no tiene subdivisiones propias.</b> Sus subdivisiones son las tres Disciplinas, alcanzada cada una forzando una Estrella m&aacute;s all&aacute; de un umbral: <b>el Crisol</b>, donde la masa se aprieta hasta cruzar a sustancia, abre la alquimia; <b>el Abismo</b>, donde se colapsa hasta pesar m&aacute;s de lo que debe, abre la cosmolog&iacute;a; y el umbral que sostiene vida, que es la pieza de este arte que sigue sin nombre, abre el espiritismo. Los tres imitan algo que hace una estrella, a una escala que nadie alcanzar&aacute;.</p>',
'<p>Una Estrella que cruza uno <b>no sale de la astronom&iacute;a</b>. Entra en una regi&oacute;n suya con reglas propias de estabilidad, y sigue respondiendo a todo lo que la astronom&iacute;a alcanza &mdash; porque nunca dej&oacute; de ser &Eacute;ter. Cruzar un segundo umbral, en una Convergencia, es la cima del arte, y se paga en las cuatro monedas a la vez.</p>',
    ],
  },
  stars => [],
},

# ================================================================= ALQUIMIA
{
  key => 'alchemy', kind => 'discipline', parent => 'astronomy',
  name => { en => 'Alchemy', es => 'Alquimia' },
  lead => { en => 'Matter: the elements, the substances, and what can be made',
            es => 'La materia: los elementos, las sustancias y lo que se fabrica' },
  info => [
    [ 'Base state', 'Estado base', 'The Crucible', 'El Crisol' ],
    [ 'Imitates', 'Imita a', 'The fusing core of a star', 'El n&uacute;cleo de fusi&oacute;n de una estrella' ],
    [ 'Mark', 'Marca', 'A pentagon with a star inscribed', 'Pent&aacute;gono con estrella inscrita' ],
    [ 'Ordered by', 'Se ordena por', 'Element &mdash; 5 primary, 10 crossings', 'Elemento: 5 primarios, 10 cruces' ],
  ],
  body => {
    en => [
'<p>Alchemy begins at <b>the Crucible</b>: the mass is pressed until it crosses over into substance, which is what the fusing core of a star does at a scale nobody will ever reach. Past that threshold a Star stops behaving like a thing and becomes one.</p>',
'<p>That is the whole frontier with Astronomy, in one line: <b>Astronomy gets a mass to behave like a thing. Alchemy gets a mass to be one.</b> An astronomer who presses Ether until it weighs like a rock has a lump of light that hits and comes apart fast; an alchemist reaches the same weight far more cheaply and with something that lasts.</p>',
'<p>It is ordered by <b>element</b> and not by principle, because a specialist commands both kinds of Star of one element at once. Whoever forms water without knowing how to make it run produces puddles, and whoever can make it run without forming it depends entirely on the nearest river.</p>',
'<p>Five elements stand on their own and come from nothing else. They meet in ten ways, and a meeting does not yield a loose effect: it yields <b>a whole element</b>, with Substance and Property Stars of its own, studied with the same grammar as the five that come from nothing. All ten crossings are covered, which is recent, and the schools celebrate it as the close of centuries of work.</p>',
    ],
    es => [
'<p>La alquimia empieza en <b>el Crisol</b>: la masa se aprieta hasta cruzar a sustancia, que es lo que hace el n&uacute;cleo de fusi&oacute;n de una estrella a una escala que nadie alcanzar&aacute;. Pasado ese umbral, una Estrella deja de comportarse como una cosa y pasa a serlo.</p>',
'<p>Ah&iacute; est&aacute; la frontera entera con la astronom&iacute;a, en una l&iacute;nea: <b>la astronom&iacute;a consigue que la masa se comporte como una cosa; la alquimia consigue que la masa sea una cosa.</b> Un astr&oacute;nomo que aprieta el &Eacute;ter hasta pesar como una roca tiene un bulto de luz que golpea y se deshace deprisa; un alquimista llega al mismo peso mucho m&aacute;s barato y con algo que aguanta.</p>',
'<p>Se ordena por <b>elemento</b> y no por principio, porque el especialista domina a la vez las dos clases de Estrella de un elemento. Quien forma agua sin saber hacerla correr produce charcos, y quien sabe hacerla correr sin poder formarla depende por completo del r&iacute;o m&aacute;s cercano.</p>',
'<p>Cinco elementos se sostienen por s&iacute; mismos y no proceden de ning&uacute;n otro. Se cruzan de diez maneras, y un encuentro no entrega un efecto suelto: entrega <b>un elemento entero</b>, con sus propias Estrellas de Sustancia y de Propiedad, que se estudia con la misma gram&aacute;tica que los cinco que no proceden de nada. Los diez cruces est&aacute;n cubiertos, cosa reciente, y las escuelas lo celebran como el cierre de un trabajo de siglos.</p>',
    ],
  },
  stars => [],
},

# --------------------------------------------------- Alquimia: primarios
{
  key => 'earth', kind => 'sub', parent => 'alchemy',
  name => { en => 'Earth', es => 'Tierra' },
  lead => { en => 'Stone, and the firmness it lends to everything else',
            es => 'La piedra, y la firmeza que presta a todo lo dem&aacute;s' },
  info => [ [ 'Class', 'Clase', 'Primary element', 'Elemento primario' ] ],
  body => {
    en => ['<p>The element that lends its character to the others. Half the secondary elements the schools have catalogued start from Stone, because stone is under foot almost anywhere &mdash; and Stone is the Star that gains most from taking a body already present instead of forming one.</p>'],
    es => ['<p>El elemento que presta su car&aacute;cter a los dem&aacute;s. De Roca parte la mitad de los elementos secundarios que las escuelas tienen catalogados, porque la piedra abunda en casi cualquier terreno &mdash; y Roca es la Estrella que m&aacute;s se beneficia de tomar un cuerpo ya presente en vez de formarlo.</p>'],
  },
  stars => [
    { en => 'Stone', es => 'Roca', kind => 'substance',
      note => { en => 'Forms cohered stone, in a shape fixed when it was Charted.',
                es => 'Forma piedra cohesionada, con la forma fijada al Cartografiarla.' } },
    { en => 'Cohesion', es => 'Cohesión', kind => 'property',
      note => { en => 'Binds the parts of a body together and hardens the whole: sand that holds like rock, water that bears a weight, flame that stays where it was put.',
                es => 'Liga entre s&iacute; las partes de un cuerpo y endurece el conjunto: arena que aguanta como roca, agua que soporta un peso, llama que permanece donde se la dej&oacute;.' } },
  ],
},
{
  key => 'water', kind => 'sub', parent => 'alchemy',
  name => { en => 'Water', es => 'Agua' },
  lead => { en => 'The cheapest Substance of the five, and the first learned away from a fight',
            es => 'La Sustancia m&aacute;s barata de las cinco, y la primera que se aprende lejos del combate' },
  info => [ [ 'Class', 'Clase', 'Primary element', 'Elemento primario' ] ],
  body => {
    en => ['<p>Water is what an astronomer learns first when their trade is far from a fight. Its Properties are worth more than its Substance: a river can be turned without forming a drop, and Dissolution empties a lock without forcing it.</p>'],
    es => ['<p>El agua es lo que un astr&oacute;nomo aprende antes cuando su oficio est&aacute; lejos del combate. Sus Propiedades valen m&aacute;s que su Sustancia: se desv&iacute;a un r&iacute;o sin formar una gota, y Disoluci&oacute;n vac&iacute;a una cerradura sin forzarla.</p>'],
  },
  stars => [
    { en => 'Water', es => 'Agua', kind => 'substance',
      note => { en => 'Forms liquid water.', es => 'Forma agua l&iacute;quida.' } },
    { en => 'Current', es => 'Caudal', kind => 'property',
      note => { en => 'Gives a liquid body a sustained direction and pull.',
                es => 'Imprime a un cuerpo l&iacute;quido una direcci&oacute;n y un arrastre sostenidos.' } },
    { en => 'Dissolution', es => 'Disolución', kind => 'property',
      note => { en => 'Undoes, inside a liquid, whatever body touches it.',
                es => 'Deshace dentro de un l&iacute;quido el cuerpo que lo toca.' } },
  ],
},
{
  key => 'air', kind => 'sub', parent => 'alchemy',
  name => { en => 'Air', es => 'Aire' },
  lead => { en => 'Movement, pressure and the heat that is taken away',
            es => 'El movimiento, la presi&oacute;n y el calor que se retira' },
  info => [ [ 'Class', 'Clase', 'Primary element', 'Elemento primario' ] ],
  body => {
    en => ['<p>Chilling is the Star that makes an air-worker indispensable in any city built of wood: it stops a fire without anyone having to move what is burning. Suction is the only Star in the Discipline that acts on someone without ever touching them.</p>'],
    es => ['<p>Enfriamiento es la Estrella por la que un elementalista de Aire resulta indispensable en cualquier ciudad de madera: detiene un incendio sin necesidad de apartar lo que arde. Succi&oacute;n es la &uacute;nica Estrella de la Disciplina que act&uacute;a sobre alguien sin llegar a tocarlo.</p>'],
  },
  stars => [
    { en => 'Air', es => 'Aire', kind => 'substance',
      note => { en => 'Forms air and gives it the motion fixed when it was Charted.',
                es => 'Forma aire y le imprime el movimiento fijado al Cartografiarla.' } },
    { en => 'Compression', es => 'Compresión', kind => 'property',
      note => { en => 'Narrows a body onto itself and raises its density and inner pressure.',
                es => 'Estrecha un cuerpo sobre s&iacute; mismo y aumenta su densidad y su presi&oacute;n interna.' } },
    { en => 'Suction', es => 'Succión', kind => 'property',
      note => { en => 'Draws air out of a space and lowers the pressure left in it.',
                es => 'Retira aire de un espacio y rebaja la presi&oacute;n que queda en &eacute;l.' } },
    { en => 'Chilling', es => 'Enfriamiento', kind => 'property',
      note => { en => 'Takes heat out of a body.', es => 'Retira calor de un cuerpo.' } },
  ],
},
{
  key => 'fire', kind => 'sub', parent => 'alchemy',
  name => { en => 'Fire', es => 'Fuego' },
  lead => { en => 'The element that opens the most roads into the others',
            es => 'El elemento que abre m&aacute;s caminos hacia los dem&aacute;s' },
  info => [ [ 'Class', 'Clase', 'Primary element', 'Elemento primario' ] ],
  body => {
    en => ['<p>Ember opens more roads into the other elements than any other Star: stone at red heat, water into steam, metal ready to take a shape. And whoever can put a fire out with Consumption is worth as much in a city as whoever can light one.</p>'],
    es => ['<p>Ascua abre m&aacute;s caminos hacia los dem&aacute;s elementos que ninguna otra Estrella: piedra al rojo, agua en vapor, metal dispuesto a recibir forma. Y quien sabe apagar con Consumo es tan valioso en una ciudad como quien sabe encender.</p>'],
  },
  stars => [
    { en => 'Flame', es => 'Llama', kind => 'substance',
      note => { en => 'Forms fire. The Ether measures its reach and its temperature, and everything that happens to what it touches follows from that temperature.',
                es => 'Forma fuego. El &Eacute;ter mide su extensi&oacute;n y su temperatura, y de esa temperatura depende cuanto le ocurre a lo que toca.' } },
    { en => 'Ember', es => 'Ascua', kind => 'property',
      note => { en => 'Puts heat into a body without setting it alight.',
                es => 'Aporta calor a un cuerpo sin prenderlo.' } },
    { en => 'Consumption', es => 'Consumo', kind => 'property',
      note => { en => 'Speeds the burning of a body already alight, and can exhaust a fire before it reaches what is behind it.',
                es => 'Acelera el consumo de un cuerpo que ya arde, y agota un incendio antes de que alcance lo que hay detr&aacute;s.' } },
  ],
},
{
  key => 'lightning', kind => 'sub', parent => 'alchemy',
  name => { en => 'Lightning', es => 'Rayo' },
  lead => { en => 'The charge, and what will carry it',
            es => 'La carga, y lo que la porta' },
  info => [ [ 'Class', 'Clase', 'Primary element', 'Elemento primario' ] ],
  body => {
    en => ['<p>Discharge always looks for the bodies that carry it, which is why it is rarely traced on its own: paired with Conduction it turns a dry stone wall, a sand floor or the air itself into a road.</p>'],
    es => ['<p>Descarga busca siempre los cuerpos que la conducen, y de ah&iacute; que rara vez se trace sola: junto a Conducci&oacute;n convierte en camino una pared de piedra seca, un suelo de arena o el aire mismo.</p>'],
  },
  stars => [
    { en => 'Discharge', es => 'Descarga', kind => 'substance',
      note => { en => 'Forms an electric current.', es => 'Forma corriente el&eacute;ctrica.' } },
    { en => 'Conduction', es => 'Conducción', kind => 'property',
      note => { en => 'Makes a body carry whatever charge it receives, whatever that body is.',
                es => 'Hace que un cuerpo porte la carga que reciba, sea cual sea su naturaleza.' } },
    { en => 'Attraction', es => 'Atracción', kind => 'property',
      note => { en => 'Charges two bodies so that they seek or repel each other.',
                es => 'Carga dos cuerpos de modo que se busquen o se rechacen entre s&iacute;.' } },
  ],
},

# ------------------------------------------------- Alquimia: secundarios
{
  key => 'mud', kind => 'sub', parent => 'alchemy',
  name => { en => 'Mud', es => 'Fango' },
  lead => { en => 'A mass that runs of its own nature', es => 'Una masa que corre por su propia naturaleza' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Earth and Water', 'Tierra y Agua' ] ],
  body => {
    en => ['<p>Mud swallows the weight that leans on it, slips through where stone would not fit, and hardens as it dries &mdash; so whoever uses it to trap has to reckon with the moment it stops being a trap.</p>'],
    es => ['<p>El fango traga el peso que se apoya en &eacute;l, se cuela por donde la piedra no cabr&iacute;a y endurece al secar, de modo que quien lo usa para atrapar debe contar tambi&eacute;n con el momento en que deja de ser trampa.</p>'],
  },
  stars => [
    { en => 'Mud', es => 'Fango', kind => 'substance', from => 'Stone + Water / Roca y Agua',
      note => { en => 'Forms a mass that runs of its own nature, with nothing imposing it.',
                es => 'Forma una masa que corre por su propia naturaleza, sin que nada se lo imponga.' } },
    { en => 'Flow', es => 'Fluencia', kind => 'property', from => 'Stone + Current / Roca y Caudal',
      note => { en => 'Lowers the inner firmness of a body until it runs: a wall collapses onto itself, a firm floor gives underfoot, cold metal takes a shape by hand.',
                es => 'Reduce la firmeza interna de un cuerpo hasta que corre: un muro se desploma sobre s&iacute; mismo, un suelo firme cede bajo el pie, un metal fr&iacute;o se deja moldear a mano.' } },
  ],
},
{
  key => 'sand', kind => 'sub', parent => 'alchemy',
  name => { en => 'Sand', es => 'Arena' },
  lead => { en => 'Mineral worn down to grain', es => 'Mineral desgastado hasta el grano' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Earth and Air', 'Tierra y Aire' ] ],
  body => {
    en => ['<p>Wearing opens a way through a wall with none of the noise of a collapse, wipes an inscription off a headstone, and takes the edge off a sheathed weapon.</p>'],
    es => ['<p>Desgaste abre un paso en un muro sin ruido de derrumbe, borra una inscripci&oacute;n de una l&aacute;pida y deja sin filo un arma envainada.</p>'],
  },
  stars => [
    { en => 'Sand', es => 'Arena', kind => 'substance', from => 'Stone + Air / Roca y Aire',
      note => { en => 'Forms mineral worn to a fine grain whose parts do not hold one another &mdash; and which holds like rock again with Cohesion.',
                es => 'Forma mineral desgastado hasta el grano fino, cuyas partes no llegan a sostenerse entre s&iacute; &mdash; y que con Cohesi&oacute;n vuelve a aguantar como roca.' } },
    { en => 'Wearing', es => 'Desgaste', kind => 'property', from => 'Stone + Suction / Roca y Succión',
      note => { en => 'Eats the surface of a firm body down to grain.',
                es => 'Consume la superficie de un cuerpo firme hasta reducirla a grano.' } },
  ],
},
{
  key => 'lava', kind => 'sub', parent => 'alchemy',
  name => { en => 'Lava', es => 'Lava' },
  lead => { en => 'Stone that runs and burns at once', es => 'Piedra que corre y quema a la vez' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Earth and Fire', 'Tierra y Fuego' ] ],
  body => {
    en => ['<p>Lava settles as it cools and leaves new ground where it fell, so its mark stays long after the astronomer has gone. It is the standing example the schools use for the worth of a secondary element: Stone and Ember mixed give lava, and whoever has Charted that Star gets the same body for less Ether, with the temperature already settled.</p>'],
    es => ['<p>La lava se asienta al enfriarse y deja terreno nuevo donde cay&oacute;, de modo que su huella permanece mucho despu&eacute;s de que el astr&oacute;nomo se haya marchado. Es el ejemplo con el que las escuelas explican el valor de un elemento secundario: Roca y Ascua mezcladas dan lava, y quien haya Cartografiado esa Estrella obtiene el mismo cuerpo por menos &Eacute;ter y con la temperatura ya resuelta.</p>'],
  },
  stars => [
    { en => 'Lava', es => 'Lava', kind => 'substance', from => 'Stone + Ember / Roca y Ascua',
      note => { en => 'Forms stone that runs and burns at once.',
                es => 'Forma piedra que corre y quema a la vez.' } },
    { en => 'Melting', es => 'Fusión', kind => 'property', from => 'Cohesion + Ember / Cohesión y Ascua',
      note => { en => 'Makes a firm body give to heat sooner than its nature would: it opens a grate without melting the wall that holds it.',
                es => 'Hace que un cuerpo firme ceda al calor antes de lo que ceder&iacute;a por su naturaleza: abre una reja sin llegar a fundir el muro que la sostiene.' } },
  ],
},
{
  key => 'metal', kind => 'sub', parent => 'alchemy',
  name => { en => 'Metal', es => 'Metal' },
  lead => { en => 'The most expensive Star in the Discipline', es => 'La Estrella m&aacute;s cara de la Disciplina' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Earth and Lightning', 'Tierra y Rayo' ] ],
  body => {
    en => ['<p>Metal is the most expensive Star in the whole Discipline &mdash; which is why mines are still worth what they are worth, and why the first to find it were high-country shepherds and not smiths.</p>'],
    es => ['<p>Metal es la Estrella m&aacute;s cara de la Disciplina entera &mdash; raz&oacute;n por la cual las minas siguen valiendo lo que valen, y por la cual los primeros en dar con ella fueron pastores de tierras altas y no herreros.</p>'],
  },
  stars => [
    { en => 'Metal', es => 'Metal', kind => 'substance', from => 'Stone + Discharge / Roca y Descarga',
      note => { en => 'Forms metal, which is what stone becomes once the charge has run through it and stripped it of what it carried.',
                es => 'Forma metal, que es lo que la piedra atravesada por la carga suelta de cuanto llevaba dentro.' } },
    { en => 'Magnetism', es => 'Imantación', kind => 'property', from => 'Cohesion + Attraction / Cohesión y Atracción',
      note => { en => 'Makes a metal body lastingly seek or repel another: it tears a weapon from a hand, or leaves an armour useless by sticking it to itself.',
                es => 'Hace que un cuerpo de metal busque o rechace a otro de forma duradera: arranca un arma de una mano, o deja inservible una armadura que se pega a s&iacute; misma.' } },
  ],
},
{
  key => 'mist', kind => 'sub', parent => 'alchemy',
  name => { en => 'Mist', es => 'Bruma' },
  lead => { en => 'What hides, what freezes, and what is drawn out of the air',
            es => 'Lo que oculta, lo que hiela y lo que se saca del aire' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Water and Air', 'Agua y Aire' ] ],
  body => {
    en => ['<p>The richest of the ten crossings: three Stars from three different mixtures. Mist smothers the sound that crosses it as well as the light, so denying sight with it denies hearing too. Ice goes back to the water it came from as soon as heat reaches it, and that countdown is the first thing anyone who builds with it is taught.</p>'],
    es => ['<p>El m&aacute;s rico de los diez cruces: tres Estrellas de tres mezclas distintas. La bruma ahoga el sonido que la atraviesa igual que la luz, de modo que negar la vista con ella niega tambi&eacute;n el o&iacute;do. El hielo vuelve al agua de la que sali&oacute; cuando el calor lo alcanza, y esa cuenta atr&aacute;s es la primera cosa que se ense&ntilde;a a quien construye con &eacute;l.</p>'],
  },
  stars => [
    { en => 'Mist', es => 'Bruma', kind => 'substance', from => 'Water + Air / Agua y Aire',
      note => { en => 'Forms a body that hides whatever stays inside it.',
                es => 'Forma un cuerpo que oculta cuanto queda dentro de &eacute;l.' } },
    { en => 'Ice', es => 'Hielo', kind => 'substance', from => 'Water + Chilling / Agua y Enfriamiento',
      note => { en => 'Forms a firm body that bears a weight and slips underfoot.',
                es => 'Forma un cuerpo firme que sostiene un peso y resbala bajo el pie.' } },
    { en => 'Condensation', es => 'Condensación', kind => 'property', from => 'Water + Compression / Agua y Compresión',
      note => { en => 'Gathers into one body the water the air carries scattered: it fills a skin in the middle of a desert, and leaves the air dry and brittle where it was drawn from.',
                es => 'Re&uacute;ne en un cuerpo el agua que el aire lleva repartida: llena un odre en mitad de un desierto, y deja el aire seco y quebradizo all&iacute; donde se la sac&oacute;.' } },
  ],
},
{
  key => 'steam', kind => 'sub', parent => 'alchemy',
  name => { en => 'Steam', es => 'Vapor' },
  lead => { en => 'Water that takes up far more room than it did',
            es => 'Agua que ocupa mucho m&aacute;s espacio del que ocupaba' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Water and Fire', 'Agua y Fuego' ] ],
  body => {
    en => ['<p>Steam scalds on contact, slips through where water would not fit, and shoves hard at whatever encloses the space it appears in.</p>'],
    es => ['<p>El vapor escalda al contacto, se cuela por donde el agua no cabr&iacute;a y empuja con fuerza cuanto encierra el espacio en el que aparece.</p>'],
  },
  stars => [
    { en => 'Steam', es => 'Vapor', kind => 'substance', from => 'Water + Ember / Agua y Ascua',
      note => { en => 'Forms a body that takes up far more room than the water it came from.',
                es => 'Forma un cuerpo que ocupa mucho m&aacute;s espacio del que ocupaba el agua de la que sale.' } },
    { en => 'Desiccation', es => 'Desecación', kind => 'property', from => 'Dissolution + Consumption / Disolución y Consumo',
      note => { en => 'Takes out of a body the water that holds it: it turns what was supple brittle, and hardens mud the instant someone steps on it.',
                es => 'Retira de un cuerpo el agua que lo mantiene: vuelve quebradizo lo que era flexible, y endurece un fango en el instante en que alguien lo pisa.' } },
  ],
},
{
  key => 'acid', kind => 'sub', parent => 'alchemy',
  name => { en => 'Acid', es => 'Ácido' },
  lead => { en => 'What bites, and what keeps working after you have gone',
            es => 'Lo que muerde, y lo que sigue trabajando cuando ya te has ido' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Water and Lightning', 'Agua y Rayo' ] ],
  body => {
    en => ['<p>Acid eats metal, limestone and flesh, and does not tell apart what its maker meant to reach from what happened to be beside it &mdash; so using it under your own roof counts as recklessness, not cunning. Corrosion is the only Star in the Discipline whose work carries on after the astronomer has left the place, which is why it turns up more often in a sabotage than in a fight.</p>',
'<p>This is also where the supplement files poison and disease that are not a matter of living tissue: what bites and what rots from outside belong to the same element.</p>'],
    es => ['<p>El &aacute;cido come el metal, la caliza y la carne, y no distingue entre lo que quien lo form&oacute; quer&iacute;a alcanzar y lo que hab&iacute;a al lado, de modo que su empleo bajo techo propio se considera imprudencia y no astucia. Corrosi&oacute;n es la &uacute;nica Estrella de la Disciplina cuyo efecto sigue trabajando despu&eacute;s de que el astr&oacute;nomo se haya marchado del sitio, y por eso es la que m&aacute;s veces aparece en un sabotaje y la que menos en un combate.</p>',
'<p>Aqu&iacute; es tambi&eacute;n donde el suplemento coloca el veneno y la enfermedad que no son cosa de tejido vivo: lo que muerde y lo que pudre desde fuera son el mismo elemento.</p>'],
  },
  stars => [
    { en => 'Acid', es => 'Ácido', kind => 'substance', from => 'Water + Discharge / Agua y Descarga',
      note => { en => 'Forms a biting liquid.', es => 'Forma un l&iacute;quido mordiente.' } },
    { en => 'Corrosion', es => 'Corrosión', kind => 'property', from => 'Dissolution + Conduction / Disolución y Conducción',
      note => { en => 'Makes a body eat itself for as long as it stays damp.',
                es => 'Hace que un cuerpo se coma a s&iacute; mismo mientras conserve humedad encima.' } },
  ],
},
{
  key => 'ash', kind => 'sub', parent => 'alchemy',
  name => { en => 'Ash', es => 'Ceniza' },
  lead => { en => 'What is left, and what pulls the fire along',
            es => 'Lo que queda, y lo que tira del fuego' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Air and Fire', 'Aire y Fuego' ] ],
  body => {
    en => ['<p>Draught is the Star that decides where a fire goes: it makes what is burning pull the air around it and spread towards wherever that air comes from.</p>'],
    es => ['<p>Tiro es la Estrella que decide hacia d&oacute;nde va un incendio: hace que lo que arde tire del aire de alrededor y se propague hacia donde ese aire venga.</p>'],
  },
  stars => [
    { en => 'Ash', es => 'Ceniza', kind => 'substance', from => 'Air + Consumption / Aire y Consumo',
      note => { en => 'Forms the light dust that is left of whatever fire has finished consuming.',
                es => 'Forma el polvo ligero en que queda cuanto el fuego ha terminado de consumir.' } },
    { en => 'Draught', es => 'Tiro', kind => 'property', from => 'Air + Ember / Aire y Ascua',
      note => { en => 'Makes a burning body pull the air around it and spread towards where that air comes from.',
                es => 'Hace que un cuerpo que arde tire del aire de alrededor y se propague hacia donde ese aire venga.' } },
  ],
},
{
  key => 'thunder', kind => 'sub', parent => 'alchemy',
  name => { en => 'Thunder', es => 'Estruendo' },
  lead => { en => 'The last crossing to fall, because everyone had already seen it',
            es => 'El &uacute;ltimo cruce en caer, precisamente por ser el que cualquiera ha visto' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Air and Lightning', 'Aire y Rayo' ] ],
  body => {
    en => ['<p>The last of the ten to be covered, and the one that held out longest &mdash; precisely because it is the one everyone has seen most often: every storm repeats it overhead. For generations it was taken for granted that the thunder was the charge making itself heard, and that certainty kept the crossing shut. <b>Nobody looks for what they believe is already explained.</b> Admitting that the crack is a thing of its own, with a character neither the air nor the charge shows apart, cost more effort than finding any of the other nine.</p>'],
    es => ['<p>El &uacute;ltimo de los diez en cubrirse, y el que m&aacute;s resisti&oacute; &mdash; precisamente por ser el que cualquiera ha visto m&aacute;s veces: toda tormenta lo repite sobre su cabeza. Durante generaciones se dio por sentado que el trueno era la carga misma haci&eacute;ndose o&iacute;r, y esa certeza mantuvo el cruce cerrado. <b>Nadie busca lo que cree tener ya explicado.</b> Reconocer que el estampido es cosa propia, con car&aacute;cter que ni el aire ni la carga presentan por separado, cost&oacute; m&aacute;s esfuerzo que hallar cualquiera de los otros nueve.</p>'],
  },
  stars => [
    { en => 'Thunderclap', es => 'Estruendo', kind => 'substance', from => 'Air + Discharge / Aire y Descarga',
      note => { en => 'Forms the crack: a blow of air that arrives before anyone sees where it came from.',
                es => 'Forma el estampido: un golpe de aire que llega antes de que nadie vea de d&oacute;nde sali&oacute;.' } },
    { en => 'Resonance', es => 'Resonancia', kind => 'property', from => 'Air + Conduction / Aire y Conducción',
      note => { en => 'Makes a body carry and spread the tremor it receives, far further than it would travel alone.',
                es => 'Hace que un cuerpo porte y propague el temblor que reciba, y lo lleve mucho m&aacute;s lejos de lo que llegar&iacute;a solo.' } },
  ],
},
{
  key => 'incandescence', kind => 'sub', parent => 'alchemy',
  name => { en => 'Incandescence', es => 'Incandescencia' },
  lead => { en => 'Matter shining, which is not the same as Ether shining',
            es => 'Materia que brilla, que no es lo mismo que &Eacute;ter que brilla' },
  info => [ [ 'Class', 'Clase', 'Secondary element', 'Elemento secundario' ],
            [ 'Born of', 'Nace del encuentro de', 'Fire and Lightning', 'Fuego y Rayo' ] ],
  body => {
    en => ['<p>This crossing used to be called <i>Light</i>, and used to yield a Star of that name: what flame and discharge have in common is that they shine while they are consumed, and from their mixture came light parted from the body that burned.</p>',
'<p><b>It no longer does.</b> Dense Ether glows on its own &mdash; that is the first thing anyone notices about it, and the reason the whole art is named after stars. Light is not something Alchemy has to make; it is what the Ether does before anyone asks. What survives the crossing is matter shining from its own heat, and the element now carries the name of the one Star it kept.</p>'],
    es => ['<p>Este cruce se llamaba <i>Luz</i>, y entregaba una Estrella del mismo nombre: lo que la llama y la descarga tienen en com&uacute;n es que alumbran mientras se consumen, y de su mezcla sal&iacute;a la luz separada del cuerpo que ard&iacute;a.</p>',
'<p><b>Ya no.</b> El &Eacute;ter denso alumbra por s&iacute; solo &mdash; es lo primero que se nota de &eacute;l, y la raz&oacute;n de que el arte entero se llame como se llama. La luz no es algo que la alquimia tenga que fabricar: es lo que el &Eacute;ter hace antes de que nadie se lo pida. Lo que sobrevive al cruce es materia que brilla por el calor que lleva dentro, y el elemento lleva ahora el nombre de la &uacute;nica Estrella que conserv&oacute;.</p>'],
  },
  stars => [
    { en => 'Incandescence', es => 'Incandescencia', kind => 'property', from => 'Ember + Discharge / Ascua y Descarga',
      note => { en => 'Makes a body shine from the heat it carries inside.',
                es => 'Hace que un cuerpo alumbre por el calor que lleva dentro.' } },
  ],
},

# =============================================================== ESPIRITISMO
{
  key => 'spiritism', kind => 'discipline', parent => 'astronomy',
  name => { en => 'Spiritism', es => 'Espiritismo' },
  lead => { en => 'Life, the soul, the mind, and what they can be made to believe',
            es => 'La vida, el alma, la mente y lo que se les puede hacer creer' },
  info => [
    [ 'Base state', 'Estado base', 'Unnamed', 'Sin nombre' ],
    [ 'Mark', 'Marca', 'A ring of points, one of them loose', 'Anillo de puntos, uno desprendido' ],
    [ 'Ordered by', 'Se ordena por', '4 Principles, 11 Branches', '4 Principios, 11 Ramas' ],
  ],
  body => {
    en => [
'<p>Spiritism reaches only what was once alive. Its threshold is <b>the one part of the system still unsettled</b>: the other two base states imitate a plain stellar event &mdash; the fusing core, the collapse &mdash; and holding life has no such clean counterpart in the sky. That may be exactly why it has not been named.</p>',
'<p>Its mark is the death rule drawn: a ring of gathered Ether with one point already loose. When a body dies its soul scatters into the Ether, which is why <b>death here is final</b> and why nothing in this Discipline brings anyone back. What it can do is hold a life while it is still a life, and move a body once nobody is in it.</p>',
'<p>The schools name the Principles and common speech names the trades, and the two rarely meet: whoever works the Mind is a <i>mentalist</i>, whoever works Nature a <i>druid</i>, whoever works Life a <i>healer</i>, and whoever works Death a <i>necromancer</i>. None of those four words appears in a treatise, and all four are understood in any inn.</p>',
'<p>Each Principle keeps its own ground and deepens inwards, so they are four bodies of study with methods of their own, and whoever masters one may not recognise the work of the others.</p>',
    ],
    es => [
'<p>El espiritismo solo alcanza lo que alguna vez estuvo vivo. Su umbral es <b>la pieza que el sistema tiene todav&iacute;a sin cerrar</b>: los otros dos estados base imitan un fen&oacute;meno estelar limpio &mdash; el n&uacute;cleo de fusi&oacute;n, el colapso &mdash; y sostener vida no tiene un punto cr&iacute;tico as&iacute; en el cielo. Puede que sea justo la raz&oacute;n de que siga sin nombre.</p>',
'<p>Su marca es la regla de la muerte dibujada: un anillo de &Eacute;ter reunido con un punto ya desprendido. Al morir un cuerpo, su alma se reparte en el &Eacute;ter, y por eso <b>aqu&iacute; la muerte es definitiva</b> y nada de esta Disciplina devuelve a nadie. Lo que s&iacute; puede es sostener una vida mientras sigue siendo vida, y mover un cuerpo cuando ya no hay nadie dentro.</p>',
'<p>Las escuelas nombran los Principios y el habla com&uacute;n nombra los oficios, y rara vez coinciden: a quien se dedica a la Mente se le llama <i>mentalista</i>; a quien se dedica a la Naturaleza, <i>druida</i>; a quien se dedica a la Vida, <i>sanador</i>; y a quien se dedica a la Muerte, <i>nigromante</i>. Ninguno de esos cuatro nombres aparece en un tratado, y los cuatro se entienden en cualquier posada.</p>',
'<p>Cada Principio conserva su territorio y lo profundiza hacia dentro, de modo que son cuatro cuerpos de estudio con m&eacute;todos propios y quien domina uno puede no reconocer el trabajo de los dem&aacute;s.</p>',
    ],
  },
  stars => [],
},
{
  key => 'mind', kind => 'sub', parent => 'spiritism',
  name => { en => 'Mind', es => 'Mente' },
  lead => { en => 'The mind of whatever feels', es => 'La mente de quien siente' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Illusion, Subjection, Senses, Mood, Memory',
              'Ilusiones, Sujeci&oacute;n, Sentidos, &Aacute;nimo, Memoria' ],
            [ 'Trade', 'Oficio', 'Mentalist', 'Mentalista' ] ],
  body => {
    en => ['<p>The widest Principle of the Discipline, and the one that holds the most of the catalogue. Everything here works on the same thing &mdash; what somebody is having happen inside them &mdash; and the five Branches only differ in which part of it they take hold of.</p>',
'<p><b>Nothing in this Principle touches the world.</b> An illusion is not a thing made in the air; it is a thing made in a mind, and a second person standing beside the first has to be reached separately or sees nothing. This is the single fact that decides whether a spell belongs here or in Alchemy: if it would still be there with nobody watching, it is not Mind.</p>',
'<p>It is also the Principle that carries the whole weight of Opposition. Matter does not argue; a mind does. Everything here is thrown against something that pushes back, and that is why so much of it ends in a saving throw and so little of it lasts.</p>'],
    es => ['<p>El Principio m&aacute;s ancho de la Disciplina, y el que re&uacute;ne la mayor parte del cat&aacute;logo. Todo lo de aqu&iacute; trabaja sobre lo mismo &mdash; lo que a alguien le est&aacute; ocurriendo por dentro &mdash; y las cinco Ramas solo se diferencian en de qu&eacute; parte agarran.</p>',
'<p><b>Nada de este Principio toca el mundo.</b> Una ilusi&oacute;n no es una cosa hecha en el aire; es una cosa hecha en una mente, y el que est&aacute; al lado hay que alcanzarlo aparte o no ve nada. Este es el hecho que decide si un conjuro pertenece aqu&iacute; o a la alquimia: si seguir&iacute;a ah&iacute; sin nadie que mirase, no es mente.</p>',
'<p>Es tambi&eacute;n el Principio que carga con toda la Resiliencia. La materia no discute; una mente s&iacute;. Todo lo de aqu&iacute; se lanza contra algo que empuja de vuelta, y por eso tanto de ello acaba en una tirada de salvaci&oacute;n y tan poco de ello dura.</p>'],
  },
  stars => [],
},
{
  key => 'illusion', kind => 'leaf', parent => 'mind',
  name => { en => 'Illusion', es => 'Ilusiones' },
  lead => { en => 'What is put into the senses, and what is taken out of them',
            es => 'Lo que se pone en los sentidos y lo que se les quita' },
  info => [ [ 'Class', 'Clase', 'Branch of the Mind', 'Rama de la Mente' ],
            [ 'Trade', 'Oficio', 'Mentalist', 'Mentalista' ] ],
  body => {
    en => ['<p>One pair of opposites and everything between them: something that is not there put in, and something that is taken out. Invisibility and a phantom army are the same operation pointed two ways.</p>',
'<p>The important thing about an illusion here is <b>where it happens</b>. It is not a thing made in the world &mdash; the art cannot afford to make things in the world, that is what Alchemy is for. It is a thing made in a mind, which is why it costs so little and why it only ever fools whoever is looking.</p>',
'<p>And why it fails the way it does: nothing has to be dispelled, only disbelieved.</p>'],
    es => ['<p>Una pareja de contrarios y todo lo que hay entre ellos: algo que no est&aacute; puesto dentro, y algo que s&iacute; est&aacute; retirado. La invisibilidad y un ej&eacute;rcito fantasma son la misma operaci&oacute;n apuntada en dos direcciones.</p>',
'<p>Lo importante de una ilusi&oacute;n aqu&iacute; es <b>d&oacute;nde ocurre</b>. No es una cosa hecha en el mundo &mdash; el arte no puede permitirse hacer cosas en el mundo, para eso est&aacute; la alquimia. Es una cosa hecha en una mente, y por eso cuesta tan poco y por eso solo enga&ntilde;a a quien est&aacute; mirando.</p>',
'<p>Y por eso falla como falla: no hay que disiparla, basta con no cre&eacute;rsela.</p>'],
  },
  stars => [],
},
{
  key => 'subjection', kind => 'leaf', parent => 'mind',
  name => { en => 'Subjection', es => 'Sujeción' },
  lead => { en => 'Acts imposed, and bonds nobody agreed to',
            es => 'Actos impuestos, y ataduras que nadie ha aceptado' },
  info => [ [ 'Class', 'Clase', 'Branch of the Mind', 'Rama de la Mente' ],
            [ 'Trade', 'Oficio', 'Mentalist', 'Mentalista' ] ],
  body => {
    en => ['<p>The Branch that decides what someone does. It runs from a nudge to a leash: a suggestion that sounds like their own idea, a command they obey before they have thought about it, a body held still, a charm that makes an enemy a friend for an hour, and at the far end a will worn like a coat.</p>',
'<p>It is called Subjection and not <i>mind control</i> on purpose. Control suggests a hand on a lever, and that is not what happens: <b>what is imposed is the act, not the person.</b> A charmed guard still knows who they are and still has their own reasons; they simply find themselves doing this. The distance between those two ideas is most of what makes this Branch worth hunting.</p>',
'<p>Everything here is resisted with Resilience, and everything here is remembered afterwards.</p>'],
    es => ['<p>La Rama que decide qu&eacute; hace alguien. Va de un empuj&oacute;n a una correa: una sugerencia que suena a idea propia, una orden que se obedece antes de haberla pensado, un cuerpo que se queda quieto, un hechizo que convierte a un enemigo en amigo durante una hora, y en el extremo una voluntad puesta como un abrigo.</p>',
'<p>Se llama Sujeci&oacute;n y no <i>control mental</i> a prop&oacute;sito. Controlar sugiere una mano en una palanca, y no es lo que pasa: <b>lo que se impone es el acto, no la persona.</b> Un guardia hechizado sigue sabiendo qui&eacute;n es y sigue teniendo sus razones; sencillamente se encuentra haciendo esto. La distancia entre esas dos ideas es casi todo lo que hace que esta Rama se persiga.</p>',
'<p>Todo lo de aqu&iacute; se resiste con Resiliencia, y todo lo de aqu&iacute; se recuerda despu&eacute;s.</p>'],
  },
  stars => [],
},
{
  key => 'senses', kind => 'leaf', parent => 'mind',
  name => { en => 'Senses', es => 'Sentidos' },
  lead => { en => 'Reading a mind, reaching one, and widening what a body can perceive',
            es => 'Leer una mente, alcanzarla, y ensanchar lo que un cuerpo percibe' },
  info => [ [ 'Class', 'Clase', 'Branch of the Mind', 'Rama de la Mente' ],
            [ 'Trade', 'Oficio', 'Mentalist', 'Mentalista' ] ],
  body => {
    en => ['<p>What comes in and what goes out. On one side, perception widened: seeing in the dark, understanding a language nobody taught you, knowing what someone is thinking. On the other, a message crossing any distance with no road to carry it.</p>',
'<p>This is the Branch that pays a mentalist&rsquo;s rent. It does no damage, it imposes nothing, and it is what a court, a caravan or an army actually hires one for &mdash; which is also why it is the half of the trade that nobody is afraid of, and the half that learns the most.</p>'],
    es => ['<p>Lo que entra y lo que sale. De un lado, la percepci&oacute;n ensanchada: ver en la oscuridad, entender una lengua que nadie te ense&ntilde;&oacute;, saber qu&eacute; est&aacute; pensando alguien. Del otro, un mensaje que cruza cualquier distancia sin camino que lo lleve.</p>',
'<p>Esta es la Rama que le paga el alquiler a un mentalista. No hace da&ntilde;o, no impone nada, y es para lo que de verdad lo contratan una corte, una caravana o un ej&eacute;rcito &mdash; y por eso mismo es la mitad del oficio a la que nadie teme, y la que m&aacute;s se entera de todo.</p>'],
  },
  stars => [],
},
{
  key => 'mood', kind => 'leaf', parent => 'mind',
  name => { en => 'Mood', es => 'Ánimo' },
  lead => { en => 'What a body feels, read or imposed',
            es => 'Lo que un cuerpo siente, le&iacute;do o impuesto' },
  info => [ [ 'Class', 'Clase', 'Branch of the Mind', 'Rama de la Mente' ],
            [ 'Trade', 'Oficio', 'Mentalist', 'Mentalista' ] ],
  body => {
    en => ['<p>Fear, calm, fury, attachment, apathy. Put a feeling into someone and it is theirs from that moment: <b>it dictates no act.</b> Whoever receives fear runs, freezes or attacks according to who they are, and that uncertainty is part of what is being used, not a flaw in the working.</p>',
'<p>It is the cheapest Branch of the Mind and the hardest to prove. A courage that was not yours, a dread that came from outside &mdash; nobody can tell afterwards, including the one who felt it.</p>'],
    es => ['<p>Miedo, calma, furia, apego, desgana. Se le pone un sentimiento a alguien y desde ese instante es suyo: <b>no dicta ning&uacute;n acto.</b> Quien recibe miedo huye, se paraliza o ataca seg&uacute;n qui&eacute;n sea, y esa incertidumbre es parte de lo que se est&aacute; usando, no un fallo del trazado.</p>',
'<p>Es la Rama m&aacute;s barata de la Mente y la m&aacute;s dif&iacute;cil de demostrar. Un coraje que no era tuyo, un p&aacute;nico que ven&iacute;a de fuera &mdash; nadie sabe decirlo despu&eacute;s, ni siquiera quien lo sinti&oacute;.</p>'],
  },
  stars => [],
},
{
  key => 'memory', kind => 'leaf', parent => 'mind',
  name => { en => 'Memory', es => 'Memoria' },
  lead => { en => 'What a body keeps of what it lived',
            es => 'Lo que un cuerpo guarda de lo que vivi&oacute;' },
  info => [ [ 'Class', 'Clase', 'Branch of the Mind', 'Rama de la Mente' ],
            [ 'Trade', 'Oficio', 'Mentalist', 'Mentalista' ] ],
  body => {
    en => ['<p>Bringing a particular memory to the surface and handing it to whoever is channelling, or putting in one that never happened and muddying one that did.</p>',
'<p>The smallest Branch of the Mind by some way, and the one with the worst reputation. Everything else here can be argued about afterwards; this one changes who somebody is and leaves no mark to argue with. In most places it is not a crime because nobody has ever managed to prove one.</p>'],
    es => ['<p>Traer a la superficie un recuerdo concreto y entreg&aacute;rselo a quien canaliza, o poner uno que no ocurri&oacute; y enturbiar uno que s&iacute;.</p>',
'<p>Con diferencia la Rama m&aacute;s peque&ntilde;a de la Mente, y la de peor fama. De todo lo dem&aacute;s se puede discutir despu&eacute;s; esta cambia qui&eacute;n es alguien y no deja marca con la que discutir. En casi ning&uacute;n sitio es delito, porque nadie ha conseguido probar uno nunca.</p>'],
  },
  stars => [],
},
{
  key => 'nature', kind => 'sub', parent => 'spiritism',
  name => { en => 'Nature', es => 'Naturaleza' },
  lead => { en => 'The dealings with what lives without speech', es => 'El trato con lo que vive sin palabra' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Animals, Plants, Fungi', 'Animales, Plantas, Hongos' ],
            [ 'Trade', 'Oficio', 'Druid', 'Druida' ] ],
  body => {
    en => ['<p>The Principle that is not imposed. A Pact is earned first, with dealings &mdash; shelter, food, defence, not failing &mdash; and the working only acknowledges what already exists between the two. <b>A druid has companions, not tools</b>, and this Principle grants nothing over what has not been pacted.</p>',
'<p>Its three Branches are the three ways of being alive without a word for it: what moves and can be dealt with, what grows without leaving the spot, and what feeds on what has already stopped. They are not degrees of the same thing &mdash; each one is approached differently, and a Pact made with one buys nothing with the others.</p>',
'<p>The one documented meeting between two Principles of this Discipline happens here: a beast that has been Pacted with offers no Opposition to the workings of the Mind, because it has already accepted the arrangement.</p>'],
    es => ['<p>El Principio que no se impone. Un Pacto se gana antes, con trato &mdash; abrigo, comida, defensa, no fallar &mdash; y la operaci&oacute;n &uacute;nicamente reconoce lo que ya existe entre los dos. <b>Un druida tiene compa&ntilde;eros, no herramientas</b>, y este Principio no le concede nada sobre lo que no ha pactado.</p>',
'<p>Sus tres Ramas son las tres maneras de estar vivo sin tener palabra para decirlo: lo que se mueve y admite trato, lo que crece sin salir del sitio, y lo que se alimenta de lo que ya se detuvo. No son grados de una misma cosa &mdash; a cada una se la aborda distinto, y un Pacto hecho con una no compra nada con las otras.</p>',
'<p>El &uacute;nico encuentro documentado entre dos Principios de esta Disciplina ocurre aqu&iacute;: una bestia con la que se ha sellado un Pacto no opone Resiliencia a las operaciones de la Mente, porque ya ha admitido su trato.</p>'],
  },
  stars => [],
},
{
  key => 'animals', kind => 'leaf', parent => 'nature',
  name => { en => 'Animals', es => 'Animales' },
  lead => { en => 'The dealings with what lives and moves', es => 'El trato con lo que vive y se mueve' },
  info => [ [ 'Class', 'Clase', 'Branch of Nature', 'Rama de la Naturaleza' ],
            [ 'Trade', 'Oficio', 'Druid', 'Druida' ] ],
  body => {
    en => ['<p>The Branch that is not imposed. A Pact is earned first, with dealings &mdash; shelter, food, defence, not failing &mdash; and the working only acknowledges what already exists between the two. <b>A druid has companions, not tools</b>, and this Branch grants nothing over what has not been pacted.</p>',
'<p>From the bond come the rest: passing what you want of them without words, borrowing a faculty and fitting it into your own body &mdash; the wolf&rsquo;s nose, the hawk&rsquo;s eye, the fish&rsquo;s breath &mdash; and, at the end, taking their whole form.</p>',
'<p>Here happens the one documented meeting between two Branches of the Discipline: a beast that has been Pacted with offers no Opposition to the workings of the Mind, because it has already accepted the arrangement. A druid and a mentalist working together get from an animal what neither would get alone.</p>'],
    es => ['<p>La Rama que no se impone. Un Pacto se gana antes, con trato &mdash; abrigo, comida, defensa, no fallar &mdash; y el trazado &uacute;nicamente reconoce lo que ya existe entre los dos. <b>Un druida tiene compa&ntilde;eros, no herramientas</b>, y esta Rama no concede nada sobre lo que no se ha pactado.</p>',
'<p>Del v&iacute;nculo sale lo dem&aacute;s: transmitirle lo que se quiere de &eacute;l sin palabras, tomarle prestada una facultad e instalarla en el cuerpo propio &mdash; el olfato del lobo, la vista del halc&oacute;n, el aliento del pez &mdash; y, al final, tomar su forma entera.</p>',
'<p>Aqu&iacute; ocurre el &uacute;nico encuentro documentado entre dos Ramas de la Disciplina: una bestia con la que se ha sellado un Pacto no opone Resiliencia a los trazados de la Mente, porque ya ha admitido su trato. Un druida y un mentalista trabajando juntos consiguen de un animal lo que ninguno conseguir&iacute;a por su cuenta.</p>'],
  },
  stars => [],
},
{
  key => 'plants', kind => 'leaf', parent => 'nature',
  name => { en => 'Plants', es => 'Plantas' },
  lead => { en => 'The dealings with what grows without moving from where it stands',
            es => 'El trato con lo que crece sin moverse del sitio' },
  info => [ [ 'Class', 'Clase', 'Branch of Nature', 'Rama de la Naturaleza' ],
            [ 'Trade', 'Oficio', 'Druid', 'Druida' ] ],
  body => {
    en => ['<p>Governing the growing of a plant: roots that shift, branches that close over a way, a harvest that runs weeks ahead in one night. The same Pact as with a beast, made with something that cannot walk away from it.</p>',
'<p>It is slower than any other Branch and it is the only one whose work is still standing years later. A wall of thorns is not a wall of conjured Ether, which comes undone the moment nobody feeds it &mdash; <b>it is a real thicket that was asked to hurry</b>, and it stays a thicket. That is the whole reason the Discipline holds plants and Alchemy does not.</p>'],
    es => ['<p>Gobernar el crecer de una planta: ra&iacute;ces que se desplazan, ramas que se cierran sobre un paso, una cosecha que adelanta semanas en una noche. El mismo Pacto que con una bestia, hecho con algo que no puede marcharse de &eacute;l.</p>',
'<p>Es m&aacute;s lenta que ninguna otra Rama y es la &uacute;nica cuyo trabajo sigue en pie a&ntilde;os despu&eacute;s. Un muro de espinas no es un muro de &Eacute;ter conjurado, que se deshace en cuanto nadie lo alimenta &mdash; <b>es una zarza de verdad a la que se le ha pedido que se d&eacute; prisa</b>, y sigue siendo una zarza. Esa es toda la raz&oacute;n de que las plantas sean de esta Disciplina y no de la alquimia.</p>'],
  },
  stars => [],
},
{
  key => 'fungi', kind => 'leaf', parent => 'nature',
  name => { en => 'Fungi', es => 'Hongos' },
  lead => { en => 'What lives on what has died', es => 'Lo que vive de lo que ha muerto' },
  info => [ [ 'Class', 'Clase', 'Branch of Nature', 'Rama de la Naturaleza' ],
            [ 'Trade', 'Oficio', 'Druid', 'Druida' ] ],
  body => {
    en => ['<p>A branch of its own, and not a corner of Plants, because what a fungus does is not what a plant does. It does not grow towards the light; it grows through what is already dead, and it is the one living thing whose trade is decay.</p>',
'<p>Which puts it exactly where two Branches of this Discipline meet: it belongs to Nature, and its whole business is the Principle of Death. Whether a Pact with a spread of fungus is even the same kind of Pact &mdash; there is no single body to make it with, and no obvious place where one ends and the next begins &mdash; has not been settled.</p>',
'<p><b>No spell of the supplement lives here yet.</b> The branch is written down before it is filled on purpose: it is a hole with a shape, which is more useful than no hole at all.</p>'],
    es => ['<p>Una Rama propia, y no un rinc&oacute;n de Plantas, porque lo que hace un hongo no es lo que hace una planta. No crece hacia la luz: crece a trav&eacute;s de lo que ya est&aacute; muerto, y es el &uacute;nico ser vivo cuyo oficio es la descomposici&oacute;n.</p>',
'<p>Lo cual lo coloca justo donde se tocan dos Ramas de esta Disciplina: es de la Naturaleza, y todo su negocio es el Principio de la Muerte. Si un Pacto con una extensi&oacute;n de hongo es siquiera la misma clase de Pacto &mdash; no hay un cuerpo con el que hacerlo, ni un sitio evidente donde uno acabe y empiece el siguiente &mdash; no est&aacute; decidido.</p>',
'<p><b>Todav&iacute;a no hay ning&uacute;n conjuro del suplemento aqu&iacute;.</b> La Rama se escribe antes de llenarse a prop&oacute;sito: es un hueco con forma, que sirve m&aacute;s que ning&uacute;n hueco.</p>'],
  },
  stars => [],
},
{
  key => 'life', kind => 'sub', parent => 'spiritism',
  name => { en => 'Life', es => 'Vida' },
  lead => { en => 'The body that is still alive', es => 'El cuerpo que sigue vivo' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Healing, Cleansing', 'Sanaci&oacute;n, Purificaci&oacute;n' ],
            [ 'Trade', 'Oficio', 'Healer', 'Sanador' ] ],
  body => {
    en => ['<p>What repairs in minutes what a body would repair by itself in weeks, and what drives out of a body whatever is consuming it. It is the least ambiguous part of the Discipline: everything it does, a body could in principle have done alone, given time it does not have.</p>',
'<p>Its ceiling is the death rule. Once the soul has scattered there is nothing left to work on, so this Principle stops exactly where the Principle of Death begins &mdash; and neither of the two crosses back.</p>'],
    es => ['<p>Lo que repara en minutos cuanto el cuerpo reparar&iacute;a por s&iacute; solo con semanas, y lo que expulsa de un cuerpo aquello que lo est&aacute; consumiendo. Es la parte menos ambigua de la Disciplina: todo lo que hace podr&iacute;a en principio haberlo hecho el cuerpo solo, con un tiempo del que no dispone.</p>',
'<p>Su techo es la regla de la muerte. Repartida el alma no queda nada sobre lo que trabajar, as&iacute; que este Principio se detiene exactamente donde empieza el de la Muerte &mdash; y ninguno de los dos cruza de vuelta.</p>'],
  },
  stars => [],
},
{
  key => 'death', kind => 'sub', parent => 'spiritism',
  name => { en => 'Death', es => 'Muerte' },
  lead => { en => 'The soul gone, and the dying of tissue that is still part of someone',
            es => 'El alma ida, y el morir del tejido que a&uacute;n forma parte de alguien' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Soul, Sickness', '&Aacute;nima, Enfermedad' ],
            [ 'Trade', 'Oficio', 'Necromancer', 'Nigromante' ] ],
  body => {
    en => ['<p>The Principle that is hunted almost everywhere, and the reason a necromancer rarely says out loud what they do. What it is hunted for is the raising: <b>what gets up moves because the Ether moves it, and there is nobody inside.</b> It does not remember, it does not obey beyond whatever is being imposed on it that instant, and it is not who it was.</p>',
'<p>All this Discipline can do about death itself is reach a soul just gone, in the instant between the death and its scattering into the Ether. After that instant there is nothing to reach. <b>Nothing here, or anywhere else in the art, brings anyone back</b> &mdash; and every spell that claimed to has been struck from the catalogue.</p>',
'<p>Rot is the exception that faces the other way: the only work here done on someone still alive, and the exact counterpart of everything Life does. In many places the word <i>necromancer</i> and the word <i>poison</i> are used as if they meant the same.</p>'],
    es => ['<p>El Principio que se persigue en casi todo el mundo conocido, y el motivo de que un nigromante rara vez diga en voz alta a qu&eacute; se dedica. Se le persigue por levantar: <b>lo que se levanta se mueve porque el &Eacute;ter lo mueve, y dentro no hay nadie.</b> No recuerda, no obedece m&aacute;s de lo que se le est&eacute; imponiendo en ese instante y no es quien fue.</p>',
'<p>Todo lo que esta Disciplina puede hacer con la muerte misma es alcanzar un alma reci&eacute;n ida, en el instante que media entre la muerte y su reparto en el &Eacute;ter. Pasado ese instante no queda nada que alcanzar. <b>Nada de aqu&iacute;, ni de ninguna otra parte del arte, devuelve a nadie</b> &mdash; y todo conjuro que dec&iacute;a hacerlo ha salido del cat&aacute;logo.</p>',
'<p>La podredumbre es la excepci&oacute;n que mira al otro lado: el &uacute;nico trabajo de aqu&iacute; que se hace sobre alguien que sigue vivo, y la contraparte exacta de cuanto hace la Vida. En muchos sitios la palabra <i>nigromante</i> y la palabra <i>veneno</i> se usan como si dijeran lo mismo.</p>'],
  },
  stars => [],
},

# ================================================================ COSMOLOGÍA
{
  key => 'cosmology', kind => 'discipline', parent => 'astronomy',
  name => { en => 'Cosmology', es => 'Cosmología' },
  lead => { en => 'Space, time and gravity', es => 'El espacio, el tiempo y la gravedad' },
  info => [
    [ 'Base state', 'Estado base', 'The Abyss', 'El Abismo' ],
    [ 'Imitates', 'Imita a', 'A black hole', 'Un agujero negro' ],
    [ 'Mark', 'Marca', 'Rings closing on a dark core', 'Anillos que se aprietan hacia un n&uacute;cleo oscuro' ],
    [ 'Ordered by', 'Se ordena por', '7 Principles, 13 Branches', '7 Principios, 13 Ramas' ],
  ],
  body => {
    en => [
'<p>Cosmology begins at <b>the Abyss</b>: the mass is collapsed until it weighs more than it should, which is what a star that has fallen in on itself does &mdash; and a fallen star is, in this world, what bends space and time most. The mark says both at once: rings closing on a dark core.</p>',
'<p>It is the youngest of the three, and the one that fused two older bodies of study &mdash; the working of time and the working of distance &mdash; once it was clear they were not two subjects but one. <b>A gravity well and a portal are, for this Discipline, two shapes of the same thing.</b> Its Principles are still studied apart, and whoever masters one may not be able to trace any of the others.</p>',
'<p><b>Of what it inherited, one Branch did not survive the rules as they now stand</b>, and is recorded here rather than quietly dropped: <b>Pocket</b>, the second Branch of Passage, made a closed space that is nowhere. There is no space apart from this one &mdash; and nothing made of Ether lasts unless somebody keeps feeding it, which no place nobody is standing in ever gets.</p>',
'<p><b>Presage</b> survived, but only just, and much smaller than it was. It no longer reads the future, because nothing has written the future down; it reads a probable outcome of what is already in motion, which is a different and far humbler thing.</p>',
'<p>What remains is severely bounded, and deliberately so. A well or a way lasts exactly as long as it is fed and not one instant longer, so the inherited enclaves of the old treatise are impossible: <b>this is the Discipline of the passage, not of the destination.</b></p>',
    ],
    es => [
'<p>La cosmolog&iacute;a empieza en <b>el Abismo</b>: la masa se colapsa hasta pesar m&aacute;s de lo que debe, que es lo que hace una estrella ca&iacute;da sobre s&iacute; misma &mdash; y una estrella ca&iacute;da es, en este mundo, lo que m&aacute;s tuerce el espacio y el tiempo. La marca lo dice a la vez: anillos que se aprietan hacia un n&uacute;cleo oscuro.</p>',
'<p>Es la m&aacute;s joven de las tres, y la que fundi&oacute; dos cuerpos de estudio m&aacute;s viejos &mdash; el trabajo sobre el tiempo y el trabajo sobre la distancia &mdash; cuando qued&oacute; claro que no eran dos materias sino una. <b>Un pozo de gravedad y un portal son, para esta Disciplina, dos formas de lo mismo.</b> Sus Principios se siguen estudiando por separado, y quien domina uno puede no saber trazar ninguno de los otros.</p>',
'<p><b>De lo que hered&oacute;, una Rama no sobrevive a las reglas tal como est&aacute;n ahora</b>, y se deja aqu&iacute; escrita en vez de retirarla sin decirlo: <b>Bolsillo</b>, la segunda Rama de Paso, formaba un espacio cerrado que no est&aacute; en ninguna parte. No hay m&aacute;s espacio que este &mdash; y nada hecho de &Eacute;ter dura si nadie lo alimenta, cosa que nunca recibe un sitio en el que no hay nadie.</p>',
'<p><b>Porvenir</b> sobrevive, pero por poco y mucho m&aacute;s peque&ntilde;o de lo que era. Ya no lee el futuro, porque nadie ha escrito el futuro; lee un desenlace probable de lo que ya est&aacute; en marcha, que es otra cosa y mucho m&aacute;s humilde.</p>',
'<p>Lo que queda est&aacute; severamente acotado, y a prop&oacute;sito. Un pozo o un paso duran exactamente lo que se les alimente y ni un instante m&aacute;s, de modo que los enclaves heredados del tratado viejo son imposibles: <b>esta es la Disciplina del paso, no la del destino.</b></p>',
    ],
  },
  stars => [],
},
{
  key => 'time', kind => 'sub', parent => 'cosmology',
  name => { en => 'Time', es => 'Tiempo' },
  lead => { en => 'The rate at which things happen, and the years already spent',
            es => 'El ritmo al que ocurre lo que ocurre, y los años ya gastados' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Tempo, Age, Past, Presage', 'Ritmo, Edad, Pasado, Porvenir' ] ],
  body => {
    en => ['<p>Everything Cosmology does to <b>when</b>. Four branches: what it reaches happens sooner or later than it would, or stops happening; the years piled onto a body or taken off it; matter and memory put back the way they were; and the sliver of what has not happened yet that can still be read.</p>',
'<p>Speeding a body and speeding the processes inside it are two different Stars, and the second is the quieter and the more useful: blood that stops running from a wound, mortar that sets in an afternoon. <b>Halting</b> is the most expensive thing this Discipline does after undoing the past, and what is halted does not stop being dangerous &mdash; a flame held halfway down its fall is still burning, and catches whatever touches it the instant the channelling fails.</p>',
'<p><b>Presage does not read the future.</b> Nothing has written the future down, so there is nothing there to read, and every spell that claimed to ask a god what was coming has been struck from the catalogue. What survives is smaller and defensible: a probable outcome of what is already in motion. The stone is already falling; where it lands is not prophecy, it is arithmetic done faster than a body can do it.</p>',
'<p>Looking backwards comes out far cheaper than looking forwards, and no school has ever explained why.</p>'],
    es => ['<p>Todo lo que la cosmolog&iacute;a le hace al <b>cu&aacute;ndo</b>. Cuatro Ramas: lo que alcanza ocurre antes o despu&eacute;s de lo que ocurrir&iacute;a, o deja de ocurrir; los a&ntilde;os que se le cargan a un cuerpo o se le quitan; la materia y la memoria devueltas a como estaban; y la rendija de lo que a&uacute;n no ha ocurrido que todav&iacute;a se puede leer.</p>',
'<p>Acelerar un cuerpo y acelerar los procesos que lleva dentro son dos Estrellas distintas, y la segunda es la m&aacute;s callada y la m&aacute;s &uacute;til: sangre que deja de correr por una herida, argamasa que fragua en una tarde. <b>Detener</b> es lo m&aacute;s caro que hace esta Disciplina despu&eacute;s de deshacer el pasado, y lo detenido no deja de ser peligroso &mdash; una llama suspendida a media ca&iacute;da sigue ardiendo y prende cuanto la toque en el instante en que la canalizaci&oacute;n falle.</p>',
'<p><b>Porvenir no lee el futuro.</b> Nadie ha escrito el futuro, as&iacute; que no hay nada ah&iacute; que leer, y todo conjuro que dec&iacute;a preguntarle a un dios qu&eacute; ven&iacute;a ha salido del cat&aacute;logo. Lo que sobrevive es m&aacute;s peque&ntilde;o y defendible: un desenlace probable de lo que ya est&aacute; en marcha. La piedra ya est&aacute; cayendo; d&oacute;nde aterriza no es profec&iacute;a, es una cuenta hecha m&aacute;s deprisa de lo que un cuerpo la hace.</p>',
'<p>Mirar atr&aacute;s sale mucho m&aacute;s barato que mirar adelante, y ninguna escuela ha explicado nunca por qu&eacute;.</p>'],
  },
  stars => [],
},
{
  key => 'space', kind => 'sub', parent => 'cosmology',
  name => { en => 'Space', es => 'Espacio' },
  lead => { en => 'The distance between two points, and the shape of what fills it',
            es => 'La distancia entre dos puntos, y la forma de lo que la ocupa' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Passage, Distortion', 'Paso, Distorsi&oacute;n' ] ],
  body => {
    en => ['<p>Two points of the world set side by side, and what can be done to a body once distance stops mattering. It is the widest part of Cosmology by some way, and the one everyone means when they talk about it.</p>',
'<p><b>Seeing at a distance counts here.</b> A remote sensor is two points set side by side; it simply sends sight across instead of a body. Finding something far off is the same operation with nothing sent at all.</p>',
'<p>Its other half works on the body rather than the gap: how much room it takes up, its parts held apart without ceasing to be joined, and two bodies changing places. <b>Swapping is the cleanest thing this Discipline does</b> &mdash; the Ether measures only the distance between the two, so exchanging a man for a stone costs the same as exchanging two men, and there is no living pulse to resist it. The only thing that dodges it is not being where the astronomer thought you were.</p>',
'<p>What it cannot do is make somewhere new. <b>Pocket</b>, the branch that made a closed space that is nowhere, has been struck out: there is no space apart from this one, and nothing made of Ether lasts unless somebody keeps feeding it &mdash; which no place with nobody standing in it ever gets. This is the Discipline of the passage, not of the destination.</p>'],
    es => ['<p>Dos puntos del mundo puestos uno junto a otro, y lo que se le puede hacer a un cuerpo cuando la distancia deja de importar. Es con diferencia la parte m&aacute;s ancha de la cosmolog&iacute;a, y la que todo el mundo tiene en la cabeza cuando habla de ella.</p>',
'<p><b>Ver a distancia cuenta aqu&iacute;.</b> Un sensor remoto son dos puntos puestos uno junto a otro; solo que manda la vista en lugar de un cuerpo. Encontrar algo lejano es la misma operaci&oacute;n sin mandar nada.</p>',
'<p>Su otra mitad trabaja sobre el cuerpo y no sobre el hueco: cu&aacute;nto ocupa, sus partes apartadas sin dejar de estar unidas, y dos cuerpos que cambian de sitio. <b>Permutar es lo m&aacute;s limpio que hace esta Disciplina</b> &mdash; el &Eacute;ter mide &uacute;nicamente la distancia que los separa, as&iacute; que cambiar a un hombre por una piedra cuesta lo mismo que cambiar a dos hombres, y no hay pulso vital que se le oponga. Lo &uacute;nico que la esquiva es no estar donde el astr&oacute;nomo cre&iacute;a que se estaba.</p>',
'<p>Lo que no puede es fabricar un sitio nuevo. <b>Bolsillo</b>, la Rama que formaba un espacio cerrado que no est&aacute; en ninguna parte, ha quedado tachada: no hay m&aacute;s espacio que este, y nada hecho de &Eacute;ter dura si nadie lo alimenta &mdash; cosa que nunca recibe un sitio en el que no hay nadie. Esta es la Disciplina del paso, no la del destino.</p>'],
  },
  stars => [],
},
{
  key => 'gravity', kind => 'sub', parent => 'cosmology',
  name => { en => 'Gravity', es => 'Gravedad' },
  lead => { en => 'Where what there is falls, and how hard',
            es => 'Hacia d&oacute;nde y con cu&aacute;nta fuerza cae lo que hay' },
  info => [ [ 'Class', 'Clase', 'Principle', 'Principio' ],
            [ 'Branches', 'Ramas', 'Weight, Field', 'Peso, Campo' ] ],
  body => {
    en => ['<p>Two branches, and the difference between them is who is being answered. <b>Weight</b> works on one body: how hard what is underneath pulls on it. <b>Field</b> works on a stretch of the world: which way everything inside it falls, or towards which single point.</p>',
'<p>The Well is the Principle standing on its own threshold &mdash; the Abyss made small and put somewhere on purpose. It is where this Discipline most plainly imitates what it is named after, and the one place in the whole art where a base state is turned outwards and used as an effect.</p>'],
    es => ['<p>Dos Ramas, y la diferencia entre ellas es a qui&eacute;n se le responde. <b>Peso</b> trabaja sobre un cuerpo: cu&aacute;nto tira de &eacute;l lo que hay debajo. <b>Campo</b> trabaja sobre una extensi&oacute;n del mundo: hacia d&oacute;nde cae cuanto haya dentro, o hacia qu&eacute; punto &uacute;nico.</p>',
'<p>El Pozo es el Principio puesto sobre su propio umbral &mdash; el Abismo hecho peque&ntilde;o y colocado en alg&uacute;n sitio a prop&oacute;sito. Es donde esta Disciplina imita m&aacute;s a las claras aquello de lo que toma el nombre, y el &uacute;nico sitio del arte entero donde un estado base se vuelve hacia fuera y se usa como efecto.</p>'],
  },
  stars => [],
},


# ============================================================ DESCATALOGADOS
# No es una Disciplina ni cuelga de la astronomia: es donde esperan los
# conjuros que el sistema todavia no coloca. Su contenido sale de
# descatalogados.txt, agrupado en tablas.
{
  key => 'uncatalogued', kind => 'limbo', parent => undef,
  name => { en => 'Uncatalogued', es => 'Descatalogados' },
  lead => { en => 'Spells that hang from no Discipline, and why',
            es => 'Conjuros que no cuelgan de ninguna Disciplina, y por qu&eacute;' },
  info => [
    [ 'Status', 'Estado', 'Outside the art', 'Fuera del arte' ],
    [ 'Why they are here', 'Por qu&eacute; est&aacute;n aqu&iacute;', 'Each one says so on its own page',
      'Cada uno lo dice en su propia p&aacute;gina' ],
  ],
  body => {
    en => [
'<p>These spells exist and have pages, but they hang from no Discipline. Some the magic system refuses outright &mdash; they ask a deity, they travel to a plane that is not there, they bring back a soul that has already scattered. Others are simply <b>not decided yet</b>: the catalogue that would hold them has not been written.</p>',
'<p>They are kept, and kept visible, on purpose. <b>A supplement that quietly deletes what does not fit teaches nothing</b>; one that writes down what it could not place, and why, is a document you can argue with. Every spell below carries its reason on its own page.</p>',
'<p>The tables are the shapes of the problem, not four separate rules: what invokes something, what poisons, what picks its own element, and what undoes death.</p>',
    ],
    es => [
'<p>Estos conjuros existen y tienen p&aacute;gina, pero no cuelgan de ninguna Disciplina. Algunos el sistema de magia los rechaza de plano &mdash; le piden algo a una deidad, viajan a un plano que no est&aacute; ah&iacute;, devuelven un alma que ya se ha repartido. Otros sencillamente <b>no est&aacute;n decididos</b>: el cat&aacute;logo que los albergar&iacute;a no se ha escrito todav&iacute;a.</p>',
'<p>Se conservan, y se conservan a la vista, a prop&oacute;sito. <b>Un suplemento que borra en silencio lo que no le encaja no ense&ntilde;a nada</b>; uno que escribe qu&eacute; no supo colocar, y por qu&eacute;, es un documento con el que se puede discutir. Cada conjuro de abajo lleva su motivo en su propia p&aacute;gina.</p>',
'<p>Las tablas son las formas del problema, no cuatro reglas distintas: lo que invoca algo, lo que envenena, lo que elige su propio elemento y lo que deshace la muerte.</p>',
    ],
  },
  stars => [],
},

);

\@T;
