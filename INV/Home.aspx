<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home.aspx.vb" Inherits="INV.Home" %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<html class="no-js" style=""> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>INVENTARIO</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
         <link rel="stylesheet" href="materialize-src/sass/estilosMaterialize.css">
        <link rel="stylesheet" href="css/style.css?0.0.1.1">
        <link rel="stylesheet" href="css/perfilUser.css">

        <script src="js/vendor/modernizr-2.6.2.min.js"></script>
        <script src="js/vendor/jquery-1.9.0.min.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <link rel="stylesheet" href="Scripts/jqwidgets/jqwidgets/styles/jqx.base.css" type="text/css" />
        <link rel="stylesheet" href="js/Validaciones/vanadium.css" type="text/css" media="screen">

        <script type="text/javascript" src="Scripts/jqwidgets/scripts/gettheme.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/scripts/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxcore.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxinput.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxbuttons.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxcheckbox.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxscrollbar.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxlistbox.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxdropdownlist.js"></script>
        <script type="text/javascript" src="js/Validaciones/vanadium_es.js"></script>      

        <script src="js/jquery.msgBox.js?0.0.0.1"></script>
        <script src="js/main.js"></script>
        <script src="js/herramientas.js?0.0.0.1"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/hp.message.js"></script>
        <script src="js/gridExport.js?0.0.0.1"></script>
        <script src="js/toolsserver.js"></script>

        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxdata.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxmenu.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxgrid.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxgrid.sort.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxgrid.pager.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxgrid.columnsresize.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxgrid.selection.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxgrid.filter.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqx-all.js"></script>
        <script type="text/javascript" src="Scripts/jqwidgets/jqwidgets/jqxwindow.js"></script>
        <script src="js/materialize.min.js"></script>

        <style type="text/css">

            #popup {
                left: 0;
                position: absolute;
                top: 0;
                width: 100%;
                z-index: 1001;
            }

            .content-popup {
                margin:0px auto;
                margin-top:120px;
                position:relative;
                padding:10px;
                width:400px;
                min-height:150px;
                border-radius:4px;
                background-color:#FFFFFF;
                box-shadow: 0 2px 5px #666666;
            }

            .content-popup h2 {
                color:#48484B;
                border-bottom: 1px solid #48484B;
                margin-top: 0;
                padding-bottom: 4px;
            }

            .popup-overlay {
                left: 0;
                position: absolute;
                top: 0;
                width: 100%;
                z-index: 999;
                display:none;
                background-color: #777777;
                cursor: pointer;
                opacity: 0.7;
            }

            .close {
                position: absolute;
                right: 15px;
            }

            .closeModal
            {
                background: #15bfbf url(images/close_chat.png) no-repeat 2px 2px;
                width: 20px;
                padding: 2px;
                height: 20px;
                display: block;
                -webkit-border-radius: 45px 45px;
                -moz-border-radius: 45px / 45px;
                border-radius: 45px / 45px;
                position: absolute;
                right: 10px;
                top: 10px;
                z-index: 999;
                cursor: pointer;
            }

            #btExportToPDFReport
            {
                background-color: #777;
                float: right;
                margin-right: 1%;
                margin-bottom: 5px;
            }
            #btExportToExcel
            {
                background-color: #777;
                float: right;
                margin-right: 5%;
                margin-bottom: 5px;
            }
        </style>

        <script type="text/javascript">
            var tabla = "Home";
            var IdSelct = '';
            var numreport = 0;
            var gridOpen = false;

            $(function() {
                var theme = getDemoTheme();

                jqxgrid = '_jqxgrid';

                $('#fechaingreso').click(function() {
                    var offset = $("#_jqxgrid").offset();
                    $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                    $("#txtFecha").val('');
                    $("#popupWindow").jqxWindow('open');
                    $("#txtFecha").focus();
                });

                $(".close_grid").click(function() {
                    $(".cont_grid").fadeOut();
                    $("#divArticulos").fadeOut();
                    $(".overlay").fadeOut();
                    codselect = '';
                    gridOpen = false;
                });

                $("#popupWindow").jqxWindow({
                    width: 270, height: 110, resizable: false, theme: theme, isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01
                });

                $("#popupWindow").on('open', function() {
                    $("#txtFecha").jqxInput('selectAll');
                });

                $("#Save").click(function() {
                    ChangeFechaReingreso($("#txtFecha").val());
                });

                $("#Cancel").click(function() {
                    $("#txtFecha").val('');
                });

                $("#CerrarMsjProducto").click(function() {
                    $("#divArticulos").fadeOut();
                    gridOpen = false;
                    MensajeArtiuculoXIngresar();
                    MensajeStockBajo();
                });

                function ChangeFechaReingreso(fecha) {
                    var info = codselect + '|' + fecha + '|';

                    $.ajax({
                        type: "POST",
                        url: "WS/WSTablas.aspx",
                        data: { tabla: 'articulo', fun: 'newRecordTransito', data: info },
                        async: false
                    }).done(function(data) {
                        if (data.split('§')[0] != "OK") {
                        } else {
                            $("#popupWindow").jqxWindow('close');
                            MensajeArtiuculoXIngresar(true);
                        }
                    });
                }

            });

            function CerrarModal() {
                $('#popup').css('display', 'none');
                $('#divArticulos').css('opacity', 1.00, 'fast');
                $('#Gigante').css('opacity', 0.00);
                $('.popup-overlay').fadeOut('fast');
                CancelarModal();
                _ShowGridView();
            };

            function CancelarModal() {
                document.getElementById('txtNumExistencia2').value = '';
                $('#txtNumExistencia2').focus();
            };

            function AbrirModal() {
                $('#divArticulos').css('opacity', 0.65, 'fast');
                $('#txtNumExistencia2').focus();
            };

            function CambiarExisteciaArtSeleccionado(e) {
                var existencia = $('#txtNumExistencia2').val();
                if (existencia == '') {
                    $('#popup').css('display', 'none');
                    $('#divArticulos').css('display', 'none');
                    $('#Gigante').css('display', 'none');
                    MensajeExistenciaVacia('Debe ingresar una existencia');
                }
                else {
                    CancelarModal();
                    var info = e + '|' + existencia + '|';
                    $.ajax({
                        type: "POST",
                        url: "../WS/WSArticulo.aspx",
                        data: { fun: 'cambiaExistenciaArticulo', data: info },
                        async: false
                    }).done(function(data) {

                        $('#popup').css('display', 'none');
                        $('#divArticulos').css('display', 'none');
                        $('#Gigante').css('display', 'none');
                        MensajeExistencia('Existencia modificada con exito');
                    });
                }
            };

            function MensajeExistencia(msg) {
                if (msg == '') { return; }
                $.msgBox({
                    title: "Información",
                    content: msg,
                    type: "confirm",
                    buttons: [{ value: "Aceptar"}],
                    success: function(result) {
                        $('#divArticulos').css('opacity', 1.00);
                        _ShowGridView();
                    }
                });
            }

            function MensajeExistenciaVacia(msg) {
                if (msg == '') { return; }
                $.msgBox({
                    title: "Información",
                    content: msg,
                    type: "confirm",
                    buttons: [{ value: "Aceptar"}],
                    success: function(result) {
                        $('#divArticulos').css('opacity', 0.65);
                        _ShowGridView();
                        $('#popup').fadeIn();
                        $('#txtNumExistencia2').focus();
                    }
                });
            }
        </script>

    </head>

    <body id="idBody" >
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        <!-- Add your site or application content here -->
        <div class="overlay"></div>
        <div style="display:none">
            <input style='margin-top: 10px;' type="button" id="_loadGridView" value="Carga data en Grid View" />
        </div>

        <div class="cont_grid" style="left:10%;" id="divArticulos">
            <span class="close_grid"></span>
             <div id="popupWindow">
                <div><span>Modificar fecha de reingreso</span></div>
                <div style="overflow: hidden;">
                    <table>
                        <tr>
                            <td align="right">Fecha</td>
                            <td align="left"><input type="text" id="txtFecha" onkeypress="javascript:return ValidaCampoFecha(event, this)" style="width:190px"/></td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td style="padding-top: 10px; float:right">
                                <input style="margin-right: 5px;" type="button" id="Save" value="Guardar" />
                                <input id="Cancel" type="button" value="Cancelar" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        
        <div id="divPerfilUser" class="user_box">
            <div class="img_userbox">
                <img src="images/img-user.png"/>
            </div>
            <div class="text_userbox">
                <span id="cerrarPerfilUser" class="cerrarPerfil"></span>
                <h2 id="nUsuarioPerfil"></h2>
                <h3 id="tUsuarioPerfil"></h3>
                <div class="dividir"></div>
                <form class="eventDatospersonales">
                <div class="seccionForm form1">
                <div>
                    <label for="telOficina">Tel. Oficina</label>
                    <input type="tel" id="telOficina">
                </div>
                <div>
                    <label for="telInterno">Tel. Interno</label>
                    <input type="tel" id="telInterno">
                </div>
                <div>
                    <label for="telCelular">Tel. Celular</label>
                    <input type="tel" id="telCelular">
                </div>
                <div>
                    <label for="telCorreo">Correo electrónico</label>
                    <input type="email" id="telCorreo">
                </div>
                </div><br>
                    <button href="" id="guardarDatospersonales">Guardar</button>
                </form>
                <form>
                    <div class="seccionForm eventPassword passwordChange">
                        <div>
                            <label for="contrasenaActual">Contraseña actual</label>
                            <input type="password" id="contrasenaActual" value="">
                        </div>
                        <div>
                            <label for="contrasenaNueva">Nueva contraseña </label>
                            <input type="password" id="contrasenaNueva" value="">
                        </div>
                        <div>
                            <label for="contrasenaNuevaConf">Confirmar contraseña</label>
                            <input type="password" id="contrasenaNuevaConf" value="">
                        </div>
                    </div>
                    <button href="" id="btnGuardarContrasena" class="btnGuardarContrasena">Guardar</button>
                    <a href="" id="cambiarContrasena">Cambiar contraseña</a>
                    <span id="msjPerfil"></span>
                </form>
            </div>
        </div>
        
        <div class="top">
            <div class="logo"><img src="images/logo3.jpg" style="position: relative;height: 45px;top: -10px;width: 280px;"></div>
            <div class="sede"></div>
            <div class="user">
                <a id="img_user"><img src="images/img-user.png"></a>
                <h3 id="nUsuario"></h3>
                <a class="boton salir" id="btSalir">Salir<span></span></a>
            </div>
        </div>
        <div class="sidebar">
             <ul class="nav-Servicios">
                <li class="menu" id="menuSistema">
                    <ul>
                        <li class=""><a class="button btn_config">Sistema</a></li>
                        <li class="dropdown">
                            <ul>
                                <li style="display:none;"><a href="Tablas/Configuracion.aspx">Configuración</a></li>
                                <li><a href="Tablas/Usuario.aspx">Usuarios</a></li>
                                <li><a href="Tablas/Log.aspx">Logs</a></li>
                            </ul>
                        </li>
                  </ul>
                </li>
                <li class="menu" id="menuRed">
                    <ul>
                        <li class=""><a class="button btn_modulos">Colaboradores y Proveedores</a></li>
                        <li class="dropdown">
                            <ul>
                                <li id="menuRed1"><a href="Tablas/Personal.aspx">Personal</a></li>
                                <li id="menuRed5"><a href="Tablas/Servicio.aspx">Servicios</a></li>
                                <li id="menuRed6"><a href="Tablas/Proveedor.aspx">Proveedores</a></li>
                                <li><a href="Tablas/Categoria.aspx">Categoria</a></li>
                                <li><a href="Tablas/CategoriaEliminada.aspx">Recuperar Categorias</a></li>
                            </ul>
                        </li>
                  </ul>
                </li>
                <li class="menu" id="menuInv">
                    <ul>
                        <li class=""><a class="button btn_modulos">Inventario</a></li>
                        <li class="dropdown">
                            <ul>
                                <li><a href="Tablas/Entrada.aspx">Entradas</a></li>
                                <li><a href="Tablas/Salida.aspx">Salidas</a></li>
                                <li><a href="Tablas/Articulo.aspx">Categorias y Articulos</a></li>
                                <li><a href="Tablas/EntradaSalida.aspx" id="liES">Entradas y Salidas</a></li>
                            </ul>
                        </li>
                  </ul>
                </li>
            </ul>
        </div>

        <div id='jqxMenu'>
            <ul>
                <li><a id="fechaingreso">Fecha Ingreso</a></li>
            </ul>
        </div>

        <div class="notificationBtn">
		    <span id="btnTop">STOCK BAJO</span>
		    <span id="btnBottom">POR INGRESAR</span>
	    </div>
	    <div class="notification">
		    <div id="topMsj">
			    <span>EXISTEN PRODUCTOS CON STOCK BAJO 
				    <a href="#modalGrip" id="listaarticulosc" style="color:Yellow;" class="modal-trigger"> (Ver lista de Productos)</a>
			    </span>
		    </div>
		    <div id="bottomMsj">
			    <span>EXISTEN PRODUCTOS POR INGRESAR 
				    <a href="#modalGrip" id="listaarticulosu" style="color:Yellow;" class="modal-trigger"> (Ver lista de Productos)</a>
			    </span>
		    </div>
	    </div>
        <div class="desktop"></div>
        <div id="modalGrip" style="width:1250px; height:100%; max-height:99%;" class="modal modal-fixed-footer footerAppCalendar">
    
        <div class="modal-content cont_grid9" style="width:1250px;" id="modalCalendarContent">
            <h1 class="title_grid" id="titGridArticulos" style="text-align:right;"></h1>
            <button id="btExportToExcel" title="Exportar a Excel" style="left:15px; height:30px;margin-top:-3%;float:left;" class="clasebtExportToExcel"><img src="../images/icon_excel.png"/></button>
            <div id="_jqxgrid"></div>
        </div>

		<div class="modal-footer">
			<a href="#!" id="CerrarMsjProducto" class="modal-action modal-close waves-effect waves-red btn-flat ">CERRAR</a>
		</div>
	</div>

    <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
    <script type="text/javascript">
        var bLogIn = false;
        var intervalVarIntro;
        var respError = '';
        var articulounico = false;
        var intervalAlertaStockBajo;
        var intervalAlertaArtiuculoXIngresar;
        var intervalCheckOcultarNotifica;

        $('#top').hide();
        $('#bottom').hide();
        $('#topMsj').hide();
        $('#bottomMsj').hide();
        $('#btnTop').hide();
        $('#btnBottom').hide();

        function launchFullscreen(element) {
            if(element.requestFullScreen) {
                element.requestFullScreen();
            } else if(element.mozRequestFullScreen) {
                element.mozRequestFullScreen();
            } else if(element.webkitRequestFullScreen) {
                element.webkitRequestFullScreen();
            }
        }

        $("#listaarticulosc").click(function () {
            columnsExports = 'codigo|nombre|nivel|exist|stock|dif|info';
            columnsExportCaption = 'Codigo|Nombre|Nivel|Exist|Stock|Diferencia|Nota';
            numreport = 1;
            articulounico = false;
            _ShowGridView();
        });

        $("#listaarticulosu").click(function () {
            columnsExports = 'codigo|nombre|nivel|estatus|fecha|resp|info';
            columnsExportCaption = 'Codigo|Nombre|Nivel|Estatus|Reintegrar|Responsable|Nota';
            numreport = 2;
            articulounico = true;
            _ShowGridView();
        });       
     
        function LogIn() {
            $('#nUsuario').html('');
            $('#nUsuarioPerfil').html('');
            $('#tUsuarioPerfil').html('');

            var infoLogin = $('#txtUsuario').val() + '|' + $('#txtPsw').val() + '|';

            $.ajax({
                type: "POST",
                url: "WS/WSSession.aspx",
                data: { name: 'usuario', fun: 'login', data: infoLogin },
                async: true
            }).done(function(data) {
                if (data.split('§')[0] == "KO") {
                    bLogIn = false;
                    respError = data.split('§')[1];
                } else {
                    bCloseMsgBox = true;
                    $(".msgBoxBackGround").hide();
                    $(".msgBox").hide();

                    intervalAlertaStockBajo = setInterval(function () { MensajeStockBajo() }, 5000);
                    intervalAlertaArtiuculoXIngresar = setInterval(function () { MensajeArtiuculoXIngresar() }, 5000);
                    intervalCheckOcultarNotifica = setInterval(function () { CheckOcultarNotifica() }, 1000);

                    bLogIn = true;
                    var nUsuario = data.split('§')[1].split('|')[1];
                    var tUsuario = data.split('§')[1].split('|')[6];
                    $('#nUsuario').html(nUsuario + '<span> (' + tUsuario + ')</span>');
                    $('#nUsuarioPerfil').html(nUsuario);
                    $('#tUsuarioPerfil').html(tUsuario);

                    if (tUsuario == 'Operador') {// TipoUtente = 2
                        $('#menuSistema').hide();
                        $('#menuRed').hide();
                    }

                    launchFullscreen(document.documentElement);
                }
            }).fail(function() { alert("error"); });
        }

        var vv = 0;
        var CheckID;

        function Check() {
            clearInterval(CheckID);
            CheckOpenArticulo();

            if (vv == 0) {
                CheckID = setInterval(function () { Check() }, 1000);
            } else {
                clearInterval(CheckID);
                SetNotOpenArticulo();
            }
        }

        function SetNotOpenArticulo() {
            $.ajax({
                type: "POST",
                url: "../WS/WSSessionVar.aspx",
                data: { name: 'OpenArticulo', fun: 'set', value: 0 }
            }).done(function (data) { });
        }

        function CheckOpenArticulo() {
            $.ajax({
                type: "POST",
                url: "WS/WSSessionVar.aspx",
                data: { name: 'OpenArticulo', fun: 'get'},
                async: false
            }).done(function (data) {
                vv = data.split('$')[0];
                if (vv == 1) { ShowArticulo(); }
            });
        }

        function ShowArticulo() {
            var ventana_alto = $(window).height();
            var alto_iframe = ventana_alto - 90;
            $(".desktop").html("<div id='iframes'><iframe src='Tablas/Articulo.aspx' id='iframe' width='100%' height='" + alto_iframe + "' frameborder='0' scrolling='no' style='margin-top:-2%;'></iframe></div>");
            $(".sidebar").animate({ left: "-230px" }, 500);
            return false;
        }

        function CheckOcultarNotifica() {
            clearInterval(intervalCheckOcultarNotifica);

            $.ajax({
                type: "POST",
                url: "WS/WSSessionVar.aspx",
                data: { name: 'OcultarNotifica', fun: 'get' },
                async: false
            }).done(function (data) {
                vv = data.split('$')[0];
                if (vv == 1) {
                    $(".notificationBtn").fadeOut();
                    $(".notification").fadeOut();                        
                } else {
                    $(".notificationBtn").fadeIn();
                    $(".notification").fadeIn();
                }
                intervalCheckOcultarNotifica = setInterval(function () { CheckOcultarNotifica() }, 1000);
            });
        }

        function LogOut() {
            clearInterval(intervalAlertaStockBajo);
            clearInterval(intervalAlertaArtiuculoXIngresar);
            $('#top').fadeOut();
            $('#bottom').fadeOut();
            $.ajax({
                type: "POST",
                url: "WS/WSSession.aspx",
                data: { name: '', fun: 'logout', data: '' },
                async: true
            }).done(function(data) {
            }).fail(function() { alert("error"); });
        }

        function MsgIntro() {
            clearInterval(intervalVarIntro);

            $.msgBox({
                title: "ARVECA",
                content: "Bienvenido, pulse el boton Acceder para Ingresar en el sistema en modo Pantalla Completa<br><br>" +
                    "<label class='caption'>Usuario</label><br><input type='text' id='txtUsuario' value='' style='width:290!important;'><br>" +
                    "<label class='caption'>Contraseña</label><br><input type='password' id='txtPsw' value='' onkeypress='javascript: ValidaENTERLogin(event);'><br><br><br>" +
                    "<label class='caption_err' id='errorMessage'></label><br><br>" + 
                    "<a style='cursor: pointer; color: #fff;' id='olvidoPass'>Olvide mi contraseña</a>" +
                    "<script>txtUsuario.focus();<\/script>",
                type: "info",
                buttons: [{ value: "Acceder" }],
                bCloseMsgBox: false,
                success: function (result) {
                    if (result == "Acceder") {
                        LogIn();
                        if (bLogIn == false) { 
                            setTimeout(function() { $('#errorMessage').html(respError); }, 200);
                            bCloseMsgBox = false;
                        }
                    }
                }
            });
        }

        function ValidaENTERLogin(e) {
            if (e.which) {
                key = e.which;
                if (key == 13) {
                    LogIn();
                    if (bLogIn == false) { 
                        setTimeout(function() { $('#errorMessage').html(respError); }, 200);
                    }
                }
            }
        }

        function showTime() {
            var timeNow = new Date();
            var hours   = timeNow.getHours();
            var minutes = timeNow.getMinutes();
            var seconds = timeNow.getSeconds();
            var timeString = "" + ((hours > 12) ? hours - 12 : hours);
            timeString  += ((minutes < 10) ? ":0" : ":") + minutes;
            timeString  += (hours >= 12) ? " P.M." : " A.M.";
            $('.hora').html(timeString);
            timerID = setTimeout("showTime()", 1000);
        }

        $(document).ready(function () {

            showTime();
            LogOut();

            var ventana_alto = $(window).height();
            var alto_sidebar = ventana_alto-0;
            $(".sidebar").css("height",alto_sidebar);

            $(window).resize(function() {
                 var ventana_alto = $(window).height();
                 var alto_sidebar = ventana_alto-0;
                 $(".sidebar").css("height",alto_sidebar);
            });

            MsgIntro();

            $('#liES').click(function() {
                Check();
                return false;
            });

            // click en algun boton llama iframe
             $(".dropdown").find("a").click(function () {
                  //arrojar alto de la ventana
                  var ventana_alto = $(window).height();
                  var alto_iframe = ventana_alto-90;
                  //recojo el vinculo del boton y lo coloco como destino del iframe
                  var vinculo = $(this).attr("href");
                  $(".desktop").html("<div id='iframes'><iframe src='"+vinculo+"' id='iframe' width='100%' height='"+alto_iframe+"' frameborder='0' scrolling='no' style='margin-top:-2%;'></iframe></div>");
                  $(".sidebar").animate({
                          left: "-230px",
                        }, 500 );
                  return false;
                });


            //menu acordeon
             /* Changing thedefault easing effect - will affect the slideUp/slideDown methods: */
            $.easing.def = "jswing";
            $("#active_down").slideToggle('slow');
            $('.button:first').addClass("buttonhover");
            $('.buttonhover').parent().parent('ul').css('background','#f1f1f1');


            /* Binding a click event handler to the links: */
            $('.button').click(function(e){

            /* Finding the drop down list that corresponds to the current section: */
            var dropDown = $(this).parent().next();
            var Servicio =  $(this);
            $(this).parent().parent('ul').css('background','#f1f1f1');

            $(this).addClass("buttonhover");
            $('.button').not(Servicio).removeClass("buttonhover");


            /* Closing all other drop down sections, except the current one */
            $('.dropdown').not(dropDown).slideUp('slow');
            $('.dropdown').not(dropDown).parent().css('background','none');
            dropDown.slideToggle('slow', function(){
                var ventana_alto = $(window).height();
                var alto_sidebar = ventana_alto-130;
                var nav_alto = $(".nav-Servicios").height();
                if(nav_alto>alto_sidebar){
                    $(".sidebar").css("overflow-y", "scroll");
                } else {$(".sidebar").css("overflow", "hidden");}
            });

            /* Preventing the default event (which would be to navigate the browser to the link's address) */
            e.preventDefault();
            })
        });

        $("#btSalir").click(function() {
            window.location = 'Home.aspx';
        });

        function MensajeStockBajo() {
            clearInterval(intervalAlertaStockBajo);

            if (!gridOpen) {
                $.ajax({
                    type: "POST",
                    url: "WS/WSTablas.aspx",
                    data: { tabla: 'Articulo', fun: 'getProduct', querytype: '56', data: '' },
                    async: true
                }).done(function (data) {
                    if (data.split('§')[0] == "KO") {
                        $('#topMsj').fadeOut();
                        $('#btnTop').fadeOut();
                    } else {
                        GetRecordProductosC();
                        if (existe_nivel_bajo) {
						    if (data.split('§')[1] != '0') {
						        $('#btnTop').fadeIn();
						        $('#topMsj').fadeIn();
							}
						} else {
						    $('#btnTop').fadeOut();
						    $('#topMsj').fadeOut();
							$(".close_grid").click();
						}
                    }
                    intervalAlertaStockBajo = setInterval(function () { MensajeStockBajo() }, 5000);
                }).fail(function () { alert("error"); });
            } else {
                intervalAlertaStockBajo = setInterval(function () { MensajeStockBajo() }, 5000);
            }
        }

        function MensajeArtiuculoXIngresar(forzarRefresh) {
            clearInterval(intervalAlertaArtiuculoXIngresar);

            if (forzarRefresh == null) { forzarRefresh = false; }

            if (!gridOpen || forzarRefresh) {
                $.ajax({
                    type: "POST",
                    url: "WS/WSTablas.aspx",
                    data: { tabla: 'Articulo', fun: 'getProduct', querytype: '61', data: '' },
                    async: true
                }).done(function (data) {
                    if (data.split('§')[0] == "KO") {
                        $('#bottomMsj').fadeOut();
                        $('#btnBottom').fadeOut();
                    } else {
					    GetRecordProductosU();
                        if (existe_ingresar) {
					        if (data.split('§')[1] != '0') {
					            $('#bottomMsj').fadeIn();
					            $('#btnBottom').fadeIn();
					        }
					    } else {
				            $('#bottomMsj').fadeOut();
				            $('#btnBottom').fadeOut();
						    $(".close_grid").click();
					    }
                    }
                    intervalAlertaArtiuculoXIngresar = setInterval(function () { MensajeArtiuculoXIngresar() }, 5000);
                }).fail(function () { alert("error"); });
            } else {
                intervalAlertaArtiuculoXIngresar = setInterval(function () { MensajeArtiuculoXIngresar() }, 5000);
            }
        }
    </script>

    <script>

        //-- GRID VIEW --//
        var _column1 = new Array();
        var _column2 = new Array();
        var _column3 = new Array();
        var _column4 = new Array();
        var _column5 = new Array();
        var _column6 = new Array();
        var _column7 = new Array();
        var _column8 = new Array();
        var _column9 = new Array();
        var _column10 = new Array();
        var aArticulos = new Array();
        var codselect = '';
        var existe_nivel_bajo, existe_ingresar;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $("#_jqxgrid").on('rowselect', function(event) {
                codselect = event.args.row.codigo;
            });

            $("#_loadGridView").click(function() {
                var data = _LoadDataGridView(_column1.length);

                var customsortfunc = function(column, direction) {
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
                    Object.prototype.toString = (typeof column == "function") ? column : function() { return this[column] };
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
                var compare = function(value1, value2) {
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
                        { name: 'nivel', type: 'string' },
                        { name: 'exist', type: 'string' },
                        { name: 'stock', type: 'string' },
                        { name: 'estatus', type: 'string' },
                        { name: 'fecha', type: 'string' },
                        { name: 'resp', type: 'string' },
                        { name: 'dif', type: 'string' },
                        { name: 'info', type: 'string' }
                    ],
                    datatype: "array"
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                var tamaño = '';
                if (numreport == 1) {
                    tamaño = 1200
                }
                else {
                    tamaño = 1200;
                }

                $('#divArticulos').css('width', tamaño);

                $("#_jqxgrid").jqxGrid(
                {   
                    width: tamaño,
                    source: dataAdapter,
                    theme: theme,
                    showfilterrow: true,
                    filterable: true,
                    sortable: true,
                    pageable: true,
                    pagesize: 10,
                    autoheight: true,
                    columnsresize: true,
                    selectionmode: 'singlerow',
                    ready: function() {
                        $("#_jqxgrid").jqxGrid('sortby', 'id', 'asc');
                    },
                    showstatusbar: true,
                    columns: [
                      { text: 'Codigo', columntype: 'textbox', filtertype: 'textbox', datafield: 'codigo', width: 150 },
                      { text: 'Nombre', columntype: 'textbox', filtertype: 'textbox', datafield: 'nombre', width: 170 },
                      { text: 'Nivel', columntype: 'textbox', filtertype: 'textbox', datafield: 'nivel', width: 250 },
                      { text: 'Exist', columntype: 'textbox', filtertype: 'textbox', datafield: 'exist', width: 50 },
                      { text: 'Stock min.', columntype: 'textbox', filtertype: 'textbox', datafield: 'stock', width: 95 },
                      { text: 'Estatus', columntype: 'textbox', filtertype: 'textbox', datafield: 'estatus', width: 100 },
                      { text: 'Reintegra', columntype: 'textbox', filtertype: 'textbox', datafield: 'fecha', width: 100 },
                      { text: 'Responsable', columntype: 'textbox', filtertype: 'textbox', datafield: 'resp', width: 200 },
                      { text: 'Diferencia', columntype: 'textbox', filtertype: 'textbox', datafield: 'dif', width: 95 },
                      { text: 'Notas', columntype: 'textbox', filtertype: 'textbox', datafield: 'info', width: 235 }
                    ]
                });
                $("#_jqxgrid").jqxGrid('setcolumnproperty', 'exist', 'hidden', true);
                $("#_jqxgrid").jqxGrid('setcolumnproperty', 'stock', 'hidden', true);
                $("#_jqxgrid").jqxGrid('setcolumnproperty', 'estatus', 'hidden', true);
                $("#_jqxgrid").jqxGrid('setcolumnproperty', 'fecha', 'hidden', true);
                $("#_jqxgrid").jqxGrid('setcolumnproperty', 'resp', 'hidden', true);
                $("#_jqxgrid").jqxGrid('setcolumnproperty', 'dif', 'hidden', true);

                if (articulounico) {
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'estatus', 'hidden', false);
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'fecha', 'hidden', false);
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'resp', 'hidden', false);
                } else {
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'exist', 'hidden', false);
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'stock', 'hidden', false);
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'dif', 'hidden', false);
                    $("#_jqxgrid").jqxGrid('setcolumnproperty', 'nombre', 'width', 330);
                }
            });
            // select a row.
            $("#_jqxgrid").on('rowselect', function(event) {
                rowindex = event.args.rowindex;
                IdSelct = aArticulos[rowindex].split('|')[0];
                return false;
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
                row["exist"] = _column4[i];
                row["stock"] = _column5[i];
                row["estatus"] = _column6[i];
                row["fecha"] = _column7[i];
                row["resp"] = _column8[i];
                row["dif"] = _column9[i];
                row["info"] = _column10[i];
                data[i] = row;
            }
            return data;
        }

        function _UnloadData_Columns() {
            aArticulos = [];
            _column1 = [];
            _column2 = [];
            _column3 = [];
            _column4 = [];
            _column5 = [];
            _column6 = [];
            _column7 = [];
            _column8 = [];
            _column9 = [];
            _column10 = [];
        }

        function _LoadGridView(index) {
            _column1.push(aArticulos[index].split('|')[0]);
            _column2.push(aArticulos[index].split('|')[1]);
            _column3.push(aArticulos[index].split('|')[2]);
            _column4.push(aArticulos[index].split('|')[3]);
            _column5.push(aArticulos[index].split('|')[4]);

            var aEstatus = 'Disponible|Ocupado|Dañado|En reparación|En mantenimiento|Extraviado'.split('|');
            _column6.push(aEstatus[aArticulos[index].split('|')[5]]);

            _column7.push(aArticulos[index].split('|')[6]);
            _column8.push(aArticulos[index].split('|')[7]);

            _column9.push(parseInt(aArticulos[index].split('|')[4]) - parseInt(aArticulos[index].split('|')[3]));
            //_column10.push('<textarea style="position: relative; float: left; left: 2px; height: 42px; width: 220px; margin-top: 0px; margin-bottom: 0px;"> ' + aArticulos[index].split('|')[8] + ' </textarea>');
            _column10.push(aArticulos[index].split('|')[8]);
        }

        function _ShowGridView() {
            gridOpen = true;

            $("#_jqxgrid").jqxGrid('clearfilters');
            if (!articulounico) {
                GetRecordProductosC();
                if (existe_nivel_bajo) {
                    $('#titGridArticulos').html('Articulos con stock bajo');
                    intervalVarRefreshGridView = setInterval(function() { _RefreshGridView() }, 100);
                }
            } else {
                GetRecordProductosU();
                if (existe_ingresar) {
                    $('#titGridArticulos').html('Articulos con fecha reingreso vencida');
                    intervalVarRefreshGridView = setInterval(function() { _RefreshGridView() }, 100);
                }
            }
        }

        function _LoadDataFromSource(source) {
            _UnloadData_Columns();
            aArticulos = source.split('$');
            for (i = 0; i < aArticulos.length; i++) {
                _LoadGridView(i);
            }
        }

        function GetRecordProductosC() {
            _UnloadData_Columns();
            $.ajax({
                type: "POST",
                url: "WS/WSTablas.aspx",
                data: { tabla: 'articulo', data: '', fun: 'getProduct', querytype: 59 },
                async: false
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    //MsgInfo('No existen Articulos.');
                    existe_nivel_bajo = false;
                } else {
                    var source = data.split('§')[1];
                    _LoadDataFromSource(source);
                    existe_nivel_bajo = true;
                }
            });
        }

        function GetRecordProductosU() {
            _UnloadData_Columns();
            $.ajax({
                type: "POST",
                url: "WS/WSTablas.aspx",
                data: { tabla: 'articulo', data: '', fun: 'getProduct', querytype: 60 },
                async: false
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    //MsgInfo('No existen Articulos.');
                    existe_ingresar = false;
                } else {
                    var source = data.split('§')[1];
                    _LoadDataFromSource(source);
                    existe_ingresar = true;
                }
            });
        }
    </script>

    <div id="popup" style="display: none;">
        <div class="content-popup">
            <div>
                <a class="closeModal"><input type="button" id="BtnCerrarModal" style=" position: absolute; right: -10px; opacity: 0.02;" onclick="CerrarModal()"></input></a>
                <h3>MODIFICAR EXISTENCIA DEL ARTICULO SELECCIONADO</h3>
                <br/>
                <br/>
                <div class="cell"><Label>EXISTENCIA</label></div>
                <div class="cell"><input type="text" id="txtNumExistencia2" onkeypress="javascript:return ValidaCampoNumero(event, this)"/></div>
            </div>
            <div class="cell">
                <input style='margin-top: 60px; margin-left: 90px;' type="button" id="Btn1Aceptar" onclick="CambiarExisteciaArtSeleccionado(IdSelct)" value="Aceptar" />
                <input style='margin-top: 60px;' type="button" id="Btn2Cancelar" onclick="CancelarModal()" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id="Gigante" class="popup-overlay"></div>

    <Script>

        $("#cerrarPerfilUser").click(function() {
            var text = $('#cambiarContrasena').text();
            $("#divPerfilUser").hide();
            if (text === 'Cancelar') {
            $('#cambiarContrasena').click();
            }
        });    

        $("#guardarDatospersonales").click(function() {
            var info = $('#telOficina').val() + '|' + $('#telInterno').val() + '|' + $('#telCelular').val() + '|' + $('#telCorreo').val() + '|';

            $.ajax({
                type: "POST",
                url: "../WS/WSSession.aspx",
                data: { fun: 'updatePerfilUsuario', data: info, id: 0 },
                async: false
            }).done(function(data) { });
            msjPerfil("Datos modificados con exito");
            return false;
        });

        $("#btnGuardarContrasena").click(function() {
            if ($('#contrasenaNueva').val() != $('#contrasenaNuevaConf').val()) {
                msjPerfil("Confirmación erronea,Vuelva a intentar");
                return false;
            } else {
                if ($('#contrasenaNueva').val() == '') {
                    msjPerfil("Debe asignar una nueva contraseña");
                    return false;
                } else {
                    var info = $('#contrasenaActual').val() + '|' + $('#contrasenaNueva').val() + '|';
                    $.ajax({
                        type: "POST",
                        url: "../WS/WSSession.aspx",
                        data: { fun: 'changePswUsuario', data: info, id: 0 },
                        async: false
                    }).done(function(data) {
                        if (data.split('§')[0] != "OK") {
                            msjPerfil("Contraseña actual incorrecta");
                        } else {
                            msjPerfil("Contraseña modificada con exito");
                            $('#contrasenaNueva').val('');
                            $('#contrasenaNuevaConf').val('');
                            $('#contrasenaActual').val('');
                        }
                    });
                    return false;
                }
            }
        });

        function PoblarFormPerfil() {
            var infoLogin = $('#txtUsuario').val() + '|' + $('#txtPsw').val() + '|';

            $.ajax({
                type: "POST",
                url: "WS/WSSession.aspx",
                data: { name: 'usuario', fun: 'getUsuario', data: infoLogin },
                async: true
            }).done(function(data) {
                var nUsuario = data.split('§')[1].split('|')[1];
                var tUsuario = data.split('§')[1].split('|')[6];
                var tlUsuario = data.split('§')[1].split('|')[9];
                var tiUsuario = data.split('§')[1].split('|')[10];
                var tcUsuario = data.split('§')[1].split('|')[11];
                var eUsuario = data.split('§')[1].split('|')[12];
                $('#nUsuario').html(nUsuario + '<span> (' + tUsuario + ')</span>');
                $('#nUsuarioPerfil').html(nUsuario);
                $('#tUsuarioPerfil').html(tUsuario);
                $("#telOficina").val(tlUsuario);
                $("#telInterno").val(tiUsuario);
                $("#telCelular").val(tcUsuario);
                $("#telCorreo").val(eUsuario);
            });
        }

        $("#img_user").click(function() {
            PoblarFormPerfil();
            $(".user_box").fadeIn();
            return false;
        });

        $('#cambiarContrasena').click(function(e) {
            e.preventDefault();
            $('.eventPassword').toggleClass('passwordChange');
            $('#contrasenaActual').focus();
            var tex = $(this).text();
            if (tex === 'Cancelar') {
                $(this).text('Cambiar contraseña');
                $('#forgetPassword').hide();
            } else {
                $(this).text('Cancelar');
                $('#forgetPassword').show();
            }
            return false;
        });

        $('.eventDatospersonales input').focusin(function() {
            $('#guardarDatospersonales').show();
            return false;
        });

        $('.modal-trigger').leanModal({
            dismissible: true,
            opacity: .5,
            in_duration: 300,
            out_duration: 200,
            starting_top: '10%',
            ending_top: '1%',
            ready: function() { },
            complete: function() { }
           }
		);
		
        $('#btnTop,#topMsj').hover(function() {
            $('#topMsj').css('right', '0');
        }, function() {
            $('#topMsj').css('right', '-600px');
        });
        
        $('#btnBottom,#bottomMsj').hover(function() {
            $('#bottomMsj').css('right', '0');
        }, function() {
            $('#bottomMsj').css('right', '-600px');
        });

        setInterval(intFunc, 2000);
        
        function intFunc() {
            $('#btnTop,#btnBottom').css('background', '#e58144');
            $('#btnTop,#btnBottom').css('color', '#fff');
            setTimeout(function() {
                $('#btnTop,#btnBottom').css('background', '#fff');
                $('#btnTop,#btnBottom').css('color', '#000');
            }, 1000)
        }
        
        function msjPerfil(text) {
            var conten = $("#msjPerfil");
            $(conten).text(text);
            setTimeout(function() {
                $(conten).text("");
            }, 4000);
        }

        function retornarEmail() {
            if ($('#txtUsuario').val() == '') {
                $('#olvidoPass').text('Recuperar');
                $('#errorMessage').text('Ingrese su nombre de usuario, clic en Recuperar y Espere un minuto');
                $('#txtUsuario').focus();
                setTimeout(function() { $('#errorMessage').text(''); }, 4000);
                return false;
            }
            if ($('#txtUsuario').val() != '' && $('#olvidoPass').text() != 'Recuperar') {
                $('#olvidoPass').text('Recuperar');
                $('#errorMessage').text('Verifique su nombre de usuario, clic en Recuperar y Espere un minuto');
                setTimeout(function() { $('#errorMessage').text(''); }, 4000);
                return false;
            }
            //Funcion para conocer el email del usuario que olvido su contraseña
            var info = $('#txtUsuario').val() + '|';
            var username = $('#txtUsuario').val();
            $.ajax({
                type: "POST",
                url: "WS/WSSession.aspx",
                data: { fun: 'getEmailUser', data: info },
                async: true
            }).done(function(data) {
                if (data.split('§')[0] == "OK") {
                    var email = data.split('§')[1];
                    enviarEmail(email, username);
                } else {
                    $('#errorMessage').text('El nombre de usuario no existe, verifiquelo');
                    setTimeout(function() { $('#errorMessage').text(''); }, 4000);
                    return false;
                }
            }).fail(function() { alert("error"); });
        }

        function enviarEmail(email, username) {
            //Generar una nueva contraseña aleatoriamente
            var newContraseña = Math.round(Math.random() * (99999999 - 00000001) + parseInt(00000001));
            //Llamar a este ajax para grabar en la BD esta nueva contraseña
            var info = username + '|' + newContraseña + '|';
            $.ajax({
                type: "POST",
                url: "WS/WSSession.aspx",
                data: { fun: 'recoveryPswUsuario', data: info },
                async: true
            }).done(function(data) {
            }).fail(function() { alert("error"); });
            //Indicar los parametros necesarios para enviar el correo
            var to = email;
            var cc = '';
            var subject = 'RECUPERAR CONTRASEÑA';
            var body = 'Su nueva contraseña para ingresar al sistema es: ' + newContraseña +
                            '{BR}Y su usuario sigue siendo: ' + username;

            sendMailPasswordAccesoCMS(to, cc, subject, body);

        }          
    </Script>
          
    </body>

</html>
