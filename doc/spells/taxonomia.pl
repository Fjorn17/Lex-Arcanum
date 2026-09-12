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
'<p>Magic here is one art, and it works with one material. Every Discipline on this site and every spell in the catalogue is something done to the Ether, and nothing else. What follows is what the Ether is, how a body handles it and what it can be asked for. The three Disciplines come at the end, because they are the last thing: thresholds forced on something you were already holding.</p>',

'<h2>The Ether</h2>',
'<p>The Ether soaks all matter, living and inert, and always has. It has no origin anyone can date and no source that could run dry. It crosses any body with the same involuntary constancy as heat or the pressure of the air, so nobody who breathes has ever not been bathed in it. It is in the room where this is being read, and in whoever is reading it.</p>',
'<p>Spread out the way it usually is, it cannot be seen. Gathered, it shines, and that one fact named the whole art: a working in progress looks from outside like a set of lit points joined by faint threads, which is exactly what a constellation looks like. When somebody says a <b>Constellation</b> is lit, they are not speaking figuratively. Nobody named any of this with imagination; things were called what they looked like.</p>',
'<p>It is neither made nor destroyed, only gathered, and gathering it here is taking it from there, so every concentration leaves a thinned halo around it in which everyone channels worse. That includes whoever caused it, which is why two astronomers working together get in each other&rsquo;s way if they stand too close.</p>',
'<p>It behaves like a fluid and it takes up volume, so it can be sharpened, spread and pressed, and what it does depends on how tightly it is packed. Very little density gives <b>light</b>, and that comes free. A middling density gives <b>movement and force</b>. A high density gives <b>presence</b>: it weighs, it strikes and it gets in the way, as though it were matter. That third one is ruinously expensive, and the whole balance between this art and Alchemy sits in that expense, because Astronomy can hit like a rock by paying far more than Alchemy pays to make the rock. It can do almost everything badly, and a few things like nobody else.</p>',
'<p>When a body dies, its soul scatters into the Ether the way any other concentration scatters. That is why death is final in this world, and why nothing in this supplement brings anyone back.</p>',

'<h2>The body</h2>',
'<p>Everyone carries an <b>Etheric system</b>, an inner network that gives the Ether shape. It is born in the brain and built to the same architecture as the nervous system, which will have unpleasant consequences later on. The brain gathers the Ether, orders it and drives it towards a <b>termination</b>.</p>',
'<p>The termination is an organ evolution reused, and the job it had before decides what it can produce now. A specialised organ gives one effect, always the same one, by instinct: that is how a creature spits fire without having studied anything. A human hand is not specialised in anything, and so it gives them all. Its advantage is not one of movement but of housing: it is for holding, not for gesturing.</p>',
'<p>Two hands, two Stars. Nobody holds more than two at once, and no degree of mastery raises that count, because the limit is the body and not the skill. The only way past it is a <b>Conjunction</b>: several people running one design with one entry point each. That is why the serious work of this world is collective, and why a large working looks more like a crew than like a wizard.</p>',

'<h2>The Star</h2>',
'<p>A <b>Star</b> is a mass of Ether gathered and held. It exists for as long as somebody holds it, and it shines, because it is dense Ether. It carries no value decided in advance: its size is simply the Ether that has been put into it.</p>',
'<p>It is born by <b>Accretion</b>, which means driving your own flow of Ether above its passive rate, at whatever speed your Will allows. Accretion does not stop once the Star is formed, so it can go on being loaded until the last moment; its size stays open until the instant it is handed over.</p>',
'<p>Left unfed it <b>wanes</b>: it bleeds out into its own halo and eventually disappears. Holding a Star is not having a hand busy, it is going on pouring, and Focus sustains that trickle rather than an idea. Hence there is no such thing as stored power &mdash; not so much because of the waning, which can after all be paid for, but because there are only two hands and everything you carry has to be fed. Nobody arrives anywhere already loaded.</p>',

'<h2>The five operations</h2>',
'<p>There are five things you can do with a Star. Four change how many Stars are in play, and those are the four points a written design gives a name to. The fifth does not change the count: it changes what the Star is.</p>',
'<p><b>Gathering</b> brings it into the world, and it is the one step nobody writes down, because it is always the same. <b>Splitting</b> shares the Ether between two halves without duplicating anything and without undoing any work, so both halves keep the whole state they were carrying; it needs a free hand. <b>Joining</b> adds them back together, and in adding them the states meet and something comes out that was neither of the two. That Convergence is where new things are born, which is why a discovery cannot be read out of a book: you have to have produced it yourself.</p>',
'<p>Joining has one condition that costs dearly. Every change has a minimum below which it simply has not happened, and to join two Stars both must have reached the minimum of the state they are carrying. With one of them halfway, the spell fails. Waiting is compulsory, and waiting is an idle hand spending Focus while the work already done bleeds away.</p>',
'<p><b>Transforming</b> means giving the Ether a state, and the state decides what it will do when it is handed over. It is what the catalogue names: every Transformation has a direction, a minimum and a result. It is done with the mind, from the brain, and there are no gestures of any kind. Each one has its word, which helps but does not command: it is a handhold for the state being aimed at, not an order to the Ether, and it only serves someone who has produced that state at least once. To everyone else it is noise. Silence works, but it costs more Concentration and fails more often, which is why the apprentice speaks and the master does not.</p>',
'<p><b>Handing over</b> is letting go, and it has no rules of its own because it is not an act: it is the moment the spell ends. What happens next is decided by the state the Star had on it. With no Transformation of delivery, it simply happens where the hand is, doing whatever it is capable of doing without going anywhere. Gathering Ether and releasing it is still a complete spell, even if it is the poorest one there is: it leaves a light on the ground that lasts as long as its Ether allows, and being able to put it down is already worth something.</p>',
'<p>Out of all this comes the rule that governs the whole art: what the Ether <i>is</i> acts always, and what has been <i>imposed</i> on it acts on release. A Star lights the hand from the first instant, and pressed hard enough it weighs and blocks while still in the hand; but a push put into it moves nothing until it is let go. A dense Star is a weapon before it is thrown, and a blade can be turned aside with one.</p>',

'<h2>The Constellation</h2>',
'<p>A <b>Constellation</b> is the written record of the steps: points for the states, Filaments for the steps that lead from one to the next. It is not a circuit, it is a guide, and the paper conducts absolutely nothing. It says what to do and in what order, and it never says how much or for how long; there is not a single quantity written anywhere in it. That is why the same Constellation performs differently in different hands.</p>',
'<p>It is drawn rather than listed because the work branches, and a graph has to be drawn. The length of the strokes and the layout of the drawing mean nothing: two designs with the same steps in the same order are the same Constellation even if they look nothing alike on the page.</p>',
'<p>Reading one is not enough to light it. A Transformation only serves someone who has already produced that state at least once, so what the guide supplies is the order, the splits and the convergences, which is precisely the part nobody remembers. A star chart is not a weapon in a bottle but a reminder, and you cannot arm anyone with magic they do not know how to make. Stealing an Atlas gives information and not power, which is exactly what espionage needs and not an ounce more.</p>',
'<p>Three things are worth keeping apart that usually get confused for one. The <b>Repertoire</b> is what you have managed to produce at least once; it is written nowhere and cannot be stolen. The <b>Atlas</b> is the book of the Constellations you have charted, and it is an object, so it can be copied, stolen, burnt and inherited. And what is <b>memorised</b> is the part of the Atlas you can run without looking. A master still carries a book, not because his skill is kept in it, but because the long recipes are.</p>',

'<h2>The four qualities</h2>',
'<p>The qualities that matter here are human and not magical: they are inherited by species and by line, and none of them does another one&rsquo;s job.</p>',
'<p><b>Will</b> sets the speed of Accretion and the yield of the Ether when it has to impose itself on somebody else, but it adds no force to any effect. <b>Intellect</b> is a requirement and not a modifier: it says who can write or light a Constellation, and whoever falls short cannot, while whoever clears it gets no better result for it. What raises the bar is not splitting but diverging: splitting to release a copy is cheap, and splitting to carry two different recipes is not. <b>Resilience</b> decides how much resistance you get for each unit of Concentration spent defending yourself, and also how long an Intoxication lasts and how much it hurts. <b>Focus</b> decides how long a Star stays up without slipping.</p>',
'<p>Hands and Intellect do not tread on each other, because they are not talking about the same thing: the hands decide what is possible and the Intellect decides who can.</p>',

