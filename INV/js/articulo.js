
function getEstatus(e) {
    switch (e) {
        case 0: return "Disponible"; break;
        case 1: return "Ocupado"; break;
        case 2: return "Dañado"; break;
        case 3: return "En reparación"; break;
        case 4: return "En mantenimiento"; break;
        case 5: return "Extraviado";
    }
    return "";
}

function getIdEstatus(e) {
    switch (e) {
        case "Disponible": return 0; break;
        case "Ocupado": return 1; break;
        case "Dañado": return 2; break;
        case "En reparación": return 3; break;
        case "En mantenimiento": return 4; break;
        case "Extraviado": return 5;
    }
    return "";
}