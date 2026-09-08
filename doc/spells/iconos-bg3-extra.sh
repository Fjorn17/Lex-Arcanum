#!/bin/sh
# Segunda pasada de iconos-bg3.sh: para los conjuros que no encontraron icono
# con el nombre del SRD, prueba las variantes que usa bg3.wiki.
#   - ortografia britanica (Armor -> Armour, Favor -> Favour)
#   - apostrofo real en vez de quitado (Hunter's Mark)
#   - sufijos de desambiguacion (_spell_Icon, _(spell)_Icon)
#   - el nombre propio de Wizards que el SRD quito (Evard, Tasha, Otiluke...)
set -e
cd "$(dirname "$0")"

# nombre SRD | nombre de archivo alternativo (sin _Icon.ext)
cat > /tmp/icon-alias.txt <<'ALIAS'
Mage Armor	Mage_Armour
Divine Favor	Divine_Favour
Hunter’s Mark	Hunter's_Mark
Heroes’ Feast	Heroes'_Feast
Dragon’s Breath	Dragon's_Breath
Arcanist’s Magic Aura	Nystul's_Magic_Aura
Acid Arrow	Melf's_Acid_Arrow
Black Tentacles	Evard's_Black_Tentacles
Hideous Laughter	Tasha's_Hideous_Laughter
Irresistible Dance	Otto's_Irresistible_Dance
Resilient Sphere	Otiluke's_Resilient_Sphere
Freezing Sphere	Otiluke's_Freezing_Sphere
Faithful Hound	Mordenkainen's_Faithful_Hound
Magnificent Mansion	Mordenkainen's_Magnificent_Mansion
Private Sanctum	Mordenkainen's_Private_Sanctum
Arcane Sword	Mordenkainen's_Sword
Arcane Hand	Bigby's_Hand
Floating Disk	Tenser's_Floating_Disk
Secret Chest	Leomund's_Secret_Chest
Tiny Hut	Leomund's_Tiny_Hut
Telepathic Bond	Rary's_Telepathic_Bond
Instant Summons	Drawmij's_Instant_Summons
Befuddlement	Feeblemind
Summon Dragon	Summon_Draconic_Spirit
ALIAS

try_file() {
  curl -s "https://bg3.wiki/w/api.php?action=query&titles=File:$1&prop=imageinfo&iiprop=url&format=json" \
    | grep -o '"url":"[^"]*"' | head -1 | sed 's/"url":"//; s/"$//'
}

cut -f1 iconos-bg3.txt | sort > /tmp/icon-have.txt
cut -f1 nombres-es.txt | sort > /tmp/icon-all.txt

comm -23 /tmp/icon-all.txt /tmp/icon-have.txt | while IFS= read -r name; do
  plain=$(printf '%s' "$name" | sed "s/[’']//g; s|/| |g; s/  */_/g")
  alias=$(grep -F "$(printf '%s\t' "$name")" /tmp/icon-alias.txt | cut -f2 || true)
  for base in $alias "${plain}_spell" "${plain}_(spell)"; do
    [ -z "$base" ] && continue
    for ext in webp png; do
      url=$(try_file "${base}_Icon.${ext}")
      if [ -n "$url" ]; then
        printf '%s\t%s\n' "$name" "$url"
        break 2
      fi
    done
  done
done >> iconos-bg3.txt

sort -o iconos-bg3.txt iconos-bg3.txt
wc -l < iconos-bg3.txt
