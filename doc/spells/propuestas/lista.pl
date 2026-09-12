use strict; use warnings; use utf8;
binmode(STDOUT, ':encoding(UTF-8)');
# Emite los candidatos como un array de JavaScript para la pagina de decisiones,
# y como lista md para doc/propuestas/README.md con --md.
my $MD = grep { $_ eq '--md' } @ARGV;

my %NOTE;
{
    open(my $h, '<:encoding(UTF-8)', 'propuestas/notas.txt') or die $!;
    while (<$h>) { s/\r?\n$//; next if /^#/ || !/\S/; my ($a, $b) = split /\t/; $NOTE{$a} = $b }
    close $h;
}

my %DN = (Astronomy => "Astronom\x{ed}a", Alchemy => 'Alquimia',
          Cosmology => "Cosmolog\x{ed}a", Spiritism => 'Espiritismo');
my %SN = (acid => "\x{c1}cido", ash => 'Ceniza', lava => 'Lava', lightning => 'Rayo',
          metal => 'Metal', mist => 'Bruma', mud => 'Fango', sand => 'Arena',
          thunder => 'Estruendo', water => 'Agua', steam => 'Vapor',
          incandescence => 'Incandescencia', time => 'Tiempo', space => 'Espacio',
          gravity => 'Gravedad', senses => 'Sentidos', memory => 'Memoria',
          mood => "\x{c1}nimo", subjection => "Sujeci\x{f3}n", illusion => 'Ilusiones',
          fungi => 'Hongos', animals => 'Animales', plants => 'Plantas',
          life => 'Vida', death => 'Muerte');

open(my $h, '<:encoding(UTF-8)', '/tmp/prop.tsv') or die $!;
my @r; while (<$h>) { chomp; push @r, [ split /\t/ ] } close $h;

sub j { my $s = shift // ''; $s =~ s/\\/\\\\/g; $s =~ s/"/\\"/g; return $s }

if ($MD) {
    my $last = '';
    for my $x (@r) {
        my ($en, $es, $lv, $d, $s, $slug, $dur) = @$x;
        my $branch = $DN{$d} . ($s ne '-' ? " \x{203a} " . ($SN{$s} // $s) : '');
        if ($branch ne $last) { print "\n### $branch\n\n"; $last = $branch }
        my $n = $lv == 0 ? 'truco' : "nivel $lv";
        my $conc = $dur =~ /Concentration/ ? " \x{b7} concentraci\x{f3}n" : '';
        printf "- [ ] **%s** \x{b7} %s%s \x{2014} %s  \n      *%s* \x{b7} [ficha en ingl\x{e9}s](en/%s.html) \x{b7} [en espa\x{f1}ol](es/%s.html)\n",
            $es, $n, $conc, $NOTE{$slug} // '', $en, $slug, $slug;
    }
} else {
    print "const CANDIDATOS = [\n";
    for my $x (@r) {
        my ($en, $es, $lv, $d, $s, $slug, $dur) = @$x;
        my $branch = $DN{$d} . ($s ne '-' ? " \x{203a} " . ($SN{$s} // $s) : '');
        printf qq{  { s: "%s", n: "%s", e: "%s", l: %s, b: "%s", c: %s, t: "%s" },\n},
            j($slug), j($es), j($en), $lv, j($branch),
            ($dur =~ /Concentration/ ? 'true' : 'false'), j($NOTE{$slug});
    }
    print "];\n";
}
printf STDERR "%d candidatos\n", scalar @r;
