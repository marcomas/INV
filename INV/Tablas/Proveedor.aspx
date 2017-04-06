<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Proveedor.aspx.vb" Inherits="INV.Proveedor" %>

<!DOCTYPE html>

<head runat="server">
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>SIGA</title>
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
    <script src="../js/toolbar.js?0.0.0.6"></script>
    <script src="../js/main.js?0.0.0.6"></script>
    <script src="../js/jquery.msgBox.js?0.0.0.6"></script>
    <script src="../js/jquery-ui.js?0.0.0.6"></script>
	<script src="../js/herramientas.js?0.0.0.6"></script>
	<script src="../js/fields.js?0.0.0.6"></script>
	<script src="../js/commtoserver.js?0.0.0.6"></script>
	<script src="../js/toolbarGeneric.js?0.0.0.6"></script>
	
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
    
    <script type="text/javascript" src="../js/gridExport.js?0.0.0.6"></script>

    <script>

        //-- CONSTANTES --//
        var tabla = 'proveedor';
        var tipoProveedor = 2;
        
        //-- VARIABLES --//
        var aSource = new Array();
        var aSearch = new Array();
        var aCodigos = new Array();
        var aNombres = new Array();
        var intervalVarLoadAllData;
        //var TextTipo = tipo;

        //-- SETUP --//
        $(function() {
            tablaToolBar = tabla;
            columnsExports = 'codigo|nombre|rif|resp|direccion|tlf|email|info';
            columnsExportCaption = 'Codigo|Nombre|Cedula/Rif|Responsable|Direccion|Telefonos|Email|Notas';
            numreport = 5;

            $("#divLista").fadeOut();

            Init();

            $('#txtSearch').change(function() {
                var index = aSearch.indexOf($('#txtSearch').val());
                if (index > -1) { GetValue(index); }
            });

            $(".close_grid").click(function() {
                $(".cont_grid").fadeOut();
                $("#divLista").fadeOut();
                $(".overlay").fadeOut();
                SetOcultarNotifica(0);
            });

            $('#btEstatus').click(function() {
                CambiaEstatus();
            }); 

        });

        function CambiaEstatus() {
            idRecordSelected = $('#idRecord').val();

            $.ajax({
                type: "POST",
                url: "../WS/WSChangeEstatusFields.aspx",
                data: { tabla: tabla, fun: 'cambiaEstatus', id: idRecordSelected },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] == "OK") {
                    SetEstatusFields(data.split('§')[1].split('$')[0], 'btEstatus', 'Inactivo', 'Activo');
                }
            });
        }

        function Init() {
            // id, type, length, notNull, msgAlert, msgError, format, isSearch, isCodigo, isFocusToSearch, isFocusToEdit, isFocusToNew, isEdit, isReadonly
            aCtrl.push(new objParamsField('idRecord', 'hid', 8, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtCodigo', 'texto', 10, 1, '', '', '', 0, 1, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNombre1', 'texto', 10, 1, '', '', '', 0, 0, 0, 1, 1));
            aCtrl.push(new objParamsField('txtNombre', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtCedula', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNombResponsable', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTelOf', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTelCell', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTelFax', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtEmail', 'texto', 250, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtDireccion', 'texto', 150, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNotas', 'texto', 500, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtEmail2', 'texto', 250, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtEmail3', 'texto', 250, 1, '', '', '', 0, 0, 0, 0, 0));


            GetRecord(1, tipoProveedor);
            ClearFieldsToInit();
        }

        function GetValue(index) {
            $('#txtSearch').val(aCodigos[index] + '|' + aNombres[index]);
            $('#txtCodigo').val(aCodigos[index]);
            $('#txtNombre').val(aNombres[index]);

            ViewButtonsEditAndDelete(true);
            SetData(index);
            SetEstatusFields(aSource[index].split('|')[10], 'btEstatus', 'Inactivo', 'Activo');
        }

        function GetInfo() {
            var info =
                $('#txtNombre1').val() + '|' +
                $("#selTipoCedula").val() + '-' + $('#txtCedula').val() + '|' +
                $('#txtNombResponsable').val() + '|' +
                $('#txtTelOf').val() + '|' +
                $('#txtTelCell').val() + '|' +
                $('#txtTelFax').val() + '|' +
                $('#txtEmail').val() + '|' + 
                $('#txtEmail2').val() + '|' + 
                $('#txtEmail3').val() + '|' + 
                $('#txtDireccion').val() + '|' +
                '2|' +
                $('#txtNotas').val() + '|' +
                tipoProveedor + '|';
                
            return info;
        }
                
        //-- DATA --//
        function LoadDataFromSource(source) {
            UnloadData_1();
            UnloadData_Columns();
            aSource = source.split('$');
            for (i = 0; i < aSource.length; i++) {
                aSearch.push(aSource[i].split('|')[1] + '|' + aSource[i].split('|')[2]);
                aCodigos.push(aSource[i].split('|')[1]);
                aNombres.push(aSource[i].split('|')[2]);
                LoadGridView(i);
            }
        }

        function LoadDataAll(fun) {
            clearInterval(intervalVarLoadData);
            LoadData_1();
            LoadData_2();
            ClearFieldsToInit();
            if (fun == 2) { PrepareFieldsToSearchRecord(); }
            if (fun == 3) { PrepareFieldsToSaveRecord(); }
        }

        function LoadData_1() {
            $("#txtSearch").jqxInput({ placeHolder: "", height: 5, width: 500, minLength: 1, source: aSearch });
            $("#txtCodigo").jqxInput({ placeHolder: "", height: 5, width: 160, minLength: 1, source: aCodigos });
            $("#txtNombre").jqxInput({ placeHolder: "", height: 5, width: 200, minLength: 1, source: aNombres });
        }

        function UnloadData_1() {
            aCodigos = [];
            aNombres = [];
            aSearch = [];
            $("#txtSearch").jqxInput({ placeHolder: "", height: 5, width: 500, minLength: 1, source: aSearch });
            $("#txtCodigo").jqxInput({ placeHolder: "", height: 5, width: 160, minLength: 1, source: aCodigos });
            $("#txtNombre").jqxInput({ placeHolder: "", height: 5, width: 200, minLength: 1, source: aNombres });
        }

        function LoadData_2() {
            $('#txtNombre1').val('');
            $('#txtCedula').val('');
            $('#txtTelOf').val('');
            $('#txtTelCell').val('');
            $('#txtTelFax').val('');
            $('#txtEmail').val('');
            $('#txtEmail2').val('');
            $('#txtEmail3').val('');
            $('#txtDireccion').val('');
            $('#txtNotas').val('');
            $('#txtNombResponsable').val('');
        }
        
    </script> 
        
    <script>

        //-- GRID VIEW --//
        var widthGridView = 1300;
        var bShowGridView = false;
        var column1 = new Array();
        var column2 = new Array();
        var column3 = new Array();
        var column4 = new Array();
        var column5 = new Array();
        var column6 = new Array();
        var column7 = new Array();
        var column8 = new Array();
        var intervalVarRefreshGridView;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $("#selTipoCedula").jqxDropDownList({ source: aTipoCedulaRif, selectedIndex: 0, autoDropDownHeight: true, width: 35, height: 25, theme: theme, disabled: true });

            $("#jqxgrid").on('rowselect', function(event) {
                var codigo = event.args.row.codigo;
                var index = aCodigos.indexOf(codigo);
                if (index > -1) { GetValue(index); }
                PrepareFieldsToSearchRecord();
                $(".close_grid").click();
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
                        { name: 'codigo', type: 'string' },
                        { name: 'nombre', type: 'string' },
                        { name: 'rif', type: 'string' },
                        { name: 'resp', type: 'string' },
                        { name: 'direccion', type: 'string' },
                        { name: 'tlf', type: 'string' },
                        { name: 'email', type: 'string' },
                        { name: 'info', type: 'string' }
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
                    autoheight: true,
                    pagesize: 15,
                    columnsresize: true,
                    ready: function() {
                        $("#jqxgrid").jqxGrid('sortby', 'id', 'asc');
                    },
                    showstatusbar: false,
                    columns: [
                          { text: 'Codigo', columntype: 'textbox', filtertype: 'textbox', datafield: 'codigo', width: 1 },
                          { text: 'Nombre', columntype: 'textbox', filtertype: 'textbox', datafield: 'nombre', width: 200 },
                          { text: 'Cedula/Rif', columntype: 'textbox', filtertype: 'textbox', datafield: 'rif', width: 100 },
                          { text: 'Responsable', columntype: 'textbox', filtertype: 'textbox', datafield: 'resp', width: 200 },
                          { text: 'Dirección', columntype: 'textbox', filtertype: 'textbox', datafield: 'direccion', width: 200 },
                          { text: 'Teléfonos', columntype: 'textbox', filtertype: 'textbox', datafield: 'tlf', width: 220 },
                          { text: 'Email', columntype: 'textbox', filtertype: 'textbox', datafield: 'email', width: 200 },
                          { text: 'Notas', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'info', width: 180 }
                        ]
                });
                $("#jqxgrid").jqxGrid('setcolumnproperty', 'codigo', 'hidden', true);
            });
            $("#jqxwindow").jqxWindow({ resizable: false, theme: theme, autoOpen: false, width: 210, height: 180 });
        });

        function RefreshGridView() {
            clearInterval(intervalVarRefreshGridView);
            $("#loadGridView").click();
			$("#jqxgrid").jqxGrid('clearfilters');
        }

        function LoadDataGridView(rowscount, hasNullValues) {
            var data = new Array();
            if (rowscount == undefined) rowscount = 100;
            for (var i = 0; i < rowscount; i++) {
                var row = {};
                row["id"] = i;
                row["codigo"] = column1[i];
                row["nombre"] = column2[i];
                row["rif"] = column3[i];
                row["resp"] = column4[i];
                row["direccion"] = column5[i];
                row["tlf"] = column6[i];
                row["email"] = column7[i];
                row["info"] = column8[i];
                data[i] = row;
            }
            return data;
        }

        function UnloadData_Columns() {
            column1 = [];
            column2 = [];
            column3 = [];
            column4 = [];
            column5 = [];
            column6 = [];
            column7 = [];
            column8 = [];
        }

        function LoadGridView(index) {
            column1.push(aSource[index].split('|')[1]);
            column2.push(aSource[index].split('|')[2]);
            column3.push(aSource[index].split('|')[4]);
            column4.push(aSource[index].split('|')[5]);
            column5.push(aSource[index].split('|')[10]);
            column6.push(aSource[index].split('|')[6] + ' / ' +  aSource[index].split('|')[7]);
            column7.push(aSource[index].split('|')[9]);
            column8.push(aSource[index].split('|')[11]);           
        } 

        function ShowGridView() {
            $("#jqxgrid").jqxGrid('clearfilters');
			GetRecord(0, tipoProveedor);
			$(".overlay").fadeIn();
			$(".divLista").fadeIn();
			bShowGridView = true;
			intervalVarRefreshGridView = setInterval(function() { RefreshGridView() }, 1000);
        }

    </script>

