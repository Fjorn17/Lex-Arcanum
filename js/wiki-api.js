document.addEventListener("DOMContentLoaded", async () => {
    // Memoria para no pedirle la misma imagen a la wiki dos veces
    const imageCache = {};

    // Función que interroga a la API de la wiki por la URL directa
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

    // Buscamos todos los daños del documento
    const elements = document.querySelectorAll('.dmg-calc');

    for (const el of elements) {
        let dice = el.getAttribute('data-dice');
        let type = el.getAttribute('data-type');

        let [x, y] = dice.toLowerCase().split('d');
        let typeCap = type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();

        let isPhysical = ['Slashing', 'Piercing', 'Bludgeoning'].includes(typeCap);
        let diceType = isPhysical ? 'Physical' : typeCap;

        // Nombres exactos de los archivos
        let diceName = `D${y}_${diceType}.png`;
        let iconName = `${typeCap}_Damage_Icon.png`;
        let fallbackName = `D${y}_Icon.png`; // Por si falla el color, carga el dorado

        // Preparamos la clase de color
        el.className = `dmg d-${type.toLowerCase()}`;

        // Buscamos las URLs reales
        let diceUrl = await getWikiImageUrl(diceName);
        let iconUrl = await getWikiImageUrl(iconName);

        // Si el dado específico no existe en la wiki, usamos el genérico dorado
        if (!diceUrl) diceUrl = await getWikiImageUrl(fallbackName);

        // Inyectamos el HTML final
        el.innerHTML = `<img class="dice-ic" src="${diceUrl}" alt=""> ${dice} <img class="ic" src="${iconUrl}" alt=""> ${typeCap}`;
    }
});