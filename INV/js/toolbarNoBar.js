
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
        editar: false,
        eliminar: false,
        fn_lista: function() {
        },
        fn_buscar: function() {
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

function EventChangeStatusToolbar() {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
}

function ViewToolBar2Ini(bShow) {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
}

function ViewButtonsEditAndDelete(bShow) {
    $("#toolbar_tabla").find(".icon-eliminar").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
    ViewToolBar2Ini(bShow);
}

function ViewButtonCancelAndSave() {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
}

function ViewButtonSearch() {
    $("#toolbar_tabla").find(".icon-editar").hide();
    $("#toolbar_tabla").find(".icon-eliminar").hide();
}

function ShowGridView() {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
}

function UnloadData_Columns() {
    $("#toolbar_tabla").find(".icon-social-addthis").hide();
    $("#toolbar_tabla").find(".icon-editar").hide();
}

function EditMode() { }

