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
| `index.html` | The cover: a full-screen entry menu into the supplement, plus an index of every section and its status. |
| `pages/classes/magister.html` | The Magister class: overview, core traits, progression table, class features level by level, and the full spell list. |
| `pages/subclasses/` | The Magister subclasses. `forgeknight.html` is the one being written; `template.html` is the blank skeleton for new ones; `legacy/` holds retired drafts. |
| `pages/spells/` | One page per spell created for the supplement, plus the index table. |
| `pages/items/` | Magic items and equipment. `adventuring_gear/` holds one page per item; the index table is built from the list at the bottom of `index.html`. |
| `pages/craft/` | The Compendium of Arcane Artisanship: Schematics, requirements, costs and time per rarity. |
| `css/style.css` | Every style on the site. Dark theme, Cinzel + Spectral typefaces. |
| `js/wiki-api.js` | Fills in the damage-type and dice icons by querying the bg3.wiki API. Falls back to plain text offline. |
| `assets/img/` | Class crest, passive icons and spell icons. |
| `doc/` | Working notes for development, not part of the published site. |

Every page shares the same site navigation (Lex Arcanum · Magister · Subclasses · Spells · Items ·
Crafting), so the paths above are the only thing to keep in sync when a page moves.

## Viewing it

The site is published with GitHub Pages at <https://fjorn17.github.io/Lex-Arcanum/>.
You can also open `index.html` straight from a local copy in any browser. There is nothing to build
and no dependencies to install. Web fonts, bg3.wiki icons and the cover artwork are loaded from the
internet — offline the page is still perfectly readable, it just loses those images.

## Status

- **Magister (levels 1–20)** — written, being balanced.
- **Subclasses** — *Forgeknight* is the one moving forward. *Weaver* and *Sigilist* are documented
  as ideas and will most likely be cut. *Gematurge* has been retired to `legacy/`.
- **Spells** — the original ones have pages; wording and numbers are still drafts.
- **Items and crafting** — just started, provisional rules.

The complete, original material lives in the
[Lex Arcanum rulebook on Nivel20](https://nivel20.com/games/dnd-2024/rulebooks/2638-lex-arcanum)
(in Spanish).

## Credits and licence

Cover artwork by [Hyunjung Im](https://www.artstation.com/artwork/QKJEo3). Rules icons and links
point to [bg3.wiki](https://bg3.wiki).

Original content is released under [CC BY-NC-SA 4.0](LICENSE). This is an unofficial fan project,
not affiliated with Larian Studios or Wizards of the Coast.
