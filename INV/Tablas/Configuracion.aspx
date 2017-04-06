<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Configuracion.aspx.vb" Inherits="INV.Configuracion" %>

<!DOCTYPE html>
<head id="Head1" runat="server">
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>CITA</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">

    <link rel="stylesheet" href="../css/normalize.css?0.0.0.6">
	<link rel="stylesheet" href="../css/main.css?0.0.0.6">
	<link rel="stylesheet" href="../css/style.css?0.0.0.6">
    <link rel="stylesheet" href="../css/jquery-ui.css?0.0.0.6" />
    <link rel="stylesheet" href="../css/uploadfiles.css?0.0.0.6" />
	
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
	<script src="../js/toolbarNoBar.js?0.0.0.6"></script>
	<script src="../js/commextrass.js?0.0.0.6"></script>
	
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

    <script>

        //-- CONSTANTES --//
        var tabla = 'configuracion';

        //-- VARIABLES --//
        var aSource = new Array();

        //-- SETUP --//
        $(function() {           
            Init();
        });

        function Init() {
            // id, type, length, notNull, msgAlert, msgError, format, isSearch, isCodigo, isFocusToSearch, isFocusToEdit, isFocusToNew, isEdit, isReadonly
            aCtrl.push(new objParamsField('idRecord', 'hid', 8, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtCodKey', 'texto', 10, 1, '', '', '', 0, 0, 0, 0, 0, 0, 1));
            aCtrl.push(new objParamsField('txtIdioma', 'texto', 150, 1, '', '', '', 0, 0, 0, 0, 0, 0, 1));

            $("#toolbar_tabla").find(".icon-editar").show();
            GetRecord(1);
        }

        function GetValue(type, index) {
            ViewButtonsEditAndDelete(true);
            SetData(index);
        }

        function GetInfo() {}

        //-- DATA --//
        function LoadDataFromSource(source) {
            UnloadData_1();
            aSource = source.split('$');
        }

        function LoadDataAll(fun) {
            clearInterval(intervalVarLoadData);
            LoadData_1();
            LoadData_2();
            ClearFieldsToInit();
            if (fun == 2) { PrepareFieldsToSearchRecord(); }
            if (fun == 3) { PrepareFieldsToSaveRecord(); }
            
            GetValue(1, 0);
        }

        function LoadData_1() {}

        function UnloadData_1() {}

        function LoadData_2() {
            $('#txtCodKey').val('');
            $('#txtIdioma').val('');
        }
        
    </script>

</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <h1 class="titulo_iframe">Configuraciones<a href="#" id="btn_cerrar"></a></h1>   
    
	<div class="seccion">
        <div class="barra" id="toolbar_tabla"></div>
        <div class="title_seccion">&nbsp;</div>
        <div class="table table_foto" id="divTabla">
            <input type="hidden" id="idRecord" value="" />
             <div class="row">
                <div class="cell"><Label>CÓDIGO KEY</label></div>
                <div class="cell"><input type="text" id="txtCodKey"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>IDIOMA</label></div>
                <div class="cell"><input type="text" id="txtIdioma"/></div>
            </div>
        </div>
    </div>
    
</body>

</html>



