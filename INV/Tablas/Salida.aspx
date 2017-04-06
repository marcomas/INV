<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Salida.aspx.vb" Inherits="INV.Salida" %>

<!DOCTYPE html>

<head runat="server">
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>INV</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">

    <link rel="stylesheet" href="../css/normalize.css?0.0.0.6">
	<link rel="stylesheet" href="../css/main.css?0.0.0.6">
	<link rel="stylesheet" href="../css/style.css?0.0.0.7">
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

    <script src="../js/jquery.nicescroll.min.js?0.0.0.6"></script>
    <script src="../js/toolbar.js?0.0.0.6"></script>
    <script src="../js/main.js?0.0.0.6"></script>
    <script src="../js/jquery.msgBox.js?0.0.0.6"></script>
    <script src="../js/jquery-ui.js?0.0.0.6"></script>
	<script src="../js/herramientas.js?0.0.0.6"></script>
	<script src="../js/fields.js?0.0.0.6"></script>
	<script src="../js/commtoserver.js?0.0.0.6"></script>
    <script src="../js/toolbarNoBar.js?0.0.0.1"></script>
    <script src="../js/articulo.js?0.0.0.6"></script>
	
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
    
    <script type="text/javascript" src="../js/gridExport.js?0.0.0.7"></script>

    <script>

        //-- CONSTANTES --//
        var tabla = 'salida';
        var columnsExports = 'articulo|nivel|cantidad|responsable|mante|fechareg|fecharei|nota';
        var columnsExportCaption = 'Articulo|Nivel|Cantidad|Responsable|Mantenimiento|Fecha Registro|Fecha Reintegro|Nota';
        var numreport = 8;
        
        //-- VARIABLES --//
        var aSource = new Array();
        var aSearch = new Array();
        var intervalVarLoadAllData;
        //var TextTipo = tipo;

        //-- SETUP --//
        $(function() {
            tablaToolBar = tabla;

            Init_S();

            $(".close_grid").click(function() {
                $(".cont_grid").fadeOut();
                $(".overlay").fadeOut();
            });

        });

        function LoadData_1() {
        }

        function UnloadData_1() {
        }

        function LoadData_2() {
        }
    </script>     

</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <!-- Esto va en todos los iframes -->
    <h1 class="titulo_iframe">Salidas<a href="#" id="btn_cerrar"></a></h1>
    <!-- fin titulo -->
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="loadGridView" value="Carga data en Grid View" />
    </div>
    
    <div class="seccion" style="position:relative; top:0px;">
        <div class="barra" id="toolbar_tabla"><button id="btExportToExcel" title="exportar a excel" style="left:15px; height:30px;position:relative;margin-left:10px;margin-right:15px;margin-top:5px;" class="btn_new"><img src="../images/icon_excel.png"/></button></div>
    </div>

    <div class="cont_grid" style="width: 1290px; border: none; left: 1%; top: 20%; z-index:997;" id="divLista">
        <h1 class="title_grid"></h1>
        <!--#include file="../inc/grid_Salida.html"-->
    </div>
    
</body>

</html>







