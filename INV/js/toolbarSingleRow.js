var bEditOrNew = false;
var bNoFields = false;
var bEdit = true;

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
        lista: false,
        buscar: false,
        nuevo: false,
        editar: true,
        eliminar: false,
        fn_lista: function() {
        },
        fn_buscar: function() {
        },
        fn_nuevo: function() {
        },
        fn_editar: function() {
            CleanFieldsToAlert
            indexRecordSelected = 0;
            PrepareFieldsToEditRecord();
            ViewToolBar2Ini(false);
            bEditOrNew = true;
        },
        fn_eliminar: function() {
        },
        fn_cancelar: function() {
            CleanFieldsToAlert();
            bEditOrNew = false;
            EditMode();
            
            if (tabla == 'configuracion') {
                $('#txtCantidadSV').attr('disabled', 'disabled');
            } else if (tabla == 'red') {
                $('#txtNombre').attr('disabled', 'disabled');
                $('#txtRIF').attr('disabled', 'disabled');
                $('#txtDireccion').attr('disabled', 'disabled');
                $('#txtEstado').attr('disabled', 'disabled');
                $('#txtCiudad').attr('disabled', 'disabled');
                $('#txtTelefono').attr('disabled', 'disabled');
                $('#txtEmail').attr('disabled', 'disabled');
                $('#txtWWW').attr('disabled', 'disabled');            
            }
        },
        fn_guardar: function() {
            CleanFieldsToAlert();
            if (CheckFieldsToAlert()) {
                MsgGuardar();
            } else {
                ViewButtonCancelAndSave();
            }
            EditMode();
        }
    });

    ViewButtonsEditAndDelete(false);
});

function EventChangeStatusToolbar() { }

function ViewToolBar2Ini(bShow) {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    if (!bEdit) { $("#toolbar_tabla").find(".icon-social-addthis").hide(); }
}

function ViewButtonsEditAndDelete(bShow) {
    if (bEditOrNew) { return; }
    if (bShow) {
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
    EditMode();
    ViewToolBar2Ini(true);
}

function ViewButtonSearch() {
    $("#toolbar_tabla").find(".icon-editar").hide();
    $("#toolbar_tabla").find(".icon-eliminar").hide();
}

function ShowGridView() { }

function UnloadData_Columns() { }

function EditMode() {
    $("#toolbar_tabla").find(".icon-search").hide();
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").show();
    $("#toolbar_tabla").find(".icon-eliminar").hide();
    $("#toolbar_tabla").find(".icon-text-justify-center").hide(); // Lista
    $("#toolbar_tabla").find(".icon-check").hide();
    $("#toolbar_tabla").find(".icon-cross").hide();
}

