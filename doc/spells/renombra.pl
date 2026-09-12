use strict; use warnings; use utf8;
binmode(STDOUT, ':encoding(UTF-8)');

# Renombra conjuros en un juego de ficheros: la clave "== Nombre", las tres
# tablas y las notas. Uso:
#     perl renombra.pl                 el catalogo
#     perl renombra.pl --propuestas
my $PROP = grep { $_ eq '--propuestas' } @ARGV;
my $PRE  = $PROP ? 'propuestas/' : '';

# clave vieja => [clave nueva, nombre espanol nuevo]
my %CAT = (
    'Polar Ray' => [ 'Ice Awl', "Punz\x{f3}n de hielo" ],
);
my %PRO = (
    # el elemento cambiaba, y con el el nombre
    'Frostbite'          => [ 'Hoarfrost',     'Escarcha' ],
    'Ice Cage'           => [ 'Ice Snare',     'Cepo de hielo' ],
    'Ice Lance'          => [ 'Hard Frost',    'Helada' ],
    'Vitriol Veil'       => [ 'Acid Dew',      "Roc\x{ed}o \x{e1}cido" ],
    'Pitch Ball'         => [ 'Clod',          'Pella' ],
    # nombres fuera de registro
    'Corrosive Touch'    => [ 'The Bite',      'Mordedura' ],
    'Lightning Arc'      => [ 'Spark',         'Chispazo' ],
    'Charged Skin'       => [ 'Charge on the Skin', 'Carga en la piel' ],
    'Wall of Sound'      => [ 'Wall of Resonance',  'Muro de resonancia' ],
    'Piercing Shriek'    => [ 'Shriek',        'Chillido' ],
    'Scouring Wind'      => [ 'Abrasion',      'Lija' ],
    'Ash Storm'          => [ 'Ash Cloud',     'Nube de ceniza' ],
    'Cinder Rain'        => [ 'Embers',        'Rescoldo' ],
    'Shrapnel'           => [ 'Iron Hail',     'Granizo de hierro' ],
    'White Brand'        => [ 'White Iron',    'Hierro al blanco' ],
    'Incandescent Lance' => [ 'Red Thread',    'Hilo al rojo' ],
    'Steel Thread'       => [ 'Steel Weave',   'Trama de acero' ],
);
my %R = $PROP ? %PRO : %CAT;

sub slug { my $s = lc shift; $s =~ s/[^a-z0-9]+/-/g; $s =~ s/^-|-$//g; return $s }

sub edit {
    my ($f, $cb) = @_;
    return unless -e $f;
    open(my $h, '<:encoding(UTF-8)', $f) or die "$f: $!";
    my @l = <$h>; close $h;
    my $crlf = (grep { /\r\n/ } @l) ? 1 : 0;
    my $n = 0;
    for (@l) { $n += $cb->($_) }
    if ($crlf) { s/\r?\n$/\r\n/ for @l }
    open($h, '>:encoding(UTF-8)', $f) or die $!; print $h @l; close $h;
    printf "  %-34s %d\n", $f, $n if $n;
}

# la clave en las fuentes de texto
for my $f ("${PRE}srd-en.txt", glob("${PRE}es/*.txt")) {
    edit($f, sub {
        my $l = \$_[0];
        return 0 unless $$l =~ /^== (.+?)\r?\n?$/;
        my $old = $1; $old =~ s/\s+$//;
        return 0 unless $R{$old};
        $$l = "== $R{$old}[0]\n";
        return 1;
    });
}

# las tablas de nombre <TAB> valor
for my $f ("${PRE}disciplinas.txt", "${PRE}subdisciplinas.txt", "${PRE}nombres-es.txt",
           "${PRE}nombres-en.txt", "${PRE}cruces.txt", "${PRE}descatalogados.txt",
           "${PRE}magister.txt") {
    edit($f, sub {
        my $l = \$_[0];
        return 0 if $$l =~ /^#/ || $$l !~ /\S/;
        my ($n, $rest) = split /\t/, $$l, 2;
        $n =~ s/\r?\n$//;
        return 0 unless $R{$n};
        if ($f =~ /nombres-es/) { $$l = "$R{$n}[0]\t$R{$n}[1]\n" }
        else { $rest //= "\n"; $$l = "$R{$n}[0]\t$rest" }
        return 1;
    });
}

# las notas, que van por slug
edit("${PRE}notas.txt", sub {
    my $l = \$_[0];
    return 0 if $$l =~ /^#/ || $$l !~ /\S/;
    my ($s, $rest) = split /\t/, $$l, 2;
    for my $old (keys %R) {
        next unless slug($old) eq $s;
        $$l = slug($R{$old}[0]) . "\t$rest";
        return 1;
    }
    return 0;
});

printf "%d conjuros renombrados\n", scalar keys %R;
