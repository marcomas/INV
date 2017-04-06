var bEditOrNew = false;
var bNoFields = false;
var bNotInsert = false;
var bEdit = true;
var bBuscar = true;
var intervalHideButtonBuscar;
var tablaToolBar = '';

function SetOcultarNotifica(valor) {
    $.ajax({
        type: "POST",
        url: "../WS/WSSessionVar.aspx",
        data: { name: 'OcultarNotifica', fun: 'set', value: valor }
    }).done(function (data) { });
}

$(document).ready(function () {

    //scroll barra nuevo estilo
    $("body").niceScroll({ cursorcolor: "#0ca6a6", cursoropacitymax: 1, cursorwidth: 8 });

    //al hacer click en cerrar aparece de nuevo el menu y se blanquea el iframe
    $("#btn_cerrar").click(function () {
        $.msgBox({
            title: "Cerrar Ventana",
            content: "Esta Seguro que desea Cerrar esta Ventana",
            type: "confirm",
            buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
            success: function (result) {
                if (result == "Aceptar") {
                    var padre = $(window.parent.document);
                    $(padre).find(".sidebar").animate({ left: "0px" }, 1000);
                    $(padre).find("#iframes").fadeOut(1000, function () {
                        $(padre).find(".desktop").html("");
                    });
                }
            }
        });
        return false;
    });

    //-- TOOLBAR --//
    $("#toolbar_tabla").toolbar({
        lista: true,
        buscar: bBuscar,
        nuevo: false,
        editar: true,
        eliminar: true,
        fn_lista: function () {
            if (!bNoFields) { CleanFieldsToAlert(); }
            ShowGridView();
            bEditOrNew = false;
            EventChangeStatusToolbar();
            $("#divLista").fadeIn();
            SetOcultarNotifica(1);
        },
        fn_buscar: function () {
            CleanFieldsToAlert();
            if (tablaToolBar == 'proveedor') {
                GetRecord(2, tipoProveedor);
            } else {
                GetRecord(2);
            }
            ViewToolBar2Ini(false);
            ViewButtonSearch();
            bEditOrNew = false;
            EventChangeStatusToolbar();
            $('#txtSearch').val('');
            $('#txtSearch').focus();
        },
        fn_nuevo: function () {
        },
        fn_editar: function () {
            if ($('#txtSearch')) { $('#txtSearch').val(''); }
            CleanFieldsToAlert();
            SaveIndexRecordSelected();
            PrepareFieldsToEditRecord();
            ViewToolBar2Ini(false);
            bEditOrNew = true;
            EventChangeStatusToolbar();
        },
        fn_eliminar: function () {
            CleanFieldsToAlert();
            DeleteRecord();
            RecuperarRecord();
            ViewToolBar2Ini(false);
            bEditOrNew = false;
            EventChangeStatusToolbar();
            if ($('#btEstatus')) { $('#btEstatus').attr('value', ''); }
            if ($('#txtSearch')) { $('#txtSearch').val(''); }
            $("#toolbar_tabla").find(".icon-social-addthis").hide();
        },
        fn_cancelar: function () {
            CleanFieldsToAlert();
            if (indexRecordSelected != -1) {
                PrepareFieldsToRollbackEditRecord();
                GoToSave();
            } else {
                ClearFieldsToInit();
            }
            bEditOrNew = false;
            EventChangeStatusToolbar();
            if (!bBuscar) { intervalHideButtonBuscar = setInterval(function () { HideButtonBuscar() }, 500); }
        },
        fn_guardar: function () {
            CleanFieldsToAlert();
            if (CheckFieldsToAlert()) {
                if (indexRecordSelected == -1) {
                    if (tabla == 'articulo' && bNewCategoria == 1) { NewCategoria(); } else { NewRecord(); }
                } else {
                    MsgGuardar();
                }
            } else {
                ViewButtonCancelAndSave();
            }
            if (!bBuscar) { intervalHideButtonBuscar = setInterval(function () { HideButtonBuscar() }, 500); }
        }
    });

    ViewButtonsEditAndDelete(false);
});

function EventChangeStatusToolbar() { }

function ViewToolBar2Ini(bShow) {
    if (bNotInsert) { $("#toolbar_tabla").find(".icon-social-addthis").hide(); }
    if (!bEdit) { $("#toolbar_tabla").find(".icon-social-addthis").hide(); }
}

function ViewButtonsEditAndDelete(bShow) {
    if (bEditOrNew) { return; }
    if (bShow) {
        $("#toolbar_tabla").find(".icon-eliminar").show();
        $("#toolbar_tabla").find(".icon-editar").show();
    } else {
        $("#toolbar_tabla").find(".icon-eliminar").hide();
        $("#toolbar_tabla").find(".icon-editar").hide();
    }
    ViewToolBar2Ini(bShow);
}

function ViewButtonCancelAndSave() {
    $("#toolbar_tabla").find(".icon-search").hide();
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
    $("#toolbar_tabla").find(".icon-eliminar").hide();
    $("#toolbar_tabla").find(".icon-text-justify-center").hide(); // Lista
    $("#toolbar_tabla").find(".icon-check").show();
    $("#toolbar_tabla").find(".icon-cross").show();
    ViewToolBar2Ini(false);
}

function GoToSave() {
    if (bBuscar) { $("#toolbar_tabla").find(".icon-search").show(); }
    $("#toolbar_tabla").find(".icon-editar").show();
    $("#toolbar_tabla").find(".icon-eliminar").show();
    $("#toolbar_tabla").find(".icon-text-justify-center").show(); // Lista
    $("#toolbar_tabla").find(".icon-check").hide();
    $("#toolbar_tabla").find(".icon-cross").hide();
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    ViewToolBar2Ini(true);
}

function ViewButtonSearch() {
    $("#toolbar_tabla").find(".icon-editar").hide();
    $("#toolbar_tabla").find(".icon-eliminar").hide();
}

function ShowGridView() { }

function UnloadData_Columns() { }

function HideButtonBuscar() {
    clearInterval(intervalHideButtonBuscar);
    $("#toolbar_tabla").find(".icon-search").hide();
}
