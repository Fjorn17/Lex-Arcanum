#!/usr/bin/perl
# Genera las paginas de conjuro de en/pages/astronomy/ y es/pages/astronomy/, y
# spells.html, que es el buscador: la barra de filtros y la tabla entera. La
# portada de la seccion (index.html, con el diagrama) y las paginas de
# Disciplina las escribe build-disciplines.pl, en esa misma carpeta.
#
#   perl build-pages.pl            # escribe las paginas de conjuro y spells.html
#   perl build-pages.pl --dry      # solo dice que escribiria
#
# Entradas (todas en este directorio):
#   srd-en.txt       conjuros del SRD, texto original (lo saca extract-srd.pl)
#   srd-es.txt       los mismos conjuros traducidos; puede estar incompleto
#   disciplinas.txt  nombre SRD <TAB> Disciplina; obligatorio para todos
#   descatalogados.txt  los que no cuelgan de ninguna Disciplina: si tienen pagina
#   lex-conjuros.txt los conjuros propios, para el indice
#   nombres-es.txt   glosario nombre SRD <TAB> nombre del Manual del Jugador
#   iconos-bg3.txt   nombre SRD <TAB> URL del icono en bg3.wiki (los que hay)
#   magister.txt     conjuros de la lista del Magistrado, uno por linea
#   tablas/<slug>.<lang>.html   fragmentos a mano de los conjuros con tabla
#
# CUIDADO al limpiar pages/astronomy/: los siete conjuros propios del suplemento
# son HTML a mano y NO se regeneran. Estan listados en @A_MANO; borrarlos sin
# querer cuesta recuperarlos de git y volver a adaptarlos.
#
# Aqui ya no se distingue entre conjuros del SRD y conjuros propios: todos son
# de Lex Arcanum, y lo que los clasifica es la Disciplina, no la escuela ni la
# clase que los lleve. La atribucion del SRD, que la licencia CC BY exige, esta
# en el pie legal de todas las paginas.
#
# El molde de pagina es el de doc/redaccion.md (7 bis). El orden de las secciones
# y de las claves de la ficha no es opcional.
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
my $DRY = grep { $_ eq '--dry' } @ARGV;
my $ROOT = '../..';

# ---------------------------------------------------------------- vocabulario

# Las cuatro Disciplinas sustituyen a las ocho escuelas de D&D. Astronomia no
# es una Disciplina mas: es el Eter trabajado como Eter, el fondo del arte. Se
# lista con las otras tres porque una ficha necesita una sola casilla.
my %DISC_ES = (
    Astronomy => 'astronomía', Alchemy   => 'alquimia',
    Cosmology => 'cosmología', Spiritism => 'espiritismo',
    Uncatalogued => 'descatalogados',
);
my @DISC_ORDER = qw(Astronomy Alchemy Cosmology Spiritism Uncatalogued);
my %ABILITY_ES = (
    Strength => 'Fuerza', Dexterity => 'Destreza', Constitution => 'Constitución',
    Intelligence => 'Inteligencia', Wisdom => 'Sabiduría', Charisma => 'Carisma',
);
my @DMG = qw(Acid Bludgeoning Cold Fire Force Lightning Necrotic Piercing Poison
             Psychic Radiant Slashing Thunder);
my $DMG_RE = join '|', @DMG;

my %T = (
    en => {
        spells => 'Spells', spell => 'Spell', level => 'Level', cantrip => 'Cantrip',
        discipline => 'Discipline', casting => 'Casting time', range => 'Range',
        duration => 'Duration', components => 'Components',
        save => 'Saving throw', damage => 'Damage', attack => 'Attack',
        none => 'None', name_col => 'Name',
        desc => 'Description', higher => 'At higher levels',
        notes => 'Notes', icon_ph => 'icon',
        action => 'Action', bonus => 'Bonus Action', reaction => 'Reaction',
        ritual => 'Ritual', conc => 'Concentration',
        or_ritual => 'or Ritual', self => 'Self', touch => 'Touch',
        sight => 'Sight', special => 'Special', unlimited => 'Unlimited',
        instantaneous => 'Instantaneous',
        ranged_attack => 'Ranged spell attack', melee_attack => 'Melee spell attack',
        half => 'half damage on a success',
        subtitle => 'Every spell of Lex Arcanum, by Discipline and level.',
    },
    es => {
        spells => 'Conjuros', spell => 'Conjuro', level => 'Nivel', cantrip => 'Truco',
        discipline => 'Disciplina', casting => 'Tiempo de lanzamiento', range => 'Alcance',
        duration => 'Duración', components => 'Componentes',
        save => 'Tirada de salvación', damage => 'Daño', attack => 'Ataque',
        none => 'Ninguna', name_col => 'Nombre',
        desc => 'Descripción', higher => 'A niveles superiores',
        notes => 'Notas', icon_ph => 'icono',
        action => 'Acción', bonus => 'Acción adicional', reaction => 'Reacción',
        ritual => 'Ritual', conc => 'Concentración',
        or_ritual => 'o ritual', self => 'Personal', touch => 'Toque',
        sight => 'Vista', special => 'Especial', unlimited => 'Ilimitado',
        instantaneous => 'Instantáneo',
        ranged_attack => 'Ataque de conjuro a distancia', melee_attack => 'Ataque de conjuro cuerpo a cuerpo',
        half => 'mitad de daño si la supera',
        subtitle => 'Todos los conjuros de Lex Arcanum, por Disciplina y nivel.',
    },
);

# Iconos de bg3.wiki que se usan una y otra vez.
my %IC = (
    action   => 'https://bg3.wiki/w/images/f/f2/Action_Icon.png',
    bonus    => 'https://bg3.wiki/w/images/c/c9/Bonus_Action_Icon.png',
    reaction => 'https://bg3.wiki/w/images/c/c1/Reaction_Icon.png',
    ritual   => 'https://bg3.wiki/w/images/f/fa/Ritual_Spell_Icon.png',
    conc     => 'https://bg3.wiki/w/images/8/83/Concentration_Icon.png',
);
sub icon { my ($k, $w) = @_; $w //= 18;
    return qq{<img class="ic" width="$w" src="$IC{$k}" alt="">} }

# ------------------------------------------------------------------- entradas

