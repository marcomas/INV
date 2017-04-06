<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EntradaSalida.aspx.vb" Inherits="INV.EntradaSalida" %>

<!DOCTYPE html>
<html style="overflow: hidden;">
<head runat="server">
    <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
    <!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
    <!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
    <!--[if gt IE 8]><!    <html class="no-js"> <!--<![endif]-->
    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>INV</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <link rel="stylesheet" href="../css/normalize.css?0.0.0.6">
    <link rel="stylesheet" href="../css/main.css?0.0.0.6">
    <link rel="stylesheet" href="../css/style.css?0.0.0.6">
    <link rel="stylesheet" href="../css/jquery-ui.css?0.0.0.6" />
    
    <link rel="stylesheet" href="../Scripts/jqwidgets/jqwidgets/styles/jqx.base.css" type="text/css" />
    
    <script type="text/javascript" src="../Scripts/jqwidgets/scripts/gettheme.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/scripts/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxinput.js"></script>
    
    <link rel="stylesheet" href="../Scripts/jqwidgets/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../js/Validaciones/vanadium.css" type="text/css" media="screen"> 
    <script type="text/javascript" src="../js/Validaciones/vanadium_es.js"></script>

    <script type="text/javascript" src="../js/Validaciones/vanadium_es.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxdata.js"></script> 
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxgrid.pager.js"></script> 
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxgrid.columnsresize.js"></script> 
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqx-all.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxwindow.js"></script>

    <script src="../js/jquery.nicescroll.min.js?0.0.0.6"></script>
    <script src="../js/main.js?0.0.0.6"></script>
    <script src="../js/jquery-ui.js?0.0.0.6"></script>
    <script src="../js/jquery.msgBox.js?0.0.0.6"></script>
    <script src="../js/herramientas.js?0.0.0.6"></script>
    <script src="../js/articulo.js?0.0.0.6"></script>
    <script src="../js/fields.js?0.0.0.6"></script>
    
    <link rel="stylesheet" href="../materialize-src/sass/estilosModal.css">      
    <script src="../materialize-src/sass/materialize.js"></script> 
    
	<link href='http://fonts.googleapis.com/css?family=Days+One' rel='stylesheet' type='text/css'>
	<style type="text/css">
        @media only screen and (max-width: 640px) {
            img {max-width: 100%;}
            .logo {padding: 30px !important;}
            .myButton {margin: 15px 10px !important;}
            .cont_botones {padding: 20px 5px 30px !important;}
            .cont_logo {top: 0px !important;}
        }
	    body {
        background: url("Immagini/bg.jpg") repeat top center;
        padding: 0px; margin: 0px;
        }

        .myButton {
            -moz-box-shadow:inset 0px 3px 2px -1px #ffffff;
            -webkit-box-shadow:inset 0px 3px 2px -1px #ffffff;
            box-shadow:inset 0px 3px 2px -1px #ffffff;
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf));
            background:-moz-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background:-webkit-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background:-o-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background:-ms-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background:linear-gradient(to bottom, #ededed 5%, #dfdfdf 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf',GradientType=0);
            background-color:#ededed;
            -moz-border-radius:10px;
            -webkit-border-radius:10px;
            border-radius:10px;
            border:4px solid #dcdcdc;
            display:inline-block;
            cursor:pointer;
            color:#192a4f;
            font-family: 'Days One', sans-serif;
            font-size:50px;
            font-weight:bold;
            padding:100px 76px;
            text-decoration:none;
            text-shadow:-1px 2px 2px #ffffff;
        }
        .myButton:hover {
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed));
            background:-moz-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
            background:-webkit-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
            background:-o-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
            background:-ms-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
            background:linear-gradient(to bottom, #dfdfdf 5%, #ededed 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed',GradientType=0);
            background-color:#dfdfdf;
        }
        .myButton:active {
            position:relative;
            top:1px;
        }
    	
	    .cont_botones {
		    text-align: center;
		    padding: 70px 0px;
	    }

	    .cont_logo {
		    box-shadow: 0px 0px 15px 3px rgba(0, 0, 0, 0.75);
		    padding: 10px 0px;
		    width: 100%;
		    text-align: center;
		    background: #FFF none repeat scroll 0% 0%;
		    position: relative;
		    top: 0px;
	    }

        .cont_botones{text-align: center; padding: 100px 0px;}
	    .cont_botones a {margin: 0px 10px;}
	</style>
	
	<script>

	    //-- CONSTANTES --//
	    var tabla = 'EntradaSalida';

	    //-- VARIABLES --//
	    var articulo;
	    var isEntrada = false;
	    var aPesonal = new Array();
	    var aArticulo = new Array();
	    var indexselect = -1;
	    var indexselectArt = -1;

	    //-- SETUP --//
	    $(function () {

	        $("#divMsgBoxImprimir").fadeOut();

	        $(".close_grid").click(function() {
	            $(".cont_grid").fadeOut();
	            $("#divArticulos").fadeOut();
	            $(".overlay").fadeOut();
	            //clearInterval(intervalVar);
	            //SetOcultarNotifica(0);
	        });

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

	        $("#btSalida").click(function () {
	            isEntrada = false;
	            $('#modalSalida').modal("open");
	            $('#modalSalida').css("z-index", 999);
	            $('#modalSalida').css("top", "130px");
	            $('.modal-overlay').css("z-index", 998); 
	            $('.modal-content').css('padding', '0px');

	            $('#txtCodArtS').keypress(function (e) {
	                if (e.which == 13) {
	                    BuscarArticuloSalida();
	                }
	            });
	            $('#btBuscarArtS').click(function () {
	                BuscarArticuloSalida();
	                /* llamada al sp para consltar el art*/
	            });

	            $('#btCatArtS').click(function () {
	                _ShowGridView();
	            });
	            $('#divexistenciasalida').show();
	            $('#divcantidadsalida').show();
	            $('#divestatussalida').hide();
	            $('#divfechasalida').hide();
	            setTimeout($('#txtCodArtS').focus(), 1000);
	        });
	        $("#btModalsalirS").click(function () {
	            $('#modalSalida').modal("close");
	        });
	        $("#btModalLimpiarS").click(function () {
	            LimpiarCampos();
	            DesHabilitarCampos();
	            setTimeout($('#txtCodArtS').focus(), 1000);
	        });
	        $("#btModalGuardarS").click(function () {
	            if (ValidarCamposSalida()) {
	                if (articulo[12] == false) {
	                    if (ESArticuloU()) {
	                        LimpiarCampos();
	                        DesHabilitarCampos();
	                    }
	                } else {
	                    if (ESArticuloC()) {
	                        LimpiarCampos();
	                        DesHabilitarCampos();
	                    }
	                }
	            }
	            setTimeout($('#txtCodArtS').focus(), 1000);
	        });

	        $("#btEntrada").click(function () {
	            $('#modalEntrada').modal("open");
	            $('#modalEntrada').css("z-index", 999);
	            $('.modal-overlay').css("z-index", 998);
	            $('.modal-content').css('padding', '0px');

	            isEntrada = true;
	            $('#divexistenciaentrada').show();
	            $('#divcantidadentrada').show();
	            $('#divestatusentrada').hide();
	        });

	        $("#btModalsalir").click(function () {
	            $('#modalEntrada').modal("close");
	        });
	        $("#btModalLimpiar").click(function () {
                LimpiarCampos();
                DesHabilitarCampos();
                setTimeout($('#txtCodArt').focus(), 1000);
            });
            $("#btModalGuardar").click(function () {
                if (ValidarCampos()) {
                    if (articulo[12] == false) {
                        if (ESArticuloU()) {
                            LimpiarCampos();
                            DesHabilitarCampos();
                        }
                    } else if (ESArticuloC()) {
                        LimpiarCampos();
                        DesHabilitarCampos();
                    }
                }
            });
	        $('#txtCodArt').keypress(function(e) {
	            if (e.which == 13) {
	                BuscarArticulo();
	            }
	        });
	        $('#btBuscarArt').click(function() {
	            BuscarArticulo();
	            /* llamada al sp para consltar el art*/
	        });
	        $('#btCatArt').click(function() {
	            _ShowGridView();
	        });
	        $('#btImprimirCode').click(function () {
	            $.msgBox({
	                    title: "Imprimir",
	                    content: "Esta Seguro que desea Imprimir el Codigo de Barra?",
	                    type: "confirm",
	                    buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
	                    success: function (result) {
	                        if (result == "Aceptar") {
	                            window.open("../Print/PrintBarCode.aspx?Codigo=" + $('#txtCodArt').val(), "_blank ");
	                        }
	                    }
	                });
	                return false;
	            });
	            setTimeout($('#txtCodArt').focus(), 1000);
	        });


	        function BuscarArticulo() {
	            var cod = $('#txtCodArt').val();
	            if (cod == '') {
	                MsgAlert('Ingrese un articulo.');
	                $('#txtCodArt').focus;
	            } else {
	                GetArticulo(cod);
	                if (articulo != '') {
	                    $('#txtNombreArticulo').val(articulo[1] + ' | ' + articulo[2]);
	                    $('#txtCodArt').removeClass('errorFields');
	                    if (articulo[12] == false) {
	                        $('#selectestatus').val(getEstatus(parseInt(articulo[11])))
	                    } else {
	                        $('#txtExistencia').val(articulo[8]);
	                    }
	                    GetPersonalProveedor();
	                    HabilitarCampos();
	                } else {
	                    MensajeCrearyOtraBusqueda()
	                }
	            }
	        }

	        function BuscarArticuloSalida() {
	            var cod = $('#txtCodArtS').val();
	            if (cod == '') {
	                MsgAlert('Ingrese un articulo.');
	                $('#txtCodArtS').focus;
	            } else {
	                GetArticulo(cod);
	                if (articulo != '') {
	                    $('#txtNombreArticuloS').val(articulo[1] + ' | ' + articulo[2]);
	                    $('#txtCodArtS').removeClass('errorFields');
	                    if (articulo[12] == false) {
	                        $('#selectestatusS').val(getEstatus(parseInt(articulo[11])))
	                    } else {
	                        $('#txtExistenciaS').val(articulo[8]);
	                    }
	                    GetPersonalProveedor();
	                    HabilitarCampos();
	                } else {
	                    MensajeCrearyOtraBusqueda()
	                }
	            }
	        }

	        function ValidarCampos() {
	            var textsvalidos = true
	            if ($('#txtNombreArticulo').val() == '') {
	                MsgError('Ingrese un articulo.');
	                $('#txtCodArt').addClass('errorFields');
	                return false;
	            }
	            $('#txtCodArt').removeClass('errorFields');
	            $('#txtResponsable').removeClass('errorFields');
	            $('#txtCantidad').removeClass('errorFields');
	            if ($('#txtResponsable').val() == '') {
	                $('#txtResponsable').addClass('errorFields');
	                textsvalidos = false;
	            }
	            if (indexselect == -1) {
	                $('#txtResponsable').addClass('errorFields');
	                textsvalidos = false;
	            }
	            if ($('#txtCantidad').val() == '' && articulo[12] == true) {
	                $('#txtCantidad').addClass('errorFields');
	                textsvalidos = false;
	            }

	            if (!isEntrada) {
	                if (articulo[12] == false) {
	                    if ($('#txtFechaReintegro').val().length != 10 && articulo[12] == false) {
	                        $('#txtFechaReintegro').addClass('errorFields');
	                        textsvalidos = false;
	                    }
	                }
	            }

	            if (!textsvalidos) {
	                MsgError('Algunos campos son abligatorios.');
	            }
	            return textsvalidos;
	        }

	        function ValidarCamposSalida() {
	            var textsvalidos = true
	            if ($('#txtNombreArticuloS').val() == '') {
	                MsgError('Ingrese un articulo.');
	                $('#txtCodArtS').addClass('errorFields');
	                return false;
	            }
	            $('#txtCodArtS').removeClass('errorFields');
	            $('#txtResponsableS').removeClass('errorFields');
	            $('#txtCantidadS').removeClass('errorFields');
	            if ($('#txtResponsableS').val() == '') {
	                $('#txtResponsableS').addClass('errorFields');
	                textsvalidos = false;
	            }
	            if (indexselect == -1) {
	                $('#txtResponsableS').addClass('errorFields');
	                textsvalidos = false;
	            }
	            if ($('#txtCantidadS').val() == '' && articulo[12] == true) {
	                $('#txtCantidadS').addClass('errorFields');
	                textsvalidos = false;
	            }

	            if (!isEntrada) {
	                if (articulo[12] == false) {
	                    if ($('#txtFechaReintegro').val().length != 10 && articulo[12] == false) {
	                        $('#txtFechaReintegro').addClass('errorFields');
	                        textsvalidos = false;
	                    }
	                }
	            }

	            if (!textsvalidos) {
	                MsgError('Algunos campos son abligatorios.');
	            }
	            return textsvalidos;
	        }

	        function MensajeCrearyOtraBusqueda() {
	            $.msgBox({
	                title: "Buscar Articulo",
	                content: "Articulo Inexintente en Inventario",
	                type: "alert",
	                buttons: [{ value: "Crear" }, { value: "Asociar" }, { value: "Salir"}],
	                success: function(result) {
	                    if (result == "Crear") {
	                        /*Visiaulizar la pantalla de articulo*/
	                        var padre = $(window.parent.document);
	                        $(padre).find(".sidebar").animate({ left: "0px" }, 1000);
	                        $(padre).find("#iframes").fadeOut(1000, function() {
	                            $(padre).find(".desktop").html("");
	                        });
	                        OpenArticulo();
	                    } else if (result == "Otra Busqueda") {
	                        MostrarCatalogoUbicacion();
	                    } else if (result == "Asociar") {
	                        CapturarArticulo();
	                    }
	                }
	            });
	            return false;
	        }

	        function HabilitarCampos() {
	            $('#btBuscarArt').attr('disabled', 'disabled');
	            $('#btBuscarArtS').attr('disabled', 'disabled');
	            $('#btCatArt').attr('disabled', 'disabled');
	            $('#txtCodArt').attr('disabled', 'disabled');
	            $('#txtResponsable').removeAttr('disabled');
	            $('#btCatArtS').attr('disabled', 'disabled');
	            $('#txtCodArtS').attr('disabled', 'disabled');
	            $('#txtResponsableS').removeAttr('disabled');
	            $('#txtNota').removeAttr('disabled');
	            $('#txtCantidad').removeAttr('disabled');
	            $('#txtNotaS').removeAttr('disabled');
	            $('#txtCantidadS').removeAttr('disabled');
	            if (articulo[12] == false) {
	                $('#divbr').hide();
	                $('#divexistenciaentrada').hide();
	                $('#divexistenciasalida').hide();
	                $('#divcantidadentrada').hide();
	                $('#divcantidadsalida').hide();
	                $('#divestatusentrada').show();
	                $('#divestatussalida').show();
	                $('#divfechasalida').show();

	            }
	            else {
	                $('#divbr').show();
	                $('#divexistenciaentrada').show();
	                $('#divexistenciasalida').show();
	                $('#divcantidadentrada').show();
	                $('#divcantidadsalida').show();
	                $('#divestatusentrada').hide();
	                $('#divestatussalida').hide();
	                $('#divfechasalida').hide();
	            }
	        }

	        function DesHabilitarCampos() {
	            $('#txtCodArt').removeAttr('disabled');
	            $('#btCatArt').removeAttr('disabled');
	            $('#btBuscarArt').removeAttr('disabled');
	            $('#txtResponsable').attr('disabled', 'disabled');
	            $('#txtNota').attr('disabled', 'disabled');
	            $('#txtCantidad').attr('disabled', 'disabled');
	            $('#divcantidadentrada').show();
	            $('#divexistenciaentrada').show();
	            $('#divexistenciasalida').show();
	            $('#divestatusentrada').hide();
	            $('#divcantidadsalida').show();
	            $('#divestatussalida').hide();
	            $('#divfechasalida').hide();
	            $('#divbr').show();
	            $('#txtCodArtS').removeAttr('disabled');
	            $('#btCatArtS').removeAttr('disabled');
	            $('#btBuscarArtS').removeAttr('disabled');
	            $('#txtResponsableS').attr('disabled', 'disabled');
	            $('#txtNotaS').attr('disabled', 'disabled');
	            $('#txtCantidadS').attr('disabled', 'disabled');
	        }

	        function LimpiarCampos() {
	            $('#txtCodArt').val('');
	            $('#txtResponsable').val('');
	            $('#txtNota').val('');
	            $('#txtExistencia').val('');
	            $('#txtCantidad').val('');
	            $('#txtNombreArticulo').val('');
	            $('#txtFechaReintegro').val('');
	            $('#txtCodArt').removeClass('errorFields');
	            $('#txtResponsable').removeClass('errorFields');
	            $('#txtCantidad').removeClass('errorFields');
	            $('#txtFechaReintegro').removeClass('errorFields');
	            $('#txtCodArtS').val('');
	            $('#txtResponsableS').val('');
	            $('#txtNotaS').val('');
	            $('#txtExistenciaS').val('');
	            $('#txtCantidadS').val('');
	            $('#txtNombreArticuloS').val('');
	            $('#txtFechaReintegro').val('');
	            $('#txtCodArtS').removeClass('errorFields');
	            $('#txtResponsableS').removeClass('errorFields');
	            $('#txtCantidadS').removeClass('errorFields');
	        }

	    function GetArticulo(codArticulo) {
	        var info = codArticulo + '|';
	        $.ajax({
	            type: "POST",
	            url: "../WS/WSTablas.aspx",
	            data: { tabla: 'articulo', fun: 'getProduct', data: info,querytype:57 },
	            async: false
	        }).done(function(data) {
	            if (data.split('§')[0] != "OK") {
	                articulo = '';
	            } else {
	                articulo = data.split('§')[1].split('|');
	            }
	        });
	    }

	    function GetPersonalProveedor() {
	        aPesonal = [];
	        $.ajax({
	            type: "POST",
	            url: "../WS/WSTablas.aspx",
	            data: { tabla:tabla, fun: 'getListCodigo' },
	            async: false
	        }).done(function(data) {
	        if (data.split('§')[0] == "OK") {
	                var a = data.split('§')[1].split('$');
	                for (i = 0; i < a.length; i++) {
	                    aPesonal.push(a[i].split('|')[0] + '|' + a[i].split('|')[1]);
	                }
	                $("#txtResponsable").jqxInput({source: aPesonal });
	                $('#txtResponsable').change(function () {
	                    indexselect = aPesonal.indexOf($('#txtResponsable').val());
	                });
	                $("#txtResponsableS").jqxInput({ source: aPesonal });
	                $('#txtResponsableS').change(function () {
	                    indexselect = aPesonal.indexOf($('#txtResponsableS').val());
	                });
	            }
	        });
	    }


	    function ESArticuloC() {
	        var resp = true;
	        var cantidad = $('#txtCantidad').val();
	        var CodPersonal = aPesonal[indexselect].split('|')[0];
	        var Notas = $('#txtNota').val();
            var fun = 'entradaArticuloC';
            if (!isEntrada) {
                fun = 'salidaArticuloC';
                var cantidad = $('#txtCantidadS').val();
                var Notas = $('#txtNotaS').val();
            }
            var info = cantidad + '|' + CodPersonal + '|' + Notas + '|';

            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { tabla: tabla, fun: fun, data: info, id: articulo[0] },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] != "OK") {
                    MsgAlert(data.split('§')[1]);
                    resp = false;
                } else {
                    if (isEntrada) { MsgInfo('Articulo Ingresado'); } else { MsgInfo('Articulo Egresado'); }
                    resp = true;
                }
            });
            return resp;
        }

	    function ESArticuloU() {
	        var resp = true;
	        var CodPersonal = aPesonal[indexselect].split('|')[0];
	        var Notas = $('#txtNota').val();
	        var estatus= $('#selectestatus').val();
	        var fechareintegro = $('#txtFechaReintegro').val();
            var fun = 'entradaArticuloU';
            if (!isEntrada) {
                fun = 'salidaArticuloU';
                var Notas = $('#txtNotaS').val();
                var estatus = $('#selectestatusS').val();
            }
            var info = getIdEstatus(estatus) + '|' + CodPersonal + '|' + Notas + '|' + fechareintegro + '|';
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { tabla: tabla, fun: fun, data: info, id: articulo[0] },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] != "OK") {
                    MsgAlert(data.split('§')[1]);
                    resp = false;
                } else {
                    if (isEntrada) { MsgInfo('Articulo Ingresado'); } else { MsgInfo('Articulo Egresado'); }
                    resp = true;
                }
            });
            return resp;
        }

        function OpenArticulo() {
            $.ajax({
                type: "POST",
                url: "../WS/WSSessionVar.aspx",
                data: { name: 'OpenArticulo', fun: 'set', value: 1 }
            }).done(function (data) { });
        }

        function CapturarArticulo() {
            var html = '<input type="text" value="" id="txtArticulo" onkeypress="javascript:return GetKeyPressed(event)"/>';
            myMsg = $.msgBox({
                title: "Asociar Articulo",
                content: "<div style='text-align: center;'>" + html + "</div>",
                type: "info",
                bCloseMsgBox: false,
                buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                success: function (result) {
                    if (result == "Aceptar") {
                        bCloseMsgBox = AddBarCode(aArticulo[indexselectArt].split('|')[0]);
                    }
                    else {
                        bCloseMsgBox = true;
                        $(".overlay").fadeOut();
                    }
                }
            });
            GetListArticulo();
            $('#txtArticulo').focus();
            $("#txtArticulo").jqxInput({ placeHolder: "Articulo", height: 5, width: 200, minLength: 1, source: aArticulo });
        }

        function AddBarCode(idProduct) {
            var resp = true;
            var barcode = $('#txtCodArt').val() + "|";
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: 'articulo', fun: 'AddBarCode', data: barcode, id: idProduct }
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    resp = false;
                    MsgError(data.split('§')[1]);
                }
            }).fail(function () {
                aSource = dataresp;
                alert("error");
            });
            return resp;
        }
	
        function GetListArticulo() {
            aPesonal = [];
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { tabla: 'Articulo', fun: 'getRecord',id:0, data:'' },
                async: false
            }).done(function (data) {
                if (data.split('§')[0] == "OK") {
                    var a = data.split('§')[1].split('$');
                    for (i = 0; i < a.length; i++) {
                        aArticulo.push(a[i].split('|')[0] + '|' + a[i].split('|')[1] + '|' + a[i].split('|')[2]);
                    }
                    $("#txtArticulo").jqxInput({ source: aPesonal });
                    $('#txtArticulo').change(function () {
                        indexselectArt = aArticulo.indexOf($('#txtArticulo').val());
                    });
                }
            });
        }
	</script>


    <script>

        //-- GRID VIEW --//
        var _column1 = new Array();
        var _column2 = new Array();
        var _column3 = new Array();
        var aArticulos = new Array();

        $(document).ready(function () {
            var theme = getDemoTheme();

            $("#_jqxgrid").on('rowselect', function (event) {
                $('#txtCodArt').val(event.args.row.codigo);
                $('#txtCodArtS').val(event.args.row.codigo);
                $(".close_grid").click();
                setTimeout($('#txtCodArt').focus(), 1000);
            });

            $("#_loadGridView").click(function () {
                // prepare the data
                var data = _LoadDataGridView(_column1.length);

                var customsortfunc = function (column, direction) {
                    var sortdata = new Array();

                    if (direction == 'ascending') direction = true;
                    if (direction == 'descending') direction = false;

                    if (direction != null) {
                        for (i = 0; i < data.length; i++) {
                            sortdata.push(data[i]);
                        }
                    }
                    else sortdata = data;

                    var tmpToString = Object.prototype.toString;
                    Object.prototype.toString = (typeof column == "function") ? column : function () { return this[column] };
                    if (direction != null) {
                        sortdata.sort(compare);
                        if (!direction) {
                            sortdata.reverse();
                        }
                    }
                    source.localdata = sortdata;
                    $("#_jqxgrid").jqxGrid('databind', source, 'sort');
                    Object.prototype.toString = tmpToString;
                }

                // custom comparer.
                var compare = function (value1, value2) {
                    value1 = String(value1).toLowerCase();
                    value2 = String(value2).toLowerCase();

                    try {
                        var tmpvalue1 = parseFloat(value1);
                        if (isNaN(tmpvalue1)) {
                            if (value1 < value2) { return -1; }
                            if (value1 > value2) { return 1; }
                        }
                        else {
                            var tmpvalue2 = parseFloat(value2);
                            if (tmpvalue1 < tmpvalue2) { return -1; }
                            if (tmpvalue1 > tmpvalue2) { return 1; }
                        }
                    }
                    catch (error) {
                        var er = error;
                    }

                    return 0;
                };

                var source =
                {
                    localdata: data,
                    sort: customsortfunc,
                    datafields:
                    [
                        { name: 'codigo', type: 'string' },
                        { name: 'nombre', type: 'string' },
                        { name: 'nivel', type: 'string' }
                    ],
                    datatype: "array"
                };
                var dataAdapter = new $.jqx.dataAdapter(source);

                $("#_jqxgrid").jqxGrid(
                {
                    width: 800,
                    source: dataAdapter,
                    theme: theme,
                    showfilterrow: true,
                    filterable: true,
                    sortable: true,
                    pageable: true,
                    pagesize: 20,
                    autoheight: true,
                    columnsresize: true,
                    selectionmode: 'singlerow',
                    ready: function () {
                        $("#_jqxgrid").jqxGrid('sortby', 'id', 'asc');
                    },
                    showstatusbar: false,
                    columns: [
                      { text: 'Codigo', columntype: 'textbox', filtertype: 'textbox', datafield: 'codigo', width: 120 },
                      { text: 'Nombre', columntype: 'textbox', filtertype: 'textbox', datafield: 'nombre', width: 230},
                      { text: 'Nivel', columntype: 'textbox', filtertype: 'textbox', datafield: 'nivel', width:  450}
                    ]
                });
            });
        });

        function _RefreshGridView() {
            clearInterval(intervalVarRefreshGridView);
            $("#_loadGridView").click();
            $("#_jqxgrid").jqxGrid('clearfilters');
        }

        function _LoadDataGridView(rowscount, hasNullValues) {
            var data = new Array();
            if (rowscount == undefined) rowscount = 100;
            for (var i = 0; i < rowscount; i++) {
                var row = {};
                row["id"] = i;
                row["codigo"] = _column1[i];
                row["nombre"] = _column2[i];
                row["nivel"] = _column3[i];
                data[i] = row;
            }
            return data;
        }

        function _UnloadData_Columns() {
            aArticulos = [];
            _column1 = [];
            _column2 = [];
            _column3 = [];
        }

        function _LoadGridView(index) {
            _column1.push(aArticulos[index].split('|')[1]);
            _column2.push(aArticulos[index].split('|')[2]);
            _column3.push(aArticulos[index].split('|')[5]);
        }

        function _ShowGridView() {
            $("#_jqxgrid").jqxGrid('clearfilters');
            GetRecordProductos();
            $(".overlay").fadeIn();
            $("#divArticulos").fadeIn();
            intervalVarRefreshGridView = setInterval(function () { _RefreshGridView() }, 1000);
        }

        function _LoadDataFromSource(source) {
            _UnloadData_Columns();
            aArticulos = source.split('$');
            for (i = 0; i < aArticulos.length; i++) {
                _LoadGridView(i);
            }
        }

        function GetRecordProductos() {
            _UnloadData_Columns();

            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: {tabla:'articulo',data:'', fun: 'getRecord' },
                async: false
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    MsgInfo('No existen Articulos.');
                } else {
                    var source = data.split('§')[1];
                    _LoadDataFromSource(source);
                }
            });
        }


    </script>
