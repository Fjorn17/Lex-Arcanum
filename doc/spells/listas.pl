#!/usr/bin/perl
# Repasa las listas de conjuros (<ul class="spells">) de la clase y las
# subclases en los dos arboles y deja cada <li> con:
#
#   - el nombre del SRD 5.2.1 en ingles y el del Manual del Jugador en espanol
#   - enlace a la pagina local del conjuro cuando el conjuro esta en el SRD
#   - el icono de bg3.wiki cuando existe
#   - la clase correcta: phb si es del manual, lex si es original del suplemento
#
# Los conjuros que estan en el Manual pero NO en el SRD se quedan sin enlace:
# no hay pagina que enlazar y su texto no se puede reproducir aqui.
#
#   perl listas.pl            # reescribe
#   perl listas.pl --dry      # solo informa
use strict;
use warnings;
use utf8;
use File::Basename qw(dirname);

BEGIN { chdir dirname($0) or die $! }
require './lib.pl';
binmode(STDOUT, ':encoding(UTF-8)');
my $DRY = grep { $_ eq '--dry' } @ARGV;

# ------------------------------------------------------------------- catalogos

my %NAME_ES = read_map('nombres-es.txt');
my %ICON    = read_map('iconos-bg3.txt');
my %ES2EN   = reverse %NAME_ES;

# Conjuros originales de Lex Arcanum: nombre visible -> fichero.
my %LEX = (
    'Arcane Thrust'      => 'arcane-thrust',      'Estocada arcana'     => 'arcane-thrust',
    'Bound Weapon'       => 'bound-weapon',       'Arma vinculada'      => 'bound-weapon',
    'Chains of Custody'  => 'chains-of-custody',  'Cadenas de custodia' => 'chains-of-custody',
    'Gravitational Pull' => 'gravitational-pull', 'Tirón gravitatorio'  => 'gravitational-pull',
    'Magic Armor'        => 'magic-armor',        'Armadura mágica'     => 'magic-armor',
    'Magic Contract'     => 'magic-contract',     'Contrato mágico'     => 'magic-contract',
    'Ravaging Cleave'    => 'ravaging-cleave',    'Hendidura arrasadora'=> 'ravaging-cleave',
);
my %LEX_NAME = (
    'arcane-thrust'      => [ 'Arcane Thrust',      'Estocada arcana' ],
    'bound-weapon'       => [ 'Bound Weapon',       'Arma vinculada' ],
    'chains-of-custody'  => [ 'Chains of Custody',  'Cadenas de custodia' ],
    'gravitational-pull' => [ 'Gravitational Pull', 'Tirón gravitatorio' ],
    'magic-armor'        => [ 'Magic Armor',        'Armadura mágica' ],
    'magic-contract'     => [ 'Magic Contract',     'Contrato mágico' ],
    'ravaging-cleave'    => [ 'Ravaging Cleave',    'Hendidura arrasadora' ],
);

# Conjuros del Manual del Jugador 2024 que el SRD 5.2.1 no incluye.
# Los conjuros del suplemento no estan en bg3.wiki: se les pone prestado el
# icono de la habilidad que mas se les parece, igual que ya hacian las paginas.
my %LEX_ICON = (
    'bound-weapon'    => 'https://bg3.wiki/w/images/2/24/Weapon_Bond_Icon.webp',
    'ravaging-cleave' => 'https://bg3.wiki/w/images/a/a8/Goading_Blast_Icon.webp',
);

my %PHB_ONLY = (
    'Arcane Vigor'       => 'Vigor arcano',
    'Blade Ward'         => 'Guardia de cuchillas',
    'Circle of Power'    => 'Círculo de poder',
    'Compelled Duel'     => 'Duelo forzado',
    'Elemental Weapon'   => 'Arma elemental',
    'Friends'            => 'Amistad',
    'Steel Wind Strike'  => 'Golpe de viento acerado',
);

# Nombres que estaban mal escritos en las paginas (calcos de Baldur's Gate 3 o
# traducciones que no son las del Manual del Jugador 2024).
my %ALIAS = (
    # ingles
    'Otiluke’s Resilient Sphere' => 'Resilient Sphere',
    'Enhance Leap'               => 'Jump',
    'Colour Spray'               => 'Color Spray',
    'Mage Armour'                => 'Mage Armor',
    # espanol
    'Toque electrizante'      => 'Shocking Grasp',
    'Guardia contra hojas'    => 'Blade Ward',
    'Golpe certero'           => 'True Strike',
    'escudo'                  => 'Shield',
    'Orden'                   => 'Command',
    'Comprensión idiomática'  => 'Comprehend Languages',
    'Escritura ilusoria'      => 'Illusory Script',
    'Difuminar'               => 'Blur',
    'Descerrajar'             => 'Knock',
    'Agrandar/Reducir'        => 'Enlarge/Reduce',
    'Imágenes múltiples'      => 'Mirror Image',
    'Premura'                 => 'Haste',
    'Parpadeo'                => 'Blink',
    'Antidetección'           => 'Nondetection',
    'Corcel fantasmal'        => 'Phantom Steed',
    'Lenguas'                 => 'Tongues',
    'Esfera resistente'       => 'Resilient Sphere',
    'Cofre secreto'           => 'Secret Chest',
    'Atravesar muros'         => 'Passwall',
    'Atadura planaria'        => 'Planar Binding',
    'Duelo forzoso'           => 'Compelled Duel',
    'Golpe de viento de acero'=> 'Steel Wind Strike',
    'Guardia de cuchillas'    => 'Blade Ward',
    'Amistad'                 => 'Friends',
    'Vigor arcano'            => 'Arcane Vigor',
    'Arma elemental'          => 'Elemental Weapon',
    'Círculo de poder'        => 'Circle of Power',
    'Duelo forzado'           => 'Compelled Duel',
    'Golpe de viento acerado' => 'Steel Wind Strike',
);