'<h2>What it costs</h2>',
'<p>The Ether is free and endless. There is no mana, no reservoir and no gauge. What is paid for is not the material but the effort of moving it, and it is paid in the three layers the body always keeps count in: breath, tiredness and injury. In the mind those are called <b>Concentration</b>, which comes back in seconds; <b>Mental Fatigue</b>, which needs sleep; and <b>Ether Intoxication</b>, which is an injury and needs treatment.</p>',
'<p>Intoxication is Ether the network failed to steer, left piled up inside. Acute, it passes, and Resilience decides how hard and how long. Repeated or severe, it does not pass: first it cuts down what a person can channel, then it stops the Accretion, and in the end it takes it away for good. And because the Etheric system shares its architecture with the nervous one, when it overflows it overflows into that. It can kill.</p>',
'<p>Working with both hands is not poisonous by decree: it spends twice and tires twice, and so it reaches the point of injury in half the time. At the other end there is <b>Asterism</b>, the everyday magic everybody does. It comes out of the passive flow, it does not tire and it costs no breath. It is not a separate gift: it is step zero.</p>',
'<p><b>Opposition</b> is not a skill either. It is what your own Ether does when something foreign tries to get in, and everyone has it, because every body is full of Ether: a farmhand resists badly, but he resists. The floor is free, and pushing above that floor spends Concentration, which is the same Concentration holding up your own Stars. Hence the most vulnerable astronomer is the one who is working. You strike a mage while he is building, not before.</p>',

'<h2>Nothing lasts by itself</h2>',
'<p>All gathered Ether comes undone, in the hand and on the ground alike, and matter is no exception. What wanes between the fingers and what dissolves lying on the ground are the same phenomenon: concentrated Ether always goes back to being spread out.</p>',
'<p>What decides how long that takes is not how much Ether a thing is carrying but how many times over its own minimum it is. The minimum of a state does two jobs at once: it is what is needed to reach it and what is needed to go on being it. A large stone and a small one, each at twice what it itself needs, last exactly the same. And an unset mass lasts longer than a rock made of the same Ether, not because it follows a different rule, but because being a rock is more demanding than being a lump.</p>',
'<p>It can be fed again: touch it and pour. Feeding costs exactly what is being lost, no more and no less, and it takes a hand the same way holding does, so whoever is keeping a wall up has his hand on the wall. Permanence therefore stops being a property of things and becomes a job. Nothing lasts on its own; it lasts as long as somebody is willing to keep it.</p>',
'<p>So this world has no magical ruins, no enchanted objects forgotten in a drawer and no traps still armed a century later. You never find old magic: you find the place where some once was.</p>',
'<p><i>That is the fiction. The spell entries on this site keep the game&rsquo;s own durations, so a ward written here can still last an hour. Where the two disagree, the entry is what you play and this is what it means.</i></p>',

'<h2>What Astronomy does, having crossed nothing</h2>',
'<p>Every Constellation starts here, because Astronomy has nothing to decide in advance. A spell is Astronomy before it is anything else, and it does not stop being one afterwards.</p>',
'<p>What it does is everything that commits the Ether to nothing. It gathers it, sharpens it, presses it until it weighs, pushes and pulls it, reads it, hinders it and takes it away from somebody else. It forges no matter and closes no wound, because the difference between an astronomer and a star is one of quantity and that quantity is unreachable. What an astronomer has instead of quantity is <b>direction</b>.</p>',
'<p>In exchange it reaches Ether wherever the Ether is, including the Ether running inside another body and the Ether another hand is holding. That is its one uncontested advantage, and the reason it is what decides duels. A Star handed over inside someone imposes the same Intoxication an astronomer inflicts on himself by forcing his own Accretion, only put in from outside. It accumulates, so it hits hardest whoever has been pushing hardest, and it does not aim to kill: it aims to take away somebody&rsquo;s Accretion, which in this world is a kind of civil death.</p>',

