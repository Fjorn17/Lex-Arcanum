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

        await Promise.all(Array.from(elements).map(async (el) => {
            let dice = el.getAttribute('data-dice');
            let type = el.getAttribute('data-type');
            if (!dice || !type) return;

            let [x, y] = dice.toLowerCase().split('d');
            let typeCap = type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();

            let isPhysical = ['Slashing', 'Piercing', 'Bludgeoning'].includes(typeCap);
            let diceType = isPhysical ? 'Physical' : typeCap;

            let diceName = `D${y}_${diceType}.png`;
            let iconName = `${typeCap}_Damage_Icon.png`;
            let fallbackName = `D${y}_Icon.png`;

            el.className = `dmg d-${type.toLowerCase()}`;

            let [diceUrl, iconUrl] = await Promise.all([
                getWikiImageUrl(diceName),
                getWikiImageUrl(iconName)
            ]);

            if (!diceUrl) diceUrl = await getWikiImageUrl(fallbackName);

            // Sin URL no se pinta la etiqueta: un <img src=""> hace que el navegador
            // vuelva a pedir la propia página. El texto se mantiene siempre.
            const diceImg = diceUrl ? `<img class="dice-ic" src="${diceUrl}" alt=""> ` : '';
            const typeImg = iconUrl ? `<img class="ic" src="${iconUrl}" alt=""> ` : '';

            el.innerHTML = `${diceImg}${dice} ${typeImg}${typeCap}`;
        }));
    }

    // 2. Procesa solo el tipo de daño sin dados (.dmg-type)
    async function renderDamageTypes() {
        const elements = document.querySelectorAll('.dmg-type');

        await Promise.all(Array.from(elements).map(async (el) => {
            let type = el.getAttribute('data-type');
            if (!type) return;

            let typeCap = type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();
            let iconName = `${typeCap}_Damage_Icon.png`;

            el.className = `dmg d-${type.toLowerCase()}`;

            const iconUrl = await getWikiImageUrl(iconName);
            const typeImg = iconUrl ? `<img class="ic" src="${iconUrl}" alt=""> ` : '';

            el.innerHTML = `${typeImg}<span>${typeCap}</span>`;
        }));
    }

    // Ejecutamos ambas funciones
    await renderDamageCalculations();
    await renderDamageTypes();
});