# La traduccion se escribe por tandas en es/NN.txt y se junta aqui.
my %DISC = read_map('disciplinas.txt');
my %SUBOF = read_map('subdisciplinas.txt');

# El arbol de Disciplinas, para poder enlazar la ficha con su pagina.
my $TAX = do './taxonomia.pl';
die "taxonomia.pl: $@ $!\n" unless ref $TAX eq 'ARRAY';
my %TAXNAME = map { $_->{key} => $_->{name} } @$TAX;
my %NODE = map { $_->{key} => $_ } @$TAX;
my %KIDS;                           # clave => hijos, en el orden del arbol
push @{ $KIDS{ $_->{parent} } }, $_->{key} for grep { $_->{parent} } @$TAX;

# La clave de un nodo y las de todo lo que cuelga de el. Un conjuro marcado
# en una Rama cuenta tambien para su subdisciplina.
sub descend { my ($k) = @_; return ($k, map { descend($_) } @{ $KIDS{$k} || [] }) }

# La Disciplina de la que cuelga una subdivision, subiendo lo que haga falta.
sub disc_of_sub {
    my ($k) = @_;
    my $n = $NODE{$k} or return '';
    $n = $NODE{ $n->{parent} } while $n && $n->{parent} && $n->{kind} ne 'discipline';
    return ($n && $n->{kind} eq 'discipline') ? $n->{key} : '';
}

my @SUBS_OF;                        # subdivisiones por Disciplina, con su altura
{
    my %seen;
    for my $dk (qw(alchemy cosmology spiritism)) {
        my @rows;
        for my $k (@{ $KIDS{$dk} || [] }) {
            push @rows, [ $k, 0 ];
            push @rows, [ $_, 1 ] for @{ $KIDS{$k} || [] };
        }
        push @SUBS_OF, [ $dk, \@rows ] if @rows;
    }
    push @SUBS_OF, [ 'uncatalogued',
                     [ map { [ $_, 0 ] } qw(none summon poison chromatic resurrection) ] ];
}
# Los descatalogados tienen pagina y salen en el indice: lo que no tienen es
# Disciplina. Cada uno lleva escrito por que esta fuera.
my %UNC;
{
    open(my $fh, '<:encoding(UTF-8)', 'descatalogados.txt') or die $!;
    while (<$fh>) { s/\r?\n$//; next if /^#/ || !/\S/;
                    my ($n, $bucket, $en, $es) = split /\t/;
                    $UNC{$n} = { bucket => $bucket, why => { en => $en, es => $es } } }
    close $fh;
}
my @BUCKETS = qw(none summon poison chromatic resurrection);

# Los siete conjuros propios son HTML a mano y no salen de aqui. Se listan para
# que --limpiar no se los lleve por delante.
my @A_MANO = qw(arcane-thrust gravitational-pull bound-weapon chains-of-custody
                magic-armor ravaging-cleave magic-contract);

# Un conjuro puede cruzar un segundo umbral (Reglas 6.4): la cima del arte.
my %CROSS = -e 'cruces.txt' ? read_map('cruces.txt') : ();

