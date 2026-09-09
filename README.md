# Lex Arcanum

Homebrew wiki for **Baldur's Gate 3** and **D&D 5e (2024)**, collecting the material from the
*Lex Arcanum* supplement: original classes, subclasses, spells and items.

The centrepiece is the **Magister** — an Intelligence half-caster who channels spells through an
arcane focus while fencing with a finesse blade.

**Live site: <https://fjorn17.github.io/Lex-Arcanum/>**

> ⚠️ **Everything here is a draft.** Features, numbers, spell lists and names are still being tested
> and rewritten, and may change or disappear between revisions. Nothing on this site is final.

## Contents

| Path | What it is |
| --- | --- |
| `index.html` | Language gate: redirects to `/en/` or `/es/` based on a remembered choice or the browser, with visible links to both as a no-JS fallback. |
| `en/`, `es/` | The two language trees. Same page paths inside each, so `en/pages/astronomy/index.html` and `es/pages/astronomy/index.html` are the same page. `index.html` in each is the cover. |
| `<lang>/pages/classes/magister.html` | The Magister class: overview, core traits, progression table, class features level by level, and the full spell list. |
| `<lang>/pages/subclasses/` | The Magister subclasses. `forgeknight.html` is the one being written; `template.html` is the blank skeleton for new ones; `legacy/` holds retired drafts. |
| `<lang>/pages/astronomy/` | The whole art in one section, behind one nav tab. 29 pages for Astronomy and the Disciplines inside it, 302 spell pages, a front page that carries the containment diagram and the doctrine, and spells.html, which is the finder: filters and the full table. Nothing here is edited by hand except the seven spells written from scratch: the Discipline pages come from `doc/spells/build-disciplines.pl` and the rest from `doc/spells/build-pages.pl`. |
| `<lang>/pages/items/` | Magic items and equipment. `adventuring_gear/` holds one page per item; the index table is built from the list at the bottom of `index.html`. |
| `<lang>/pages/craft/` | The Compendium of Arcane Artisanship: Schematics, requirements, costs and time per rarity. |
| `css/style.css` | Every style on the site. Dark theme, Cinzel + Spectral typefaces. |
| `js/lang.js` | Remembers the language choice and drives the root redirect. |
| `js/wiki-api.js` | Fills in the damage-type and dice icons by querying the bg3.wiki API. Falls back to plain text offline. |
| `js/spell-filter.js` | Filtering and column sorting on the spell index. Without it the table still shows every spell, ordered by level. |
| `assets/img/` | Class crest, passive icons and spell icons. |
| `analysis/` | Internal balance documents, Spanish only. Outside the language trees, not in the navigation, marked `noindex`; reachable only from a discreet link in every page footer. |
| `doc/redaccion.md` | **How rules are written here.** PHB 2024 conventions, fixed phrasings, capitalisation, forbidden vocabulary and the EN/ES name glossary. Read before writing any rule. |
| `doc/` | Working notes and reference material for development, not part of the published site. |

Every page shares the same site navigation plus a two-flag language switcher, which links to the same
page in the other tree. Because the two trees mirror each other path for path, that link is just the
same path with `en/` swapped for `es/` — so when a page moves, it has to move in both.

## Viewing it

The site is published with GitHub Pages at <https://fjorn17.github.io/Lex-Arcanum/>.
You can also open `index.html` straight from a local copy in any browser. There is nothing to build
and no dependencies to install. Web fonts, bg3.wiki icons and the cover artwork are loaded from the
internet — offline the page is still perfectly readable, it just loses those images.

## Translation status

Both trees are complete. Spanish naming: the class is **Magistrado**, the Forgeknight is the
**Caballero de la Forja**, and spell names use the Spanish PHB 2024 wording. Feature names follow the
internal analysis, which deliberately keeps *Arcane Swordplay* and *Spellsword* in English.

File paths are identical in both trees (`magister.html`, `forgeknight.html`) even where the display
name differs — the language switcher works by swapping `en/` for `es/` in the current path, so a page
that moves has to move in both.

## Status

- **Magister (levels 1–20)** — written, being balanced.
- **Subclasses** — *Forgeknight* and *Threadmarshal* are written up. *Sigilist* is still an idea and will most
  likely be cut. *Gematurge* has been retired to `legacy/`.
- **Disciplines** — the taxonomy has pages of its own: **Astronomy** is the whole art and its subdivisions are the other three Disciplines; **Alchemy** divides into 15 elements (5 primary, 10 crossings), **Spiritism** into 4 Principles and 11 Branches, **Cosmology** into 6 Principles and 12 Branches. Doctrine and the Star catalogue come from the magic-system documents; two inherited Principles (Presage, Pocket) are recorded as removed because the rules no longer allow them.
- **Spells** — 347 spells in both trees. 270 are filed under a Discipline and, where it has one, a subdivision; the other 77 are **uncatalogued**: they exist and have pages, but hang from no Discipline, either because the magic system refuses them outright or because the catalogue that would hold them is unwritten. Each says which on its own page. Spells are listed in tables split by spell level. English text and a Spanish translation of our own, using PHB 2024 vocabulary; wording and numbers are still drafts.
- **Items and crafting** — just started, provisional rules.

The complete, original material lives in the
[Lex Arcanum rulebook on Nivel20](https://nivel20.com/games/dnd-2024/rulebooks/2638-lex-arcanum)
(in Spanish).

## Credits and licence

Cover artwork by [Hyunjung Im](https://www.artstation.com/artwork/QKJEo3). Rules icons and links
point to [bg3.wiki](https://bg3.wiki).

Original content is released under [CC BY-NC-SA 4.0](LICENSE). This is an unofficial fan project,
not affiliated with Larian Studios or Wizards of the Coast.