my %ISSRD = map { $_->{name} => 1 } read_spells('srd-en.txt');

# ------------------------------------------------------------------ utilidades

my %ENT = ('á'=>'&aacute;','é'=>'&eacute;','í'=>'&iacute;','ó'=>'&oacute;',
           'ú'=>'&uacute;','ñ'=>'&ntilde;','Á'=>'&Aacute;','É'=>'&Eacute;',
           'Í'=>'&Iacute;','Ó'=>'&Oacute;','Ú'=>'&Uacute;','Ñ'=>'&Ntilde;',
           "\x{2019}"=>'&rsquo;');
sub ent { my $s = shift; $s =~ s/([\x{e1}\x{e9}\x{ed}\x{f3}\x{fa}\x{f1}\x{c1}\x{c9}\x{cd}\x{d3}\x{da}\x{d1}\x{2019}])/$ENT{$1}/g; return $s }

sub visible {
    my $in = shift;
    $in =~ s/<[^>]*>//gs;
    my %rev = reverse %ENT;
    $in =~ s/(&\w+;)/exists $rev{$1} ? $rev{$1} : $1/ge;
    $in =~ s/&nbsp;/ /g;
    $in =~ s/\s+/ /g;
    $in =~ s/^\s+|\s+$//g;
    return $in;
}

# ---------------------------------------------------------------------- arregla

my @FILES = (
    [ 'en', '../../en/pages/classes/magister.html',        '../spells' ],
    [ 'es', '../../es/pages/classes/magister.html',        '../spells' ],
    [ 'en', '../../en/pages/subclasses/forgeknight.html',  '../spells' ],
    [ 'es', '../../es/pages/subclasses/forgeknight.html',  '../spells' ],
    [ 'en', '../../en/pages/subclasses/threadmarshal.html','../spells' ],
    [ 'es', '../../es/pages/subclasses/threadmarshal.html','../spells' ],
    [ 'en', '../../en/pages/subclasses/legacy/gematurge.html', '../../spells' ],
    [ 'es', '../../es/pages/subclasses/legacy/gematurge.html', '../../spells' ],
);

my (%unknown, $changed, $total);
for my $f (@FILES) {
    my ($lang, $path, $rel) = @$f;
    next unless -e $path;
    open(my $fh, '<:encoding(UTF-8)', $path) or die "$path: $!";
    local $/; my $html = <$fh>; close $fh;

    my $before = $html;
    $html =~ s{<li class="(?:phb|lex)">(.*?)</li>}{ rewrite($1, $lang, $rel) }ges;

    if ($html ne $before) {
        $changed++;
        unless ($DRY) {
            open(my $out, '>:encoding(UTF-8)', $path) or die "$path: $!";
            print $out $html;
            close $out;
        }
    }
    print "$path\n";
}
for my $u (sort keys %unknown) { print "  sin identificar: $u\n" }
printf "%d entradas, %d ficheros tocados%s\n", $total, $changed, ($DRY ? ' (simulacro)' : '');

sub rewrite {
    my ($inner, $lang, $rel) = @_;
    my $name = visible($inner);
    $total++;

    # las plantillas llevan huecos ([Spell 1]): se dejan como estan
    return qq{<li class="phb">$inner</li>} if $name =~ /^\[/;

    # conjuro original del suplemento
    if (my $slug = $LEX{$name}) {
        my $label = $LEX_NAME{$slug}[ $lang eq 'es' ? 1 : 0 ];
        my $ic    = $LEX_ICON{$slug}
                  ? qq{<img class="ic" width="20" src="$LEX_ICON{$slug}" alt="">}
                  : '';
        return qq{<li class="lex">$ic<a href="$rel/$slug.html">@{[ ent($label) ]}</a></li>};
    }

    # nombre canonico en ingles
    my $key = $ALIAS{$name} // ($ES2EN{$name} || $name);

    if ($ISSRD{$key}) {
        my $label = $lang eq 'es' ? ($NAME_ES{$key} // $key) : $key;
        my $ic    = $ICON{$key}
                  ? qq{<img class="ic" width="20" src="$ICON{$key}" alt="">}
                  : '';
        return qq{<li class="phb">$ic<a href="$rel/@{[ slug($key) ]}.html">@{[ ent($label) ]}</a></li>};
    }

    if (my $es = $PHB_ONLY{$key}) {
        my $label = $lang eq 'es' ? $es : $key;
        return qq{<li class="phb">@{[ ent($label) ]}</li>};
    }

    $unknown{"$lang: $name"}++;
    return qq{<li class="phb">$inner</li>};
}
