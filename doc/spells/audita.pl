# Pasa el catalogo por el filtro de pages/astronomy/rules.html y por sus propios
# numeros. Se ejecuta desde doc/spells/:
#
#     perl audita.pl
#
# Tres avisos son falsos positivos conocidos y estan revisados:
#
#   Modify Memory   "permanently eliminate" es un cambio instantaneo al recuerdo
#                   del propio cuerpo, no Eter sostenido. Cumple.
#   Floating Disk   "plane of force" es geometria, no un plano de existencia.
#   Glyph of Warding  la frase que salta es una condicional sobre el conjuro
#                   almacenado ("si el conjuro invoca..."), no algo que haga el.
#

use strict; use warnings; use utf8;
binmode(STDOUT, ':encoding(UTF-8)');
# Pasa el catalogo por el filtro de la pagina de reglas y por sus propios numeros.

my %TECHO = (0=>6.5, 1=>14, 2=>13.5, 3=>28, 4=>36, 5=>49.5, 6=>49, 7=>55, 8=>65, 9=>78);
my %MED   = (0=>4.5, 1=>9,  2=>7,    3=>16.5,4=>14, 5=>22.5,6=>33, 7=>39, 8=>42, 9=>27.5);

my %UNC;
open(my $h,'<:encoding(UTF-8)','descatalogados.txt') or die $!;
while (<$h>) { s/\r?\n$//; next if /^#|^\s*$/; my ($n) = split /\t/; $UNC{$n}=1 } close $h;

open($h,'<:encoding(UTF-8)','srd-en.txt') or die $!;
my (@S,$cur);
while (<$h>) { s/\r?\n$//;
  if (/^== (.+)/) { push @S,$cur if $cur; $cur={name=>$1,body=>''}; next }
  next unless $cur;
  if (/^(level|school|classes|casting|range|components|duration):\s*(.*)/) { $cur->{$1}=$2; next }
  next if /^body:$/;
  $cur->{body} .= "$_\n";
}
push @S,$cur if $cur; close $h;

my (@dmg, @perm, @plane, @conj, @res, @div);
for my $s (@S) {
    next if $UNC{ $s->{name} };
    my $lv = $s->{level};
    # --- numeros
    my $max = 0; my $which='';
    while ($s->{body} =~ /(\d+)d(\d+)\s+(?:Acid|Cold|Fire|Force|Lightning|Necrotic|Poison|Psychic|Radiant|Thunder|Bludgeoning|Piercing|Slashing)/g) {
        my $avg = $1 * ($2+1)/2;
        if ($avg > $max) { $max = $avg; $which = "$1d$2" }
    }
    push @dmg, [ $s->{name}, $lv, $which, $max ] if $max > $TECHO{$lv} * 1.05;

    # --- el filtro
    push @perm,  $s->{name} if $s->{body} =~ /becomes permanent|permanent(?:ly)?(?! and cumulative)|until dispelled/i
                            && ($s->{duration}//'') !~ /^Instantaneous/;
    push @plane, $s->{name} if $s->{body} =~ /\b(?:plane|demiplane|Astral|Ethereal Plane|extradimensional)\b/i;
    push @conj,  $s->{name} if $s->{body} =~ /\byou (?:summon|conjure)\b|\bsummons?\b|\bcreature appears\b/i;
    push @res,   $s->{name} if $s->{body} =~ /\breturns? to life\b|\bresurrect/i;
    push @div,   $s->{name} if $s->{body} =~ /\bfuture\b|\bomen\b|\bportent/i;
}

print "=== dano por encima del techo de su nivel ===\n";
printf "  %-26s n%-2s %-7s %.1f (techo %.1f, mediana %.1f)\n", @$_[0,1,2,3], $TECHO{$_->[1]}, $MED{$_->[1]} for
    sort { $b->[3]/$TECHO{$b->[1]} <=> $a->[3]/$TECHO{$a->[1]} } @dmg;
print "  (ninguno)\n" unless @dmg;

for my $p ([\@perm,'regla 6: dura solo'], [\@plane,'regla 3: otro sitio'],
           [\@conj,'regla 2: invoca'], [\@res,'regla 4: deshace una muerte'],
           [\@div,'regla 5: lee el futuro']) {
    my ($list, $t) = @$p;
    print "\n=== $t ===\n";
    print "  $_\n" for @$list;
    print "  (ninguno)\n" unless @$list;
}
