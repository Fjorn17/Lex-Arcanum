#!/usr/bin/perl
# Genera las paginas de Disciplina dentro de en/pages/astronomy/ y su espejo
# espanol: una por Disciplina y una por cada subdisciplina, con su doctrina, su
# catalogo de Estrellas y los conjuros que le corresponden.
#
# El indice de esa carpeta NO lo escribe este script: lo escribe build-pages.pl,
# porque en la misma pagina van el arbol de Disciplinas y la tabla de conjuros.
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
        all_spells => 'Every spell, in one table',
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
        all_spells => 'Todos los conjuros, en una tabla',
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

# Los conjuros de un nodo. Una Disciplina lista los suyos que no bajan a
# ninguna subdivision; Astronomia lista todos los suyos, porque no tiene.
sub spells_of {
    my ($node) = @_;
    my $k = $node->{key};
    return grep { $_->{unc} } @SPELLS if $node->{kind} eq 'limbo';
    my $disc_of_sub = $node->{kind} eq 'sub' ? $node->{parent} : undef;
    my @s = grep {
        $_->{unc} ? 0
        : $node->{kind} eq 'sub'
            ? (lc($_->{disc}) eq $disc_of_sub && $_->{sub} eq $k)
            : (lc($_->{disc}) eq $k && ($_->{sub} eq '' || $_->{sub} eq '-'))
    } @SPELLS;
    return sort { $a->{level} <=> $b->{level} || $a->{name}{en} cmp $b->{name}{en} } @s;
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
    $n += spell_count($_) for children($node->{key});
    return $n;
}

# --------------------------------------------------------------------- trozos

sub crumb {
    my ($node, $lang) = @_;
    my @up;
    my $p = $node->{parent};
    while ($p) { unshift @up, $NODE{$p}; $p = $NODE{$p}{parent} }
    return '' unless @up;
    return join(' &rsaquo; ', (map { qq{<a href="./$_->{key}.html">} . nm($_, $lang) . '</a>' } @up),
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
        $out .= qq{            <li><b><a href="./$c->{key}.html">} . nm($c, $lang)
              . qq{</a></b> &mdash; $c->{lead}{$lang}. <i>$n $word</i></li>\n};
    }
    return $out . qq{          </ul>\n};
}

# ------------------------------------------------------------------ la pagina

sub render_node {
    my ($node, $lang) = @_;
    my $t = $T{$lang};
    my $file = "$node->{key}.html";
    my $path = "pages/astronomy/$file";

    my $body = join "\n          ", @{ $node->{body}{$lang} };
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

    <div class="spellbody">
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
    $out .= page_foot(up => $UP, scripts => []);
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
