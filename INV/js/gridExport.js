var columnsExports = '';
var columnsExportCaption = '';
var numreport = 1;
var jqxgrid = 'jqxgrid';

$(function() {

    $('#btExportToExcel').click(function () {
        ExportRecordsXLS();
    });

    $('#btExportToPDFReport').click(function() {
        ExportRecordsPDF();
    });

});

function ExportRecordsXLS(isHome) {
    if (numreport == 3) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var codigo = rowsTemp[i]['codigo'];
            var cedula = rowsTemp[i]['cedula'];
            var nombre = rowsTemp[i]['nombre'];
            var cargo = rowsTemp[i]['cargo'];
            var resp = rowsTemp[i]['resp'];
            var tlf = rowsTemp[i]['tlf'];
            var email = rowsTemp[i]['email'];
            var direccion = rowsTemp[i]['direccion'];
            var estatus = rowsTemp[i]['estatus'];
            rows[i] = { codigo: codigo, cedula: cedula, nombre: nombre, cargo: cargo, resp: resp, tlf: tlf, email: email, estatus: estatus, direccion: direccion };
        }
    }
    else if (numreport == 4) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var codigo = rowsTemp[i]['codigo'];
            var nombre = rowsTemp[i]['nombre'];
            var cedula = rowsTemp[i]['cedula'];
            var resp = rowsTemp[i]['resp'];
            var tlf = rowsTemp[i]['tlf'];
            var email = rowsTemp[i]['email'];
            var estatus = rowsTemp[i]['estatus'];
            rows[i] = { codigo: codigo, nombre: nombre, cedula: cedula, resp: resp, tlf: tlf, email: email, estatus: estatus };
        }
    }
    else if (numreport == 5) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var codigo = rowsTemp[i]['codigo'];
            var nombre = rowsTemp[i]['nombre'];
            var rif = rowsTemp[i]['rif'];
            var resp = rowsTemp[i]['resp'];
            var direccion = rowsTemp[i]['direccion'];
            var tlf = rowsTemp[i]['tlf'];
            var email = rowsTemp[i]['email'];
            var info = rowsTemp[i]['info'];
            var nuevo_info = info.replace('<textarea style="position: relative; float: left; left: 2px; height: 42px; width: 220px; margin-top: 0px; margin-bottom: 0px;"> ', "")
            nuevo_info = nuevo_info.replace(' </textarea>', "")
            rows[i] = { codigo: codigo, nombre: nombre, rif: rif, resp: resp, direccion: direccion, tlf: tlf, email: email, info: nuevo_info };
        }
    }
    else if (numreport == 1) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var codigo = rowsTemp[i]['codigo'];
            var nombre = rowsTemp[i]['nombre'];
            var nivel = rowsTemp[i]['nivel'];
            var exist = rowsTemp[i]['exist'];
            var stock = rowsTemp[i]['stock'];
            var dif = rowsTemp[i]['dif'];
            var info = rowsTemp[i]['info'];
            var nuevo_info = info.replace('<textarea style="position: relative; float: left; left: 2px; height: 42px; width: 220px; margin-top: 0px; margin-bottom: 0px;"> ', "")
            nuevo_info = nuevo_info.replace(' </textarea>', "")
            rows[i] = { codigo: codigo, nombre: nombre, nivel: nivel, exist: exist, stock: stock, dif: dif, info: nuevo_info };
        }
    }
    else if (numreport == 6) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var descr = rowsTemp[i]['descr'];
            var usuario = rowsTemp[i]['usuario'];
            var accion = rowsTemp[i]['accion'];
            var fecha = rowsTemp[i]['fecha'];
            var hora = rowsTemp[i]['hora'];
            rows[i] = { descr: descr, usuario: usuario, accion: accion, fecha: fecha, hora: hora };
        }
    }
    else if (numreport == 2) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var codigo = rowsTemp[i]['codigo'];
            var nombre = rowsTemp[i]['nombre'];
            var nivel = rowsTemp[i]['nivel'];
            var estatus = rowsTemp[i]['estatus'];
            var fecha = rowsTemp[i]['fecha'];
            var nueva_fecha = new Date(fecha);
            var resp = rowsTemp[i]['resp'];
            var info = rowsTemp[i]['info'];
            var nuevo_info = info.replace('<textarea style="position: relative; float: left; left: 2px; height: 42px; width: 220px; margin-top: 0px; margin-bottom: 0px;"> ', "")
            nuevo_info = nuevo_info.replace(' </textarea>', "")
            rows[i] = { codigo: codigo, nombre: nombre, nivel: nivel, estatus: estatus, fecha: nueva_fecha, resp: resp, info: nuevo_info };
        }
    }
    else if (numreport == 7) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var articulo = rowsTemp[i]['articulo'];
            var nivel = rowsTemp[i]['nivel'];
            var cantidad = rowsTemp[i]['cantidad'];
            var responsable = rowsTemp[i]['responsable'];
            var fechareg = rowsTemp[i]['fechareg'];
            var estatus = rowsTemp[i]['estatus'];
            rows[i] = { articulo: articulo, nivel: nivel, cantidad: cantidad, responsable: responsable, fechareg: fechareg, estatus: estatus };
        }
    }
    else if (numreport == 8) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var articulo = rowsTemp[i]['articulo'];
            var nivel = rowsTemp[i]['nivel'];
            var cantidad = rowsTemp[i]['cantidad'];
            var responsable = rowsTemp[i]['responsable'];
            var mante = rowsTemp[i]['mante'];
            var fechareg = rowsTemp[i]['fechareg'];
            var fecharei = rowsTemp[i]['fecharei'];
            var nota = rowsTemp[i]['nota'];
            rows[i] = { articulo: articulo, nivel: nivel, cantidad: cantidad, responsable: responsable, mante: mante, fechareg: fechareg, fecharei: fecharei, nota: nota };
        }
    }
    else if (numreport == 9) {
            var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
            var rows = new Array(rowsTemp.length);
            for (i = 0; i < rowsTemp.length; i++) {
                var codigo = rowsTemp[i]['codigo'];
                var nombre = rowsTemp[i]['nombre'];
                var nivel = rowsTemp[i]['nivel'];
                var um = rowsTemp[i]['um'];
                var sm = rowsTemp[i]['sm'];
                var e = rowsTemp[i]['e'];
                var estatus = rowsTemp[i]['estatus'];
                rows[i] = { codigo: codigo, nombre: nombre, nivel: nivel, um: um, sm: sm, e: e, estatus: estatus };
            }
    }

    var dataexport = JSON.stringify(rows);

    if (isHome == null) { isHome = false; }
    var url = "../WS/WSExport.aspx";
    if (isHome) { url = "WS/WSExport.aspx"; }

    $.ajax({
        type: "POST",
        url: url,
        async: true,
        data: { fun: 'exportRecordsXLS', data: dataexport, columnsexports: columnsExports, columnsexportCaption: columnsExportCaption }
    }).done(function (data) {
        if (data.split('§')[0] == "OK") {
            MsgDescargarArchivo(data.split('§')[1]);
        } else {
            MsgError(data.split('§')[1])
        }
    });
}