</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <div class="overlay2"></div>

    <h1 class="titulo_iframe">Entradas y Salidas<a href="#" id="btn_cerrar"></a></h1>
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="_loadGridView" value="Carga data en Grid View" />
    </div>

    <div class="cont_grid" style="width:800px;left:20%;" id="divArticulos">
        <h1 class="title_grid">&nbsp;</h1>
        <span class="close_grid"></span>
        <div id="_jqxgrid"></div>      
    </div>

    <div class="cont_botones">
        <a class="myButton" href="#" id="btEntrada" style="width:460px;" >ENTRADA</a>
        <a class="myButton" href="#" id="btSalida" style="width:460px;">SALIDA</a>
    </div>
    
     <div id="modalEntrada" class="modal" style="padding:0px!important;width:620px!important;z-index:999!important;top:25%!important;">
        <div class="modal-content" style="z-index:999!important;">
            <div id="modaltitle" style="height: 35px;">
            <h5>ENTRADA</h5><br>
            </div>
            <div id="divmodalCuerpo" style="background-color:#e58144;width: 620px!important;padding:0px!important;">
                <div id="divmodalCampos" style="background-color:#e58144;width: 520px!important;padding:20px!important;">
                <div class="row" style="margin-top:15px!important;">
                    <div class="cell"><label>Cod. Art.</label></div>
                    <div class="cell"><input type="text" style="width:150px !important;" value="" id="txtCodArt" /><button id="btBuscarArt" class="boton" style ="margin-left:9px !important;">Cargar</button><button id="btCatArt" class="boton" style ="margin-left:9px !important;">Buscar por nombre</button></div>
                </div>
                <div class="row">
                    <div class="cell"><label>Articulo</label></div>
                    <div class="cell"><input type="text" style="width:390px !important;margin-top: 5px;" disabled="disabled" value="" id="txtNombreArticulo" /></div>
                </div>
                <div class="row">
                    <div class="cell"><label>Responsable</label></div>
                    <div class="cell"><input type="text" style="width:390px !important;" disabled="disabled" value="" id="txtResponsable" /></div>
                </div>
                <div class="row">
                    <div class="cell"><label>Nota</label></div>
                    <div class="cell"><input type="text" style="width:390px !important;" disabled="disabled" value="" id="txtNota" /></div>
                </div>
                <div class="row" id="divexistenciaentrada">
                    <div class="cell"><label>Existencia</label></div>
                    <div class="cell"><input type="text" id="txtExistencia" style="width:50px !important;" disabled="disabled"/></div>
                </div>
                <div class="row" id="divcantidadentrada">
                    <div class="cell"><label>Cantidad</label></div>
                    <div class="cell"><input type="text" style="width:50px !important;" disabled="disabled" value="" id="txtCantidad" onkeypress="javascript:return ValidaCampoNumero(event, this)"  /></div>
                </div>
                 <div class="row" id="divImprimirCode">
                    <div class="cell"><label></label></div>
                    <div class="cell"><button id="btImprimirCode" class="boton" style ="width:auto; margin-left:13px !important;">Imprimir Code Bar</button></div>
                </div>
                <div class="row" id="divestatusentrada">
                    <div class="cell"><label style="top:0px;">Estatus</label></div>
                    <div class="cell">
                        <select id="selectestatus" class="blueText">
                            <option value="Disponible">Disponible</option>
                            <option value="Ocupado">Ocupado</option>
                            <option value="Dañado">Dañado</option>
                            <option value="En reparación">En reparaciòn</option>
                            <option value="En mantenimiento">En mantenimiento</option>
                            <option value="Extraviado">Extraviado</option>
	                    </select>
                    </div>
                </div>
                </div>
            </div>
        </div>
        <div class="modal-footer" style="height: 50px!important;">
             <input type="button" value="Guardar" id="btModalGuardar"/>
             <input type="button" value="Limpiar" id="btModalLimpiar"/> 
             <input type="button" value="Salir" id="btModalsalir"/>    
        </div>
    </div>  

    <div id="modalSalida" class="modal" style="padding:0px!important;width:620px!important;z-index:999!important;top:25%!important;">
        <div class="modal-content" style="z-index:999!important;">
            <div id="modaltitleS" style="height: 35px;">
            <h5>SALIDA</h5><br>
            </div>
            <div id="divmodalCuerpoS" style="background-color:#e58144;width: 620px!important;padding:0px!important;">
                <div id="divmodalCamposS" style="background-color:#e58144;width: 520px!important;padding:20px!important;">
                <div class="row" id="primerRowSalida">
                    <div class="cell"><label>Cod. Art.</label></div>
                    <div class="cell"><input type="text" style="width:150px !important;" value="" id="txtCodArtS" /><button id="btBuscarArtS" class="boton" style ="margin-left:9px !important;">Cargar</button><button id="btCatArtS" class="boton" style ="margin-left:12px !important;">Buscar por nombre</button></div>
                </div>
                <div class="row">
                    <div class="cell"><label>Articulo</label></div>
                    <div class="cell"><input type="text" style="width:390px !important;margin-top: 5px;" disabled="disabled" value="" id="txtNombreArticuloS" /></div>
                </div>
                <div class="row">
                    <div class="cell"><label>Responsable</label></div>
                    <div class="cell"><input type="text" style="width:390px !important;" disabled="disabled" value="" id="txtResponsableS" /></div>
                </div>
                <div class="row">
                    <div class="cell"><label>Nota</label></div>
                    <div class="cell"><input type="text" style="width:390px !important;" disabled="disabled" value="" id="txtNotaS" /></div>
                </div>
                <div class="row" id="divexistenciasalida">
                    <div class="cell"><label>Existencia</label></div>
                    <div class="cell"><input type="text" id="txtExistenciaS" style="width:50px !important;" disabled="disabled"/></div>
                </div>
                <div class="row" id="divcantidadsalida">
                    <div class="cell"><label>Cantidad</label></div>
                    <div class="cell"><input type="text" style="width:50px !important;" disabled="disabled" value="" id="txtCantidadS" onkeypress="javascript:return ValidaCampoNumero(event, this)"  /></div>
                </div>
                <div class="row" id="divestatussalida">
                    <div class="cell"><label style="top:0px;">Estatus</label></div>
                    <div class="cell">
                        <select id="selectestatusS" class="blueText">
                            <option value="Disponible">Disponible</option>
                            <option value="Ocupado">Ocupado</option>
                            <option value="Dañado">Dañado</option>
                            <option value="En reparación">En reparaciòn</option>
                            <option value="En mantenimiento">En mantenimiento</option>
                            <option value="Extraviado">Extraviado</option>
	                    </select>
                    </div>
                </div>
                <div class="row" id="divfechasalida">
                    <div class="cell"><label style="top:0px;">Reintegra el</label></div>
                    <div class="cell"><input type="text" style="width:100px !important;" value="" id="txtFechaReintegro" onkeypress="javascript:return ValidaCampoFecha(event, this)" /></div>
                </div>
            </div>
            </div>
        </div>
        <div class="modal-footer" style="height: 50px!important;">
             <input type="button" value="Guardar" id="btModalGuardarS"/>
             <input type="button" value="Limpiar" id="btModalLimpiarS"/> 
             <input type="button" value="Salir" id="btModalsalirS"/>    
        </div>
    </div> 
    
    <script>
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
        $(document).ready(function () {
            $('html').css('overflow', 'hidden');
            // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
            $('.modal').modal({
                dismissible: true, // Modal can be dismissed by clicking outside of the modal
                opacity: .5, // Opacity of modal background
                inDuration: 300, // Transition in duration
                outDuration: 200, // Transition out duration
                startingTop: '14%', // Starting top style attribute
                endingTop: '14%', // Ending top style attribute
                ready: function (modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
                    $('.modal').css('top', '25%');
                    $('html').scrollTop(0);
                    console.log(modal, trigger);
                },
                complete: function () {  } // Callback for Modal close
            }
            );
        });
    </script>     
</body>

</html>
