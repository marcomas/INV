var JQUERY4U = {};
var key;

//-- FUNCTIONS --//
JQUERY4U.UTIL = {
    formatVarString: function() {
        var args = [].slice.call(arguments);
        if (this.toString() != '[object Object]') {
            args.unshift(this.toString());
        }
        var pattern = new RegExp('{([1-' + args.length + '])}', 'g');
        return String(args[0]).replace(pattern, function(match, index) { return args[index]; });
    }
}

//-- VALIDACIONES KEYPRESS --//

function ValidaCampoFecha(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 9) {
            if (key >= 48 && key <= 57) {
                var value = $('#' + o.id).val();
                if (value.length == 2) {
                    $('#' + o.id).val(value + '/');
                } else if (value.length == 5) {
                    $('#' + o.id).val(value + '/');
                }
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoCedula(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 9) { return true; }
        if ($('#' + o.id).val().length <= 8) {
            if (key >= 48 && key <= 57) {
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoNombre(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 99) {
            if ((key >= 65 && key <= 90) || (key >= 97 && key <= 122) || (key == 32)) {
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoTelefono(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 11) {
            if (key >= 48 && key <= 57) {
                var value = $('#' + o.id).val();
                if (value.length == 4) {
                    $('#' + o.id).val(value + '-');
                }
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoCelular(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 11) {
            if (key >= 48 && key <= 57) {
                var value = $('#' + o.id).val();
                if (value.length == 4) {
                    $('#' + o.id).val(value + '-');
                }
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoRif(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 8) {
            if ((key >= 48 && key <= 57) || (key == 45)) {
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoRifUnico(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 13) {
            if ((key >= 48 && key <= 57) || key == 45 || key == 106 || key == 74) {
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoNumero(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 8) {
            if ((key >= 48 && key <= 57) || (key == 45)) {
                return true;
            }
        }
        return false;
    }
}

function ValidaCampoNumeroDec(e, o) {
    if (e.which) {
        key = e.which;
        if (key == 8) { return true; }
        if ($('#' + o.id).val().length <= 8) {
            if ((key >= 48 && key <= 57) || (key == 45) || (key == 46)) {
                return true;
            }
        }
        return false;
    }
}

function GetKeyPressed(e) {
    if (e.which) { key = e.which; }
}

//-- FECHAS --//

Date.prototype.addDays = function(num) {
    var value = this.valueOf();
    value += 86400000 * num;
    return new Date(value);
}

Date.prototype.addSeconds = function(num) {
    var value = this.valueOf();
    value += 1000 * num;
    return new Date(value);
}

Date.prototype.addMinutes = function(num) {
    var value = this.valueOf();
    value += 60000 * num;
    return new Date(value);
}

Date.prototype.addHours = function(num) {
    var value = this.valueOf();
    value += 3600000 * num;
    return new Date(value);
}

Date.prototype.addMonths = function(num) {
    var value = new Date(this.valueOf());

    var mo = this.getMonth();
    var yr = this.getYear();

    mo = (mo + num) % 12;
    if (0 > mo) {
        yr += (this.getMonth() + num - mo - 12) / 12;
        mo += 12;
    }
    else
        yr += ((this.getMonth() + num - mo) / 12);

    value.setMonth(mo);
    value.setYear(yr);
    return value;
}

function GetStringDateFromDate(dDate) {
    var dd = dDate.getDate() + '';
    if (dd.length == 1) { dd = '0' + dd }
    var mm = (dDate.getMonth() + 1) + '';
    if (mm.length == 1) { mm = '0' + mm }
    var yyyy = dDate.getFullYear() + '';
    return dd + '/' + mm + '/' + yyyy;
}

function GetFechaActual() {
    var today = new Date();
    return GetStringDateFromDate(today);
}

function GetDateFromString(sDate) {
    var dd = sDate.split("/")[0];
    var mm = sDate.split("/")[1];
    var yy = sDate.split("/")[2];
    return new Date(yy + '-' + mm + '-' + dd);
}

function AddDayToDate(sDate, nDay) {
    var dDate = GetDateFromString(sDate);
    dDate = dDate.addDays(nDay);
    return GetStringDateFromDate(dDate);
}

function GetDay(sDate, lng) {
    var dDate = GetDateFromString(sDate);
    var day = '';

    if (lng == 'ES') {
        switch (dDate.getDay()) {
            case 0: day = 'Lunes'; break;
            case 1: day = 'Martes'; break;
            case 2: day = 'Miercoles'; break;
            case 3: day = 'Jueves'; break;
            case 4: day = 'Viernes'; break;
            case 0: day = 'Sabado'; break;
            case 6: day = 'Domingo'; break;
        }
    } else if (lng == 'EN') {
        switch (dDate.getDay()) {
            case 0: day = 'Domingo'; break;
            case 1: day = 'Lunes'; break;
            case 2: day = 'Martes'; break;
            case 3: day = 'Miercoles'; break;
            case 4: day = 'Jueves'; break;
            case 5: day = 'Viernes'; break;
            case 6: day = 'Sabado'; break;
        }
    }
    return day;
}

function GetDayFromDate(dDate, lng) {
    var day = '';

    if (lng == 'ES') {
        switch (dDate.getDay()) {
            case 0: day = 'Lunes'; break;
            case 1: day = 'Martes'; break;
            case 2: day = 'Miercoles'; break;
            case 3: day = 'Jueves'; break;
            case 4: day = 'Viernes'; break;
            case 0: day = 'Sabado'; break;
            case 6: day = 'Domingo'; break;
        }
    } else if (lng == 'EN') {
        switch (dDate.getDay()) {
            case 0: day = 'Domingo'; break;
            case 1: day = 'Lunes'; break;
            case 2: day = 'Martes'; break;
            case 3: day = 'Miercoles'; break;
            case 4: day = 'Jueves'; break;
            case 5: day = 'Viernes'; break;
            case 6: day = 'Sabado'; break;
        }
    }
    return day;
}

//-- MENSAGES --//

function HideMessages(sede) {
    $(".msgBoxBackGround").hide();
    $(".msgBox").hide();
    return false;
}

function MsgError(msg) {
    if (msg == '') { return; }
    $.msgBox({
        title: "Error",
        content: msg,
        type: "error",
        buttons: [{ value: "Aceptar"}],
        success: function(result) {
            if (result == "Aceptar") {
                $(".overlay").fadeOut();
            }
        }
    });
}

function MsgGuardar() {
    $.msgBox({
        title: "Guardar",
        content: "Desea guardar los cambios",
        type: "confirm",
        buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
        success: function(result) {
            if (result == "Aceptar") {
                UpdateRecord();
                GoToSave();
            }
            $(".overlay").fadeOut();
        }
    });
}

function MsgInfo(msg) {
    if (msg == '') { return; }
    $.msgBox({
        title: "Información",
        content: msg,
        type: "confirm",
        buttons: [{ value: "Aceptar"}],
        success: function(result) {
            $(".overlay").fadeOut();
        }
    });
}

function MsgInfo2(msg) {
    if (msg == '') { return; }
    $.msgBox2({
        title: "Información",
        content: msg,
        type: "confirm",
        buttons: [{ value: "Aceptar"}],
        success: function(result) {
        }
    });
}

function MsgAlert(msg) {
    if (msg == '') { return; }
    $.msgBox({
        title: 'Atención',
        content: msg,
        type: "alert",
        buttons: [{ value: "Aceptar"}],
        success: function(result) {
            $(".overlay").fadeOut();
        }
    });
}

function MsgAlertCerrarVentana(msg) {
    if (msg == '') { return; }
    $.msgBox({
        title: 'Atención',
        content: msg,
        type: "alert",
        buttons: [{ value: "Aceptar"}],
        success: function(result) {
            CerrarVentana();
            $(".overlay").fadeOut();
        }
    });
}

function MsgAlertNoOverlay(msg) {
    if (msg == '') { return; }
    $.msgBox({
        title: 'Atención',
        content: msg,
        type: "alert",
        buttons: [{ value: "Aceptar"}],
        success: function(result) { }
    });
}

//-- VENTANAS --//

function CerrarVentana() {
    var padre = $(window.parent.document);
    $(padre).find(".sidebar").animate({ left: "0px" }, 1000);
    $(padre).find("#iframes").fadeOut(1000, function() {
        $(padre).find(".desktop").html("");
    });
}

//-- ESTATUS FIELDS --//

function SetEstatusFields(value, btName, sValue_0, sValue_1) {
    var sValue = sValue_0;
    if (value == 1) { sValue = sValue_1; }
    $('#' + btName).attr('value', sValue);
}