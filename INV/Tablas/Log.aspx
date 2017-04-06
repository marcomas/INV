<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Log.aspx.vb" Inherits="INV.Log" %>

<!DOCTYPE html>

<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>CITA</title>
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
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxcheckbox.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="../Scripts/jqwidgets/jqwidgets/jqxdata.export.js"></script> 

    <script src="../js/jquery.nicescroll.min.js?0.0.0.6"></script>
    <script src="../js/toolbar.js?0.0.0.6"></script>
    <script src="../js/main.js?0.0.0.6"></script>
    <script src="../js/jquery.msgBox.js?0.0.0.6"></script>
    <script src="../js/jquery-ui.js?0.0.0.6"></script>
    <script src="../js/herramientas.js?0.0.0.6"></script>
    <script src="../js/fields.js?0.0.0.6"></script>
    <script src="../js/commtoserver.js?0.0.0.6"></script>
    <script src="../js/gridExport.js?0.0.0.7"></script>
    
    <link rel="stylesheet" href="../Scripts/jqwidgets/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../js/Validaciones/vanadium.css" type="text/css" media="screen"> 
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
    
    <script type="text/javascript" src="../js/datapicker.js?0.0.0.6"></script>

    <script>

        //-- CONSTANTES --//
        var tabla = 'log';
        var columnsExports = 'descr|usuario|accion|fecha|hora';
        var columnsExportCaption = 'Descripcion|Usuario|Accion|Fecha|Hora';
        var numreport = 6;

        //-- VARIABLES --//
        var aSource = new Array();

        //-- SETUP --//
        $(function() {
            $("#jqxgrid").fadeOut();
            $("#lbBuscando").hide();
            
            Init();

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

            $('#btBuscar').click(function() {
                GetCitas();
            });

            $(".datepicker").datepicker({
                onSelect: function(curDate, instance) {},
                dateFormat: 'dd/mm/yy',
                altFormat: 'dd/mm/yy'
            });

        });

        function Init() { }

        function GetCitas() {
            $("#jqxgrid").jqxGrid('clearfilters');
            UnloadData_Columns();

            var info = $("#txtFechaDesde").val() + '|' + $("#txtFechaHasta").val() + '|';
            $("#lbBuscando").fadeIn();

            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { tabla: 'log', fun: 'getRecord', data: info },
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
                    $("#lbBuscando").fadeOut();
                }
            });
        }
        
    </script>

</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <h1 class="titulo_iframe">Logs<a href="#" id="btn_cerrar"></a></h1> 
    
    <div class="table table_foto" style="float:left; padding:0px 0px 10px;">
        <div class="row">
            <div class="cell">
                <Label style="top:0px; color:Red;" id="lbBuscando">búsqueda en proceso...</label>
                <input type="button" value="Buscar" id="btBuscar" style="left:15px; height:24px;"/>
                <div id="divBuscar" style="border-style:none;"> 
                    <input type="text" placeholder="desde la fecha" id="txtFechaDesde" style="width:100px" class="datepicker" onkeypress="javascript:return ValidaCampoFecha(event, this)" class=":fechaValida" />
                    <input type="text" placeholder="hasta la fecha" id="txtFechaHasta" style="width:100px" class="datepicker" onkeypress="javascript:return ValidaCampoFecha(event, this)" class=":fechaValida" />
                </div>
                <input id="clearfiltersbutton" type="button" value="borrar filtros" style="left:15px; height:24px;"/>
                <input id="btExportToExcel" type="button" value="exportar en excel" style="left:15px; height:24px;"/>
            </div>
        </div>
    </div>
    
    <div style="position:relative; top:30px; left:15%;">
    <!--#include file="../inc/grid_logs.html"-->
    </div>
    
</body>

</html>


