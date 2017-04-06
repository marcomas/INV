var bCheckToolBarDelContinue = false;
var bCheckToolBarNewContinue = false;
var titEgreso = "egreso";
var titImportar = "importar presupuesto";
var titSelec = "seleccionar";
var titImprimir = "imprimir";
var titDetalle = "consulta";
var titDetalle2 = "cargar";
var titDetalle3 = "modificar";
var titCoberturas = "coberturas";
var titFacturar = "facturar";
var iconEgreso = "icon-arrow-down-bold";
var bToolBarToEditOrDelete = true;

(function($) {
    $.fn.toolbar = function(opciones) {

        //opciones por defecto
        var config = {
            checkbox: [false],
            lista: false,
            buscar: false,
            nuevo: false,
            editar: false,
            eliminar: false,
            cancelar: false,
            guardar: false,
            selec: false,
            egreso: false,
            importar: false,
            detalle: false,
            detalle2: false,
            detalle3: false,
            coberturas: false,
            imprimir: false,
            facturar: false,
            fn_lista: function() { },
            fn_buscar: function() { },
            fn_nuevo: function() { },
            fn_editar: function() { },
            fn_eliminar: function() { },
            fn_cancelar: function() { },
            fn_guardar: function() { },
            fn_selec: function() { },
            fn_egreso: function() { },
            fn_importar: function() { },
            fn_detalle: function() { },
            fn_detalle2: function() { },
            fn_detalle3: function() { },
            fn_coberturas: function() { },
            fn_imprimir: function() { },
            fn_facturar: function() { }

        }
        //extiendo las opciones por defecto con las opciones del parámetro.
        jQuery.extend(config, opciones);

        this.each(function() {
            //creo una variable elem con el elemento actual, El contenedor de la tabla que creare
            elem = $(this);

            if (config.checkbox[0] == true) {
                elem.append("<div class='checkbox " + config.checkbox[1] + "'><label>" + config.checkbox[2] + "</label><input type='checkbox' name='" + config.checkbox[1] + "' id='" + config.checkbox[1] + "' /></div>");
                elem.find("div[class='checkbox']").addClass("unchecked");
                elem.find(".checkbox").click(function() {

                    if ($(this).children("input").attr("checked")) {
                        // uncheck
                        $(this).children("input").removeAttr("checked");
                        $(this).removeClass("checked");
                        $(this).addClass("unchecked");
                    } else {
                        // check
                        $(this).children("input").attr("checked", "checked");
                        $(this).removeClass("unchecked");
                        $(this).addClass("checked");
                    }


                });
            }

            var btn_lista = "btn_lista" + new Date().getTime();
            var btn_selec = "btn_selec" + new Date().getTime();
            var btn_buscar = "btn_buscar" + new Date().getTime();
            var btn_nuevo = "btn_nuevo" + new Date().getTime();
            var btn_editar = "btn_editar" + new Date().getTime();
            var btn_eliminar = "btn_eliminar" + new Date().getTime();
            var btn_cancelar = "btn_cancelar" + new Date().getTime();
            var btn_guardar = "btn_guardar" + new Date().getTime();
            var btn_egreso = "btn_egreso" + new Date().getTime();
            var btn_importar = "btn_importar" + new Date().getTime();
            var btn_detalle2 = "btn_detalle2" + new Date().getTime();
            var btn_detalle3 = "btn_detalle3" + new Date().getTime();
            var btn_detalle = "btn_detalle" + new Date().getTime();
            var btn_coberturas = "btn_coberturas" + new Date().getTime();
            var btn_imprimir = "btn_imprimir" + new Date().getTime();
            var btn_facturar = "btn_facturar" + new Date().getTime();
            var herramientas = "herramientas" + new Date().getTime();

            //botones
            elem.append("<div id='" + btn_lista + "' class='boton icon-text-justify-center' title='Lista'></div>");
            elem.append("<div id='" + btn_selec + "' class='boton icon-check-sel' title='" + titSelec + "'></div>");
            elem.append("<div id='" + btn_buscar + "' class='boton icon-search' title='Buscar'></div>");
            elem.append("<div id='" + btn_nuevo + "' class='boton icon-social-addthis' title='Nuevo'></div>");
            elem.append("<div id='" + btn_editar + "' class='boton icon-editar' title='Editar'></div>");
            elem.append("<div id='" + btn_eliminar + "' class='boton icon-eliminar' title='Eliminar'></div>");
            elem.append("<div id='" + btn_cancelar + "' class='boton icon-cross' title='Cancelar'></div>");
            elem.append("<div id='" + btn_guardar + "' class='boton icon-check' title='Guardar'></div>");
            elem.append("<div id='" + herramientas + "' class='herramientas'></div>");
            var cont = "#" + herramientas;
            elem.find(cont).append("<div id='" + btn_importar + "' class='boton icon-paperclip-oblique' title='" + titImportar + "'></div>");
            elem.find(cont).append("<div id='" + btn_egreso + "' class='boton " + iconEgreso + "' title='" + titEgreso + "'></div>");
            elem.find(cont).append("<div id='" + btn_detalle2 + "' class='boton icon-circles' title='" + titDetalle2 + "'></div>");
            elem.find(cont).append("<div id='" + btn_detalle3 + "' class='boton icon-quote' title='" + titDetalle3 + "'></div>");
            elem.find(cont).append("<div id='" + btn_detalle + "' class='boton icon-info' title='" + titDetalle + "'></div>");
            elem.find(cont).append("<div id='" + btn_coberturas + "' class='boton icon-layers' title='" + titCoberturas + "'></div>");
            elem.find(cont).append("<div id='" + btn_imprimir + "' class='boton icon-document-fill' title='" + titImprimir + "'></div>");
            elem.find(cont).append("<div id='" + btn_facturar + "' class='boton icon-directions' title='" + titFacturar + "'></div>");

            elem.find(".boton").hide();

            //boton egreso
            if (config.egreso == true) {
                elem.find("#" + btn_egreso).show();
                elem.find("#" + btn_egreso).click(config.fn_egreso);
            }

            //boton Importar
            if (config.importar == true) {
                elem.find("#" + btn_importar).show();
            }

            elem.find("#" + btn_importar).click(function() {
                config.fn_importar();
                //                $.msgBox({
                //                    title: "Importar Presupuesto",
                //                    content: "<input type='text' class='campo_box' id='txtCodPresupuesto' onkeypress='javascript:return GetKeyPressed(event)'>",
                //                    type: "confirm",
                //                    buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
                //                    success: function(result) {
                //                        if (result == "Aceptar") {
                //                            ImportPresupuesto();
                //                            config.fn_importar();
                //                        }
                //                    }
                //                });
            });

            //boton detalle2
            if (config.detalle2 == true) {
                elem.find("#" + btn_detalle2).show();
                elem.find("#" + btn_detalle2).click(config.fn_detalle2);
            }

            //boton detalle3
            if (config.detalle3 == true) {
                elem.find("#" + btn_detalle3).show();
                elem.find("#" + btn_detalle3).click(config.fn_detalle3);
            }

            //boton detalle
            if (config.detalle == true) {
                elem.find("#" + btn_detalle).show();
                elem.find("#" + btn_detalle).click(config.fn_detalle);
            }

            //boton coberturas
            if (config.coberturas == true) {
                elem.find("#" + btn_coberturas).show();
                elem.find("#" + btn_coberturas).click(config.fn_coberturas);
            }

            //boton facturar
            if (config.facturar == true) {
                elem.find("#" + btn_facturar).show();
                elem.find("#" + btn_facturar).click(config.fn_facturar);
            }

            //boton imprimir
            if (config.imprimir == true) {
                elem.find("#" + btn_imprimir).show();
                elem.find("#" + btn_imprimir).click(config.fn_imprimir);
            }

            //boton seleccionar
            if (config.selec == true) {
                elem.find("#" + btn_selec).show();
                elem.find("#" + btn_selec).click(config.fn_selec);
            }

            //boton lista
            if (config.lista == true) {
                elem.find("#" + btn_lista).show();
                elem.find("#" + btn_lista).click(config.fn_lista);
            }

            //boton buscar
            if (config.buscar == true) {
                elem.find("#" + btn_buscar).show();
                elem.find("#" + btn_buscar).click(config.fn_buscar);
            }

            //boton nuevo
            if (config.nuevo == true) {
                elem.find("#" + btn_nuevo).show();
                elem.find("#" + btn_nuevo).click(config.fn_nuevo);
                elem.find("#" + btn_nuevo).click(function() {
                    if (bCheckToolBarNewContinue) {
                        if (!CheckToolBarNewContinue()) { return; }
                    }
                    $(this).siblings("#" + btn_cancelar + ",#" + btn_guardar).addClass("press_nuevo");
                    $(this).fadeOut().siblings('#' + btn_buscar + ', #' + btn_editar + ',#' + btn_eliminar + ',#' + btn_lista).fadeOut();
                    $('#' + btn_importar).fadeOut();
                    $(this).siblings("#" + btn_cancelar + ",#" + btn_guardar).fadeIn();

                });
            }

            //boton editar
            if (config.editar == true) {
                elem.find("#" + btn_editar).show();
                elem.find("#" + btn_editar).click(config.fn_editar);
                elem.find("#" + btn_editar).click(function() {
                    if (bToolBarToEditOrDelete == true) {
                        $(this).fadeOut().siblings('#' + btn_buscar + ', #' + btn_nuevo + ',#' + btn_eliminar + ',#' + btn_lista).fadeOut();
                        $('#' + btn_importar).fadeOut();
                        $(this).siblings('#' + btn_cancelar + ', #' + btn_guardar).fadeIn();
                    }
                });
            }

            //boton eliminar
            if (config.eliminar == true) {
                elem.find('#' + btn_eliminar).show();
            }

            elem.find("#" + btn_eliminar).click(function() {
                if (bToolBarToEditOrDelete == true) {
                    if (bCheckToolBarDelContinue) {
                        if (!CheckToolBarDelContinue()) { return; }
                    }
                    $.msgBox({
                        title: "Desea Eliminar",
                        content: "Esta seguro que desea Eliminar",
                        type: "confirm",
                        buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
                        success: function(result) {
                            if (result == "Aceptar") {
                                $('#' + btn_editar + ',#' + btn_eliminar).fadeOut();
                                $('#' + btn_buscar + ',#' + btn_nuevo).fadeIn();
                                config.fn_eliminar();
                            }
                        }
                    });
                }
            });

            //boton cancelar
            if (config.cancelar == true) {
                elem.find('#' + btn_cancelar).show();
            }

            elem.find('#' + btn_cancelar).click(function() {
                if ($(this).hasClass("press_nuevo")) {
                    $(this).fadeOut().siblings('#' + btn_guardar).fadeOut();
                    $(this).siblings('#' + btn_buscar + ', #' + btn_nuevo).fadeIn();
                    $(this).removeClass("press_nuevo").siblings('#' + btn_guardar).removeClass("press_nuevo");
                    $('#' + btn_buscar + ',#' + btn_nuevo + ', #' + btn_lista).fadeIn();
                    if (config.importar == true) {
                        $('#' + btn_importar).fadeIn();
                    }
                    config.fn_cancelar();
                    for (i = 1; i < aCtrl.length; i++) {
                        var oCtrl = aCtrl[i];
                        $('#' + oCtrl.id).val() == ''
                        $('#' + oCtrl.id).removeClass('errorFields');
                        $('#' + oCtrl.id).removeClass("vanadium-invalid");
                        $("span").empty();
                        $("span").removeClass("vanadium-invalid");
                        $("span").removeClass("vanadium-advice");
                    }
                }
                else {
                    $.msgBox({
                        title: "Desea Cancelar",
                        content: "Esta seguro que desea cancelar? se perderan los avances que no haya guardado",
                        type: "confirm",
                        buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
                        success: function(result) {
                            if (result == "Aceptar") {
                                $('#' + btn_guardar + ',#' + btn_cancelar).fadeOut();
                                $('#' + btn_buscar + ',#' + btn_nuevo + ', #' + btn_editar + ',#' + btn_eliminar + ',#' + btn_lista).fadeIn();
                                if (config.importar == true) {
                                    $('#' + btn_importar).fadeIn();
                                }
                                config.fn_cancelar();
                                for (i = 1; i < aCtrl.length; i++) {
                                    var oCtrl = aCtrl[i];
                                    $('#' + oCtrl.id).val() == ''
                                    $('#' + oCtrl.id).removeClass('errorFields');
                                    $('#' + oCtrl.id).removeClass("vanadium-invalid");
                                    $("span").empty();
                                    $("span").removeClass("vanadium-invalid");
                                    $("span").removeClass("vanadium-advice");
                                }
                            }
                        }
                    });
                } //fin else
            });

            //boton guardar
            if (config.guardar == true) {
                elem.find('#' + btn_guardar).show();
            }

            elem.find('#' + btn_guardar).click(function() {
                config.fn_guardar();
                //                if ($(this).hasClass("press_nuevo")) {
                //                    $(this).fadeOut().siblings('#' + btn_cancelar).fadeOut();
                //                    $(this).siblings('#' + btn_buscar + ', #' + btn_nuevo + ', #' + btn_editar + ',#' + btn_eliminar).fadeIn();
                //                    $(this).removeClass("press_nuevo").siblings('#' + btn_cancelar).removeClass("press_nuevo");
                //                    config.fn_guardar();
                //                } else {
                //                    config.fn_guardar();
                //                    $.msgBox({
                //                        title: "Guardar Cambios",
                //                        content: "Desea Guardar los Cambios",
                //                        type: "confirm",
                //                        buttons: [{ value: "Aceptar" }, { value: "Cancelar"}],
                //                        success: function(result) {
                //                            if (result == "Aceptar") {
                ////                                $('#' + btn_guardar + ',#' + btn_cancelar).fadeOut();
                ////                                $('#' + btn_buscar + ',#' + btn_nuevo + ', #' + btn_editar + ',#' + btn_eliminar).fadeIn();
                //                                config.fn_guardar();
                //                            }
                //                        }
                //                    });
                //                }
            });

        }); //fin this.each



        //siempre tengo que devolver this
        return this;
    };
})(jQuery);