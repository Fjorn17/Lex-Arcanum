document.addEventListener("DOMContentLoaded", async () => {
    // Memoria para no pedirle la misma imagen a la wiki dos veces
    const imageCache = {};

    // Función genérica para consultar la API de la wiki
    async function getWikiImageUrl(filename) {
        if (imageCache[filename]) return imageCache[filename];

        try {
            const res = await fetch(`https://bg3.wiki/w/api.php?action=query&titles=File:${filename}&prop=imageinfo&iiprop=url&format=json&origin=*`);
            const data = await res.json();
            const pages = data.query.pages;
            const pageId = Object.keys(pages)[0];

            if (pageId !== "-1" && pages[pageId].imageinfo) {
                const url = pages[pageId].imageinfo[0].url;
                imageCache[filename] = url;
                return url;
            }
        } catch (e) {
            console.error("No se pudo cargar: ", filename);
        }
        return "";
    }

    // 1. Procesa cálculos con dados (.dmg-calc)
    async function renderDamageCalculations() {
        const elements = document.querySelectorAll('.dmg-calc');

        for (const el of elements) {
            let dice = el.getAttribute('data-dice');
            let type = el.getAttribute('data-type');
            if (!dice || !type) continue;

            let [x, y] = dice.toLowerCase().split('d');
            let typeCap = type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();

            let isPhysical = ['Slashing', 'Piercing', 'Bludgeoning'].includes(typeCap);
            let diceType = isPhysical ? 'Physical' : typeCap;

            let diceName = `D${y}_${diceType}.png`;
            let iconName = `${typeCap}_Damage_Icon.png`;
            let fallbackName = `D${y}_Icon.png`;

            el.className = `dmg d-${type.toLowerCase()}`;

            let diceUrl = await getWikiImageUrl(diceName);
            let iconUrl = await getWikiImageUrl(iconName);

            if (!diceUrl) diceUrl = await getWikiImageUrl(fallbackName);

            el.innerHTML = `<img class="dice-ic" src="${diceUrl}" alt=""> ${dice} <img class="ic" src="${iconUrl}" alt=""> ${typeCap}`;
        }
    }

    // 2. Procesa solo el tipo de daño sin dados (.dmg-type)
    async function renderDamageTypes() {
        const elements = document.querySelectorAll('.dmg-type');

        for (const el of elements) {
            let type = el.getAttribute('data-type');
            if (!type) continue;

            let typeCap = type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();
            let iconName = `${typeCap}_Damage_Icon.png`;

            el.className = `dmg d-${type.toLowerCase()}`;

            let iconUrl = await getWikiImageUrl(iconName);

            el.innerHTML = `<img class="ic" src="${iconUrl}" alt=""> <span>${typeCap}</span>`;
        }
    }

    // Ejecutamos ambas funciones
    await renderDamageCalculations();
    await renderDamageTypes();
});