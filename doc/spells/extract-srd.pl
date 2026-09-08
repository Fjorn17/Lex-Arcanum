#!/usr/bin/perl
# Lee el volcado de texto del SRD 5.2.1 (paginas 107-175; una llamada a pdftotext
# por pagina, porque en una sola llamada se pierden los titulos que caen al
# principio de pagina) y escribe el fichero de datos srd-en.txt.
#
#   for p in $(seq 107 175); do
#     pdftotext -enc UTF-8 -f $p -l $p "SRD_CC_v5.2.1.pdf" - \
#       | perl -ne 'next if /^\s*$/; next if /^\d+\s+System Reference Document/; print'
#   done > srd-pages.txt
#
# Formato de salida: un registro por conjuro, campos "clave: valor" y luego el
# cuerpo, un parrafo por linea, hasta el siguiente "== ".
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':encoding(UTF-8)');

my $src = shift // 'srd-pages.txt';
open(my $fh, '<:encoding(UTF-8)', $src) or die "$src: $!";
my @L = grep { !/^\s*$/ } map { my $x = $_; chomp $x; $x =~ s/\r//g; $x } <$fh>;
close $fh;

my $SCH = qr/Abjuration|Conjuration|Divination|Enchantment|Evocation|Illusion|Necromancy|Transmutation/;
my $HDR = qr/^(?:Level ([1-9]) )?($SCH)( Cantrip)? \((.+)\)$/;

my @idx = grep { $L[$_] =~ $HDR } 0 .. $#L;
die "esperaba 339 conjuros, encontrados " . scalar(@idx) . "\n" unless @idx == 339;

for my $k (0 .. $#idx) {
    my $i    = $idx[$k];
    my $name = $L[ $i - 1 ];
    $L[$i] =~ $HDR;
    my ($lvl, $school, $cantrip, $classes) = ($1, $2, $3, $4);
    $lvl = 0 if $cantrip;

    my $end  = ($k < $#idx) ? $idx[ $k + 1 ] - 1 : scalar(@L);
    my @body = @L[ $i + 1 .. $end - 1 ];
    # Los componentes largos parten la cabecera en varias lineas: se van
    # uniendo hasta que aparece la duracion.
    my $meta = shift @body;
    $meta .= ' ' . shift @body while @body && $meta !~ /Duration:/;

    $meta =~ /^Casting Time:\s*(.*?)\s+Range:\s*(.*?)\s+Components?:\s*(.*?)\s+Duration:\s*(.*)$/
        or die "cabecera rara en $name: $meta\n";

    print "== $name\n";
    print "level: $lvl\n";
    print "school: $school\n";
    print "classes: $classes\n";
    print "casting: $1\n";
    print "range: $2\n";
    print "components: $3\n";
    print "duration: $4\n";
    # Un parrafo partido por un salto de pagina llega como dos lineas: se unen
    # cuando la segunda empieza en minuscula o la primera no cierra la frase.
    my @join;
    for my $p (@body) {
        if (@join && ($p =~ /^[a-z\x{2014}(]/ || $join[-1] !~ /[.!?:"\x{201d}]$/)) {
            $join[-1] .= " $p";
        } else {
            push @join, $p;
        }
    }

    print "body:\n";
    print "$_\n" for @join;
    print "\n";
}