my @EN = read_spells('srd-en.txt');
for my $s (@EN) {
    if (my $u = $UNC{ $s->{name} }) { $s->{unc} = $u; next }
    $s->{discipline} = $DISC{ $s->{name} }
        or die "sin Disciplina en disciplinas.txt: $s->{name}\n";
}
my @ES = map { read_spells($_) } sort glob('es/*.txt');
my %ES  = map { $_->{key} // $_->{name} => $_ } @ES;
my %NAME_ES = read_map('nombres-es.txt');
my %FIX = (
    en => { read_fixes('arreglos-en.txt') },
    es => { read_fixes('arreglos-es.txt') },
);
my %ICON    = -e 'iconos-bg3.txt' ? read_map('iconos-bg3.txt') : ();
my %MAGISTER;
if (-e 'magister.txt') {
    open(my $fh, '<:encoding(UTF-8)', 'magister.txt') or die $!;
    while (<$fh>) { s/\r?\n$//; $MAGISTER{$_} = 1 if /\S/ }
    close $fh;
}

# ------------------------------------------------------------- transformacion

# Un parrafo del SRD empieza a veces por un subtitulo en linea: "Cantrip
# Upgrade. El resto...". Son palabras con mayuscula inicial salvo las de enlace.
my %SMALL = map { $_ => 1 } qw(of the a an and or to in from on with only per
                               de del la el los las y o en con por para sin un una solo);
sub runin_head {
    my ($text) = @_;
    return unless $text =~ /^(.{2,60}?)\.\s+(\S.*)$/s;
    my ($head, $rest) = ($1, $2);
    return if $head =~ /[.:;]/;
    my @w = split /\s+/, $head;
    return if @w > 6;
    for my $w (@w) {
        next if $SMALL{lc $w};
        return unless $w =~ /^[\x{201c}"(]?[A-Z0-9\x{c1}\x{c9}\x{cd}\x{d3}\x{da}\x{d1}]/;
    }
    return ($head, $rest);
}

sub distances {
    my ($t, $lang) = @_;
    $t =~ s/(\d+)-foot-radius/dist_paren($1,$lang).' radius'/ge if $lang eq 'en';
    $t =~ s/(\d+)-foot-radius/dist_paren($1,$lang).' de radio'/ge if $lang eq 'es';
    $t =~ s/(\d+)-foot/dist_paren($1,$lang)/ge;
    $t =~ s/(\d+) feet\b/dist_paren($1,$lang)/ge;
    $t =~ s/(\d+) pies\b/dist_paren($1,$lang)/ge;
    $t =~ s/\b1 mile\b/miles_to_km(1,$lang).'&nbsp;km (1&nbsp;mile)'/ge;
    $t =~ s/(\d+) miles\b/miles_to_km($1,$lang)."&nbsp;km ($1&nbsp;miles)"/ge;
    $t =~ s/\b1 milla\b/miles_to_km(1,$lang).'&nbsp;km (1&nbsp;milla)'/ge;
    $t =~ s/(\d+) millas\b/miles_to_km($1,$lang)."&nbsp;km ($1&nbsp;millas)"/ge;
    return $t;
}

# El texto visible del span lo reescribe js/wiki-api.js; data-type va SIEMPRE en
# ingles porque es la clave del icono en bg3.wiki.
sub damage_spans {
    my ($t, $lang) = @_;
    my $word = $lang eq 'es' ? 'de daño' : 'damage';
    if ($lang eq 'en') {
        $t =~ s{(\d+d\d+) ($DMG_RE) damage}
               {<span class="dmg-calc" data-dice="$1" data-type="$2">$1 $2</span> damage}g;
        $t =~ s{(?<!">)\b($DMG_RE) damage}
               {<span class="dmg-type" data-type="$1">$1</span> damage}g;
    }
    return $t;
}

# El cuerpo entero. Los parrafos que el SRD marca con vineta se agrupan en una
# lista; el resto sale como parrafos sueltos.
sub blocks {
    my ($paras, $lang) = @_;
    my (@out, @bullets);
    my $flush = sub {
        return unless @bullets;
        push @out, "<ul>\n            "
            . join("\n            ", map { "<li>" . markup($_, $lang) . "</li>" } @bullets)
            . "\n          </ul>";
        @bullets = ();
    };
    for my $p (@$paras) {
        if ($p =~ /^\x{2022}\s*(.*)$/) { push @bullets, $1; next }
        $flush->();
        push @out, block($p, $lang);
    }
    $flush->();
    return join "\n          ", @out;
}

# Un bloque del cuerpo: parrafo normal, o HTML crudo si viene de arreglos.txt.
sub block {
    my ($text, $lang) = @_;
    return $1 if $text =~ /^\x00HTML\x00(.*)$/s;
    return '<p>' . markup($text, $lang) . '</p>';
}

# En la traduccion el dano se marca a mano, porque en espanol no hay un patron
# fijo que reconocer: {{4d4|Acid}} para dados y tipo, {{Acid}} para solo el tipo.
# El tipo va siempre en ingles: es la clave del icono de bg3.wiki.
my %DMG_ES = (
    Acid => 'ácido', Bludgeoning => 'contundente', Cold => 'frío', Fire => 'fuego',
    Force => 'fuerza', Lightning => 'relámpago', Necrotic => 'necrótico',
    Piercing => 'perforante', Poison => 'veneno', Psychic => 'psíquico',
    Radiant => 'radiante', Slashing => 'cortante', Thunder => 'trueno',
);
sub dmg_tag {
    my ($dice, $type, $lang) = @_;
    my $label = $lang eq 'es' ? ($DMG_ES{$type} // $type) : $type;
    return qq{<span class="dmg-calc" data-dice="$dice" data-type="$type">$dice $label</span>}
        if defined $dice && $dice ne '';
    return qq{<span class="dmg-type" data-type="$type">$label</span>};
}

sub markup {
    my ($text, $lang) = @_;
    my $t = h($text);
    $t =~ s/\{\{(\d+d\d+)\|($DMG_RE)\}\}/dmg_tag($1,$2,$lang)/ge;
    $t =~ s/\{\{($DMG_RE)\}\}/dmg_tag('',$1,$lang)/ge;
    $t = distances($t, $lang);
    $t = damage_spans($t, $lang);
    # en la traduccion el subtitulo en linea va marcado con **...**
    if ($t =~ s/^\*\*(.+?)\*\*/<b>$1<\/b>/) { return $t }
    return $t if $lang eq 'es';
    my ($head, $rest) = runin_head($t);
    return defined $head ? "<b>$head.</b> $rest" : $t;
}

# ------------------------------------------------------------------ metadatos

sub casting_html {
    my ($ct, $lang, $override) = @_;
    my $t = $T{$lang};
    # La coletilla de las reacciones ("which you take when...") se traduce a
    # mano en srd-es.txt; el icono lo sigue poniendo la version inglesa.
    if (defined $override && $override ne '') {
        my $icn = $ct =~ /^Bonus Action/ ? 'bonus'
                : $ct =~ /^Reaction/     ? 'reaction'
                : $ct =~ /^Action/       ? 'action'
                : undef;
        my $out = defined $icn ? icon($icn) : '';
        $out .= ent_es($override);
        $out .= ' ' . icon('ritual') . $t->{ritual} if $ct =~ /or Ritual$/;
        return $out;
    }
    my ($icn, $label);
    if    ($ct =~ /^Bonus Action/) { $icn = 'bonus';    $label = $t->{bonus} }
    elsif ($ct =~ /^Reaction/)     { $icn = 'reaction'; $label = $t->{reaction} }
    elsif ($ct =~ /^Action/)       { $icn = 'action';   $label = $t->{action} }
    my $tail = '';
    if ($ct =~ /,\s*(.+)$/) { $tail = ', ' . distances(h($1), $lang) }
    if ($ct =~ /or Ritual$/) {
        my $base = defined $label ? icon($icn) . $label : h(time_word($ct, $lang));
        return $base . ' ' . lc($lang eq 'es' ? 'o' : 'or') . ' ' . icon('ritual') . $t->{ritual};
    }
    return icon($icn) . $label . $tail if defined $label;
    return h(time_word($ct, $lang));
}

sub time_word {
    my ($ct, $lang) = @_;
    return $ct if $lang eq 'en';
    my %W = ('1 minute' => '1 minuto', '10 minutes' => '10 minutos',
             '1 hour' => '1 hora', '8 hours' => '8 horas', '12 hours' => '12 horas',
             '24 hours' => '24 horas', 'Action' => 'Acción');
    $ct =~ s/\bor Ritual\b/o ritual/;
    for my $k (sort { length($b) <=> length($a) } keys %W) {
        $ct =~ s/\Q$k\E/$W{$k}/;
    }
    return $ct;
}

# Las coletillas del tiempo de lanzamiento ("which you take when...") se
# traducen a mano en srd-es.txt; aqui solo se copian.
sub clause { my ($c) = @_; return $c }

sub range_text {
    my ($rg, $lang, $spell) = @_;
    my $t = $T{$lang};
    return $t->{touch}     if $rg eq 'Touch';
    return $t->{sight}     if $rg eq 'Sight';
    return $t->{special}   if $rg eq 'Special';
    return $t->{unlimited} if $rg eq 'Unlimited';
    if ($rg eq 'Self') {
        my $area = self_area($spell, $lang);
        return $area ? "$t->{self} ($area)" : $t->{self};
    }
    return dist_slash($1, $lang)                if $rg =~ /^(\d+) feet$/;
    return miles_to_km($1, $lang) . " km / $1 " . ($lang eq 'es' ? ($1 == 1 ? 'milla' : 'millas') : ($1 == 1 ? 'mile' : 'miles'))
        if $rg =~ /^(\d+) miles?$/;
    return h($rg);
}

my %SHAPE_ES = (Cone => 'cono', Line => 'línea', Cube => 'cubo', Sphere => 'esfera',
                Cylinder => 'cilindro', Emanation => 'emanación');
sub self_area {
    my ($spell, $lang) = @_;
    my $blob = join ' ', @{ $spell->{body} };
    return unless $blob =~ /(\d+)-foot(?:-radius)?\s+(Cone|Line|Cube|Sphere|Cylinder|Emanation)/;
    my ($ft, $shape) = ($1, $2);
    return $lang eq 'es'
        ? "$SHAPE_ES{$shape} de " . dist_slash($ft, $lang)
        : dist_slash($ft, $lang) . ' ' . lc($shape);
}

sub duration_html {
    my ($du, $lang) = @_;
    my $t = $T{$lang};
    my $s = $du;
    if ($lang eq 'es') {
        $s =~ s/^Concentration, up to /Concentración, hasta /;
        $s =~ s/^Up to /Hasta /;
        $s =~ s/^Instantaneous$/Instantáneo/;
        $s =~ s/^Until dispelled$/Hasta que se disipe/;
        $s =~ s/^Until dispelled or triggered$/Hasta que se disipe o se active/;
        $s =~ s/\b1 minute\b/1 minuto/;   $s =~ s/(\d+) minutes\b/$1 minutos/;
        $s =~ s/\b1 hour\b/1 hora/;       $s =~ s/(\d+) hours\b/$1 horas/;
        $s =~ s/\b1 day\b/1 día/;         $s =~ s/(\d+) days\b/$1 días/;
        $s =~ s/\b1 round\b/1 asalto/;    $s =~ s/(\d+) rounds\b/$1 asaltos/;
        $s =~ s/\b1 turn\b/1 turno/;      $s =~ s/(\d+) turns\b/$1 turnos/;
        $s =~ s/^Special$/Especial/;
        $s =~ s/^Permanent$/Permanente/;
    }
    my $out = h($s);
    $out = icon('conc') . $out if $du =~ /^Concentration/;
    return $out;
}

sub saving_throw {
    my ($spell, $lang) = @_;
    my $t = $T{$lang};
    my $blob = join ' ', @{ $spell->{body} };
    return $t->{none} unless $blob =~ /(Strength|Dexterity|Constitution|Intelligence|Wisdom|Charisma) saving throw/;
    my $ab = $lang eq 'es' ? $ABILITY_ES{$1} : $1;
    return "$ab, $t->{half}" if $blob =~ /half as much damage on a successful/;
    return $ab;
}

sub attack_line {
    my ($spell, $lang) = @_;
    my $blob = join ' ', @{ $spell->{body} };
    return $T{$lang}{ranged_attack} if $blob =~ /ranged spell attack/i;
    return $T{$lang}{melee_attack}  if $blob =~ /melee spell attack/i;
    return;
}

sub damage_line {
    my ($spell, $lang) = @_;
    my $blob = join ' ', @{ $spell->{body} };
    my (@types, %seen);
    while ($blob =~ /\b($DMG_RE)\b/g) { push @types, $1 unless $seen{$1}++ }
    return unless @types;
    return join ' &middot; ', map { dmg_tag('', $_, $lang) } @types;
}

sub disc_name {
    my ($disc, $lang, $upper) = @_;
    my $s = $lang eq 'es' ? $DISC_ES{$disc} : lc $disc;
    return $upper ? ucfirst $s : $s;
}

# Las tablas de descatalogados no son subdisciplinas, pero ocupan su sitio en
# la ficha y en el filtro, asi que se nombran aqui.
my %BUCKET_NAME = (
    none         => { en => 'no Discipline',  es => 'sin Disciplina' },
    summon       => { en => 'summoning',      es => 'invocaci&oacute;n' },
    poison       => { en => 'poison',         es => 'veneno' },
    chromatic    => { en => 'chromatic',      es => 'crom&aacute;tico' },
    resurrection => { en => 'undoing death',  es => 'deshacer la muerte' },
);

sub sub_name {
    my ($key, $lang) = @_;
    return unless $key && $key ne '-';
    return $BUCKET_NAME{$key}{$lang} if $BUCKET_NAME{$key};
    return unless $TAXNAME{$key};
    return $TAXNAME{$key}{$lang};
}

# La casilla de Disciplina de la ficha: enlaza a la Disciplina y, si el conjuro
# baja a una subdisciplina, tambien a ella.
# La cadena de subdivisiones a la que pertenece una clave, de la mas ancha a la
# mas fina: 'illusion' devuelve ('mind','illusion'). Es lo que necesitan tanto
# la ficha como el buscador, porque filtrar por Mente tiene que traer sus Ramas.
sub sub_chain {
    my ($k) = @_;
    my @c;
    while ($k && $NODE{$k} && ($NODE{$k}{kind} eq 'leaf' || $NODE{$k}{kind} eq 'sub')) {
        unshift @c, $k;
        $k = $NODE{$k}{parent};
    }
    return @c;
}

sub disc_link {
    my ($spell, $lang) = @_;
    if ($spell->{unc}) {
        return qq{<a href="./uncatalogued.html">}
             . ($lang eq 'es' ? 'Descatalogado' : 'Uncatalogued') . qq{</a>};
    }
    my $dkey = lc $spell->{discipline};
    # la astronomia es la portada de la seccion, asi que su archivo es index
    my $dfile = $dkey eq 'astronomy' ? 'index.html' : "$dkey.html";
    my $out  = qq{<a href="./$dfile">}
             . ent_es(disc_name($spell->{discipline}, $lang, 1)) . qq{</a>};
    for my $sk (sub_chain($SUBOF{ $spell->{name} } // '')) {
        my $sn = sub_name($sk, $lang) or next;
        $out .= qq{ &rsaquo; <a href="./$sk.html">} . ent_es($sn) . qq{</a>};
    }
    # el segundo umbral, cuando lo hay
    if (my $x = $CROSS{ $spell->{name} }) {
        my $xf = $x eq 'astronomy' ? 'index.html' : "$x.html";
        $out .= ' + <a href="./' . $xf . '">'
              . ent_es(disc_name(ucfirst $x, $lang)) . '</a>';
    }
    return $out;
}

sub level_line {
    my ($spell, $lang) = @_;
    my $t = $T{$lang};
    my $disc = disc_name($spell->{discipline}, $lang);
    return $spell->{level} == 0 ? "$t->{cantrip}, $disc" : "$spell->{level}, $disc";
}

sub kind_line {
    my ($spell, $lang) = @_;
    my $t = $T{$lang};
    my $lvl = $spell->{level} == 0 ? $t->{cantrip} : "$t->{level} $spell->{level}";
    return "$lvl &middot; " . ($lang eq 'es' ? 'Descatalogado' : 'Uncatalogued')
        if $spell->{unc};
    my $disc = disc_name($spell->{discipline}, $lang, 1);
    return "$lvl &middot; $disc";
}

# ------------------------------------------------------------------- plantilla

# ------------------------------------------------------------------- la pagina

sub render_page {
    my ($en, $lang) = @_;
    my $t     = $T{$lang};
    my $file  = spell_slug($en->{name}) . '.html';
    my $es    = $ES{ $en->{name} };
    my $name  = disp_name($en->{name}, $lang);
    my $src   = ($lang eq 'es' && $es) ? $es : $en;

    # los conjuros con tabla traen el parrafo aplastado: se sustituye
    my @body = @{ $src->{body} };
    my $fixlang = ($lang eq 'es' && $es) ? 'es' : 'en';
    for my $fix (@{ $FIX{$fixlang}{ $en->{name} } || [] }) {
        for my $i (0 .. $#body) {
            next unless index($body[$i], $fix->{match}) >= 0;
            my @new = map { $_->[0] eq 'html' ? "\x00HTML\x00" . $_->[1] : $_->[1] }
                      @{ $fix->{parts} };
            splice @body, $i, 1, @new;
            last;
        }
    }

    # cuerpo: descripcion / a niveles superiores
    my (@desc, @higher);
    for my $p (@body) {
        if ($p =~ /^\*{0,2}(Using a Higher-Level Spell Slot|Cantrip Upgrade|Con un espacio de conjuro|Mejora de truco)/) {
            push @higher, $p;
        } else {
            push @desc, $p;
        }
    }
    my $desc_html   = blocks(\@desc, $lang);
    my $higher_html = blocks(\@higher, $lang);

    # ficha lateral
    my $iconurl = $ICON{ $en->{name} };
    my $iconhtml = $iconurl
        ? qq{<img class="spell-icon" src="$iconurl" alt="">}
        : qq{<div class="spell-icon ph" aria-hidden="true">$t->{icon_ph}</div>};

    my @rows = (
        [ $t->{level},      $en->{level} == 0 ? $t->{cantrip} : $en->{level} ],
        [ $t->{discipline}, disc_link($en, $lang) ],
        [ $t->{components}, ent_es($lang eq 'es' && $es ? $es->{components} : $en->{components}) ],
        [ $t->{casting},    casting_html($en->{casting}, $lang,
                                         $lang eq 'es' && $es ? $es->{casting} : undef) ],
        [ $t->{range},      range_text($en->{range}, $lang, $en) ],
        [ $t->{duration},   duration_html($en->{duration}, $lang) ],
        [ $t->{save},       h(saving_throw($en, $lang)) ],
    );
    my $atk = attack_line($en, $lang);
    push @rows, [ $t->{attack}, h($atk) ] if $atk;
    my $dmg = damage_line($en, $lang);
    push @rows, [ $t->{damage}, $dmg ] if $dmg;

    my $rows_html = join "\n          ",
        map { qq{<div class="ibrow"><span class="ibk">$_->[0]</span><span class="ibv">$_->[1]</span></div>} } @rows;

    my $first = @desc ? $desc[0] : $name;
    $first =~ s/^(.{0,150}?[.!?])\s.*$/$1/s;
    my $desc_meta = plain(kind_line($en, $lang) . '. ' . $first);

    # mientras la traduccion no este, la pagina lo dice en vez de fingir
    my $pending = '';
    # Un descatalogado dice en su propia pagina por que lo esta.
    if (my $u = $en->{unc}) {
        my $h = $lang eq 'es' ? 'Descatalogado' : 'Uncatalogued';
        my $l = $lang eq 'es'
            ? 'No cuelga de ninguna Disciplina. Ver <a href="./uncatalogued.html">descatalogados</a>.'
            : 'It hangs from no Discipline. See <a href="./uncatalogued.html">uncatalogued</a>.';
        $pending .= qq{\n    <div class="warn top" role="note">\n}
                  . qq{      <h3>$h</h3>\n}
                  . qq{      <p>$u->{why}{$lang} $l</p>\n}
                  . qq{    </div>\n};
    }
    if ($lang eq 'es' && !$es) {
        $pending = qq{\n    <div class="warn top" role="note">\n}
                 . qq{      <h3>Traducci&oacute;n pendiente</h3>\n}
                 . qq{      <p>El texto de este conjuro todav&iacute;a est&aacute; en ingl&eacute;s. El nombre, }
                 . qq{la ficha y la Disciplina s&iacute; est&aacute;n en espa&ntilde;ol.</p>\n}
                 . qq{    </div>\n};
    }

    my $out = page_head(lang => $lang, path => "pages/astronomy/$file", up => '../../../',
                        title => h($name), desc => $desc_meta);
    $out .= qq{\n<body>\n  <div class="spellpage">\n\n};
    $out .= page_nav(lang => $lang, path => "pages/astronomy/$file", up => '../../../', section => 'astronomy');
    $out .= <<"HTML";

    <header class="spellhead">
      <h1>@{[ h($name) ]}</h1>
      <p class="spellkind">@{[ kind_line($en, $lang) ]}</p>
    </header>

$pending
    <div class="spellbody">
      <main>
        <section>
          <h2>$t->{desc}</h2>
          $desc_html
        </section>
HTML
    $out .= <<"HTML" if $higher_html;

        <section>
          <h2>$t->{higher}</h2>
          $higher_html
        </section>
HTML
    $out .= <<"HTML";
      </main>

      <aside class="infobox">
        <div class="ibhead">
          $iconhtml
          <h2>@{[ h($name) ]}</h2>
        </div>
        <div class="ibrows">
          $rows_html
        </div>
      </aside>
    </div>

HTML
    $out .= page_foot(up => '../../../', scripts => ['wiki-api.js']);
    return ($file, $out);
}

# ---------------------------------------------------------------------- indice

my %IDX = (
    en => {
        title => 'Spells',
        lead => 'Every spell of the supplement: search it, filter it, sort it',
        back_to_art => '&larr; The art, its Disciplines and the diagram',
        tree_art => 'the Ether worked as Ether, and everything it contains.',
        all_h => 'Every spell', count_one => 'spell', count_many => 'spells',
        tree_unc => 'what hangs from no Discipline, and why.',
        intro => 'Magic is one art. What separates one spell from another is not '
               . 'who taught it but how far it pushes the Ether: <b>Astronomy</b> works '
               . 'the Ether as Ether &mdash; light, force, and everything that finds, '
               . 'hinders or undoes magic; <b>Alchemy</b> crosses into matter; '
               . '<b>Cosmology</b> into space, time and gravity; <b>Spiritism</b> into '
               . 'life, the soul, the mind and what they can be made to believe.',
        cantrips => 'Cantrips', lvl => 'Level',
        cols => [ 'Name', 'Level', 'Discipline', 'Casting time', 'Range', 'Duration' ],
        f_search => 'Search by name', f_level => 'Any level', f_disc => 'Any Discipline',
        f_sub => 'Any subdivision',
        f_reset => 'Reset', f_sort => 'Sort',
        f_count => 'spells shown', f_count_one => 'spell shown', f_none => 'No spell matches these filters.',
        f_help => 'Click a column heading to sort by it.',
        tree_h => 'The tree', tree_all => 'The whole catalogue',
        tree_note => 'Pick a branch and the tables keep only it. Without JavaScript, each name goes to its own page.',
        tree_core => 'Astronomy alone', tree_core_note => 'crosses no threshold',
        f_in => 'in',
    },
    es => {
        title => 'Conjuros',
        lead => 'Todos los conjuros del suplemento: buscar, filtrar y ordenar',
        back_to_art => '&larr; El arte, sus Disciplinas y el diagrama',
        tree_art => 'el &Eacute;ter trabajado como &Eacute;ter, y cuanto contiene.',
        all_h => 'Todos los conjuros', count_one => 'conjuro', count_many => 'conjuros',
        tree_unc => 'lo que no cuelga de ninguna Disciplina, y por qu&eacute;.',
        intro => 'La magia es un solo arte. Lo que separa un conjuro de otro no es '
               . 'qui&eacute;n lo ense&ntilde;a, sino hasta d&oacute;nde fuerza el &Eacute;ter: '
               . 'la <b>astronom&iacute;a</b> trabaja el &Eacute;ter como &Eacute;ter &mdash; luz, '
               . 'fuerza, y todo lo que encuentra, estorba o deshace magia&mdash;; la '
               . '<b>alquimia</b> cruza a la materia; la <b>cosmolog&iacute;a</b>, al espacio, '
               . 'el tiempo y la gravedad; el <b>espiritismo</b>, a la vida, el alma, la '
               . 'mente y lo que se les puede hacer creer.',
        cantrips => 'Trucos', lvl => 'Nivel',
        cols => [ 'Nombre', 'Nivel', 'Disciplina', 'Tiempo de lanzamiento', 'Alcance', 'Duraci&oacute;n' ],
        f_search => 'Buscar por nombre', f_level => 'Cualquier nivel',
        f_disc => 'Cualquier Disciplina',
        f_sub => 'Cualquier subdivisi&oacute;n',
        f_reset => 'Limpiar', f_sort => 'Ordenar',
        f_count => 'conjuros a la vista', f_count_one => 'conjuro a la vista', f_none => 'Ning&uacute;n conjuro encaja con estos filtros.',
        f_help => 'Pulsa en una cabecera de columna para ordenar por ella.',
        tree_h => 'El &aacute;rbol', tree_all => 'Todo el cat&aacute;logo',
        tree_note => 'Elige una rama y las tablas se quedan con ella. Sin JavaScript, cada nombre lleva a su p&aacute;gina.',
        tree_core => 'Solo astronom&iacute;a', tree_core_note => 'no cruza umbral',
        f_in => 'en',
    },
);

sub read_lex {
    open(my $fh, '<:encoding(UTF-8)', 'lex-conjuros.txt') or die $!;
    my @out;
    while (<$fh>) {
        s/\r?\n$//;
        next if /^#/ || !/\S/;
        my @f = split /\t/;
        push @out, {
            slug => $f[0], level => $f[1], discipline => $f[2],
            name => { en => $f[3], es => $f[4] },
            casting => { en => $f[5], es => $f[6] },
            range => { en => $f[7], es => $f[8] },
            duration => { en => $f[9], es => $f[10] },
            icon => $f[11] // '',
        };
    }
    close $fh;
    return @out;
}

sub row_icon {
    my ($url) = @_;
    return '' unless $url;
    return qq{<img class="ic" width="24" src="$url" alt="">};
}

# Barra de filtros. Va oculta hasta que js/spell-filter.js la activa: sin
# JavaScript las tablas salen completas y agrupadas por nivel, que ya sirve.
sub filter_bar {
    my ($lang) = @_;
    my $i = $IDX{$lang};

    my $levels = qq{<option value="">$i->{f_level}</option>};
    for my $l (0 .. 9) {
        my $label = $l == 0 ? $i->{cantrips} : "$i->{lvl} $l";
        $levels .= qq{<option value="$l">$label</option>};
    }
    # Astronomia va la primera, no en orden alfabetico: es el fondo del arte
    my $discs = qq{<option value="">$i->{f_disc}</option>};
    for my $d (@DISC_ORDER) {
        my $label = ent_es(disc_name($d, $lang, 1));
        $discs .= qq{<option value="@{[ lc $d ]}">$label</option>};
    }
    # Las subdisciplinas, agrupadas bajo su Disciplina. Astronomia no aparece:
    # no tiene, porque sus subdivisiones son las otras tres.
    my $subs = qq{<option value="">$i->{f_sub}</option>};
    for my $g (@SUBS_OF) {
        my ($disc, $keys) = @$g;
        my $glabel = ent_es(ucfirst $TAXNAME{$disc}{$lang});
        $subs .= qq{<optgroup label="$glabel">};
        for my $r (@$keys) {
            my ($k, $depth) = @$r;
            my $pad = $depth ? '&nbsp;&nbsp;&middot; ' : '';
            $subs .= qq{<option value="$k">$pad@{[ ent_es(ucfirst sub_name($k, $lang)) ]}</option>};
        }
        $subs .= qq{</optgroup>};
    }

    return <<"HTML";
<div class="spellfilter" id="spellfilter" hidden>
          <label class="vh" for="sf-q">$i->{f_search}</label>
          <input type="search" id="sf-q" placeholder="$i->{f_search}&hellip;" autocomplete="off">
          <label class="vh" for="sf-level">$i->{f_level}</label>
          <select id="sf-level">$levels</select>
          <label class="vh" for="sf-discipline">$i->{f_disc}</label>
          <select id="sf-discipline">$discs</select>
          <label class="vh" for="sf-sub">$i->{f_sub}</label>
          <select id="sf-sub">$subs</select>
          <button type="button" id="sf-reset">$i->{f_reset}</button>
          <p class="sf-count" id="sf-count" role="status" data-label="$i->{f_count}"></p>
        </div>
        <p class="sf-empty" id="sf-empty" hidden>$i->{f_none}</p>
HTML
}

sub render_index {
    my ($lang) = @_;
    my $t = $T{$lang};
    my $i = $IDX{$lang};

    # Los conjuros propios del suplemento y los que vienen del SRD van
    # mezclados, porque aqui ya no se distinguen.
    my @all;
    for my $s (read_lex()) {
        push @all, {
            level => $s->{level}, disc => $s->{discipline}, slug => $s->{slug},
            sub   => $SUBOF{ $s->{name}{en} } // '',
            icon  => $s->{icon},  name => $s->{name}{$lang}, sort => $s->{name}{en},
            casting  => ent_es($s->{casting}{$lang}),
            range    => ent_es($s->{range}{$lang}),
            duration => ent_es($s->{duration}{$lang}),
        };
    }
    for my $s (@EN) {
        my $name = disp_name($s->{name}, $lang);
        push @all, {
            level => $s->{level},
            disc  => $s->{unc} ? 'Uncatalogued' : $s->{discipline},
            slug  => spell_slug($s->{name}),
            sub   => $s->{unc} ? $s->{unc}{bucket} : ($SUBOF{ $s->{name} } // ''),
            icon  => $ICON{ $s->{name} } // '', name => $name, sort => $name,
            casting  => casting_html($s->{casting}, $lang,
                            $lang eq 'es' && $ES{ $s->{name} } ? $ES{ $s->{name} }{casting} : undef),
            range    => range_text($s->{range}, $lang, $s),
            duration => duration_html($s->{duration}, $lang),
        };
    }

    my (%n_disc, %n_sub);
    for my $s (@all) {
        $n_disc{ lc $s->{disc} }++;
        next unless $s->{sub} && $s->{sub} ne '-';
        # sube por el arbol: lo que esta en una Rama cuenta en su subdisciplina
        my $k = $s->{sub};
        while ($k) { $n_sub{$k}++; my $p = $NODE{$k} or last;
                     $k = ($p->{kind} eq 'leaf') ? $p->{parent} : undef }
    }
    my $total = scalar @all;

    # ------------------------------------------------------- el arbol lateral

    my $max = 0;
    for (values %n_disc, values %n_sub) { $max = $_ if $_ > $max }
    $max ||= 1;
    my $bar = sub {
        my ($n) = @_;
        my $pct = int(100 * $n / $max + .5);
        my $z = $n ? '' : ' tb-zero';
        return qq{<span class="tb-bar$z" aria-hidden="true"><i style="width:$pct%"></i></span>};
    };
    # Una rama: nombre, barra y recuento. El href es la pagina de la rama, de
    # modo que sin JavaScript el arbol sigue siendo un indice navegable.
    my $branch = sub {
        my (%a) = @_;
        my $cls = 'tb';
        $cls .= " tb-$a{kind}" if $a{kind};
        $cls .= ' tb-empty' unless $a{n};
        my $d = defined $a{disc} ? qq{ data-disc="$a{disc}"} : '';
        my $s = $a{sub} ? qq{ data-sub="$a{sub}"} : '';
        my $note = $a{note} ? qq{ <span class="tb-note">$a{note}</span>} : '';
        return qq{        <li><a class="$cls" href="./$a{href}"$d$s data-branch="$a{label}">}
             . qq{<span class="tb-name">$a{label}$note</span>}
             . $bar->($a{n}) . qq{<b class="tb-n">$a{n}</b></a></li>\n};
    };

    my $tree = qq{<nav class="treepanel" aria-label="$i->{tree_h}">\n}
             . qq{        <h2>$i->{tree_h}</h2>\n        <p class="tree-note">$i->{tree_note}</p>\n}
             . qq{        <ul>\n};
    $tree .= $branch->(kind => 'all', href => 'spells.html', disc => '', n => $total,
                       label => ent_es(ucfirst $TAXNAME{astronomy}{$lang}));
    $tree .= $branch->(kind => 'core', href => 'index.html', disc => 'astronomy',
                       n => $n_disc{astronomy} // 0, label => $i->{tree_core},
                       note => $i->{tree_core_note});
    for my $g (@SUBS_OF) {
        my ($dk, $keys) = @$g;
        my $dn = ent_es(ucfirst $TAXNAME{$dk}{$lang});
        my $df = $dk eq 'uncatalogued' ? 'uncatalogued.html' : "$dk.html";
        $tree .= $branch->(kind => 'disc', href => $df, disc => $dk,
                           n => $n_disc{$dk} // 0, label => $dn);
        for my $r (@$keys) {
            my ($k, $depth) = @$r;
            my $n = $n_sub{$k} // 0;
            next if $dk eq 'uncatalogued' && !$n;
            my $kf = $dk eq 'uncatalogued' ? 'uncatalogued.html' : "$k.html";
            $tree .= $branch->(kind => $depth ? 'leaf' : 'sub', href => $kf,
                               disc => $dk, sub => $k,
                               n => $n, label => ent_es(ucfirst sub_name($k, $lang)));
        }
    }
    $tree .= qq{        </ul>\n      </nav>\n};

    # ------------------------------------------------ una tabla por cada nivel

    my %by;
    push @{ $by{ $_->{level} } }, $_ for @all;
    my @levels = sort { $a <=> $b } keys %by;
    # sin columna de nivel: la seccion entera ya es un nivel
    my @cols = @{ $i->{cols} };
    splice @cols, 1, 1;
    my $cols = join '', map { qq{<th scope="col">$_</th>} } @cols;

    my $tables = '';
    for my $l (@levels) {
        my @s = sort { $a->{sort} cmp $b->{sort} } @{ $by{$l} };
        my $n = scalar @s;
        my $head = $l == 0 ? $i->{cantrips} : "$i->{lvl} $l";
        my $rows = '';
        for my $s (@s) {
            my $disc = ent_es(disc_name($s->{disc}, $lang, 1));
            my @chain = ($s->{sub} && $s->{sub} ne '-') ? sub_chain($s->{sub}) : ();
            # descatalogados: el 'sub' es el motivo, no un nodo del arbol
            @chain = ($s->{sub}) if !@chain && $s->{sub} && $s->{sub} ne '-';
            my $skey  = join ' ', @chain;
            for my $sk (@chain) {
                my $sn = sub_name($sk, $lang) or next;
                $disc .= ' &middot; ' . ent_es($sn);
            }
            # los data-* van en ingles: son claves, no texto visible
            $rows .= sprintf(
                qq{              <tr data-discipline="%s" data-sub="%s" data-name="%s">\n}
              . qq{                <td>%s<a href="./%s.html">%s</a></td>\n}
              . qq{                <td>%s</td>\n                <td>%s</td>\n}
              . qq{                <td>%s</td>\n                <td>%s</td>\n              </tr>\n},
                lc $s->{disc}, $skey, lc plain($s->{name}),
                row_icon($s->{icon}), $s->{slug}, ent_es($s->{name}),
                $disc, $s->{casting}, $s->{range}, $s->{duration});
        }
        $tables .= qq{        <section class="lvlsec" data-level="$l">\n}
                 . qq{          <h2>$head <span class="lvlsec-n">&middot; <b>$n</b> }
                 . ($n == 1 ? $i->{count_one} : $i->{count_many}) . qq{</span></h2>\n}
                 . qq{          <div class="tw">\n            <table class="spelltable">\n}
                 . qq{              <thead><tr>$cols</tr></thead>\n}
                 . qq{              <tbody>\n$rows              </tbody>\n}
                 . qq{            </table>\n          </div>\n        </section>\n};
    }

    my $file = 'spells.html';
    my $out = page_head(lang => $lang, path => "pages/astronomy/$file", up => '../../../',
                        title => $i->{title}, desc => plain($t->{subtitle}));
    $out .= qq{\n<body>\n  <div class="spellpage">\n\n};
    $out .= page_nav(lang => $lang, path => "pages/astronomy/$file", up => '../../../',
                     section => 'astronomy');
    $out .= <<"HTML";

    <header class="spellhead">
      <h1>$i->{title}</h1>
      <p class="spellkind">$i->{lead}</p>
    </header>

    <div class="spellfinder">
      $tree
      <main class="findermain">
        @{[ filter_bar($lang) ]}$tables      </main>
    </div>

    <p class="pagelink"><a href="./index.html">$i->{back_to_art}</a></p>

HTML
    $out .= page_foot(up => '../../../', scripts => ['wiki-api.js', 'spell-filter.js']);
    return ($file, $out);
}

# Barra de filtros del indice. Va oculta hasta que js/spell-filter.js la activa:
# sin JavaScript la tabla sigue completa y ordenada por nivel.


sub ent_es {
    my $s = h(shift // '');
    my %e = ('á'=>'&aacute;','é'=>'&eacute;','í'=>'&iacute;','ó'=>'&oacute;','ú'=>'&uacute;',
             'ñ'=>'&ntilde;','Á'=>'&Aacute;','É'=>'&Eacute;','Í'=>'&Iacute;','Ó'=>'&Oacute;',
             'Ú'=>'&Uacute;','Ñ'=>'&Ntilde;', "\x{2019}"=>'&rsquo;');
    $s =~ s/([\x{e1}\x{e9}\x{ed}\x{f3}\x{fa}\x{f1}\x{c1}\x{c9}\x{cd}\x{d3}\x{da}\x{d1}\x{2019}])/$e{$1}/g;
    return $s;
}

# --------------------------------------------------------------------- escribe

my $CLEAN = grep { $_ eq '--limpiar' } @ARGV;

for my $lang (qw(en es)) {
    my $dir = "$ROOT/$lang/pages/astronomy";
    make_path($dir) unless -d $dir;
    # --limpiar retira lo que ya no genera nadie (un conjuro renombrado deja su
    # archivo viejo atras), sin tocar los siete escritos a mano.
    if ($CLEAN && !$DRY) {
        my %keep = map { ("$_.html" => 1) } @A_MANO;
        $keep{'index.html'} = 1;      # la portada: la escribe build-disciplines.pl
        $keep{'spells.html'} = 1;
        $keep{ spell_slug($_->{name}) . '.html' } = 1 for @EN;
        for my $n (@$TAX) {
            next if $n->{key} eq 'astronomy';   # esa es index.html, ya listada
            $keep{"$n->{key}.html"} = 1;
        }
        for my $f (glob "$dir/*.html") {
            my ($base) = $f =~ m{([^/\\]+)$};
            next if $keep{$base};
            unlink $f and print STDERR "  retirado $lang/$base\n";
        }
    }
    for my $s (@EN) {
        my ($file, $html) = render_page($s, $lang);
        next if $DRY;
        open(my $fh, '>:encoding(UTF-8)', "$dir/$file") or die "$dir/$file: $!";
        print $fh $html;
        close $fh;
    }
    my ($ifile, $ihtml) = render_index($lang);
    next if $DRY;
    open(my $fh, '>:encoding(UTF-8)', "$dir/$ifile") or die $!;
    print $fh $ihtml;
    close $fh;
}
printf STDERR "%d conjuros x 2 idiomas, mas spells.html en los dos idiomas
", scalar(@EN);