'<h2>The three thresholds</h2>',
'<p>Astronomy has no subdivisions of its own. Its subdivisions are the three Disciplines, and each is reached by forcing a Star past a threshold. <b>The Crucible</b>, where the mass is pressed until it crosses over into substance, opens Alchemy. <b>The Abyss</b>, where it collapses until it weighs more than it should, opens Cosmology. And the threshold that holds life, which is the piece of this art still without a name, opens Spiritism. All three imitate something a star does, at a scale nobody is going to reach.</p>',
'<p>The base state is a step you execute, not a label you attach: without it no Transformation of that Discipline is worth anything. And it shows from outside, so people know what somebody is making from the second step onwards.</p>',
'<p>A Star that crosses a threshold does not leave Astronomy: it enters a region of it with its own rules of stability, and it still answers to everything Astronomy knows how to do, because it never stopped being Ether. Crossing a second threshold, in a Convergence, is the summit of the art, and it is paid for in all four coins at once: you have to split early, carry two histories with nothing in common, bear double the Intoxication and square a Convergence at the end.</p>',
],
    es => [
'<p>Aqu&iacute; la magia es un solo arte y trabaja con un solo material. Todas las Disciplinas de este sitio y todos los conjuros del cat&aacute;logo son cosas que se le hacen al &Eacute;ter, y nada m&aacute;s. Lo que viene a continuaci&oacute;n es qu&eacute; es el &Eacute;ter, c&oacute;mo lo maneja un cuerpo y qu&eacute; se le puede pedir. Las tres Disciplinas aparecen al final, porque son lo &uacute;ltimo: umbrales que se le fuerzan a algo que ya se ten&iacute;a en la mano.</p>',

'<h2>El &Eacute;ter</h2>',
'<p>El &Eacute;ter impregna toda la materia, la viva y la inerte, y lo ha hecho desde siempre. No se le conoce origen que datar ni fuente que se pueda agotar. Atraviesa cualquier cuerpo con la misma constancia involuntaria que el calor o la presi&oacute;n del aire, de manera que nadie que respire ha dejado nunca de estar ba&ntilde;ado en &eacute;l. Est&aacute; en la sala donde se lee esto y en quien lo lee.</p>',
'<p>Repartido como est&aacute; normalmente no se ve. Cuando se junta, alumbra, y de ese hecho sali&oacute; el nombre del arte entero: una operaci&oacute;n en marcha se ve desde fuera como una serie de puntos encendidos unidos por hilos tenues, que es exactamente lo que parece una constelaci&oacute;n. Cuando se dice que una <b>Constelaci&oacute;n</b> se enciende no se est&aacute; hablando en figurado. Nadie bautiz&oacute; nada de esto con imaginaci&oacute;n; se le puso a las cosas el nombre de lo que se ve&iacute;a.</p>',
'<p>Ni se fabrica ni se destruye: se re&uacute;ne. Y reunirlo aqu&iacute; es quit&aacute;rselo a all&iacute;, de modo que alrededor de toda concentraci&oacute;n queda un halo empobrecido en el que se canaliza peor. Lo sufre tambi&eacute;n quien lo ha provocado, y por eso dos astr&oacute;nomos que trabajan juntos se estorban si se ponen demasiado cerca.</p>',
'<p>Se comporta como un fluido y ocupa volumen, as&iacute; que se le puede afilar, extender y apretar, y lo que hace depende de lo apretado que est&eacute;. Muy poca densidad da <b>luz</b>, y eso sale gratis. Una densidad media da <b>movimiento y fuerza</b>. Una densidad alta da <b>presencia</b>: pesa, golpea y estorba como si fuera materia. Esa tercera es car&iacute;sima, y en esa carest&iacute;a est&aacute; todo el equilibrio entre este arte y la alquimia, porque la astronom&iacute;a puede golpear como una roca pagando mucho m&aacute;s de lo que le cuesta a la alquimia hacer la roca. Puede hacerlo casi todo p&eacute;simamente, y unas pocas cosas como nadie.</p>',
'<p>Cuando un cuerpo muere, su alma se reparte en el &Eacute;ter igual que se reparte cualquier otra concentraci&oacute;n. De ah&iacute; que la muerte sea definitiva en este mundo, y que nada de este suplemento devuelva a nadie.</p>',

'<h2>El cuerpo</h2>',
'<p>Todo el mundo lleva dentro un <b>sistema et&eacute;reo</b>, una red interna que le da forma al &Eacute;ter. Nace en el cerebro y est&aacute; construido con la misma arquitectura que el sistema nervioso, cosa que tendr&aacute; consecuencias desagradables m&aacute;s adelante. El cerebro recoge el &Eacute;ter, lo ordena y lo empuja hacia una <b>terminaci&oacute;n</b>.</p>',
'<p>La terminaci&oacute;n es un &oacute;rgano que la evoluci&oacute;n reaprovech&oacute;, y el trabajo que ten&iacute;a antes decide qu&eacute; puede producir ahora. Un &oacute;rgano especializado da un solo efecto, siempre el mismo, por instinto: as&iacute; es como una criatura escupe fuego sin haber estudiado nada. Una mano humana no est&aacute; especializada en nada, y por eso los da todos. Su ventaja no es de movimiento sino de albergue: sirve para contener, no para gesticular.</p>',
'<p>Dos manos, dos Estrellas. Nadie sostiene m&aacute;s de dos a la vez, y ning&uacute;n grado de maestr&iacute;a sube esa cuenta, porque el l&iacute;mite est&aacute; en el cuerpo y no en la habilidad. La &uacute;nica manera de pasar de ah&iacute; es una <b>Conjunci&oacute;n</b>: varias personas ejecutando un mismo trazado con un punto de entrada cada una. Por eso el trabajo serio de este mundo es colectivo, y por eso una obra grande se parece m&aacute;s a una cuadrilla que a un mago.</p>',

'<h2>La Estrella</h2>',
'<p>Una <b>Estrella</b> es una masa de &Eacute;ter reunida y sostenida. Existe mientras alguien la sostenga, y alumbra, porque es &Eacute;ter denso. No lleva ning&uacute;n valor de antemano: su tama&ntilde;o es sencillamente el &Eacute;ter que se le haya metido.</p>',
'<p>Nace por <b>Acreci&oacute;n</b>, que consiste en acelerar el flujo propio de &Eacute;ter por encima de su ritmo pasivo, a la velocidad que permita la Voluntad de cada cual. La Acreci&oacute;n no se detiene cuando la Estrella ya est&aacute; formada, as&iacute; que se la puede seguir cargando hasta el &uacute;ltimo momento; su tama&ntilde;o queda abierto hasta el instante en que se entrega.</p>',
'<p>Si se deja de alimentarla, <b>merma</b>: se desangra hacia su propio halo y acaba por desaparecer. Sostener una Estrella no es tener una mano ocupada, es seguir vertiendo, y el Enfoque sostiene ese goteo y no una idea. De ah&iacute; que no exista el poder almacenado. No tanto por la merma, que al fin y al cabo se puede pagar, sino porque solo hay dos manos y todo lo que se lleva encima hay que alimentarlo. Nadie llega a ninguna parte cargado de antemano.</p>',

'<h2>Las cinco operaciones</h2>',
'<p>Con una Estrella se pueden hacer cinco cosas. Cuatro cambian cu&aacute;ntas Estrellas hay en juego, y son los cuatro puntos que un trazado escrito nombra. La quinta no cambia la cuenta: cambia lo que la Estrella es.</p>',
'<p><b>Reunir</b> la trae al mundo, y es el &uacute;nico paso que no se escribe porque siempre es el mismo. <b>Partir</b> reparte el &Eacute;ter entre dos mitades sin duplicar nada y sin deshacer lo hecho, de manera que las dos conservan entero el estado que llevaban; exige una mano libre. <b>Juntar</b> vuelve a sumarlas, y al sumarlas los estados se encuentran y sale algo que no era ninguna de las dos. Es en esa Convergencia donde nace lo nuevo, y de ah&iacute; que un hallazgo no se pueda leer en un libro: hay que haberlo producido uno mismo.</p>',
'<p>Juntar tiene una condici&oacute;n que cuesta caro. Todo cambio tiene un m&iacute;nimo por debajo del cual sencillamente no ha ocurrido, y para juntar dos Estrellas las dos han de haber alcanzado el m&iacute;nimo del estado que llevan. Con una a medias, el conjuro fracasa. Esperar es obligatorio, y esperar es una mano parada gastando Enfoque mientras lo ya hecho se desangra.</p>',
'<p><b>Transformar</b> es darle un estado al &Eacute;ter, y el estado decide qu&eacute; har&aacute; al entregarse. Es lo que el cat&aacute;logo nombra: cada Transformaci&oacute;n tiene una direcci&oacute;n, un m&iacute;nimo y un resultado. Se hace con la mente, desde el cerebro, y no hay gestos de ning&uacute;n tipo. Cada una tiene su palabra, que ayuda pero no manda: es un asidero para el estado al que se apunta, no una orden al &Eacute;ter, y solo le sirve a quien ya ha producido ese estado alguna vez. A los dem&aacute;s les suena a ruido. En silencio se puede, pero cuesta m&aacute;s Concentraci&oacute;n y se falla m&aacute;s, que es la raz&oacute;n de que el aprendiz hable y el maestro no.</p>',
'<p><b>Entregar</b> es dejar de sostener, y no tiene reglas propias porque no es un acto: es el momento en que el conjuro termina. Lo que ocurra despu&eacute;s lo decide el estado que la Estrella llevaba puesto. Si no se le ha puesto ninguna Transformaci&oacute;n de reparto, se manifiesta donde est&eacute; la mano y hace lo que sea capaz de hacer sin ir a ninguna parte. Reunir &Eacute;ter y soltarlo sigue siendo un conjuro completo, aunque sea el m&aacute;s pobre que existe: deja una luz en el suelo que dura lo que su &Eacute;ter le permita, y poder dejarla ah&iacute; ya es algo.</p>',
'<p>De todo esto sale la regla que gobierna el arte entero: lo que el &Eacute;ter <i>es</i> act&uacute;a siempre, y lo que se le <i>ha impuesto</i> act&uacute;a al soltar. Una Estrella alumbra la mano desde el primer instante, y apretada lo suficiente pesa y estorba en la mano; pero un empuje que se le haya puesto no mueve nada hasta que se suelta. Una Estrella densa es un arma antes de lanzarla, y se puede parar un filo con ella.</p>',

'<h2>La Constelaci&oacute;n</h2>',
'<p>Una <b>Constelaci&oacute;n</b> es el registro escrito de los pasos: puntos para los estados, Filamentos para los pasos que llevan de uno a otro. No es un circuito, es una gu&iacute;a, y el papel no conduce absolutamente nada. Dice qu&eacute; hacer y en qu&eacute; orden, y no dice nunca cu&aacute;nto ni durante cu&aacute;nto tiempo; no hay una sola cantidad escrita en ninguna parte. Por eso la misma Constelaci&oacute;n rinde distinto en manos distintas.</p>',
'<p>Se dibuja en lugar de listarse porque el trabajo se ramifica, y un grafo hay que dibujarlo. La longitud de los trazos y la disposici&oacute;n del dibujo no significan nada: dos trazados con los mismos pasos en el mismo orden son la misma Constelaci&oacute;n aunque no se parezcan en la p&aacute;gina.</p>',
'<p>Leerla no basta para encenderla. Una Transformaci&oacute;n solo le sirve a quien ya ha producido ese estado al menos una vez, as&iacute; que lo que aporta la gu&iacute;a es el orden, las particiones y las convergencias, que es justo la parte que nadie recuerda. Una carta astral no es un arma embotellada sino un recordatorio, y no se puede armar a nadie con magia que no sepa hacer. Robar un Atlas da informaci&oacute;n y no poder, que es exactamente lo que necesita el espionaje y ni un gramo m&aacute;s.</p>',
'<p>Conviene separar tres cosas que suelen confundirse en una. El <b>Repertorio</b> es lo que uno ha conseguido producir alguna vez; no est&aacute; escrito en ninguna parte y no se puede robar. El <b>Atlas</b> es el libro de las Constelaciones que uno ha cartografiado, y es un objeto, de manera que se copia, se roba, se quema y se hereda. Y lo <b>memorizado</b> es la parte del Atlas que se ejecuta sin mirar. Un maestro sigue llevando libro encima, no porque guarde ah&iacute; su habilidad, sino porque guarda las recetas largas.</p>',

'<h2>Las cuatro cualidades</h2>',
'<p>Las cualidades que importan aqu&iacute; son humanas y no m&aacute;gicas: se heredan por especie y por linaje, y ninguna hace el trabajo de otra.</p>',
'<p>La <b>Voluntad</b> marca la velocidad de la Acreci&oacute;n y el rendimiento del &Eacute;ter cuando hay que imponerse a otro, pero no le a&ntilde;ade fuerza a ning&uacute;n efecto. El <b>Intelecto</b> es un requisito y no un modificador: dice qui&eacute;n puede escribir o encender una Constelaci&oacute;n, y quien no llega no puede, pero quien llega no obtiene por ello mejor resultado. Lo que sube el list&oacute;n no es partir, sino divergir: partir para soltar una copia sale barato, y partir para llevar dos recetas distintas, caro. La <b>Resiliencia</b> decide cu&aacute;nta resistencia se obtiene por cada unidad de Concentraci&oacute;n gastada en defenderse, y tambi&eacute;n cu&aacute;nto dura y cu&aacute;nto duele una Intoxicaci&oacute;n. El <b>Enfoque</b> decide cu&aacute;nto se sostiene una Estrella sin que se caiga.</p>',
'<p>Las manos y el Intelecto no se pisan, porque no hablan de lo mismo: las manos deciden qu&eacute; es posible y el Intelecto decide qui&eacute;n puede.</p>',

'<h2>Lo que cuesta</h2>',
'<p>El &Eacute;ter es gratis e inagotable. No hay man&aacute;, ni dep&oacute;sito, ni medidor. Lo que se paga no es el material sino el esfuerzo de moverlo, y se paga en las tres capas en que el cuerpo lleva siempre la cuenta: el aliento, el cansancio y la lesi&oacute;n. En la cabeza eso se llama <b>Concentraci&oacute;n</b>, que vuelve en segundos; <b>Fatiga Mental</b>, que necesita dormir; e <b>Intoxicaci&oacute;n et&eacute;rea</b>, que es una lesi&oacute;n y necesita tratamiento.</p>',
'<p>La Intoxicaci&oacute;n es &Eacute;ter que la red no consigui&oacute; dirigir y se qued&oacute; dentro amontonado. Aguda se pasa, y la Resiliencia decide con cu&aacute;nta dificultad y en cu&aacute;nto tiempo. Repetida o grave no se pasa: primero recorta lo que la persona puede canalizar, luego le detiene la Acreci&oacute;n, y al final se la quita para siempre. Y como el sistema et&eacute;reo comparte arquitectura con el nervioso, cuando se desborda lo hace hacia &eacute;l. Puede matar.</p>',
'<p>Trabajar con las dos manos no es venenoso por decreto: gasta el doble y cansa el doble, y por eso llega a la lesi&oacute;n en la mitad de tiempo. En el otro extremo est&aacute; el <b>Asterismo</b>, que es la magia cotidiana que hace todo el mundo. Sale del flujo pasivo, no cansa y no cuesta aliento. No es un don aparte: es el paso cero.</p>',
'<p>La <b>Oposici&oacute;n</b> tampoco es una habilidad. Es lo que hace el &Eacute;ter de uno cuando algo ajeno intenta entrar, y la tiene todo el mundo, porque todo cuerpo est&aacute; lleno de &Eacute;ter: un mozo de labranza se resiste mal, pero se resiste. El suelo es gratis, y empujar por encima de ese suelo gasta Concentraci&oacute;n, que es la misma Concentraci&oacute;n que est&aacute; sosteniendo las Estrellas propias. De ah&iacute; que el astr&oacute;nomo m&aacute;s vulnerable sea el que est&aacute; trabajando. A un mago se le golpea mientras construye, no antes.</p>',

'<h2>Nada dura solo</h2>',
'<p>Todo &Eacute;ter reunido se deshace, en la mano y en el suelo por igual, y la materia no es ninguna excepci&oacute;n. Lo que mengua entre los dedos y lo que se disuelve tirado en el suelo son el mismo fen&oacute;meno: el &Eacute;ter concentrado siempre vuelve a repartirse.</p>',
'<p>Lo que decide cu&aacute;nto tarda no es cu&aacute;nto &Eacute;ter lleva encima, sino cu&aacute;ntas veces por encima de su propio m&iacute;nimo est&aacute;. El m&iacute;nimo de un estado sirve para dos cosas a la vez: es lo que hace falta para alcanzarlo y lo que hace falta para seguir si&eacute;ndolo. Una piedra grande y una peque&ntilde;a, cada una al doble de lo que ella misma necesita, aguantan exactamente lo mismo. Y una masa sin cuajar dura m&aacute;s que una roca hecha del mismo &Eacute;ter, no porque siga otra regla, sino porque ser roca es m&aacute;s exigente que ser un bulto.</p>',
'<p>Se puede realimentar: tocar y verter. Alimentar cuesta exactamente lo que se est&aacute; perdiendo, ni m&aacute;s ni menos, y ocupa una mano igual que sostener, de modo que quien mantiene un muro tiene la mano puesta en el muro. As&iacute; que la permanencia deja de ser una propiedad de las cosas y pasa a ser un oficio. Nada dura solo; dura lo que alguien est&eacute; dispuesto a mantener.</p>',
'<p>De ah&iacute; que en este mundo no haya ruinas m&aacute;gicas, ni objetos encantados olvidados en un caj&oacute;n, ni trampas que sigan armadas cien a&ntilde;os despu&eacute;s. No se encuentra magia vieja: se encuentra el sitio donde hubo magia.</p>',
'<p><i>Eso es la ficci&oacute;n. Las fichas de conjuro de este sitio conservan las duraciones del juego, as&iacute; que una guarda escrita aqu&iacute; puede seguir durando una hora. Donde las dos cosas no coincidan, la ficha es lo que se juega y esto es lo que significa.</i></p>',

'<h2>Lo que hace la astronom&iacute;a sin haber cruzado nada</h2>',
'<p>Toda Constelaci&oacute;n empieza aqu&iacute;, porque la astronom&iacute;a no tiene nada que decidir de antemano. Un conjuro es astronom&iacute;a antes de ser cualquier otra cosa, y no deja de serlo despu&eacute;s.</p>',
'<p>Lo que hace es todo aquello que no compromete al &Eacute;ter a nada. Lo re&uacute;ne, lo afila, lo aprieta hasta que pesa, lo empuja y lo tira, lo lee, lo estorba y se lo quita a otro. No forja materia y no cierra heridas, porque la diferencia entre un astr&oacute;nomo y una estrella es de cantidad y esa cantidad es inalcanzable. Lo que tiene un astr&oacute;nomo en lugar de cantidad es <b>direcci&oacute;n</b>.</p>',
'<p>A cambio alcanza el &Eacute;ter est&eacute; donde est&eacute;, incluido el que corre dentro de otro cuerpo y el que otra mano est&aacute; sosteniendo. Esa es su &uacute;nica ventaja indiscutible, y es la raz&oacute;n de que sea lo que decide los duelos. Una Estrella entregada dentro de alguien le impone la misma Intoxicaci&oacute;n que un astr&oacute;nomo se hace a s&iacute; mismo forzando la Acreci&oacute;n, solo que puesta desde fuera. Se acumula, de modo que golpea m&aacute;s fuerte a quien m&aacute;s ha estado forzando, y no busca matar: busca quitarle a alguien la Acreci&oacute;n, que en este mundo es una forma de muerte civil.</p>',

'<h2>Los tres umbrales</h2>',
'<p>La astronom&iacute;a no tiene subdivisiones propias. Sus subdivisiones son las tres Disciplinas, y a cada una se llega forzando una Estrella m&aacute;s all&aacute; de un umbral. <b>El Crisol</b>, donde la masa se aprieta hasta cruzar a sustancia, abre la alquimia. <b>El Abismo</b>, donde se colapsa hasta pesar m&aacute;s de lo que deber&iacute;a, abre la cosmolog&iacute;a. Y el umbral que sostiene vida, que es la pieza de este arte que sigue sin bautizar, abre el espiritismo. Los tres imitan algo que hace una estrella, a una escala que nadie va a alcanzar.</p>',
'<p>El estado base es un paso que se ejecuta, no una etiqueta que se pone: sin &eacute;l ninguna Transformaci&oacute;n de esa Disciplina sirve de nada. Y se ve desde fuera, as&iacute; que se sabe qu&eacute; est&aacute; fabricando alguien desde el segundo paso.</p>',
'<p>Una Estrella que cruza un umbral no abandona la astronom&iacute;a: entra en una regi&oacute;n suya con reglas propias de estabilidad, y sigue respondiendo a todo lo que la astronom&iacute;a sabe hacer, porque nunca dej&oacute; de ser &Eacute;ter. Cruzar un segundo umbral, en una Convergencia, es la cima del arte, y se paga en las cuatro monedas a la vez: hay que partir pronto, llevar dos historias sin nada en com&uacute;n, soportar el doble de Intoxicaci&oacute;n y cuadrar una Convergencia al final.</p>',
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
'<p>This is also where the supplement files poison and disease that did not come out of anything living: a corrosion, a rot in a beam, a poison decanted from a jar. What a body makes for itself &mdash; venom, sap, spores &mdash; belongs to Nature instead.</p>'],
    es => ['<p>El &aacute;cido come el metal, la caliza y la carne, y no distingue entre lo que quien lo form&oacute; quer&iacute;a alcanzar y lo que hab&iacute;a al lado, de modo que su empleo bajo techo propio se considera imprudencia y no astucia. Corrosi&oacute;n es la &uacute;nica Estrella de la Disciplina cuyo efecto sigue trabajando despu&eacute;s de que el astr&oacute;nomo se haya marchado del sitio, y por eso es la que m&aacute;s veces aparece en un sabotaje y la que menos en un combate.</p>',
'<p>Aqu&iacute; es tambi&eacute;n donde el suplemento coloca el veneno y la enfermedad que no salieron de nada vivo: una corrosi&oacute;n, una podredumbre en una viga, un veneno sacado de un frasco. Lo que un cuerpo fabrica por su cuenta &mdash; ponzo&ntilde;a, savia, esporas &mdash; es de la Naturaleza.</p>'],
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
'<p>And venom, which is this Branch&rsquo;s own poison: made in a body, delivered by a body, and over quickly one way or the other. Asking a bonded animal for it is asking for something it spends and has to make again, so nobody asks twice in a day.</p>',
'<p>Here happens the one documented meeting between two Branches of the Discipline: a beast that has been Pacted with offers no Opposition to the workings of the Mind, because it has already accepted the arrangement. A druid and a mentalist working together get from an animal what neither would get alone.</p>'],
    es => ['<p>La Rama que no se impone. Un Pacto se gana antes, con trato &mdash; abrigo, comida, defensa, no fallar &mdash; y el trazado &uacute;nicamente reconoce lo que ya existe entre los dos. <b>Un druida tiene compa&ntilde;eros, no herramientas</b>, y esta Rama no concede nada sobre lo que no se ha pactado.</p>',
'<p>Del v&iacute;nculo sale lo dem&aacute;s: transmitirle lo que se quiere de &eacute;l sin palabras, tomarle prestada una facultad e instalarla en el cuerpo propio &mdash; el olfato del lobo, la vista del halc&oacute;n, el aliento del pez &mdash; y, al final, tomar su forma entera.</p>',
'<p>Y la ponzo&ntilde;a, que es el veneno propio de esta Rama: hecha en un cuerpo, entregada por un cuerpo, y resuelta pronto de una manera o de otra. Ped&iacute;rsela a un animal vinculado es pedirle algo que gasta y tiene que volver a fabricar, as&iacute; que nadie la pide dos veces en un d&iacute;a.</p>',
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
'<p>Its poison is in the sap, and it is a defence rather than a weapon: it is put there to be eaten and regretted, which is why almost nothing a plant makes works fast.</p>',
'<p>It is slower than any other Branch and it is the only one whose work is still standing years later. A wall of thorns is not a wall of conjured Ether, which comes undone the moment nobody feeds it &mdash; <b>it is a real thicket that was asked to hurry</b>, and it stays a thicket. That is the whole reason the Discipline holds plants and Alchemy does not.</p>'],
    es => ['<p>Gobernar el crecer de una planta: ra&iacute;ces que se desplazan, ramas que se cierran sobre un paso, una cosecha que adelanta semanas en una noche. El mismo Pacto que con una bestia, hecho con algo que no puede marcharse de &eacute;l.</p>',
'<p>Su veneno va en la savia, y es una defensa antes que un arma: est&aacute; puesto ah&iacute; para que se lo coman y lo lamenten, que es la raz&oacute;n de que casi nada de lo que hace una planta act&uacute;e deprisa.</p>',
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
'<p>What it makes is <b>poison</b>, and disease, and everything that works by getting inside and staying there. A spore is not thrown at anybody: it is let go where somebody is going to breathe, and then it takes its time. That patience is the whole character of the Branch, and it is why the trade has never liked it much.</p>',
'<p>The three Branches of Nature each have a poison and they are not interchangeable. An animal&rsquo;s is <b>venom</b>: made in a body, delivered by a body, and over quickly one way or the other. A plant&rsquo;s is in the sap, and it is a defence &mdash; it waits to be eaten. A fungus&rsquo;s is neither. It is the by-product of something feeding, and it does not care at all who was in the way.</p>',
'<p>What belongs to Acid instead is everything that bites without being alive: a corrosion, a rot in a beam, a poison decanted from a jar. The line is drawn by where it came from, not by what it does when it arrives.</p>'],

    es => ['<p>Una Rama propia, y no un rinc&oacute;n de Plantas, porque lo que hace un hongo no es lo que hace una planta. No crece hacia la luz: crece a trav&eacute;s de lo que ya est&aacute; muerto, y es el &uacute;nico ser vivo cuyo oficio es la descomposici&oacute;n.</p>',
'<p>Lo cual lo coloca justo donde se tocan dos Ramas de esta Disciplina: es de la Naturaleza, y todo su negocio es el Principio de la Muerte. Si un Pacto con una extensi&oacute;n de hongo es siquiera la misma clase de Pacto &mdash; no hay un cuerpo con el que hacerlo, ni un sitio evidente donde uno acabe y empiece el siguiente &mdash; no est&aacute; decidido.</p>',
'<p>Lo que hace es <b>veneno</b>, y enfermedad, y todo aquello que trabaja meti&eacute;ndose dentro y qued&aacute;ndose. Una espora no se le tira a nadie: se suelta donde alguien va a respirar, y despu&eacute;s se toma su tiempo. Esa paciencia es todo el car&aacute;cter de la Rama, y es la raz&oacute;n de que nunca le haya ca&iacute;do bien al oficio.</p>',
'<p>Las tres Ramas de la Naturaleza tienen cada una su veneno y no son intercambiables. El de un animal es <b>ponzo&ntilde;a</b>: hecha en un cuerpo, entregada por un cuerpo, y resuelta pronto de una manera o de otra. El de una planta va en la savia y es una defensa &mdash; espera a que se la coman. El de un hongo no es ninguna de las dos cosas. Es el desecho de algo que est&aacute; comiendo, y le da exactamente igual qui&eacute;n estuviera en medio.</p>',
'<p>Lo que en cambio es del &Aacute;cido es todo lo que muerde sin estar vivo: una corrosi&oacute;n, una podredumbre en una viga, un veneno sacado de un frasco. La raya la marca de d&oacute;nde sali&oacute;, no lo que hace al llegar.</p>'],

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
  key => 'rules', kind => 'doc', parent => undef,
  name => { en => 'Writing a spell', es => 'Cómo se escribe un conjuro' },
  lead => { en => 'What may exist, where it goes, and what the numbers have to be',
            es => 'Qu&eacute; puede existir, d&oacute;nde va, y qu&eacute; n&uacute;meros le tocan' },
  info => [
    [ 'What it is', 'Qu&eacute; es', 'Working rules for the catalogue', 'Reglas de trabajo del cat&aacute;logo' ],
    [ 'Drawn from', 'Sacadas de', 'The 347 entries already written', 'Las 347 fichas ya escritas' ],
    [ 'Binding on', 'Obligan a', 'Every new or adapted spell', 'Todo conjuro nuevo o adaptado' ],
    [ 'Wording', 'Redacci&oacute;n', 'Player&rsquo;s Handbook 2024', 'Manual del Jugador 2024' ],
  ],
  body => {
    en => [
'<p>This page is the filter every entry in the catalogue has to pass. The first half asks whether a spell can exist at all in this world, which is a question about the magic system and has nothing to do with balance. The second half asks what its numbers should be, and that part is not invented: it is measured off the 347 entries already written.</p>',
'<p>It is written for three jobs: adapting a spell from an older edition, importing one from somewhere else, and writing one from scratch. The order matters. A spell that fails the filter does not get numbers &mdash; it gets a line in the uncatalogued list saying why.</p>',

'<h2>1. The filter</h2>',
'<p>Ten questions, and a single no is enough. Each one comes straight out of the doctrine; the reference in brackets is the section of the Astronomy page it comes from.</p>',
'<ol class="ruleset">',
'<li><b>Is it something done to the Ether?</b> Every spell is Gathering, Transforming, Splitting, Joining or Handing over, and nothing else. If the effect cannot be told as one of those five, it is not a spell &mdash; it is a wish with a casting time. <i>(The five operations)</i></li>',
'<li><b>Does it make something out of nothing?</b> Only the Crucible turns Ether into substance, and only Alchemy holds the Crucible. Nothing conjures a creature, an ally or a servant: what is not there cannot be called, because there is nowhere to call it from. <i>(The three thresholds)</i></li>',
'<li><b>Does it need somewhere that is not here?</b> There are no other planes, no pocket spaces and no elsewhere to store or step through. Space can be crossed; it cannot be manufactured. <i>(Cosmology &rsaquo; Space)</i></li>',
'<li><b>Does it undo a death?</b> A soul scatters into the Ether when the body stops. There is nothing left to call back, and no amount of Ether reassembles it. <i>(The Ether)</i></li>',
'<li><b>Does it read what has not happened?</b> Nothing has written the future down. A probable outcome of what is already in motion is arithmetic and is allowed; asking a god what is coming is not. <i>(Cosmology &rsaquo; Time)</i></li>',
'<li><b>Does it last on its own?</b> Nothing does. A long duration means somebody is holding it with a hand on it, or it is a concession the game makes and the fiction does not. Permanent effects, enchanted objects and traps left armed for years do not exist. <i>(Nothing lasts by itself)</i></li>',
'<li><b>Is the illusion made in the air or in a mind?</b> In a mind, always. So an illusion reaches whoever it was aimed at and nobody else, and a second onlooker has to be reached separately or sees nothing at all. <i>(Spiritism &rsaquo; Mind)</i></li>',
'<li><b>Does it act on the world or on the Ether?</b> Astronomy on its own acts on Ether wherever Ether is, including the Ether inside a body and the Ether another hand is holding. It forges no matter and closes no wound. If an effect works on the world without crossing a threshold, it is in the wrong Discipline. <i>(What Astronomy does)</i></li>',
'<li><b>Does it rely on a gesture, a sigil or an object being magical?</b> Transformations are done with the mind. The word helps and never commands; the paper conducts nothing. Components stay in the entry because the game uses them, but nothing in the fiction hangs off them. <i>(The Constellation)</i></li>',
'<li><b>Could you say what it costs?</b> Every spell is paid in Concentration, Mental Fatigue or Intoxication, and the entry should be recognisable as one of those three. An effect that costs nothing and risks nothing is Asterism, not a spell. <i>(What it costs)</i></li>',
'</ol>',
'<p>Two of these are softer than they look. Rules 3 and 4 are absolute and always have been. Rule 6 is the one the catalogue openly breaks: the entries keep the game&rsquo;s durations, so a ward on the page still lasts an hour. Where the two disagree, the entry is what you play.</p>',

'<h2>2. Where it goes</h2>',
'<p>A spell that passes the filter has to be placed, and placing it is the part that goes wrong most often. The decision is made in this order, and the first rule settles most of the arguments on its own.</p>',
'<p><b>What is laid on top of something that already exists is Astronomy. It is only Alchemy if the matter becomes something else.</b> A blade wrapped in Ether is Astronomy, because the blade is still a blade. A blade turned to glass is Alchemy. This one rule is what moved magic weapon, magic armour and the whole family of coatings out of Alchemy, and it is worth applying before anything else.</p>',
'<ol class="ruleset">',
'<li><b>Does it cross a threshold at all?</b> If the Ether is still Ether when the spell ends &mdash; light, force, wards, anything that detects, hinders or undoes magic &mdash; it is Astronomy and it stops there. This is the largest single bucket in the catalogue and the default answer.</li>',
'<li><b>Does matter become other matter?</b> Alchemy, and then the element it becomes. Fifteen elements, and the compounds are reached by joining two: mud is earth and water, steam is water and fire.</li>',
'<li><b>Does it work on when, on where, or on weight?</b> Cosmology, and then Time, Space or Gravity. Seeing at a distance is Space, because a remote sensor is two points set side by side.</li>',
'<li><b>Does it work on something alive?</b> Spiritism, and then which part of it. On what somebody perceives, feels, remembers, decides or is made to do: Mind, and then one of its five Branches. On something alive without speech: Nature, and then animal, plant or fungus. On the pulse itself: Life or Death.</li>',
'<li><b>Does it cross a second threshold?</b> Only in a Convergence, only at the summit of the art, and it must be written in <code>cruces.txt</code> rather than by changing the Discipline. There is exactly one in the catalogue.</li>',
'</ol>',
'<p>When two answers seem right, prefer the shallower one. A spell that could be Astronomy or a Discipline is Astronomy; a spell that could be a subdivision or its parent goes to the parent. The tree is there to describe the catalogue, not to make it tidy.</p>',

'<h2>3. The numbers</h2>',
'<p>These are not conventions somebody decided. They are what the catalogue already does, measured across all 340 imported entries, and a new spell that sits far outside them needs a reason.</p>',
'<p><b>Damage.</b> The figure is the average of the largest damage die in the entry, at its base level, before any upcasting. The median is the spell you should be writing; the ceiling is what the outliers reach, and every one of them buys that ceiling with a cost &mdash; a saving throw that ends it, a single target, a component that is consumed.</p>',
'<table class="ruletable"><thead><tr><th>Level</th><th>Median</th><th>Ceiling</th><th>The one at the ceiling</th></tr></thead><tbody>'
. '<tr><td>Cantrip</td><td>4.5</td><td>6.5</td><td>Poison Spray</td></tr>'
. '<tr><td>1</td><td>9</td><td>14</td><td>Guiding Bolt</td></tr>'
. '<tr><td>2</td><td>7</td><td>13.5</td><td>Mind Spike</td></tr>'
. '<tr><td>3</td><td>16.5</td><td>28</td><td>Fireball</td></tr>'
. '<tr><td>4</td><td>14</td><td>36</td><td>Blight</td></tr>'
. '<tr><td>5</td><td>22.5</td><td>49.5</td><td>Contagion</td></tr>'
. '<tr><td>6</td><td>33</td><td>49</td><td>Harm</td></tr>'
. '<tr><td>7</td><td>39</td><td>55</td><td>Symbol</td></tr>'
. '<tr><td>8</td><td>42</td><td>65</td><td>Befuddlement</td></tr>'
. '<tr><td>9</td><td>27.5</td><td>78</td><td>Power Word Kill</td></tr>'
. '</tbody></table>',
'<p>Two things to read off it. The curve is not smooth &mdash; level 2 dips below level 1 and level 9 has a low median, because at both of those levels the catalogue is buying something other than damage. And the ceiling is roughly double the median everywhere, which is the room an exceptional spell has.</p>',
'<p><b>The saving throw.</b> Pick it from what the spell actually does to a body, and the catalogue is consistent about this: Dexterity for anything you could get out of the way of, Constitution for anything that has to be endured, Wisdom for anything aimed at a mind. Strength appears where something is moved bodily. Intelligence and Charisma are rare and should stay rare: across the whole catalogue there are three Intelligence saves and seventeen Charisma ones.</p>',
'<p><b>Areas.</b> The 20-foot-radius Sphere is the standard for a level 3 area and appears more than any other shape at any level. Cones run 15 feet at low level and 60 at high. Emanations are 10 to 30 feet and belong to spells centred on the caster. A new area that is not one of those sizes should have a reason.</p>',
'<p><b>Range.</b> Four ranges cover three quarters of the catalogue: Self (72 entries), Touch (67), 60 feet (65) and 30 feet (47). 120 feet is the long reach; anything past 150 feet is a handful of entries and is almost always a spell that does not deal damage.</p>',
'<p><b>Duration and Concentration.</b> Roughly half of everything from level 2 upwards takes Concentration, and that is the price of anything that goes on happening. Below that, level 1 sits at a third and cantrips at a tenth. A spell that lasts and does not take Concentration is claiming something, and the entry should show what it paid.</p>',
'<p><b>Upcasting.</b> 111 of the 340 entries scale. The overwhelming convention is <i>increases by 1d6</i> or <i>1d8 for each spell slot level above N</i>, with the die matching the one the spell already rolls. Anything that scales by more than one die per level, or that adds a second effect on upcasting, is exceptional.</p>',

'<h2>4. The shape of the entry</h2>',
'<p>The wording rules live in <code>doc/redaccion.md</code> and follow the 2024 <i>Player&rsquo;s Handbook</i> exactly. The three that get broken most often:</p>',
'<ol class="ruleset">',
'<li><b>English capitalises game terms; Spanish does not.</b> <i>Force damage</i> and <i>Dexterity saving throw</i>, but <i>da&ntilde;o de fuerza</i> and <i>tirada de salvaci&oacute;n de Destreza</i>. This is the manual&rsquo;s own convention in each language, not a choice.</li>',
'<li><b>The damage type attribute is never translated.</b> <code>data-type</code> is the key the icon service is asked with, and it stays in English in both trees.</li>',
'<li><b>Saving throws and uses have fixed formulas.</b> Do not improvise them; copy the shape from an entry that already has one.</li>',
'</ol>',

'<h2>5. The checklist</h2>',
'<p>Before an entry is considered finished:</p>',
'<ol class="ruleset">',
'<li>It passes all ten questions of the filter, or it is in <code>descatalogados.txt</code> with a reason written in both languages.</li>',
'<li>It has a Discipline in <code>disciplinas.txt</code> and, if it goes deeper, a subdivision in <code>subdisciplinas.txt</code>.</li>',
'<li>Its damage sits between the median and the ceiling for its level, or the entry says what it gave up.</li>',
'<li>Its saving throw matches what it does to a body.</li>',
'<li>It scales the way the catalogue scales, or it does not scale at all.</li>',
'<li>It exists in both languages, at the same path, with the display name set in <code>nombres-en.txt</code> and <code>nombres-es.txt</code>.</li>',
'<li>It was generated, not hand-edited. Nothing in this section is written by hand except the seven original spells.</li>',
'</ol>',
    ],
    es => [
'<p>Esta p&aacute;gina es el filtro por el que tiene que pasar toda ficha del cat&aacute;logo. La primera mitad pregunta si un conjuro puede existir siquiera en este mundo, que es una pregunta sobre el sistema de magia y no tiene nada que ver con el equilibrio. La segunda mitad pregunta qu&eacute; n&uacute;meros le tocan, y esa parte no se inventa: est&aacute; medida sobre las 347 fichas ya escritas.</p>',
'<p>Est&aacute; pensada para tres trabajos: adaptar un conjuro de una edici&oacute;n vieja, importar uno de otro sitio y escribir uno de cero. El orden importa. Un conjuro que no pasa el filtro no llega a tener n&uacute;meros &mdash; llega a tener una l&iacute;nea en los descatalogados diciendo por qu&eacute;.</p>',

'<h2>1. El filtro</h2>',
'<p>Diez preguntas, y con un solo no basta. Cada una sale directamente de la doctrina; la referencia entre par&eacute;ntesis es la secci&oacute;n de la p&aacute;gina de Astronom&iacute;a de la que viene.</p>',
'<ol class="ruleset">',
'<li><b>&iquest;Es algo que se le hace al &Eacute;ter?</b> Todo conjuro es reunir, transformar, partir, juntar o entregar, y nada m&aacute;s. Si el efecto no se puede contar como una de esas cinco cosas, no es un conjuro: es un deseo con tiempo de lanzamiento. <i>(Las cinco operaciones)</i></li>',
'<li><b>&iquest;Fabrica algo de la nada?</b> Solo el Crisol convierte &Eacute;ter en sustancia, y solo la alquimia tiene el Crisol. Nada invoca a una criatura, a un aliado ni a un siervo: lo que no est&aacute; no se puede llamar, porque no hay sitio desde el que llamarlo. <i>(Los tres umbrales)</i></li>',
'<li><b>&iquest;Necesita un sitio que no sea este?</b> No hay otros planos, ni bolsillos, ni un m&aacute;s all&aacute; donde guardar cosas o por donde pasar. El espacio se cruza; no se fabrica. <i>(Cosmolog&iacute;a &rsaquo; Espacio)</i></li>',
'<li><b>&iquest;Deshace una muerte?</b> Un alma se reparte en el &Eacute;ter cuando el cuerpo se para. No queda nada que traer de vuelta, y ninguna cantidad de &Eacute;ter la vuelve a juntar. <i>(El &Eacute;ter)</i></li>',
'<li><b>&iquest;Lee lo que todav&iacute;a no ha ocurrido?</b> Nadie ha escrito el futuro. Un desenlace probable de lo que ya est&aacute; en marcha es una cuenta y se admite; preguntarle a un dios qu&eacute; viene, no. <i>(Cosmolog&iacute;a &rsaquo; Tiempo)</i></li>',
'<li><b>&iquest;Dura solo?</b> Nada dura solo. Una duraci&oacute;n larga significa que hay alguien sosteni&eacute;ndolo con la mano puesta, o es una concesi&oacute;n que hace el juego y no la ficci&oacute;n. No existen los efectos permanentes, ni los objetos encantados, ni las trampas que siguen armadas al cabo de los a&ntilde;os. <i>(Nada dura solo)</i></li>',
'<li><b>&iquest;La ilusi&oacute;n se hace en el aire o en una mente?</b> En una mente, siempre. As&iacute; que una ilusi&oacute;n alcanza a quien iba dirigida y a nadie m&aacute;s, y al que mira al lado hay que alcanzarlo aparte o no ve nada. <i>(Espiritismo &rsaquo; Mente)</i></li>',
'<li><b>&iquest;Act&uacute;a sobre el mundo o sobre el &Eacute;ter?</b> La astronom&iacute;a sola act&uacute;a sobre el &Eacute;ter est&eacute; donde est&eacute;, incluido el que corre dentro de un cuerpo y el que otra mano sostiene. No forja materia y no cierra heridas. Si un efecto trabaja sobre el mundo sin cruzar un umbral, est&aacute; en la Disciplina equivocada. <i>(Lo que hace la astronom&iacute;a)</i></li>',
'<li><b>&iquest;Depende de un gesto, de un sello o de que un objeto sea m&aacute;gico?</b> Las Transformaciones se hacen con la mente. La palabra ayuda y nunca manda; el papel no conduce nada. Los componentes se quedan en la ficha porque el juego los usa, pero de ellos no cuelga nada de la ficci&oacute;n. <i>(La Constelaci&oacute;n)</i></li>',
'<li><b>&iquest;Sabr&iacute;as decir qu&eacute; cuesta?</b> Todo conjuro se paga en Concentraci&oacute;n, Fatiga Mental o Intoxicaci&oacute;n, y la ficha deber&iacute;a dejar reconocer cu&aacute;l de las tres. Un efecto que no cuesta nada y no arriesga nada es Asterismo, no un conjuro. <i>(Lo que cuesta)</i></li>',
'</ol>',
'<p>Dos de estas son m&aacute;s blandas de lo que parecen. La 3 y la 4 son absolutas y lo han sido siempre. La 6 es la que el cat&aacute;logo incumple a la vista de todos: las fichas conservan las duraciones del juego, as&iacute; que una guarda escrita aqu&iacute; sigue durando una hora. Donde las dos cosas no coincidan, la ficha es lo que se juega.</p>',

'<h2>2. D&oacute;nde cae</h2>',
'<p>Un conjuro que pasa el filtro hay que colocarlo, y colocarlo es la parte que m&aacute;s veces sale mal. La decisi&oacute;n se toma en este orden, y la primera regla resuelve sola casi todas las discusiones.</p>',
'<p><b>Lo que se pone encima de algo que ya existe es astronom&iacute;a. Solo es alquimia si la materia pasa a ser otra cosa.</b> Un filo envuelto en &Eacute;ter es astronom&iacute;a, porque el filo sigue siendo un filo. Un filo convertido en vidrio es alquimia. Esta regla sola es la que sac&oacute; de la alquimia a <i>arma m&aacute;gica</i>, a <i>armadura m&aacute;gica</i> y a toda la familia de los recubrimientos, y conviene aplicarla antes que ninguna otra.</p>',
'<ol class="ruleset">',
'<li><b>&iquest;Cruza alg&uacute;n umbral?</b> Si el &Eacute;ter sigue siendo &Eacute;ter cuando el conjuro termina &mdash; luz, fuerza, guardas, y todo lo que detecta, estorba o deshace magia &mdash;, es astronom&iacute;a y ah&iacute; se queda. Es el grupo m&aacute;s grande del cat&aacute;logo y la respuesta por defecto.</li>',
'<li><b>&iquest;La materia pasa a ser otra materia?</b> Alquimia, y despu&eacute;s el elemento en el que se convierte. Quince elementos, y los compuestos se alcanzan juntando dos: el fango es tierra y agua, el vapor es agua y fuego.</li>',
'<li><b>&iquest;Trabaja sobre el cu&aacute;ndo, sobre el d&oacute;nde o sobre el peso?</b> Cosmolog&iacute;a, y despu&eacute;s Tiempo, Espacio o Gravedad. Ver a distancia es Espacio, porque un sensor remoto son dos puntos puestos uno junto a otro.</li>',
'<li><b>&iquest;Trabaja sobre algo vivo?</b> Espiritismo, y despu&eacute;s sobre qu&eacute; parte. Sobre lo que alguien percibe, siente, recuerda, decide o se ve obligado a hacer: Mente, y una de sus cinco Ramas. Sobre algo vivo sin palabra: Naturaleza, y animal, planta u hongo. Sobre el pulso mismo: Vida o Muerte.</li>',
'<li><b>&iquest;Cruza un segundo umbral?</b> Solo en una Convergencia, solo en la cima del arte, y se escribe en <code>cruces.txt</code> en vez de cambi&aacute;ndole la Disciplina. En el cat&aacute;logo hay exactamente uno.</li>',
'</ol>',
'<p>Cuando dos respuestas parecen buenas, gana la menos profunda. Un conjuro que podr&iacute;a ser astronom&iacute;a o una Disciplina es astronom&iacute;a; uno que podr&iacute;a ser una subdivisi&oacute;n o su madre va a la madre. El &aacute;rbol est&aacute; para describir el cat&aacute;logo, no para dejarlo ordenado.</p>',

'<h2>3. Los n&uacute;meros</h2>',
'<p>Esto no son convenios que decidiera nadie. Es lo que el cat&aacute;logo ya hace, medido sobre las 340 fichas importadas, y un conjuro nuevo que se salga mucho necesita una raz&oacute;n.</p>',
'<p><b>Da&ntilde;o.</b> La cifra es la media del dado de da&ntilde;o mayor de la ficha, a su nivel base y antes de subirlo de espacio. La mediana es el conjuro que deber&iacute;as estar escribiendo; el techo es lo que alcanzan los casos raros, y todos ellos compran ese techo con algo &mdash; una salvaci&oacute;n que lo corta, un solo objetivo, un componente que se consume.</p>',
'<table class="ruletable"><thead><tr><th>Nivel</th><th>Mediana</th><th>Techo</th><th>El que est&aacute; en el techo</th></tr></thead><tbody>'
. '<tr><td>Truco</td><td>4,5</td><td>6,5</td><td>Rociada venenosa</td></tr>'
. '<tr><td>1</td><td>9</td><td>14</td><td>Proyectil gu&iacute;a</td></tr>'
. '<tr><td>2</td><td>7</td><td>13,5</td><td>Pica mental</td></tr>'
. '<tr><td>3</td><td>16,5</td><td>28</td><td>Bola de fuego</td></tr>'
. '<tr><td>4</td><td>14</td><td>36</td><td>Marchitar</td></tr>'
. '<tr><td>5</td><td>22,5</td><td>49,5</td><td>Contagio</td></tr>'
. '<tr><td>6</td><td>33</td><td>49</td><td>Da&ntilde;ar</td></tr>'
. '<tr><td>7</td><td>39</td><td>55</td><td>S&iacute;mbolo</td></tr>'
. '<tr><td>8</td><td>42</td><td>65</td><td>Aturdimiento</td></tr>'
. '<tr><td>9</td><td>27,5</td><td>78</td><td>Palabra de poder: matar</td></tr>'
. '</tbody></table>',
'<p>Hay dos cosas que leer ah&iacute;. La curva no es lisa &mdash; el nivel 2 baja por debajo del 1 y el nivel 9 tiene una mediana peque&ntilde;a, porque en esos dos niveles el cat&aacute;logo est&aacute; comprando otra cosa que no es da&ntilde;o. Y el techo est&aacute; en torno al doble de la mediana en todas partes, que es el margen que tiene un conjuro excepcional.</p>',
'<p><b>La salvaci&oacute;n.</b> Se elige por lo que el conjuro le hace a un cuerpo, y en esto el cat&aacute;logo es coherente: Destreza para todo aquello de lo que uno podr&iacute;a apartarse, Constituci&oacute;n para lo que hay que aguantar, Sabidur&iacute;a para lo que va dirigido a una mente. Fuerza aparece donde algo mueve un cuerpo a la fuerza. Inteligencia y Carisma son raras y deben seguir si&eacute;ndolo: en todo el cat&aacute;logo hay tres salvaciones de Inteligencia y diecisiete de Carisma.</p>',
'<p><b>&Aacute;reas.</b> La esfera de 20 pies de radio es el patr&oacute;n del &aacute;rea de nivel 3 y aparece m&aacute;s veces que ninguna otra forma en ning&uacute;n nivel. Los conos van de 15 pies abajo a 60 arriba. Las emanaciones van de 10 a 30 pies y son de los conjuros centrados en quien canaliza. Un &aacute;rea nueva que no tenga una de esas medidas deber&iacute;a tener un motivo.</p>',
'<p><b>Alcance.</b> Cuatro alcances cubren tres cuartas partes del cat&aacute;logo: personal (72 fichas), toque (67), 60 pies (65) y 30 pies (47). 120 pies es el alcance largo; de 150 para arriba hay un pu&ntilde;ado de fichas y casi ninguna hace da&ntilde;o.</p>',
'<p><b>Duraci&oacute;n y Concentraci&oacute;n.</b> Alrededor de la mitad de todo lo que hay de nivel 2 para arriba pide Concentraci&oacute;n, y ese es el precio de cualquier cosa que siga ocurriendo. Por debajo, el nivel 1 se queda en un tercio y los trucos en un d&eacute;cimo. Un conjuro que dura y no pide Concentraci&oacute;n est&aacute; reclamando algo, y la ficha deber&iacute;a ense&ntilde;ar con qu&eacute; lo pag&oacute;.</p>',
'<p><b>Subirlo de espacio.</b> 111 de las 340 fichas escalan. El convenio abrumador es <i>aumenta en 1d6</i> o <i>en 1d8 por cada nivel por encima de N</i>, con el dado que el conjuro ya tira. Todo lo que escale m&aacute;s de un dado por nivel, o que a&ntilde;ada un efecto nuevo al subirlo, es excepcional.</p>',

'<h2>4. La forma de la ficha</h2>',
'<p>Las reglas de redacci&oacute;n viven en <code>doc/redaccion.md</code> y siguen al pie de la letra el <i>Manual del Jugador</i> de 2024. Las tres que m&aacute;s se incumplen:</p>',
'<ol class="ruleset">',
'<li><b>El ingl&eacute;s capitaliza los t&eacute;rminos de juego; el espa&ntilde;ol no.</b> <i>Force damage</i> y <i>Dexterity saving throw</i>, pero <i>da&ntilde;o de fuerza</i> y <i>tirada de salvaci&oacute;n de Destreza</i>. Es el convenio del propio manual en cada idioma, no una elecci&oacute;n.</li>',
'<li><b>El atributo del tipo de da&ntilde;o no se traduce nunca.</b> <code>data-type</code> es la clave con la que se le piden los iconos al servicio, y va en ingl&eacute;s en los dos &aacute;rboles.</li>',
'<li><b>Las salvaciones y los usos tienen f&oacute;rmulas fijas.</b> No se improvisan: se copia la forma de una ficha que ya la tenga.</li>',
'</ol>',

'<h2>5. La lista de comprobaci&oacute;n</h2>',
'<p>Antes de dar una ficha por terminada:</p>',
'<ol class="ruleset">',
'<li>Pasa las diez preguntas del filtro, o est&aacute; en <code>descatalogados.txt</code> con su motivo escrito en los dos idiomas.</li>',
'<li>Tiene Disciplina en <code>disciplinas.txt</code> y, si baja m&aacute;s, subdivisi&oacute;n en <code>subdisciplinas.txt</code>.</li>',
'<li>Su da&ntilde;o cae entre la mediana y el techo de su nivel, o la ficha dice a qu&eacute; renunci&oacute;.</li>',
'<li>Su salvaci&oacute;n se corresponde con lo que le hace a un cuerpo.</li>',
'<li>Escala como escala el cat&aacute;logo, o no escala en absoluto.</li>',
'<li>Existe en los dos idiomas, en la misma ruta, con el nombre visible puesto en <code>nombres-en.txt</code> y <code>nombres-es.txt</code>.</li>',
'<li>Se ha generado, no editado a mano. Aqu&iacute; no hay nada escrito a mano salvo los siete conjuros propios.</li>',
'</ol>',
    ],
  },
  stars => [],
},
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
