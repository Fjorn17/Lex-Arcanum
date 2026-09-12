#!/usr/bin/perl
# Genera las paginas de Disciplina dentro de en/pages/astronomy/ y su espejo
# espanol: una por Disciplina y una por cada subdisciplina, con su doctrina, su
# catalogo de Estrellas y los conjuros que le corresponden.
#
# La portada de la seccion (index.html) es la pagina de la astronomia: el
# diagrama, la doctrina plegada y sus conjuros. El buscador va aparte, en
# spells.html, y lo escribe build-pages.pl.
#
#   perl build-disciplines.pl          # escribe
#   perl build-disciplines.pl --dry    # solo cuenta
#
# Entradas (todas en este directorio):
#   taxonomia.pl        el arbol y su contenido
#   disciplinas.txt     conjuro <TAB> Disciplina
#   subdisciplinas.txt  conjuro <TAB> subdisciplina
#   lex-conjuros.txt    los conjuros propios del suplemento
#   nombres-es.txt      glosario de nombres
#   iconos-bg3.txt      iconos
#   descatalogados.txt  los que no cuelgan de ninguna Disciplina: si tienen pagina
#
# Astronomia no tiene subdisciplinas propias: sus subdivisiones SON las otras
# tres Disciplinas (Reglas 6.1-6.2). Sus conjuros se listan en su propia pagina.
use strict;
use warnings;
use utf8;
use File::Basename qw(dirname);
use File::Path qw(make_path);

BEGIN { chdir dirname($0) or die $! }
require './lib.pl';
require './paginas.pl';
load_names();

binmode(STDERR, ':encoding(UTF-8)');
my $DRY  = grep { $_ eq '--dry' } @ARGV;
my $ROOT = '../..';
my $UP   = '../../../';

# Las Estrellas de cada Disciplina siguen escritas en taxonomia.pl, pero no se
# publican todavia. Ponlo a 1 para volver a sacarlas.
my $SHOW_STARS = 0;

# ------------------------------------------------------------------- entradas

my $TAX = do './taxonomia.pl';
die "taxonomia.pl: $@ $!\n" unless ref $TAX eq 'ARRAY';
my %NODE = map { $_->{key} => $_ } @$TAX;

my %DISC = read_map('disciplinas.txt');
my %SUB  = read_map('subdisciplinas.txt');
my %NAME_ES = read_map('nombres-es.txt');
my %ICON = -e 'iconos-bg3.txt' ? read_map('iconos-bg3.txt') : ();

# Los descatalogados si tienen pagina y si salen en su propia seccion; lo que
# no tienen es Disciplina, asi que no aparecen en ninguna otra.
my (%UNC, @UNC_ORDER);
{
    open(my $fh, '<:encoding(UTF-8)', 'descatalogados.txt') or die $!;
    while (<$fh>) {
        s/\r?\n$//; next if /^#/ || !/\S/;
        my ($n, $bucket, $en, $es) = split /\t/;
        $UNC{$n} = { bucket => $bucket, why => { en => $en, es => $es } };
        push @UNC_ORDER, $n;
    }
    close $fh;
}
my @BUCKETS = qw(none summon poison chromatic resurrection);

# Los conjuros, con lo poco que hace falta para una fila de tabla.
my @SPELLS;
{
    my ($n, $in, %s, @order);
    open(my $fh, '<:encoding(UTF-8)', 'srd-en.txt') or die $!;
    while (<$fh>) {
        s/\r?\n$//;
        if (/^== (.+)$/) { $n = $1; $in = 0; push @order, $n; $s{$n} = {} }
        elsif (/^body:$/) { $in = 1 }
        elsif (!$in && /^(level|casting|range|duration): (.*)$/) { $s{$n}{$1} = $2 }
    }
    close $fh;
    for my $name (@order) {
        push @SPELLS, {
            key  => $name,
            name => { en => disp_name($name, 'en'), es => disp_name($name, 'es') },
            slug => spell_slug($name), level => $s{$name}{level},
            icon => $ICON{$name} // '',
            disc => $DISC{$name} // '', sub => $SUB{$name} // '',
            unc  => $UNC{$name} ? $UNC{$name}{bucket} : '',
        };
    }
    # los siete propios del suplemento van mezclados: aqui no se distinguen
    open($fh, '<:encoding(UTF-8)', 'lex-conjuros.txt') or die $!;
    while (<$fh>) {
        s/\r?\n$//; next if /^#/ || !/\S/;
        my @f = split /\t/;
        push @SPELLS, {
            key => $f[3],
            name => { en => $f[3], es => $f[4] }, slug => $f[0], level => $f[1],
            icon => $f[11] // '', disc => $f[2], sub => $SUB{$f[3]} // '', unc => '',
        };
    }
    close $fh;
}

