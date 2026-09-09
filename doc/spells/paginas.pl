# Cabecera, navegacion y pie compartidos por los generadores del sitio.
# Lo usan build-pages.pl (los conjuros) y build-disciplines.pl (las Disciplinas).
#
#   $up   prefijo relativo hasta la raiz del sitio: '../../../'
#   $path ruta dentro del arbol de idioma: 'pages/spells/fireball.html'
#
# El arbol ingles y el espanol son espejo ruta por ruta, asi que el selector de
# idioma es la misma ruta con en/ cambiado por es/.

use strict;
use warnings;
use utf8;

our $BASE = 'https://fjorn17.github.io/Lex-Arcanum';

# de '../../../' a '../../': la raiz del idioma esta un nivel por debajo
sub lang_up { my ($up) = @_; $up =~ s{^\.\./}{}; return $up }

sub page_head {
    my (%a) = @_;
    my $u = "$a{lang}/$a{path}";
    my $up = $a{up};
    return <<"HTML";
<!doctype html>
<html lang="$a{lang}">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$a{title} &middot; Lex Arcanum</title>
  <meta name="description" content="$a{desc}">
  <link rel="canonical" href="$BASE/$u">
  <link rel="alternate" hreflang="es" href="$BASE/es/$a{path}">
  <link rel="alternate" hreflang="en" href="$BASE/en/$a{path}">
  <link rel="alternate" hreflang="x-default" href="$BASE/en/$a{path}">
  <link rel="icon" href="${up}assets/img/magister_icon_simplified.png">
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
  <link rel="stylesheet" href="${up}css/style.css">
</head>
HTML
}

# Astronomia es una sola entrada porque es una sola cosa: el arte entero, sus
# Disciplinas y los conjuros que salen de ellas viven bajo pages/astronomy/.
our @NAV_ITEMS = (
    [ 'magister',   'pages/classes/magister.html',  'Magister',   'Magistrado'   ],
    [ 'subclasses', 'pages/subclasses/index.html',  'Subclasses', 'Subclases'    ],
    [ 'astronomy',  'pages/astronomy/index.html',   'Astronomy',  'Astronom&iacute;a' ],
    [ 'items',      'pages/items/index.html',       'Items',      'Objetos'      ],
    [ 'craft',      'pages/craft/index.html',       'Crafting',   'Artesan&iacute;a' ],
);

sub page_nav {
    my (%a) = @_;
    my $up   = $a{up};
    my $lup  = lang_up($up);
    my $es_cur = $a{lang} eq 'es' ? ' aria-current="true"' : '';
    my $en_cur = $a{lang} eq 'en' ? ' aria-current="true"' : '';
    my $out = qq{    <nav class="sitenav" aria-label="Site">\n}
            . qq{      <a class="brand" href="${lup}index.html">Lex Arcanum</a>\n};
    for my $n (@NAV_ITEMS) {
        my ($key, $href, $en, $es) = @$n;
        my $label = $a{lang} eq 'es' ? $es : $en;
        $out .= $key eq ($a{section} // '')
            ? qq{      <a class="here" aria-current="page" href="$lup$href">$label</a>\n}
            : qq{      <a href="$lup$href">$label</a>\n};
    }
    $out .= qq{      <span class="langsw">\n}
          . qq{        <a class="lang-es"$es_cur hreflang="es" href="${up}es/$a{path}" title="Ver esta p&aacute;gina en espa&ntilde;ol"><span class="vh">Espa&ntilde;ol</span></a>\n}
          . qq{        <a class="lang-en"$en_cur hreflang="en" href="${up}en/$a{path}" title="View this page in English"><span class="vh">English</span></a>\n}
          . qq{      </span>\n    </nav>\n};
    return $out;
}

# El aviso del SRD es obligatorio: la licencia CC BY exige la atribucion aunque
# el sitio ya no distinga entre conjuros propios y conjuros importados.
sub page_foot {
    my (%a) = @_;
    my $up = $a{up};
    my $more = '';
    $more .= qq{  <script src="${up}js/$_"></script>\n} for @{ $a{scripts} || [] };
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
      <p class="legal"><a class="backstage" href="${up}analysis/index.html">&middot; an&aacute;lisis &middot;</a></p>
    </footer>

    <script src="${up}js/lang.js"></script>
  </div>
HTML
}

1;