</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <!-- Esto va en todos los iframes -->
    <h1 class="titulo_iframe">Proveedores<a href="#" id="btn_cerrar"></a></h1>
    <!-- fin titulo -->
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="loadGridView" value="Carga data en Grid View" />
    </div>
    
    <div class="cont_grid" style="width:1300px;" id="divLista">
        <h1 class="title_grid">&nbsp;</h1>
        <span class="close_grid"></span>
        <button id="btExportToExcel" title="Exportar a Excel" style="left:15px; height:30px;margin-top:-3%;float:left;" class="clasebtExportToExcel"><img src="../images/icon_excel.png"/></button>
        <div id="jqxgrid"></div>
    </div>
    
    <div class="seccion" style="position:relative; top:0px;">
        <div class="barra" id="toolbar_tabla"></div>
        <div class="title_seccion">&nbsp;</div>
        <div class="table table_foto" style="float:left;">
            <input type="hidden" id="idRecord" value="" />
            <div class="row">
                <div class="cell"><Label>BUSQUEDA</label></div>
                <div class="cell">
                    <input type="text" id="txtSearch" onkeypress="javascript:return GetKeyPressed(event)" style="width:500px;"/>
                    <div style="display:none">
                        <input type="text" id="txtCodigo" onkeypress="javascript:return GetKeyPressed(event)"/>
                        <input type="text" id="txtNombre" onkeypress="javascript:return GetKeyPressed(event)"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>NOMBRE</label></div>
                <div class="cell">
                    <input type="text" id="txtNombre1" style="width:300px"/>
                </div>
            </div>
            <div class="row"> 
                <div class="cell"><Label>CEDULA/RIF</label></div>
                <div class="cell">
                    <div id="selTipoCedula" style="width:10px;position:relative;left:10px;"></div>
                    <input type="text" id="txtCedula" onkeypress="javascript:return ValidaCampoCedula(event, this)"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>RESPONSABLE</label></div>
                <div class="cell">
                    <input type="text" id="txtNombResponsable" style="width:100px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. OFICINA</label></div>
                <div class="cell"><input type="text" id="txtTelOf" onkeypress="javascript:return ValidaCampoTelefono(event, this)" class=":tlfl" style="width:90px;"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. CELULAR</label></div>
                <div class="cell"><input type="text" id="txtTelCell" onkeypress="javascript:return ValidaCampoCelular(event, this)" class=":tlf-m" style="width:90px;"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. FAX</label></div>
                <div class="cell"><input type="text" id="txtTelFax" onkeypress="javascript:return ValidaCampoTelefono(event, this)" class=":tlfl" style="width:90px;"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>EMAIL</label></div>
                <div class="cell"><input type="text" id="txtEmail" class=":email" style="width:300px;" maxlength="50"/></div>
            </div> 
            <div class="row">
                <div class="cell"><Label>EMAIL 2</label></div>
                <div class="cell"><input type="text" id="txtEmail2" class=":email" style="width:300px;" maxlength="50"/></div>
            </div> 
            <div class="row">
                <div class="cell"><Label>EMAIL 3</label></div>
                <div class="cell"><input type="text" id="txtEmail3" class=":email" style="width:300px;" maxlength="50"/></div>
            </div> 
            <div class="row">
                <div class="cell"><Label>DIRECCIÓN</label></div>
                <div class="cell"><input type="text" id="txtDireccion" style="width:140px;" maxlength="150"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>NOTAS</label></div>
                <div class="cell"><input type="text" id="txtNotas" style="width:500px;" maxlength="250"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>ESTATUS</label></div>
                <div class="cell"><input type="button" value="" id="btEstatus" style="left:15px; height:24px;"/></div>
            </div>
                                  
        </div>
    </div>
    
</body>

</html>