# ---------------------------------------------------------------- vocabulario

my %T = (
    en => {
        title => 'Disciplines', name_col => 'Name', level => 'Level',
        cantrip => 'Cantrip', cantrips => 'Cantrips', lvl => 'Level',
        subdivisions => 'Subdivisions', stars => 'Stars', spells => 'Spells',
        why => 'Why it is uncatalogued',
        b_none => 'No Discipline', b_summon => 'Summoning, conjuring and animating',
        b_poison => 'Poison', b_chromatic => 'The chromatics',
        b_resurrection => 'Undoing death',
        substance => 'Substance', property => 'Property', branch => 'Branch',
        mixture => 'Mixture', none_here => 'No spell of the supplement is filed here yet.',
        count_one => 'spell', count_many => 'spells',
        idx_lead => 'The four Disciplines of the art, and how the catalogue divides inside them',
        back => 'Back to the Disciplines',
        all_spells => 'Search every spell &rarr;',
        toc_label => 'The doctrine', open_all => 'Open all', close_all => 'Collapse',
    },
    es => {
        title => 'Disciplinas', name_col => 'Nombre', level => 'Nivel',
        cantrip => 'Truco', cantrips => 'Trucos', lvl => 'Nivel',
        subdivisions => 'Subdivisiones', stars => 'Estrellas', spells => 'Conjuros',
        why => 'Por qu&eacute; est&aacute; descatalogado',
        b_none => 'Sin Disciplina', b_summon => 'Invocar, conjurar y animar',
        b_poison => 'El veneno', b_chromatic => 'Los crom&aacute;ticos',
        b_resurrection => 'Deshacer la muerte',
        substance => 'Sustancia', property => 'Propiedad', branch => 'Rama',
        mixture => 'Mezcla', none_here => 'Todav&iacute;a no hay ning&uacute;n conjuro del suplemento aqu&iacute;.',
        count_one => 'conjuro', count_many => 'conjuros',
        idx_lead => 'Las cuatro Disciplinas del arte, y c&oacute;mo se divide el cat&aacute;logo dentro de cada una',
        back => 'Volver a las Disciplinas',
        all_spells => 'Buscar entre todos los conjuros &rarr;',
        toc_label => 'La doctrina', open_all => 'Abrir todo', close_all => 'Plegar',
    },
);

sub ent_es {
    my $s = shift // '';
    my %e = ('á'=>'&aacute;','é'=>'&eacute;','í'=>'&iacute;','ó'=>'&oacute;','ú'=>'&uacute;',
             'ñ'=>'&ntilde;','Á'=>'&Aacute;','É'=>'&Eacute;','Í'=>'&Iacute;','Ó'=>'&Oacute;',
             'Ú'=>'&Uacute;','Ñ'=>'&Ntilde;', "\x{2019}"=>'&rsquo;');
    $s =~ s/([\x{e1}\x{e9}\x{ed}\x{f3}\x{fa}\x{f1}\x{c1}\x{c9}\x{cd}\x{d3}\x{da}\x{d1}\x{2019}])/$e{$1}/g;
    return $s;
}
sub nm { my ($n, $lang) = @_; return ent_es($n->{name}{$lang}) }

# ------------------------------------------------------------------- consultas

