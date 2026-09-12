# Comprueba que los conjuros de alquimia estan en el elemento que les toca,
# contrastando el tipo de dano que hacen con la tabla de elementos de
# taxonomia.pl. Se ejecuta desde doc/spells/:
#
#     perl elementos.pl            el catalogo
#     perl elementos.pl --propuestas
#
# El hielo es una Estrella de BRUMA (agua + aire), no de Agua: lo dice el
# propio nodo. El acido es un elemento propio (agua + rayo) y se queda todo lo
# que muerde y lo que sigue trabajando solo, incluidos el veneno y la
# enfermedad que NO son cosa de tejido vivo. Esas dos son las que mas veces se
# han colocado mal.

use strict;
use warnings;
use utf8;
binmode(STDOUT, ':encoding(UTF-8)');

my $PROP = grep { $_ eq '--propuestas' } @ARGV;
my $PRE  = $PROP ? 'propuestas/' : '';

# tipo de dano => elementos en los que ese dano tiene sentido
my %ESPERA = (
    Cold      => [qw(mist air)],             # hielo es Bruma; el frio seco, Aire.
    Fire      => [qw(fire lava incandescence steam ash)],
    Acid      => [qw(acid)],
    Lightning => [qw(lightning metal thunder)],
    Thunder   => [qw(thunder air)],
    Poison    => [qw(acid fungi plants animals)],
    Slashing  => [qw(sand metal air ice)],
    Piercing  => [qw(metal earth sand plants)],
);

my %SUB;
{
    open(my $h, '<:encoding(UTF-8)', "${PRE}subdisciplinas.txt") or die $!;
    while (<$h>) { s/\r?\n$//; next if /^#/ || !/\S/; my ($n, $s) = split /\t/; $SUB{$n} = $s }
    close $h;
}
my %DISC;
{
    open(my $h, '<:encoding(UTF-8)', "${PRE}disciplinas.txt") or die $!;
    while (<$h>) { s/\r?\n$//; next if /^#/ || !/\S/; my ($n, $d) = split /\t/; $DISC{$n} = $d }
    close $h;
}

open(my $h, '<:encoding(UTF-8)', "${PRE}srd-en.txt") or die $!;
my (@S, $cur);
while (<$h>) {
    s/\r?\n$//;
    if (/^== (.+)/) { push @S, $cur if $cur; $cur = { name => $1, body => '' }; next }
    next unless $cur;
    next if /^(level|school|classes|casting|range|components|duration):/ || /^body:$/;
    $cur->{body} .= "$_\n";
}
push @S, $cur if $cur;
close $h;

my $malos = 0;
for my $s (@S) {
    my $sub = $SUB{ $s->{name} } // '';
    next unless $sub && $sub ne '-';
    next unless lc($DISC{ $s->{name} } // '') eq 'alchemy';

    my %tipos;
    $tipos{$1}++ while $s->{body} =~ /\b\d+d\d+\s+(Acid|Cold|Fire|Lightning|Poison|Thunder|Slashing|Piercing)\b/g;
    next unless %tipos;

    # el tipo que mas veces aparece es el que manda
    my ($principal) = sort { $tipos{$b} <=> $tipos{$a} || $a cmp $b } keys %tipos;
    my $ok = $ESPERA{$principal} or next;
    next if grep { $_ eq $sub } @$ok;

    printf "  %-26s %-10s hace %-9s y deberia estar en: %s\n",
        $s->{name}, $sub, $principal, join(', ', @$ok);
    $malos++;
}
print $malos ? "\n$malos conjuros en el elemento equivocado\n" : "  todos los elementos cuadran\n";
