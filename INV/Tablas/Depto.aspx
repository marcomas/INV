<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Depto.aspx.vb" Inherits="INV.Depto" %>

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
    <script src="../js/main.js?0.0.0.6"></script>
    <script src="../js/jquery.msgBox.js?0.0.0.6"></script>
    <script src="../js/jquery-ui.js?0.0.0.6"></script>
	<script src="../js/commtoserverGrid.js?0.0.0.6"></script>
	
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
  
    <script type="text/javascript" src="../js/menuDepto.js?0.0.0.6"></script>
    <script type="text/javascript" src="../js/hp.menuFlotante.js?0.0.0.6"></script>
    
    <style type="text/css">
        .menu_flotante {
            width: 140px; height: auto; 
            background: #f9f9f9; 
            border-radius: 5px;
            position: absolute; 
            z-index: 99999; 
            padding: -8px;
            -webkit-box-shadow: 1px 1px 4px 0px rgba(136,136,136,0.5);
            -moz-box-shadow: 1px 1px 4px 0px rgba(136,136,136,0.5);
            box-shadow: 1px 1px 4px 0px rgba(136,136,136,0.5);
        }
        .menu_flotante div{
            text-align: left !important;
            padding: 8px 10px !important;
            margin: 0px !important;
            cursor: pointer;
            font-size: 14px !important;
            font-weight: bold;
            color: #888;
            border-bottom: 1px solid #e2e2e2;

        }
        .menu_flotante div i {margin-right: 3px;}
        .menu_flotante div:last-child {border: none;}
        .menu_flotante div:hover {
            background: #e9e9e9;
        }
        .clear{clear:both;}
        #asdf {padding: 15px; background: #f8f8f8;}
    </style>

    <script>

        //-- CONSTANTES --//
        var tabla = 'depto';

        //-- VARIABLES --//
        var aSource = new Array();
        var nombreDepto = '';

        //-- SETUP --//
        $(function() {
            $("#jqxgrid").fadeOut();
            $("#lbBuscando").hide();

            Init();

            //al hacer click en cerrar aparece de nuevo el menu y se blanquea el iframe
            $("#btn_cerrar").click(function() {
                $.msgBox({
                    title: "Chiudi finestra",
                    content: "Sei sicuro?",
                    type: "confirm",
                    buttons: [{ value: "Si" }, { value: "No"}],
                    success: function(result) {
                        if (result == "Si") {
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
                GetRecord();
            });

            $('#btNuevo').click(function() {
                $('.overlay').fadeIn();
                $('#divNewItemGrid').fadeIn();
                $("#txtNombreNew").val('');
                $("#txtNombreNew").focus();
            });

            $('#btGuardarEdit').click(function() {
                if ($('#txtNombreEdit').val() != '') {
                    var info = $('#txtNombreEdit').val() + '|';
                    MsgGuardar(info);
                }
            });

            $('#btGuardarNew').click(function() {
                if ($('#txtNombreNew').val() != '') {
                    var info = $('#txtNombreNew').val() + '|';
                    NewRecord(info);
                }
            });
            
            $(".close_grid").click(function() {
                $("#divEditItemGrid").fadeOut();
                $("#divNewItemGrid").fadeOut();
                $(".overlay").fadeOut();
                SetOcultarNotifica(0);
            });
        });

        function Init() {
            GetRecord();
        }

    </script>
    
    <script>

        //-- GRID VIEW --//
        var widthGridView = 400;
        var column1 = new Array();
        var column2 = new Array();
        var intervalVarRefreshGridView;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $("#jqxgrid").on('rowselect', function(event) {
                idRecordSelected = event.args.row.id_record;
                nombreDepto = event.args.row.nombre;
            });

            $("#loadGridView").click(function() {
                // prepare the data
                var data = LoadDataGridView(column1.length);

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
                    $("#jqxgrid").jqxGrid('databind', source, 'sort');
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
                        { name: 'id_record', type: 'string' },
                        { name: 'nombre', type: 'string' }
                    ],
                    datatype: "array"
                };
                var dataAdapter = new $.jqx.dataAdapter(source);

                $("#jqxgrid").jqxGrid(
                {
                    width: widthGridView,
                    source: dataAdapter,
                    theme: theme,
                    showfilterrow: true,
                    filterable: true,
                    sortable: true,
                    pageable: true,
                    pagesize: 20,
                    autoheight: true,
                    pagesize: 15,
                    columnsresize: true,
                    selectionmode: 'singlerow',
                    ready: function() {
                        $("#jqxgrid").jqxGrid('sortby', 'id', 'asc');
                    },
                    showstatusbar: false,
                    columns: [
                      { text: 'Id', columntype: 'textbox', filtertype: 'textbox', datafield: 'id_record', width: 10 },
                      { text: 'Nombre', columntype: 'textbox', filtertype: 'textbox', datafield: 'nombre', width: 400 }
                    ]
                  });
                  $("#jqxgrid").jqxGrid('setcolumnproperty', 'id_record', 'hidden', true);
            });
            $("#jqxwindow").jqxWindow({ resizable: false, theme: theme, autoOpen: false, width: 210, height: 180 });
        });

        function RefreshGridView() {
            clearInterval(intervalVarRefreshGridView);
            $("#loadGridView").click();
            $("#jqxgrid").jqxGrid('clearfilters');
            $("#jqxgrid").fadeIn();
            $("#lbBuscando").hide();
        }

        function LoadDataGridView(rowscount, hasNullValues) {
            var data = new Array();
            if (rowscount == undefined) rowscount = 100;
            for (var i = 0; i < rowscount; i++) {
                var row = {};
                row["id"] = i;
                row["id_record"] = column1[i];
                row["nombre"] = column2[i];
                data[i] = row;
            }
            return data;
        }

        function UnloadData_Columns() {
            aSource = [];
            column1 = [];
            column2 = [];
        }

        function LoadGridView(index) {
            column1.push(aSource[index].split('|')[0]);
            column2.push(aSource[index].split('|')[1]);
        }
        
    </script>