sub children { my ($key) = @_; return grep { ($_->{parent} // '') eq $key } @$TAX }

# La astronomia es la portada de la seccion: la pestana del menu aterriza en
# ella, asi que su archivo es index.html y no astronomy.html.
sub node_file { my ($key) = @_; return $key eq 'astronomy' ? 'index.html' : "$key.html" }

# Los conjuros de un nodo. Una Disciplina lista los suyos que no bajan a
# ninguna subdivision; Astronomia lista todos los suyos, porque no tiene.
# El arbol tiene tres alturas: Disciplina > subdisciplina > Rama. Una Rama
# ('leaf') cuelga de una subdisciplina, y su Disciplina es la del abuelo.
sub disc_of_node {
    my ($key) = @_;
    my $n = $NODE{$key} or return '';
    $n = $NODE{ $n->{parent} } while $n->{parent} && $n->{kind} ne 'discipline';
    return $n->{kind} eq 'discipline' ? $n->{key} : '';
}
# La clave del nodo y las de todo lo que cuelga de el.
sub with_descendants {
    my ($key) = @_;
    my @out = ($key);
    push @out, with_descendants($_->{key}) for children($key);
    return @out;
}

sub spells_of {
    my ($node) = @_;
    my $k = $node->{key};
    return grep { $_->{unc} } @SPELLS if $node->{kind} eq 'limbo';
    my $leafy = $node->{kind} eq 'sub' || $node->{kind} eq 'leaf';
    my %want  = map { $_ => 1 } with_descendants($k);
    my $disc  = $leafy ? disc_of_node($k) : '';
    my @s = grep {
        $_->{unc} ? 0
        : $leafy
            ? (lc($_->{disc}) eq $disc && $want{ $_->{sub} })
            : (lc($_->{disc}) eq $k && ($_->{sub} eq '' || $_->{sub} eq '-'))
    } @SPELLS;
    # ordenado y en un array: devolver un sort suelto no cuenta en contexto
    # escalar, y eso ya ha mordido dos veces.
    my @sorted = sort { $a->{level} <=> $b->{level} || $a->{name}{en} cmp $b->{name}{en} } @s;
    return @sorted;
}

# Los descatalogados no van por nivel: van por el motivo de estarlo.
sub uncatalogued_sections {
    my ($lang) = @_;
    my $t = $T{$lang};
    my $out = '';
    for my $bk (@BUCKETS) {          # $b es la variable de sort: no tocarla
        my @s = sort { $a->{level} <=> $b->{level} || $a->{name}{en} cmp $b->{name}{en} }
                grep { $_->{unc} eq $bk } @SPELLS;
        next unless @s;
        my $rows = '';
        for my $s (@s) {
            my $ic = $s->{icon} ? qq{<img class="ic" width="24" src="$s->{icon}" alt="">} : '';
            my $lv = $s->{level} == 0 ? $t->{cantrip} : "$t->{lvl} $s->{level}";
            my $why = $UNC{ $s->{key} }{why}{$lang} // '';
            $rows .= qq{              <tr>\n}
                   . qq{                <td>$ic<a href="./$s->{slug}.html">} . nm($s, $lang) . qq{</a></td>\n}
                   . qq{                <td class="lvl">$lv</td>\n}
                   . qq{                <td class="why">$why</td>\n              </tr>\n};
        }
        $out .= qq{\n        <section>\n          <h2>$t->{"b_$bk"}</h2>\n}
              . qq{          <div class="tw">\n            <table class="spelltable unctable">\n}
              . qq{              <thead><tr><th scope="col">$t->{name_col}</th>}
              . qq{<th scope="col">$t->{level}</th><th scope="col">$t->{why}</th></tr></thead>\n}
              . qq{              <tbody>\n$rows              </tbody>\n}
              . qq{            </table>\n          </div>\n        </section>\n};
    }
    return $out;
}

# Todos los de la rama, subdivisiones incluidas: es lo que cuenta el indice.
sub spell_count {
    my ($node) = @_;
    my @own = spells_of($node);          # sort en contexto escalar no cuenta
    my $n = scalar @own;
    # spells_of ya es inclusivo para sub y leaf: recursar ahi contaria dos veces
    return $n if $node->{kind} eq q{sub} || $node->{kind} eq q{leaf};
    $n += spell_count($_) for children($node->{key});
    return $n;
}

# ------------------------------------------------------------------ diagramas

# El diagrama de contencion: un circulo que es la astronomia, tres gajos que son
# las Disciplinas, y en el centro la region que no cruza ningun umbral. La
# geometria es fija; los recuentos y los nombres salen de los datos.
sub containment_svg {
    my ($lang) = @_;
    my $t = $T{$lang};

    my $core  = scalar spells_of($NODE{astronomy});
    my $total = scalar grep { !$_->{unc} } @SPELLS;
    my $unc   = scalar grep { $_->{unc} } @SPELLS;

    # gajo => [ etiqueta del umbral, punteado, x/y del nombre, x/y del chip ]
    my @W = (
      { key => 'alchemy',   arc => 'M 310 190 A 130 130 0 0 1 422.6 385',
        wedge => 'M 310 50 A 270 270 0 0 1 543.8 455 L 422.6 385 A 130 130 0 0 0 310 190 Z',
        nx => 483, ny => 216, cx => 423, cy => 259.5, cw => 94,
        th => { en => 'The Crucible', es => 'El Crisol' }, dash => 0 },
      { key => 'cosmology', arc => 'M 197.4 385 A 130 130 0 0 1 310 190',
        wedge => 'M 76.2 455 A 270 270 0 0 1 310 50 L 310 190 A 130 130 0 0 0 197.4 385 Z',
        nx => 137, ny => 216, cx => 197, cy => 259.5, cw => 94,
        th => { en => 'The Abyss', es => 'El Abismo' }, dash => 0 },
      { key => 'spiritism', arc => 'M 422.6 385 A 130 130 0 0 1 197.4 385',
        wedge => 'M 543.8 455 A 270 270 0 0 1 76.2 455 L 197.4 385 A 130 130 0 0 0 422.6 385 Z',
        nx => 310, ny => 524, cx => 310, cy => 454.5, cw => 112,
        th => { en => 'Unnamed', es => 'Sin nombre' }, dash => 1 },
    );

    my $frame = $lang eq 'es'
        ? "EL MARCO ES LA ASTRONOM&Iacute;A &middot; $total CONJUROS"
        : "THE FRAME IS ASTRONOMY &middot; $total SPELLS";
    my $of = $lang eq 'es' ? "de $total conjuros" : "of $total spells";
    my $only = $lang eq 'es' ? 'SOLO ASTRONOM&Iacute;A' : 'ASTRONOMY ALONE';
    my @gloss = $lang eq 'es'
        ? ('luz &middot; fuerza cin&eacute;tica &middot; guardas', 'y todo lo que detecta, estorba', 'o deshace magia')
        : ('light &middot; kinetic force &middot; wards', 'and everything that finds, hinders', 'or undoes magic');

    my $alt = $lang eq 'es'
        ? 'La astronom&iacute;a contiene las tres Disciplinas; en el centro, la regi&oacute;n que no cruza ning&uacute;n umbral'
        : 'Astronomy contains the three Disciplines; at the centre, the region that crosses no threshold';

    my $s = qq{<svg class="diagram" viewBox="0 0 620 620" role="img" aria-label="$alt">\n};
    $s .= qq{          <circle cx="310" cy="320" r="270" class="d-frame"/>\n};
    for my $w (@W) {
        $s .= qq{          <a href="./$w->{key}.html"><path d="$w->{wedge}" class="d-wedge"/></a>\n};
    }
    $s .= qq{          <path d="M 310 190 L 310 50" class="d-spoke"/>\n}
        . qq{          <path d="M 422.6 385 L 543.8 455" class="d-spoke"/>\n}
        . qq{          <path d="M 197.4 385 L 76.2 455" class="d-spoke"/>\n}
        . qq{          <text x="14" y="30" class="d-frame-label">$frame</text>\n}
        . qq{          <circle cx="310" cy="320" r="130" class="d-core-fill"/>\n};
    for my $w (@W) {
        my $c = $w->{dash} ? ' d-core-dash' : '';
        $s .= qq{          <path d="$w->{arc}" class="d-core$c"/>\n};
    }
    $s .= qq{          <a href="#conjuros">\n}
        . qq{            <text x="310" y="238" class="d-core-kicker">$only</text>\n}
        . qq{            <text x="310" y="298" class="d-core-n">$core</text>\n}
        . qq{            <text x="310" y="320" class="d-core-of">$of</text>\n};
    my $y = 350;
    for my $g (@gloss) { $s .= qq{            <text x="310" y="$y" class="d-core-gloss">$g</text>\n}; $y += 18 }
    $s .= qq{          </a>\n};
    for my $w (@W) {
        my $n  = spell_count($NODE{ $w->{key} });
        my $nm = ent_es(ucfirst $NODE{ $w->{key} }{name}{$lang});
        my $lead = $lang eq 'es'
            ? ($w->{key} eq 'alchemy' ? 'la materia' : $w->{key} eq 'cosmology' ? 'espacio y tiempo' : 'la vida')
            : ($w->{key} eq 'alchemy' ? 'matter' : $w->{key} eq 'cosmology' ? 'space and time' : 'life');
        my $word = $lang eq 'es' ? ($n == 1 ? 'conjuro' : 'conjuros') : ($n == 1 ? 'spell' : 'spells');
        my $x = $w->{cx} - $w->{cw} / 2;
        my $dash = $w->{dash} ? ' d-chip-dash' : '';
        my $ty = $w->{cy} - 5;
        $s .= qq{          <rect x="$x" y="$ty" width="$w->{cw}" height="21" class="d-chip$dash"/>\n}
            . qq{          <text x="$w->{cx}" y="$w->{cy}" class="d-chip-label">@{[ ent_es(uc $w->{th}{$lang}) ]}</text>\n}
            . qq{          <a href="./$w->{key}.html">\n}
            . qq{            <text x="$w->{nx}" y="$w->{ny}" class="d-disc">$nm</text>\n}
            . qq{            <text x="$w->{nx}" y="@{[ $w->{ny} + 20 ]}" class="d-disc-sub">$n $word &middot; $lead</text>\n}
            . qq{          </a>\n};
    }
    $s .= qq{        </svg>\n};

    # La leyenda repite el diagrama en texto: es lo que se lee en movil y lo
    # que hace navegable lo que el dibujo solo insinua.
    my $L = sub {
        my (%a) = @_;
        my $k = $a{kicker} ? qq{<span class="dl-kicker">$a{kicker}</span>} : '';
        return qq{          <a class="dl-row$a{cls}" href="$a{href}">$k}
             . qq{<span class="dl-head"><b>$a{name}</b><b class="dl-n">$a{n}</b></span>}
             . qq{<span class="dl-note">$a{note}</span></a>\n};
    };
    my $leg = qq{<div class="disc-legend">\n};
    $leg .= $L->(cls => ' dl-core', href => '#conjuros', n => $core,
        name => $lang eq 'es' ? 'Solo astronom&iacute;a' : 'Astronomy alone',
        note => $lang eq 'es'
            ? 'El fondo del arte: lo que se hace con el &Eacute;ter sin dirigirlo a nada. No cruza ning&uacute;n umbral.'
            : 'The floor of the art: what is done to the Ether without aiming it anywhere. It crosses no threshold.');
    for my $w (@W) {
        my $n = spell_count($NODE{ $w->{key} });
        my $kick = $w->{dash}
            ? ($lang eq 'es' ? 'Umbral todav&iacute;a sin nombre' : 'A threshold still unnamed')
            : ($lang eq 'es' ? "Umbral &middot; $w->{th}{es}" : "Threshold &middot; $w->{th}{en}");
        my %note = (
          alchemy   => { es => 'La masa se aprieta hasta cruzar a sustancia.',
                         en => 'The mass is pressed until it crosses over into substance.' },
          cosmology => { es => 'Se colapsa hasta pesar m&aacute;s de lo que debe.',
                         en => 'It collapses until it weighs more than it should.' },
          spiritism => { es => 'El umbral que sostiene vida, y la pieza de este arte que sigue sin bautizar.',
                         en => 'The threshold that holds life, and the one piece of this art still unnamed.' },
        );
        $leg .= $L->(cls => $w->{dash} ? ' dl-dash' : '', href => "./$w->{key}.html", n => $n,
            kicker => ent_es($kick), name => ent_es(ucfirst $NODE{ $w->{key} }{name}{$lang}),
            note => $note{ $w->{key} }{$lang});
    }
    $leg .= $L->(cls => ' dl-outside', href => './uncatalogued.html', n => $unc,
        kicker => $lang eq 'es' ? 'Fuera del diagrama' : 'Outside the diagram',
        name => ent_es($NODE{uncatalogued}{name}{$lang}),
        note => $lang eq 'es'
            ? 'Sin Disciplina asignada. No son una regi&oacute;n del arte: son trabajo pendiente.'
            : 'No Discipline assigned. Not a region of the art: work still to do.');
    $leg .= qq{        </div>\n};

    return qq{<div class="diagram-wrap">\n        $s        $leg      </div>\n};
}

# El pentagono de la alquimia: cinco vertices y diez cruces, que es la marca de
# la Disciplina dibujada como catalogo. Cinco lados y cinco diagonales, y cada
# secundario se coloca en el punto medio del segmento del que nace.
my @PENTA = (
  [ 'earth',     330,   100   ],
  [ 'water',     548.7, 258.9 ],
  [ 'fire',      465.2, 516.1 ],
  [ 'lightning', 194.8, 516.1 ],
  [ 'air',       111.3, 258.9 ],
);
my %CROSSING = (
  mud           => [ 'earth', 'water'     ],
  water_fire    => [ 'water', 'fire'      ],
  incandescence => [ 'fire',  'lightning' ],
  thunder       => [ 'air',   'lightning' ],
  sand          => [ 'earth', 'air'       ],
  lava          => [ 'earth', 'fire'      ],
  metal         => [ 'earth', 'lightning' ],
  acid          => [ 'water', 'lightning' ],
  mist          => [ 'water', 'air'       ],
  ash           => [ 'air',   'fire'      ],
);
$CROSSING{steam} = delete $CROSSING{water_fire};

sub elements_svg {
    my ($lang, $here) = @_;
    my %P = map { $_->[0] => [ $_->[1], $_->[2] ] } @PENTA;
    my $count = sub { my $k = shift; my @s = spells_of($NODE{$k}); return scalar @s };

    my $alt = $lang eq 'es'
        ? 'Los cinco elementos primarios y los diez cruces que nacen de sus encuentros'
        : 'The five primary elements and the ten crossings born of their meetings';
    my $s = qq{<svg class="diagram" viewBox="0 0 660 660" role="img" aria-label="$alt">\n};

    # el pentagono y sus diagonales
    my @v = map { $P{ $_->[0] } } @PENTA;
    $s .= qq{          <path d="M } . join(' L ', map { "$_->[0] $_->[1]" } @v) . qq{ Z" class="p-edge"/>\n};
    my @diag;
    for my $i (0 .. 4) {
        for my $j ($i + 1 .. 4) {
            next if $j == $i + 1 || ($i == 0 && $j == 4);
            push @diag, "M $v[$i][0] $v[$i][1] L $v[$j][0] $v[$j][1]";
        }
    }
    $s .= qq{          <path d="@{[ join ' ', @diag ]}" class="p-diag"/>\n};

    # los cinco primarios
    for my $p (@PENTA) {
        my ($k, $x, $y) = @$p;
        my $n = $count->($k);
        my $cur = $here && $here eq $k ? ' p-here' : '';
        my $z = $n ? '' : ' p-empty';
        $s .= qq{          <a href="./$k.html"><circle cx="$x" cy="$y" r="46" class="p-node$cur$z"/>}
            . qq{<text x="$x" y="@{[ $y - 3 ]}" class="p-name">@{[ ent_es(ucfirst $NODE{$k}{name}{$lang}) ]}</text>}
            . qq{<text x="$x" y="@{[ $y + 15 ]}" class="p-n">$n</text></a>\n};
    }

    # Los diez cruces van en el punto medio de su segmento. Los cinco de los
    # lados tienen sitio y llevan caja de dos lineas; los cinco de las
    # diagonales caen amontonados junto al centro, asi que van compactos.
    my %EDGE = map { $_ => 1 } qw(mud sand steam thunder incandescence);
    for my $k (sort keys %CROSSING) {
        my ($a, $b) = @{ $CROSSING{$k} };
        my $x = ($P{$a}[0] + $P{$b}[0]) / 2;
        my $y = ($P{$a}[1] + $P{$b}[1]) / 2;
        # el de abajo se aparta de la arista para no pisar los dos vertices
        $y += 52 if $k eq 'incandescence';
        my $n   = $count->($k);
        my $nm  = ent_es(ucfirst $NODE{$k}{name}{$lang});
        my $cur = $here && $here eq $k ? ' p-here' : '';
        my $z   = $n ? '' : ' p-empty';

        if ($EDGE{$k}) {
            my $from = ent_es(ucfirst $NODE{$a}{name}{$lang}) . ' + ' . ent_es(lc $NODE{$b}{name}{$lang});
            my $w = length($NODE{$k}{name}{$lang}) > 9 ? 128 : 118;
            $s .= qq{          <a href="./$k.html">}
                . qq{<rect x="@{[ $x - $w/2 ]}" y="@{[ $y - 18 ]}" width="$w" height="36" class="p-box$cur$z"/>}
                . qq{<text x="$x" y="@{[ $y - 2 ]}" class="p-box-name">$nm</text>}
                . qq{<text x="$x" y="@{[ $y + 12 ]}" class="p-box-from">$from &middot; $n</text></a>\n};
        } else {
            # se apartan del centro para no solaparse entre ellos
            my $dx = $x - 330; my $dy = $y - 320;
            my $d  = sqrt($dx * $dx + $dy * $dy) || 1;
            $x = 330 + $dx / $d * ($d + 26);
            $y = 320 + $dy / $d * ($d + 26);
            my $w = 15 + 7.1 * length($NODE{$k}{name}{$lang}) + 8 * length($n);
            $s .= qq{          <a href="./$k.html">}
                . qq{<rect x="@{[ sprintf '%.1f', $x - $w/2 ]}" y="@{[ sprintf '%.1f', $y - 11 ]}" }
                . qq{width="@{[ sprintf '%.1f', $w ]}" height="22" class="p-box$cur$z"/>}
                . qq{<text x="@{[ sprintf '%.1f', $x ]}" y="@{[ sprintf '%.1f', $y + 4 ]}" }
                . qq{class="p-box-mini">$nm &middot; $n</text></a>\n};
        }
    }
    $s .= qq{        </svg>\n};
    my $key = $lang eq 'es'
        ? '<span class="p-key"><i class="p-key-solid"></i> con conjuros</span><span class="p-key"><i class="p-key-empty"></i> todav&iacute;a vac&iacute;o</span>'
        : '<span class="p-key"><i class="p-key-solid"></i> has spells</span><span class="p-key"><i class="p-key-empty"></i> still empty</span>';
    return qq{<div class="diagram-wrap solo">\n        $s        <p class="p-legend">$key</p>\n      </div>\n};
}

# Un cuerpo largo se parte por sus <h2> en secciones plegables, y de los mismos
# titulos sale el indice lateral. Sin JavaScript sigue sirviendo: son <details>
# abiertos de serie.
sub slugify_es {
    my ($s) = @_;
    $s =~ s/&\w+;//g;
    $s = lc $s;
    my %a = ("\x{e1}"=>'a', "\x{e9}"=>'e', "\x{ed}"=>'i', "\x{f3}"=>'o', "\x{fa}"=>'u', "\x{f1}"=>'n');
    $s =~ s/([\x{e1}\x{e9}\x{ed}\x{f3}\x{fa}\x{f1}])/$a{$1}/g;
    $s =~ s/[^a-z0-9]+/-/g;
    $s =~ s/^-|-$//g;
    return $s;
}

sub doctrine {
    my ($node, $lang) = @_;
    my @paras = @{ $node->{body}{$lang} };
    my (@lead, @secs);
    for my $p (@paras) {
        if ($p =~ m{^<h2>(.*?)</h2>$}) {
            push @secs, { title => $1, id => 's-' . slugify_es($1), body => [] };
        } elsif (@secs) { push @{ $secs[-1]{body} }, $p }
        else { push @lead, $p }
    }
    return unless @secs;

    my $t = $T{$lang};
    my $toc = qq{<nav class="doctrine-toc" aria-label="$t->{toc_label}">\n}
            . qq{          <h2>$t->{toc_label}</h2>\n          <ol>\n};
    my $i = 0;
    for my $s (@secs) {
        $i++;
        $toc .= qq{            <li><a href="#$s->{id}">$s->{title}</a></li>\n};
    }
    $toc .= qq{          </ol>\n}
          . qq{          <p class="toc-all"><a href="#" data-all="open">$t->{open_all}</a>}
          . qq{ <a href="#" data-all="close">$t->{close_all}</a></p>\n}
          . qq{        </nav>\n};

    my $out = join("\n          ", @lead) . "\n";
    $i = 0;
    for my $s (@secs) {
        $i++;
        my $n = sprintf '%02d', $i;
        # cerradas de serie: la pagina es primero el diagrama, y la doctrina
        # se abre cuando alguien la quiere
        $out .= qq{          <details class="sec" id="$s->{id}">\n}
              . qq{            <summary><h2>$s->{title}</h2><span class="sec-n">$n</span></summary>\n}
              . qq{            <div class="sec-body">\n              }
              . join("\n              ", @{ $s->{body} })
              . qq{\n            </div>\n          </details>\n};
    }
    return ($toc, $out);
}

# --------------------------------------------------------------------- trozos

sub crumb {
    my ($node, $lang) = @_;
    my @up;
    my $p = $node->{parent};
    while ($p) { unshift @up, $NODE{$p}; $p = $NODE{$p}{parent} }
    return '' unless @up;
    return join(' &rsaquo; ',
        (map { my $f = node_file($_->{key});
               qq{<a href="./$f">} . nm($_, $lang) . '</a>' } @up),
        nm($node, $lang));
}

# Una tabla por nivel de conjuro, no una sola tabla larga: dentro de una
# Disciplina lo que se busca es "que tengo de nivel 3", no el orden alfabetico.
sub spell_table {
    my ($list, $lang) = @_;
    my $t = $T{$lang};
    return qq{<p class="sf-empty">$t->{none_here}</p>\n} unless @$list;

    my %by;
    push @{ $by{ $_->{level} } }, $_ for @$list;

    my $out = qq{<div class="bylevel">\n};
    for my $lv (sort { $a <=> $b } keys %by) {
        my @s = sort { $a->{name}{en} cmp $b->{name}{en} } @{ $by{$lv} };
        my $head = $lv == 0 ? $t->{cantrips} : "$t->{lvl} $lv";
        my $n = scalar @s;
        my $rows = '';
        for my $s (@s) {
            my $ic = $s->{icon} ? qq{<img class="ic" width="24" src="$s->{icon}" alt="">} : '';
            $rows .= qq{              <tr><td>$ic<a href="./$s->{slug}.html">}
                   . nm($s, $lang) . qq{</a></td></tr>\n};
        }
        $out .= qq{          <section class="lvlgroup">\n}
              . qq{            <h3>$head <span class="lvlcount">$n</span></h3>\n}
              . qq{            <table class="spelltable lvltable">\n}
              . qq{              <tbody>\n$rows              </tbody>\n}
              . qq{            </table>\n          </section>\n};
    }
    return $out . qq{        </div>\n};
}

sub stars_list {
    my ($node, $lang) = @_;
    return '' unless @{ $node->{stars} };
    my $t = $T{$lang};
    my $out = qq{<ul class="sendlist">\n};
    for my $s (@{ $node->{stars} }) {
        my $name = ent_es($lang eq 'es' ? $s->{es} : $s->{en});
        my @tags;
        push @tags, $s->{kind} eq 'substance' ? $t->{substance} : $t->{property}
            if $s->{kind};
        if (my $f = $s->{from} || $s->{branch}) {
            my ($en, $es) = split m{ / }, $f, 2;
            push @tags, ent_es($lang eq 'es' ? ($es // $en) : $en);
        }
        my $tag = @tags ? ' <i>(' . join(', ', @tags) . ')</i>' : '';
        $out .= qq{            <li><b>$name</b>$tag &mdash; $s->{note}{$lang}</li>\n};
    }
    return $out . qq{          </ul>\n};
}

sub kids_list {
    my ($node, $lang) = @_;
    my @k = children($node->{key});
    return '' unless @k;
    my $t = $T{$lang};
    my $out = qq{<ul class="sendlist">\n};
    for my $c (@k) {
        my $n = spell_count($c);
        my $word = $n == 1 ? $t->{count_one} : $t->{count_many};
        my $f = node_file($c->{key});
        $out .= qq{            <li><b><a href="./$f">} . nm($c, $lang)
              . qq{</a></b> &mdash; $c->{lead}{$lang}. <i>$n $word</i></li>\n};
    }
    return $out . qq{          </ul>\n};
}

# ------------------------------------------------------------------ la pagina

sub render_node {
    my ($node, $lang) = @_;
    my $t = $T{$lang};
    my $file = node_file($node->{key});
    my $path = "pages/astronomy/$file";

    # La astronomia lleva su doctrina plegada, con indice al lado; las demas
    # paginas son cortas y van de corrido.
    my ($toc, $body);
    ($toc, $body) = doctrine($node, $lang) if $node->{key} eq 'astronomy';
    $body //= join "\n          ", @{ $node->{body}{$lang} };
    $toc  //= '';

    # el diagrama que le toque a esta pagina
    my $diagram = '';
    $diagram = containment_svg($lang)         if $node->{key} eq 'astronomy';
    $diagram = elements_svg($lang)            if $node->{key} eq 'alchemy';
    $diagram = elements_svg($lang, $node->{key})
        if $node->{kind} eq 'sub' && $node->{parent} eq 'alchemy';

    my $rows = join "\n          ",
        map { qq{<div class="ibrow"><span class="ibk">} . ($lang eq 'es' ? $_->[1] : $_->[0])
            . qq{</span><span class="ibv">} . ($lang eq 'es' ? $_->[3] : $_->[2]) . qq{</span></div>} }
        @{ $node->{info} };

    my @mine  = spells_of($node);
    my $kids  = kids_list($node, $lang);
    my $crumb = crumb($node, $lang);
    # Las Estrellas quedan aparcadas: el dato sigue en taxonomia.pl, pero no se
    # publica hasta que se decida como encajan con el catalogo de conjuros.
    my $stars = $SHOW_STARS ? stars_list($node, $lang) : '';

    my $desc = plain("$node->{lead}{$lang}. " . ($node->{body}{$lang}[0] // ''));
    $desc = substr($desc, 0, 200);

    my $out = page_head(lang => $lang, path => $path, up => $UP,
                        title => nm($node, $lang), desc => $desc);
    $out .= qq{\n<body>\n  <div class="spellpage">\n\n};
    $out .= page_nav(lang => $lang, path => $path, up => $UP, section => 'astronomy');
    $out .= <<"HTML";

    <header class="spellhead">
      <h1>@{[ nm($node, $lang) ]}</h1>
      <p class="spellkind">$node->{lead}{$lang}</p>
    </header>
$diagram
    <div class="spellbody@{[ $toc ? ' withtoc' : '' ]}">
      $toc
      <main>
        <section>
          $body
        </section>
HTML
    $out .= <<"HTML" if $kids;

        <section>
          <h2>$t->{subdivisions}</h2>
          $kids
        </section>
HTML
    $out .= <<"HTML" if $stars;

        <section>
          <h2>$t->{stars}</h2>
          $stars
        </section>
HTML
    if ($node->{kind} eq 'limbo') {
        $out .= uncatalogued_sections($lang);
    } else {
        $out .= <<"HTML";

        <section>
          <h2>$t->{spells}</h2>
          @{[ spell_table(\@mine, $lang) ]}
          <p class="pagelink"><a href="./spells.html">$t->{all_spells}</a></p>
        </section>
HTML
    }
    $out .= <<"HTML";
      </main>

      <aside class="infobox">
        <div class="ibhead">
          <h2>@{[ nm($node, $lang) ]}</h2>
        </div>
        <div class="ibrows">
          $rows
        </div>
HTML
    $out .= qq{        <p class="ibfoot">$crumb</p>\n} if $crumb;
    $out .= <<"HTML";
      </aside>
    </div>

HTML
    $out .= page_foot(up => $UP,
                      scripts => $node->{key} eq 'astronomy' ? ['astronomy.js'] : []);
    return ($file, $out);
}


# --------------------------------------------------------------------- escribe

my $n = 0;
for my $lang (qw(en es)) {
    my $dir = "$ROOT/$lang/pages/astronomy";
    make_path($dir) unless -d $dir;
    for my $node (@$TAX) {
        my ($file, $html) = render_node($node, $lang);
        $n++;
        next if $DRY;
        open(my $fh, '>:encoding(UTF-8)', "$dir/$file") or die "$dir/$file: $!";
        print $fh $html; close $fh;
    }
}
printf STDERR "%d paginas de Disciplina en los dos idiomas\n", $n;
