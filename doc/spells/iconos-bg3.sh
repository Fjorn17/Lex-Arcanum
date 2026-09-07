#!/bin/sh
# Pregunta a la API de bg3.wiki por el icono de cada conjuro del SRD y deja el
# resultado en iconos-bg3.txt (nombre SRD <TAB> URL). Los conjuros que no estan
# en Baldur's Gate 3 no tienen icono y no aparecen en el fichero.
#
# Se prueban varios nombres de archivo por conjuro, porque bg3.wiki usa la
# ortografia britanica (Colour, Armour) y conserva los nombres propios que el
# SRD quito (Melf, Tenser, Otiluke...). Las consultas van de 40 en 40.
set -e
cd "$(dirname "$0")"

cut -f1 nombres-es.txt | sed "s/[’']//g; s|/| |g; s/  */_/g" | sort -u > /tmp/icon-bases.txt

: > /tmp/icon-urls.txt
split -l 40 /tmp/icon-bases.txt /tmp/icon-chunk-
for chunk in /tmp/icon-chunk-*; do
  for ext in webp png; do
    titles=$(sed "s/\$/_Icon.$ext/" "$chunk" | paste -sd'|' -)
    curl -s -G "https://bg3.wiki/w/api.php" \
      --data-urlencode "action=query" \
      --data-urlencode "titles=File:$(printf '%s' "$titles" | sed 's/|/|File:/g')" \
      --data-urlencode "prop=imageinfo" \
      --data-urlencode "iiprop=url" \
      --data-urlencode "format=json" \
      | tr ',' '\n' | grep -o '"url":"[^"]*"' | sed 's/"url":"//; s/"$//' \
      >> /tmp/icon-urls.txt
  done
done
rm -f /tmp/icon-chunk-*

# Cruza las URL encontradas con el nombre SRD del que salieron.
cut -f1 nombres-es.txt | while IFS= read -r name; do
  base=$(printf '%s' "$name" | sed "s/[’']//g; s|/| |g; s/  */_/g")
  url=$(grep -i -m1 "/${base}_Icon\.\(webp\|png\)\$" /tmp/icon-urls.txt || true)
  [ -n "$url" ] && printf '%s\t%s\n' "$name" "$url"
done > iconos-bg3.txt

wc -l < iconos-bg3.txt