</head>

<body id="idBody" class="body_iframe">
    <div class="overlay"></div>
    <h1 class="titulo_iframe">Departamentos<a href="#" id="btn_cerrar"></a></h1>
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="loadGridView" value="Carga data en Grid View" />
    </div>
    
    <div id="divEditItemGrid" style="display:none;width:400px;position:relative;left:30%;float:left;" class="cont_grid" >
        <h1 class="title_grid">Editar</h1>
        <span class="close_grid"></span>
        <div class="table">
            <div class="row">
                <div class="cell"><label style="width:50px;">Nombre</label></div>
                <div class="cell"><input type="text" id="txtNombreEdit" style="width:300px;" maxlength="50"/></div>
            </div>
        </div>
        <input type="button" value="Guardar" id="btGuardarEdit" />
    </div>
    
    <div id="divNewItemGrid" style="display:none;width:400px;position:relative;left:30%;float:left;" class="cont_grid" >
        <h1 class="title_grid">Nuevo</h1>
        <span class="close_grid"></span>
        <div class="table">
            <div class="row">
                <div class="cell"><label style="width:50px;">Nombre</label></div>
                <div class="cell"><input type="text" id="txtNombreNew" style="width:300px;" /></div>
            </div>
        </div>
        <input type="button" value="Guardar" id="btGuardarNew" />
    </div>
    
    <div class="table" style="float:left;">
        <div class="row">
            <div class="cell"><Label style="top:0px; color:Red;" id="lbBuscando">procesando...</label></div>
            <div class="cell"><input type="button" value="Actualizar" id="btBuscar" style="left:15px; height:24px;"/></div>
            <div class="cell"><input type="button" value=" Nuevo" id="btNuevo" style="left:15px; height:24px;"/></div>
        </div>
    </div>
    
    <div id="jqxgrid"></div>
    
</body>

</html>