function ExportRecordsPDF(isHome) {
        var rowsTemp = $('#' + jqxgrid).jqxGrid('getrows');
        var rows = new Array(rowsTemp.length);
        for (i = 0; i < rowsTemp.length; i++) {
            var codigo = rowsTemp[i]['codigo'];
            var nombre = rowsTemp[i]['nombre'];
            var cedula = rowsTemp[i]['cedula'];
            var rep = rowsTemp[i]['rep'];
            var tlf = rowsTemp[i]['tlf'];
            var email = rowsTemp[i]['email'];
            var estatus = rowsTemp[i]['estatus'];
            rows[i] = { codigo: codigo, nombre: nombre, cedula: cedula, rep: rep, tlf: tlf, email: email, estatus: estatus };
        } 

    var dataexport = JSON.stringify(rows);
    $.ajax({
        type: "POST",
        url: "../WS/WSExport.aspx",
        async: false,
        data: { fun: 'exportRecordsXLS', data: dataexport, columnsexports: columnsExports, columnsexportCaption: columnsExportCaption }
    }).done(function(data) {
        if (data.split('§')[0] == "OK") {
            MsgDescargarArchivo(data.split('§')[1]);
        } else {
            MsgError(data.split('§')[1])
        }
    });
}

function ExportRecordsPDF() {
    var rows = $('#' + jqxgrid).jqxGrid('getrows');
    var dataexport = JSON.stringify(rows);

    if (isHome == null) { isHome = false; }
    var url = "../WS/WSExport.aspx";
    if (isHome) { url = "WS/WSExport.aspx"; }

    $.ajax({
        type: "POST",
        url: url,
        async: true,
        data: { fun: 'exportRecordsPDF', data: dataexport, columnsexports: columnsExports, numreport: numreport }
    }).done(function(data) {
        if (data.split('§')[0] == "OK") {
            MsgDescargarArchivo(data.split('§')[1]);
        } else {
            MsgError(data.split('§')[1])
        }
    });
}


function MsgDescargarArchivo(fileExcel) {
    $('#divArticulos').fadeTo('slow', 0.4);
    $(".overlayArt").fadeIn();
    
    window.open(fileExcel);
           
    $('#divArticulos').fadeTo('slow', 1);
   
}
