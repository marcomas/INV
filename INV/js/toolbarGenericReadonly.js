var bBuscar = true;
var tablaToolBar = '';
var tablaHighPopulate = 0;

function SetOcultarNotifica(valor) {
    $.ajax({
        type: "POST",
        url: "../WS/WSSessionVar.aspx",
        data: { name: 'OcultarNotifica', fun: 'set', value: valor }
    }).done(function (data) { });
}

$(document).ready(function() {

    //scroll barra nuevo estilo
    $("body").niceScroll({ cursorcolor: "#0ca6a6", cursoropacitymax: 1, cursorwidth: 8 });

    //al hacer click en cerrar aparece de nuevo el menu y se blanquea el iframe
    $("#btn_cerrar").click(function() {
        $.msgBox({
            title: "Cerrar Ventana",
            content: "Esta Seguro que desea Cerrar esta Ventana",
            type: "confirm",
            buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
            success: function(result) {
                if (result == "Aceptar") {
                    var padre = $(window.parent.document);
                    $(padre).find(".sidebar").animate({ left: "0px" }, 1000);
                    $(padre).find("#iframes").fadeOut(1000, function() {
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
        editar: false,
        eliminar: false,
        fn_lista: function() {
            if (tablaHighPopulate == 1) {
                MsgConfirmTablaHighPopulate();
            } else {
                if (tablaToolBar == 'cliente') {
                    GetRecord(1);
                }
                ShowGridView();
                EventChangeStatusToolbar();
                $("#divLista").fadeIn();
                SetOcultarNotifica(1);
            }
        },
        fn_buscar: function() {
            CleanFieldsToAlert();
            if (tablaToolBar == 'cliente') {
                MsgBuscarPaciente();
            } else {
                GetRecord(2);
            }
            ViewToolBar2Ini(false);
            ViewButtonSearch();
            EventChangeStatusToolbar();
            $('#txtSearch').val('');
            $('#txtSearch').focus();
        },
        fn_nuevo: function() {
        },
        fn_editar: function() {
        },
        fn_eliminar: function() {
        },
        fn_cancelar: function() {
        },
        fn_guardar: function() {
        }
    });

    ViewButtonsEditAndDelete(false);
});

function EventChangeStatusToolbar() { }

function ViewToolBar2Ini(bShow) {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
}

function ViewButtonsEditAndDelete(bShow) {
    $("#toolbar_tabla").find(".icon-eliminar").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
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
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
    $("#toolbar_tabla").find(".icon-eliminar").hide(); 
    $("#toolbar_tabla").find(".icon-text-justify-center").show(); // Lista
    $("#toolbar_tabla").find(".icon-check").hide();
    $("#toolbar_tabla").find(".icon-cross").hide();
    ViewToolBar2Ini(true);
}

function ViewButtonSearch() {
    $("#toolbar_tabla").find(".icon-editar").hide();
    $("#toolbar_tabla").find(".icon-eliminar").hide();
}

function ShowGridView() { }

function UnloadData_Columns() { }

function MsgConfirmTablaHighPopulate() {
    myMsg = $.msgBox({
        title: "Atención",
        content: 'Estas seguro de querer abrir la lista completa?. Ésta operación podría tardar algunos segundos.',
        type: "info",
        buttons: [{ value: "Continuar" }, { value: "Cancelar"}],
        success: function(result) {
            if (result == "Continuar") {
                if (tablaToolBar == 'cliente') {
                    GetRecord(1);
                }
                ShowGridView();
                EventChangeStatusToolbar();
                $("#divLista").fadeIn();
            }
        }
    });
    $('#txtSearchPaciente').focus();
}

