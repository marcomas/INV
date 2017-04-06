function GetRecord(fun, dataRef, bShowMessage) {
    UnloadData_1();
    UnloadData_Columns();

    if (dataRef == null) {
        dataRef = '';
    } else {
        dataRef = dataRef + '|';
    }

    if (bShowMessage == null) {
        bShowMessage = true;
    } else {
        bShowMessage = bShowMessage;
    }

    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'getRecord', data: dataRef, id: 0 },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] != "OK") {
            if (bShowMessage == true) { MsgError(data.split('§')[1]); }
            LoadData_2();
            ClearFieldsToInit();
        } else {
            var source = data.split('§')[1];
            LoadDataFromSource(source);
            SetExcepcionesLoadData();
            if (fun != 0) {
                intervalVarLoadData = setInterval(function() { LoadDataAll(fun) }, 1000);
            }
        }
    }).fail(function() { alert("error"); });
}

function SetExcepcionesLoadData() { 
    switch (tabla) {
        case 'Usuario':
            var valEstatus = aSource[aSource.lenght-1].split('|')[10];
            $('#btEstatus').attr('value', aEstatus[valEstatus].split('|')[0]);
            break;
    }
}

function NewRecord() {
    var info = GetInfo();
    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'newRecord', data: info, id: 0 },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] != "OK") {
            MsgError(data.split('§')[1]);
        } else {
            GoToSave();
            bEditOrNew = false;
            EventChangeStatusToolbar();
            idRecordSelected = data.split('§')[1].split('|')[0];
            if (tablaToolBar == 'proveedor') {
                GetRecord(3, tipoProveedor);
            } else{
                GetRecord(3);
            }
            if (tabla == 'articulo') {
                MostrarMensajeBarCode();
            }
        }
    }).fail(function() { alert("error"); });
}

function UpdateRecord() {
    var info = GetInfo();

    idRecordSelected = $('#idRecord').val();

    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: tabla, fun: 'updateRecord', data: info, id: idRecordSelected },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] != "OK") {
            MsgError(data.split('§')[1]);
        } else {
            GoToSave();
            bEditOrNew = false;
            EventChangeStatusToolbar();

            if (tablaToolBar == 'proveedor') {
                GetRecord(3, tipoProveedor);
            } else {
                GetRecord(3);
            }
        }
    }).fail(function() { alert("error"); });
}
var nombre = ''
var idRecordRecuperar = 0

function DeleteRecord() {
    idRecordSelected = $('#idRecord').val();
    idRecordRecuperar = $('#idRecord').val();
    nombre = $('#txtNombre').val();

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
            idRecordSelected = -1;
            ClearFieldsToInit();
        }
    }).fail(function() { alert("error"); });
}

function RecuperarRecord() {

    $.msgBox({
        title: "Alerta",
        content: "Fue eliminada la categoria " + nombre + " y todos los Articulos registrados en ella, desea deshacer la eliminación?",
        type: "confirm",
        buttons: [{ value: "Si" }, { value: "No" }],
        success: function (result) {
            if (result == "Si") {

                $.ajax({
                    type: "POST",
                    url: "../WS/WSTablas.aspx",
                    data: { tabla: tabla, fun: 'recuperarRecord', id: idRecordRecuperar },
                    async: false
                }).done(function (data) {
                    if (data.split('§')[0] != "OK") {
                        MsgError("No se pudo Restablecer la Información");
                    } else {
                        MsgInfo("Información Restablecida con exito");
                    }
                }).fail(function () { alert("error"); });
            }
        }
    });
}



