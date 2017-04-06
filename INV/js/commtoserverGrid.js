var idRecordSelected = -1; 

function GetRecord() {
    $("#lbBuscando").fadeIn();
    $("#jqxgrid").jqxGrid('clearfilters');
    UnloadData_Columns();

    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'getRecord' },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] == "OK") {
            var source = data.split('§')[1];
            aSource = source.split('$');
            for (i = 0; i < aSource.length; i++) {
                LoadGridView(i);
            }
            intervalVarRefreshGridView = setInterval(function() { RefreshGridView() }, 1000);
        } else {
            $("#loadGridView").click();
            $("#jqxgrid").jqxGrid('clearfilters');
            $("#lbBuscando").fadeOut();
        }
    });
}

function NewRecord(info) {
    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'newRecord', data: info, id: 0 },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] != "OK") {
            MsgError(data.split('§')[1]);
        } else {
            $("#divNewItemGrid").fadeOut();
            $(".overlay").fadeOut();
            idRecordSelected = data.split('§')[1].split('|')[0];
            GetRecord();
        }
    });
}

function UpdateRecord(info) {
    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'updateRecord', data: info, id: idRecordSelected },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] != "OK") {
            MsgError(data.split('§')[1]);
        } else {
            $("#divEditItemGrid").fadeOut();
            $(".overlay").fadeOut();
            GetRecord();
        }
    });
}

function DeleteRecord() {
    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'deleteRecord', id: idRecordSelected },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] != "OK") {
            if (data.split('§')[1].split('|')[0] == "MSG") {
                MsgInfo(data.split('§')[1].split('|')[1]);
            } else {
                MsgError(data.split('§')[1]);
            }
        } else {
            HideMessages();
            idRecordSelected = -1;
            GetRecord();
        }
    });
}

//-- MENSAGES --//

function HideMessages(sede) {
    $(".msgBoxBackGround").hide();
    $(".msgBox").hide();
    return false;
}

function MsgGuardar(info) {
    $.msgBox({
        title: "Guardar",
        content: "Desea guardar los cambios?",
        type: "confirm",
        buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
        success: function(result) {
            if (result == "Aceptar") {
                UpdateRecord(info);
            }
        }
    });
}

function MsgDelete() {
    $.msgBox({
        title: "Eliminar",
        content: "Desea eliminar el registro?",
        type: "confirm",
        buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
        success: function(result) {
            if (result == "Aceptar") {
                DeleteRecord();
            }
            $(".overlay").fadeOut();
        }
    });
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




