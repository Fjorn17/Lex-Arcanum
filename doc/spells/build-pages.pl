#!/usr/bin/perl
# Genera en/pages/spells/ y es/pages/spells/ a partir de los datos del SRD 5.2.1.
#
#   perl build-pages.pl            # escribe las paginas y los dos indices
#   perl build-pages.pl --dry      # solo dice que escribiria
#
# Entradas (todas en este directorio):
#   srd-en.txt       conjuros del SRD, texto original (lo saca extract-srd.pl)
#   srd-es.txt       los mismos conjuros traducidos; puede estar incompleto
#   nombres-es.txt   glosario nombre SRD <TAB> nombre del Manual del Jugador
#   iconos-bg3.txt   nombre SRD <TAB> URL del icono en bg3.wiki (los que hay)
#   magister.txt     conjuros de la lista del Magistrado, uno por linea
#   tablas/<slug>.<lang>.html   fragmentos a mano de los conjuros con tabla
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

binmode(STDERR, ':encoding(UTF-8)');
my $DRY = grep { $_ eq '--dry' } @ARGV;
my $ROOT = '../..';

# ---------------------------------------------------------------- vocabulario

my %SCHOOL_ES = (
    Abjuration    => 'abjuración',   Conjuration  => 'conjuración',
    Divination    => 'adivinación',  Enchantment  => 'encantamiento',
    Evocation     => 'evocación',    Illusion     => 'ilusionismo',
    Necromancy    => 'nigromancia',  Transmutation=> 'transmutación',
);
my %CLASS_ES = (
    Bard => 'bardo', Cleric => 'clérigo', Druid => 'druida', Paladin => 'paladín',
    Ranger => 'explorador', Sorcerer => 'hechicero', Warlock => 'brujo', Wizard => 'mago',
);
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
        school => 'School', casting => 'Casting time', range => 'Range',
        duration => 'Duration', components => 'Components', origin => 'Origin',
        save => 'Saving throw', damage => 'Damage', attack => 'Attack',
        none => 'None', name_col => 'Name',
        desc => 'Description', higher => 'At higher levels', howto => 'How to learn',
        notes => 'Notes', icon_ph => 'icon',
        action => 'Action', bonus => 'Bonus Action', reaction => 'Reaction',
        ritual => 'Ritual', conc => 'Concentration',
        or_ritual => 'or Ritual', self => 'Self', touch => 'Touch',
        sight => 'Sight', special => 'Special', unlimited => 'Unlimited',
        instantaneous => 'Instantaneous',
        ranged_attack => 'Ranged spell attack', melee_attack => 'Melee spell attack',
        half => 'half damage on a success',
        srd => 'SRD 5.2.1',
        ibfoot => 'Text adapted from the System Reference Document 5.2.1, '
                . 'licensed under CC BY 4.0.',
        howto_lead => 'Classes whose spell list includes this spell:',
        subtitle => 'Spells of the System Reference Document 5.2.1, plus the '
                  . 'original spells written for Lex Arcanum.',
    },
    es => {
        spells => 'Conjuros', spell => 'Conjuro', level => 'Nivel', cantrip => 'Truco',
        school => 'Escuela', casting => 'Tiempo de lanzamiento', range => 'Alcance',
        duration => 'Duración', components => 'Componentes', origin => 'Origen',
        save => 'Tirada de salvación', damage => 'Daño', attack => 'Ataque',
        none => 'Ninguna', name_col => 'Nombre',
        desc => 'Descripción', higher => 'A niveles superiores', howto => 'Cómo se aprende',
        notes => 'Notas', icon_ph => 'icono',
        action => 'Acción', bonus => 'Acción adicional', reaction => 'Reacción',
        ritual => 'Ritual', conc => 'Concentración',
        or_ritual => 'o ritual', self => 'Personal', touch => 'Toque',
        sight => 'Vista', special => 'Especial', unlimited => 'Ilimitado',
        instantaneous => 'Instantáneo',
        ranged_attack => 'Ataque de conjuro a distancia', melee_attack => 'Ataque de conjuro cuerpo a cuerpo',
        half => 'mitad de daño si la supera',
        srd => 'SRD 5.2.1',
        ibfoot => 'Texto adaptado del System Reference Document 5.2.1, '
                . 'con licencia CC BY 4.0.',
        howto_lead => 'Clases que tienen este conjuro en su lista:',
        subtitle => 'Los conjuros del System Reference Document 5.2.1 y los '
                  . 'conjuros originales de Lex Arcanum.',
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
my @EN = read_spells('srd-en.txt');
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

sub level_line {
    my ($spell, $lang) = @_;
    my $t = $T{$lang};
    my $school = $lang eq 'es' ? $SCHOOL_ES{ $spell->{school} } : lc $spell->{school};
    return $spell->{level} == 0 ? "$t->{cantrip}, $school" : "$spell->{level}, $school";
}

sub kind_line {
    my ($spell, $lang) = @_;
    my $t = $T{$lang};
    my $school = $lang eq 'es' ? ucfirst $SCHOOL_ES{ $spell->{school} } : $spell->{school};
    my $lvl = $spell->{level} == 0 ? $t->{cantrip} : "$t->{level} $spell->{level}";
    return "$lvl &middot; $school &middot; $t->{srd}";
}

sub classes_list {
    my ($spell, $lang) = @_;
    return map { s/^\s+|\s+$//gr } split /,/, $spell->{classes};
}

# ------------------------------------------------------------------- plantilla

my $BASE = 'https://fjorn17.github.io/Lex-Arcanum';

sub head_block {
    my (%a) = @_;
    my $u = "$a{lang}/pages/spells/$a{file}";
    return <<"HTML";
<!doctype html>
<html lang="$a{lang}">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$a{title} &middot; Lex Arcanum</title>
  <meta name="description" content="$a{desc}">
  <link rel="canonical" href="$BASE/$u">
  <link rel="alternate" hreflang="es" href="$BASE/es/pages/spells/$a{file}">
  <link rel="alternate" hreflang="en" href="$BASE/en/pages/spells/$a{file}">
  <link rel="alternate" hreflang="x-default" href="$BASE/en/pages/spells/$a{file}">
  <link rel="icon" href="../../../assets/img/magister_icon_simplified.png">
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Lex Arcanum">
  <meta property="og:title" content="$a{title} &middot; Lex Arcanum">
  <meta property="og:description" content="$a{desc}">
  <meta property="og:url" content="$BASE/$u">
  <meta property="og:image" content="$BASE/assets/img/magister_icon.png">
  <meta property="og:image:width" content="594">
  <meta property="og:image:height" content="594">
  <meta property="og:image:alt" content="Magister class crest">
  <meta name="twitter:card" content="summary_large_image">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Cinzel:wght\@500;600;700&family=Spectral:ital,wght\@0,300;0,400;0,600;1,400&display=swap">
  <link rel="stylesheet" href="../../../css/style.css">
</head>
HTML
}

my %NAV = (
    en => [ 'Magister', 'Subclasses', 'Spells', 'Items', 'Crafting' ],
    es => [ 'Magistrado', 'Subclases', 'Conjuros', 'Objetos', 'Artesanía' ],
);

sub nav_block {
    my ($lang, $file) = @_;
    my @n = @{ $NAV{$lang} };
    my $es_title = 'Ver esta p&aacute;gina en espa&ntilde;ol';
    my $en_title = 'View this page in English';
    my $es_cur = $lang eq 'es' ? ' aria-current="true"' : '';
    my $en_cur = $lang eq 'en' ? ' aria-current="true"' : '';
    return <<"HTML";
    <nav class="sitenav" aria-label="Site">
      <a class="brand" href="../../index.html">Lex Arcanum</a>
      <a href="../../pages/classes/magister.html">$n[0]</a>
      <a href="../../pages/subclasses/index.html">$n[1]</a>
      <a class="here" aria-current="page" href="../../pages/spells/index.html">$n[2]</a>
      <a href="../../pages/items/index.html">$n[3]</a>
      <a href="../../pages/craft/index.html">$n[4]</a>
      <span class="langsw">
        <a class="lang-es"$es_cur hreflang="es" href="../../../es/pages/spells/$file" title="$es_title"><span class="vh">Espa&ntilde;ol</span></a>
        <a class="lang-en"$en_cur hreflang="en" href="../../../en/pages/spells/$file" title="$en_title"><span class="vh">English</span></a>
      </span>
    </nav>
HTML
}

sub footer_block {
    my ($extra) = @_;
    my $more = $extra ? qq{  <script src="../../../js/$extra"></script>\n} : '';
    return <<"HTML" . $more . "</body>\n\n</html>\n";
    <footer>
      <p class="legal"><b>Unofficial fan content.</b> Not affiliated with, endorsed or sponsored by Wizards of
        the Coast LLC or Larian Studios. Nothing on this site is final.</p>
      <p class="legal">Unofficial Fan Content permitted under the Wizards of the Coast Fan Content Policy. Not
        approved or endorsed by Wizards. Portions of the materials used are property of Wizards of the Coast.
        &copy;&nbsp;Wizards of the Coast LLC.</p>
      <p class="legal">This work includes material from the System Reference Document 5.2 (&ldquo;SRD&nbsp;5.2&rdquo;)
        by Wizards of the Coast LLC, available at <a href="https://www.dndbeyond.com/srd">dndbeyond.com/srd</a>.
        The SRD&nbsp;5.2 is licensed under the Creative Commons Attribution 4.0 International License, available at
        <a
          href="https://creativecommons.org/licenses/by/4.0/legalcode">creativecommons.org/licenses/by/4.0/legalcode</a>.
      </p>
      <p class="legal">Icons are assets of <i>Baldur&rsquo;s Gate&nbsp;3</i>, property of Larian Studios, sourced
        from <a href="https://bg3.wiki/">bg3.wiki</a> (CC&nbsp;BY-SA&nbsp;4.0) and used here for identification
        only. Rules links also point to bg3.wiki.</p>
      <p class="legal"><a class="backstage" href="../../../analysis/index.html">&middot; an&aacute;lisis &middot;</a></p>
    </footer>

    <script src="../../../js/lang.js"></script>
  </div>

  <script src="../../../js/wiki-api.js"></script>
HTML
}

# ------------------------------------------------------------------- la pagina

sub render_page {
    my ($en, $lang) = @_;
    my $t     = $T{$lang};
    my $file  = slug($en->{name}) . '.html';
    my $es    = $ES{ $en->{name} };
    my $name  = $lang eq 'es' ? ($NAME_ES{ $en->{name} } // $en->{name}) : $en->{name};
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
        [ $t->{origin},     $t->{srd} ],
        [ $t->{level},      h(level_line($en, $lang)) ],
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

    # como se aprende
    my @li;
    for my $c (classes_list($en, $lang)) {
        my $label = $lang eq 'es' ? ucfirst($CLASS_ES{$c} // $c) : $c;
        push @li, qq{<li><b><a href="https://bg3.wiki/wiki/$c">$label</a></b></li>};
    }
    if ($MAGISTER{ $en->{name} }) {
        my $label = $lang eq 'es' ? 'Magistrado' : 'Magister';
        my $note  = $lang eq 'es' ? 'lista de conjuros del suplemento' : 'supplement spell list';
        push @li, qq{<li><img class="ic" width="32" src="../../../assets/img/magister_icon_simplified.png" alt=""><b><a href="../classes/magister.html">$label</a></b> &mdash; $note.</li>};
    }
    my $howto = join "\n            ", @li;

    my $first = @desc ? $desc[0] : $name;
    $first =~ s/^(.{0,150}?[.!?])\s.*$/$1/s;
    my $desc_meta = plain(kind_line($en, $lang) . '. ' . $first);

    # mientras la traduccion no este, la pagina lo dice en vez de fingir
    my $pending = '';
    if ($lang eq 'es' && !$es) {
        $pending = qq{\n    <div class="warn top" role="note">\n}
                 . qq{      <h3>Traducci&oacute;n pendiente</h3>\n}
                 . qq{      <p>El texto de este conjuro todav&iacute;a est&aacute; en ingl&eacute;s. Los nombres, }
                 . qq{la ficha y las clases s&iacute; est&aacute;n en espa&ntilde;ol.</p>\n}
                 . qq{    </div>\n};
    }

    my $out = head_block(lang => $lang, file => $file, title => h($name), desc => $desc_meta);
    $out .= qq{\n<body>\n  <div class="spellpage">\n\n};
    $out .= nav_block($lang, $file);
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

        <section>
          <h2>$t->{howto}</h2>
          <p>$t->{howto_lead}</p>
          <ul class="sendlist">
            $howto
          </ul>
        </section>
      </main>

      <aside class="infobox">
        <div class="ibhead">
          $iconhtml
          <h2>@{[ h($name) ]}</h2>
        </div>
        <div class="ibrows">
          $rows_html
        </div>
        <p class="ibfoot">$t->{ibfoot}</p>
      </aside>
    </div>

HTML
    $out .= footer_block();
    return ($file, $out);
}

# ---------------------------------------------------------------------- indice

my %IDX = (
    en => {
        title => 'Spells', lead => 'Every spell of the game, plus the ones written for Lex Arcanum',
        lex_h => 'Lex Arcanum originals', srd_h => 'System Reference Document 5.2.1',
        lex_p => 'Spells written for this supplement. They do not exist in the '
               . 'Player&rsquo;s Handbook. Every one of them is translated from the '
               . '<a href="https://nivel20.com/games/dnd-2024/rulebooks/2638-lex-arcanum">Lex Arcanum '
               . 'rulebook on Nivel20</a>, where the original Spanish text lives.',
        srd_p => 'The 339 spells of the SRD&nbsp;5.2.1, adapted to the format of '
               . 'this site. Spells that are in the Player&rsquo;s Handbook but not '
               . 'in the SRD have no page here: their text is not ours to publish.',
        cantrips => 'Cantrips', lvl => 'Level',
        cols => [ 'Name', 'Level', 'School', 'Classes', 'Casting time', 'Range', 'Duration' ],
        f_search => 'Search by name', f_level => 'Any level', f_school => 'Any school',
        f_class => 'Any class', f_reset => 'Reset', f_sort => 'Sort',
        f_count => 'spells shown', f_none => 'No spell matches these filters.',
        f_help => 'Click a column heading to sort by it.',
    },
    es => {
        title => 'Conjuros', lead => 'Todos los conjuros del juego y los escritos para Lex Arcanum',
        lex_h => 'Originales de Lex Arcanum', srd_h => 'System Reference Document 5.2.1',
        lex_p => 'Conjuros escritos para este suplemento. No existen en el '
               . '<i>Manual del Jugador</i>. El texto original est&aacute; en el '
               . '<a href="https://nivel20.com/games/dnd-2024/rulebooks/2638-lex-arcanum">manual de '
               . 'Lex Arcanum en Nivel20</a>.',
        srd_p => 'Los 339 conjuros del SRD&nbsp;5.2.1, con el formato de este sitio. '
               . 'Los conjuros que est&aacute;n en el <i>Manual del Jugador</i> pero no '
               . 'en el SRD no tienen p&aacute;gina aqu&iacute;: su texto no es nuestro.',
        cantrips => 'Trucos', lvl => 'Nivel',
        cols => [ 'Nombre', 'Nivel', 'Escuela', 'Clases', 'Tiempo de lanzamiento', 'Alcance', 'Duraci&oacute;n' ],
        f_search => 'Buscar por nombre', f_level => 'Cualquier nivel',
        f_school => 'Cualquier escuela', f_class => 'Cualquier clase',
        f_reset => 'Limpiar', f_sort => 'Ordenar',
        f_count => 'conjuros a la vista', f_none => 'Ning&uacute;n conjuro encaja con estos filtros.',
        f_help => 'Pulsa en una cabecera de columna para ordenar por ella.',
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
            slug => $f[0], level => $f[1], school => $f[2],
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

sub index_table {
    my ($lang, $rows, $id) = @_;
    my $i = $IDX{$lang};
    # las columnas ordenables llevan la clave por la que ordenan
    my @keys = ('name', 'level', 'school', 'classes', '', '', '');
    my $head = '';
    for my $n (0 .. $#{ $i->{cols} }) {
        my $k = $id ? ($keys[$n] // '') : '';
        $head .= $k
            ? qq{<th scope="col" data-sort="$k">$i->{cols}[$n]</th>}
            : qq{<th scope="col">$i->{cols}[$n]</th>};
    }
    my $tid = $id ? qq{ id="$id"} : '';
    return qq{<div class="tw">\n        <table class="spelltable"$tid>\n}
         . qq{          <thead>\n            <tr>$head</tr>\n          </thead>\n}
         . qq{          <tbody>\n} . join('', @$rows) . qq{          </tbody>\n}
         . qq{        </table>\n      </div>\n};
}

# Barra de filtros del indice. Va oculta hasta que js/spell-filter.js la activa:
# sin JavaScript la tabla sigue completa y ordenada por nivel.
sub filter_bar {
    my ($lang) = @_;
    my $i = $IDX{$lang};
    my $t = $T{$lang};

    my $levels = qq{<option value="">$i->{f_level}</option>};
    for my $l (0 .. 9) {
        my $label = $l == 0 ? $i->{cantrips} : "$i->{lvl} $l";
        $levels .= qq{<option value="$l">$label</option>};
    }
    my $schools = qq{<option value="">$i->{f_school}</option>};
    for my $s (sort keys %SCHOOL_ES) {
        my $label = ent_es($lang eq 'es' ? ucfirst $SCHOOL_ES{$s} : $s);
        $schools .= qq{<option value="@{[ lc $s ]}">$label</option>};
    }
    my $classes = qq{<option value="">$i->{f_class}</option>};
    for my $c (sort keys %CLASS_ES) {
        my $label = ent_es($lang eq 'es' ? ucfirst $CLASS_ES{$c} : $c);
        $classes .= qq{<option value="@{[ lc $c ]}">$label</option>};
    }

    return <<"HTML";
<div class="spellfilter" id="spellfilter" hidden>
        <label class="vh" for="sf-q">$i->{f_search}</label>
        <input type="search" id="sf-q" placeholder="$i->{f_search}&hellip;" autocomplete="off">
        <label class="vh" for="sf-level">$i->{f_level}</label>
        <select id="sf-level">$levels</select>
        <label class="vh" for="sf-school">$i->{f_school}</label>
        <select id="sf-school">$schools</select>
        <label class="vh" for="sf-class">$i->{f_class}</label>
        <select id="sf-class">$classes</select>
        <button type="button" id="sf-reset">$i->{f_reset}</button>
        <p class="sf-count" id="sf-count" role="status" data-label="$i->{f_count}"></p>
        <p class="sf-help">$i->{f_help}</p>
      </div>
      <p class="sf-empty" id="sf-empty" hidden>$i->{f_none}</p>

HTML
}

sub render_index {
    my ($lang) = @_;
    my $t = $T{$lang};
    my $i = $IDX{$lang};

    # tabla de los conjuros propios
    my @lexrows;
    for my $s (sort { $a->{level} <=> $b->{level} || $a->{name}{en} cmp $b->{name}{en} } read_lex()) {
        my $school = ent_es($lang eq "es" ? ucfirst $SCHOOL_ES{ $s->{school} } : $s->{school});
        my $lvl = $s->{level} == 0 ? $t->{cantrip} : "$t->{level} $s->{level}";
        push @lexrows, sprintf(
            qq{            <tr>\n}
          . qq{              <td>%s<a href="./%s.html">%s</a></td>\n}
          . qq{              <td class="lvl">%s</td>\n              <td>%s</td>\n}
          . qq{              <td>%s</td>\n              <td>%s</td>\n              <td>%s</td>\n}
          . qq{            </tr>\n},
            row_icon($s->{icon}), $s->{slug}, ent_es($s->{name}{$lang}), $lvl, $school,
            ent_es($s->{casting}{$lang}), ent_es($s->{range}{$lang}), ent_es($s->{duration}{$lang}));
    }
    # la tabla propia no va agrupada por nivel, asi que lleva columna de nivel
    # en lugar de la de clases
    my @lexcols = @{ $i->{cols} };
    $lexcols[2] = $i->{lvl};
    @lexcols = ( $lexcols[0], $lexcols[2], @lexcols[ 1, 3, 4, 5 ] );
    my $lexhead = join '', map { qq{<th scope="col">$_</th>} } @lexcols;
    my $lextable = qq{<div class="tw">\n        <table class="spelltable">\n}
        . qq{          <thead>\n            <tr>$lexhead</tr>\n          </thead>\n}
        . qq{          <tbody>\n} . join('', @lexrows) . qq{          </tbody>\n}
        . qq{        </table>\n      </div>\n};

    # una sola tabla con los 339, ordenable y filtrable desde js/spell-filter.js
    my @rows;
    for my $s (sort { $a->{level} <=> $b->{level} || $a->{name} cmp $b->{name} } @EN) {
        my $name   = $lang eq 'es' ? ($NAME_ES{ $s->{name} } // $s->{name}) : $s->{name};
        my $school = ent_es($lang eq "es" ? ucfirst $SCHOOL_ES{ $s->{school} } : $s->{school});
        my @cl_en  = classes_list($s, $lang);
        my @cl     = map { $lang eq 'es' ? ($CLASS_ES{$_} // $_) : $_ } @cl_en;
        my $lvltxt = $s->{level} == 0 ? $i->{cantrips} : "$i->{lvl} $s->{level}";
        # los data-* van en ingles: son claves, no texto visible
        push @rows, sprintf(
            qq{            <tr data-level="%d" data-school="%s" data-classes="%s" data-name="%s">\n}
          . qq{              <td>%s<a href="./%s.html">%s</a></td>\n}
          . qq{              <td class="lvl">%s</td>\n              <td>%s</td>\n}
          . qq{              <td>%s</td>\n              <td>%s</td>\n}
          . qq{              <td>%s</td>\n              <td>%s</td>\n}
          . qq{            </tr>\n},
            $s->{level}, lc $s->{school}, lc(join ',', @cl_en), lc plain($name),
            row_icon($ICON{ $s->{name} }), slug($s->{name}), ent_es($name),
            $lvltxt, $school, ent_es(join ', ', @cl),
            casting_html($s->{casting}, $lang,
                         $lang eq 'es' && $ES{ $s->{name} } ? $ES{ $s->{name} }{casting} : undef),
            range_text($s->{range}, $lang, $s),
            duration_html($s->{duration}, $lang));
    }
    my $srd = '      ' . filter_bar($lang) . '      ' . index_table($lang, \@rows, 'srdtable');

    my $file = 'index.html';
    my $out = head_block(lang => $lang, file => $file, title => $i->{title},
                         desc => plain($t->{subtitle}));
    $out .= qq{\n<body>\n  <div class="spellpage">\n\n};
    $out .= nav_block($lang, $file);
    $out .= <<"HTML";

    <header class="spellhead">
      <h1>$i->{title}</h1>
      <p class="spellkind">$i->{lead}</p>
    </header>

    <section>
      <h2>$i->{lex_h}</h2>
      <p>$i->{lex_p}</p>
      $lextable
    </section>

    <section>
      <h2>$i->{srd_h}</h2>
      <p>$i->{srd_p}</p>
$srd    </section>

HTML
    $out .= footer_block("spell-filter.js");
    return ($file, $out);
}

sub ent_es {
    my $s = h(shift // '');
    my %e = ('á'=>'&aacute;','é'=>'&eacute;','í'=>'&iacute;','ó'=>'&oacute;','ú'=>'&uacute;',
             'ñ'=>'&ntilde;','Á'=>'&Aacute;','É'=>'&Eacute;','Í'=>'&Iacute;','Ó'=>'&Oacute;',
             'Ú'=>'&Uacute;','Ñ'=>'&Ntilde;', "\x{2019}"=>'&rsquo;');
    $s =~ s/([\x{e1}\x{e9}\x{ed}\x{f3}\x{fa}\x{f1}\x{c1}\x{c9}\x{cd}\x{d3}\x{da}\x{d1}\x{2019}])/$e{$1}/g;
    return $s;
}

# --------------------------------------------------------------------- escribe

for my $lang (qw(en es)) {
    my $dir = "$ROOT/$lang/pages/spells";
    make_path($dir) unless -d $dir;
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
printf STDERR "%d conjuros x 2 idiomas, mas los dos indices\n", scalar(@EN);
