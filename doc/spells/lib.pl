# Utilidades compartidas por los scripts de doc/spells/.
# Se cargan con "require './lib.pl';" desde el propio directorio.
use strict;
use warnings;
use utf8;

# --- lectura del fichero de datos ------------------------------------------

sub read_spells {
    my ($path) = @_;
    open(my $fh, '<:encoding(UTF-8)', $path) or die "$path: $!";
    my (@out, $cur, $inbody);
    while (my $line = <$fh>) {
        $line =~ s/\r?\n$//;
        if ($line =~ /^== (.*)$/) {
            push @out, $cur if $cur;
            $cur = { name => $1, body => [] };
            $inbody = 0;
            next;
        }
        next unless $cur;
        if ($line eq 'body:') { $inbody = 1; next }
        if (!$inbody) {
            $cur->{$1} = $2 if $line =~ /^(\w+):\s*(.*)$/;
            next;
        }
        push @{ $cur->{body} }, $line if $line ne '';
    }
    push @out, $cur if $cur;
    close $fh;
    return @out;
}

# Los conjuros que traen una tabla salen del PDF como un parrafo aplastado. El
# fichero de arreglos dice, para cada uno, que parrafo sustituir y por que.
#
#   == Creation
#   match: Materials Material Vegetable matter
#   html:
#   <div class="tw">...</div>
#   text: Using a Higher-Level Spell Slot. ...
#
# Devuelve { "Creation" => [ { match => ..., parts => [ ["html",...], ["text",...] ] } ] }
sub read_fixes {
    my ($path) = @_;
    return () unless -e $path;
    open(my $fh, '<:encoding(UTF-8)', $path) or die "$path: $!";
    my (%fx, $spell, $block, $inhtml);
    while (my $line = <$fh>) {
        $line =~ s/\r?\n$//;
        if ($line =~ /^== (.*)$/) { $spell = $1; $block = undef; $inhtml = 0; next }
        if ($line =~ /^match:\s*(.*)$/) {
            $block = { match => $1, parts => [] };
            push @{ $fx{$spell} }, $block;
            $inhtml = 0;
            next;
        }
        next unless $block;
        if ($line eq 'html:') { push @{ $block->{parts} }, [ 'html', '' ]; $inhtml = 1; next }
        if ($line =~ /^text:\s*(.*)$/) { push @{ $block->{parts} }, [ 'text', $1 ]; $inhtml = 0; next }
        if ($inhtml) { $block->{parts}[-1][1] .= "$line\n" }
    }
    close $fh;
    return %fx;
}

sub read_map {
    my ($path) = @_;
    my %m;
    open(my $fh, '<:encoding(UTF-8)', $path) or die "$path: $!";
    while (<$fh>) {
        s/\r?\n$//;
        my ($k, $v) = split /\t/, $_, 2;
        $m{$k} = $v if defined $v;
    }
    close $fh;
    return %m;
}

# --- nombres de archivo ------------------------------------------------------

sub slug {
    my $s = lc shift;
    $s =~ s/[\x{2019}']//g;    # apostrofo tipografico y recto
    $s =~ s/[\/ ]+/-/g;
    $s =~ s/[^a-z0-9-]//g;
    return $s;
}

# --- escapado ----------------------------------------------------------------

sub h {
    my $s = shift // '';
    $s =~ s/&/&amp;/g;
    $s =~ s/</&lt;/g;
    $s =~ s/>/&gt;/g;
    $s =~ s/"/&quot;/g;
    return $s;
}

# Texto plano para atributos meta: sin etiquetas y sin comillas.
sub plain {
    my $s = shift // '';
    $s =~ s/<[^>]+>//g;
    $s =~ s/&nbsp;/ /g;
    $s =~ s/\s+/ /g;
    $s =~ s/^\s+|\s+$//g;
    return h($s);
}

# --- distancias --------------------------------------------------------------

# El manual pone siempre el metrico delante. En espanol coma decimal, en ingles
# punto: 1,5 m / 1.5 m.
my %FT2M = (
    5 => '1.5', 10 => '3', 15 => '4.5', 20 => '6', 25 => '7.5', 30 => '9',
    40 => '12', 50 => '15', 60 => '18', 90 => '27', 100 => '30', 120 => '36',
    150 => '45', 200 => '60', 300 => '90', 400 => '120', 500 => '150',
    1000 => '300',
);

sub feet_to_m {
    my ($ft, $lang) = @_;
    my $m = $FT2M{$ft};
    $m = sprintf('%.1f', $ft * 0.3) unless defined $m;
    $m =~ s/\.0$//;
    $m =~ s/\./,/ if $lang eq 'es';
    return $m;
}

sub miles_to_km {
    my ($mi, $lang) = @_;
    my $km = $mi * 1.5;
    $km = sprintf('%g', $km);
    $km =~ s/\./,/ if $lang eq 'es';
    return $km;
}

# Forma corta para la ficha lateral: "18 m / 60 ft".
sub dist_slash {
    my ($ft, $lang) = @_;
    return feet_to_m($ft, $lang) . ' m / ' . $ft . ' ft';
}

# Forma larga para el cuerpo del texto: "18 m (60 ft)", con espacio duro.
sub dist_paren {
    my ($ft, $lang) = @_;
    return feet_to_m($ft, $lang) . '&nbsp;m (' . $ft . '&nbsp;ft)';
}

1;

# --- nombre visible y nombre de archivo --------------------------------------
# La clave de todos los ficheros de datos es el nombre del SRD. Lo que se LEE, y
# con ello el nombre del archivo, puede ser otro: nombres-en.txt lo cambia
# (casi siempre para quitar una denotacion divina que este mundo no admite).

our %DISPLAY_EN;
our %DISPLAY_ES;

# El prefijo permite a --propuestas leer sus propios nombres sin pisar los del
# catalogo: load_names('propuestas/') lee propuestas/nombres-*.txt.
sub load_names {
    my ($pre) = @_;
    $pre //= '';
    %DISPLAY_EN = -e "${pre}nombres-en.txt" ? read_map("${pre}nombres-en.txt") : ();
    %DISPLAY_ES = -e "${pre}nombres-es.txt" ? read_map("${pre}nombres-es.txt") : ();
}

sub disp_name {
    my ($key, $lang) = @_;
    return $DISPLAY_ES{$key} // $DISPLAY_EN{$key} // $key if ($lang // '') eq 'es';
    return $DISPLAY_EN{$key} // $key;
}

sub spell_slug { my ($key) = @_; return slug($DISPLAY_EN{$key} // $key) }

1;
