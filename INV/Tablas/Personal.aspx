<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Personal.aspx.vb" Inherits="INV.Personal" %>

<!DOCTYPE html>

<head runat="server">
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
    
    <script type="text/javascript" src="../js/gridExport.js?0.0.0.7"></script>
    
    <script>

        //-- CONSTANTES --//
        var tabla = 'personal';
        
        //-- VARIABLES --//
        var aSource = new Array();
        var aCodigos = new Array();
        var aNombres = new Array();
        var aSearch = new Array();
        var oResponsable;
        var oDepto;
        var intervalVarLoadAllData;
        var indexselect = -1;
        
        //-- SETUP --//
        $(function() {

            columnsExports = 'codigo|cedula|nombre|cargo|resp|tlf|email|direccion|estatus';
            columnsExportCaption = 'Codigo|Cedula|Nombre|Cargo|Responsable|Telefonos|Email|Direccion|Estatus';
            numreport = 3;
            
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
            aCtrl.push(new objParamsField('txtCodigo', 'texto', 10, 1, '', '', '', 0, 1, 1, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNominativo', 'texto', 100, 1, '', '', '', 1, 0, 0, 0, 0, 0, 1));
            aCtrl.push(new objParamsField('txtNombre1', 'texto', 50, 1, 'x', '', '', 0, 0, 0, 1, 1));
            aCtrl.push(new objParamsField('txtNombre2', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtApellido1', 'texto', 50, 1, 'x', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtApellido2', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('selSexo', 'sexo', 0, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtFN', 'texto', 10, 1, 'x', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtCedula', 'texto', 50, 1, 'x', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTelCasa', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTelCell', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtDireccion', 'texto', 250, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtEmail', 'texto', 250, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtFI', 'texto', 10, 1, 'x', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtCargo', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNombResponsable', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNombDepto', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNotas', 'texto', 250, 1, '', '', '', 0, 0, 0, 0, 0));

            GetRecord(1);
            oResponsable = new objExtras('personal', $("#txtNombResponsable")); GetRecordExtras(oResponsable);
            oDepto = new objExtras('depto', $("#txtNombDepto")); GetRecordExtras(oDepto);
            intervalVarLoadAllData = setInterval(function() { InitFiels() }, 1000);
        }

        function InitFiels() {
            clearInterval(intervalVarLoadAllData);
            if (oResponsable.load && oDepto.load) {
                ClearFieldsToInit();
            } else {
                intervalVarLoadAllData = setInterval(function() { InitFiels() }, 1000);
            }
        }

        function GetValue(index) {
            $('#txtSearch').val(aCodigos[index] + '|' + aNombres[index]);
            $('#txtCodigo').val(aCodigos[index]);
            $('#txtNominativo').val(aNombres[index]);

            ViewButtonsEditAndDelete(true);
            SetData(index);
            SetEstatusFields(aSource[index].split('|')[15], 'btEstatus', 'Inactivo', 'Activo');
        }

        function GetInfo() {
            var info =
                $('#txtNombre1').val() + '|' +
                $('#txtNombre2').val() + '|' +
                $('#txtApellido1').val() + '|' +
                $('#txtApellido2').val() + '|' +
                $('#selSexo').val() + '|' +
                $('#txtFN').val() + '|' +
                $("#selTipoCedula").val() + '-' + $('#txtCedula').val() + '|' +
                $('#txtTelCasa').val() + '|' +
                $('#txtTelCell').val() + '|' +
                $('#txtDireccion').val() + '|' +
                $('#txtEmail').val() + '|' +
                $('#txtFI').val() + '|' +
                $('#txtCargo').val() + '|' +
                $('#txtNombResponsable').val().split('-')[0] + '|' +
                $('#txtNombDepto').val() + '|' +
                $('#txtNotas').val() + '|';
                
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
            $("#txtNominativo").jqxInput({ placeHolder: "", height: 5, width: 200, minLength: 1, source: aNombres });
        }

        function UnloadData_1() {
            aCodigos = [];
            aNombres = [];
            aSearch = [];
            $("#txtSearch").jqxInput({ placeHolder: "", height: 5, width: 500, minLength: 1, source: aSearch });
            $("#txtCodigo").jqxInput({ placeHolder: "", height: 5, width: 160, minLength: 1, source: aCodigos });
            $("#txtNominativo").jqxInput({ placeHolder: "", height: 5, width: 200, minLength: 1, source: aNombres });
        }

        function LoadData_2() {
            $('#txtNombre1').val('');
            $('#txtNombre2').val('');
            $('#txtApellido1').val('');
            $('#txtApellido2').val('');
            $('#txtFN').val('');
            $('#txtFI').val('');
            $('#txtCedula').val('');
            $('#txtTelCasa').val('');
            $('#txtTelCell').val('');
            $('#txtDireccion').val('');
            $('#txtEmail').val('');
            $('#txtNombResponsable').val('');
            $('#txtNombDepto').val('');
            $('#txtCargo').val('');
            $('#txtNotas').val('');

            $('#selSexo').empty();
            for (i = 0; i < 2; i++) {
                $('#selSexo').append(new Option(aSexo[i].split('|')[0], aSexo[i].split('|')[1]));
            }
        }
        
    </script> 
        
    <script>

        //-- GRID VIEW --//
        var widthGridView = 1250;
        var bShowGridView = false;
        var column1 = new Array();
        var column2 = new Array();
        var column3 = new Array();
        var column4 = new Array();
        var column5 = new Array();
        var column6 = new Array();
        var column7 = new Array();
        var column8 = new Array();
        var column9 = new Array();
        var intervalVarRefreshGridView;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $('#txtNombDepto').change(function () {
                indexselect = oDepto.aSearch.indexOf($('#txtNombDepto').val());
            });

            $('#btAddDep').click(function () {
                if (bEditOrNew && indexselect == -1) {
                    $.msgBox({
                        title: "Agregar Departamento",
                        content: "Esta Seguro que desea agregar el departamento?",
                        type: "confirm",
                        buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                        success: function (result) {
                            if (result == "Aceptar") {
                                AgregarDepartamento();
                            }
                        }
                    });
                }
                return false;
            })

            $('#btModDep').click(function () {
                if (bEditOrNew && indexselect != -1) {
                    var html = '<input type="text" value="' + $('#txtNombDepto').val() + '" id="txtNombDeptoMod" onkeypress="javascript:return GetKeyPressed(event)"/>';
                    $.msgBox({
                        title: "Modificar Departamento",
                        content: "<div style='text-align: center;'>" + html + "</div>",
                        type: "confirm",
                        buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                        success: function (result) {
                            if (result == "Aceptar") {
                                var id = ObtenerIdDepartamento($('#txtNombDepto').val());
                                ModificarDepartamento(id,$('#txtNombDeptoMod').val());
                            }
                        }
                    });
                }
                return false;
            })

            $("#selTipoCedula").jqxDropDownList({ source: aTipoCedulaRif, selectedIndex: 0, autoDropDownHeight: true, width: 35, height: 25, theme: theme, disabled: true });

            $("#jqxgrid").on('rowselect', function(event) {
                var codigo = event.args.row.codigo;
                var index = aCodigos.indexOf(codigo);
                if (index > -1) { GetValue(index); indexselect = oDepto.aSearch.indexOf($('#txtNombDepto').val()); }
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
                        { name: 'cedula', type: 'string' },
                        { name: 'nombre', type: 'string' },
                        { name: 'cargo', type: 'string' },
                        { name: 'resp', type: 'string' },
                        { name: 'tlf', type: 'string' },
                        { name: 'email', type: 'string' },
                        { name: 'estatus', type: 'string' },
                        { name: 'direccion', type: 'string' }
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
                          { text: 'Cedula', columntype: 'textbox', filtertype: 'textbox', datafield: 'cedula', width: 120 },
                          { text: 'Nombre y Apellido', columntype: 'textbox', filtertype: 'textbox', datafield: 'nombre', width: 200 },
                          { text: 'Cargo', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'cargo', width: 150 },
                          { text: 'Responsable', columntype: 'textbox', filtertype: 'textbox', datafield: 'resp', width: 200 },
                          { text: 'Teléfonos', columntype: 'textbox', filtertype: 'textbox', datafield: 'tlf', width: 230 },
                          { text: 'Email', columntype: 'textbox', filtertype: 'textbox', datafield: 'email', width: 270 },
                          { text: 'Estatus', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'estatus', width: 80 },
                          { text: 'Direccion', columntype: 'textbox', filtertype: 'textbox', datafield: 'direccion', width: 0 }
                        ]
                    });
                $("#jqxgrid").jqxGrid('setcolumnproperty', 'codigo', 'hidden', true);
            });
            $("#jqxwindow").jqxWindow({ resizable: false, theme: theme, autoOpen: false, width: 210, height: 180 });
        });

        function ObtenerIdDepartamento(Departamento) {
            var resp = 0;
            var dep = Departamento + "|";
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: 'Depto', fun: 'getIdDepto', data: dep }
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    resp = 0;
                    MsgError(data.split('§')[1]);
                } else {
                    resp = data.split('§')[1];
                }
            }).fail(function () {
                alert("error");
            });
            return resp;
        }

        function AgregarDepartamento() {
            var resp = true;
            var dep = $('#txtNombDepto').val() + "|";
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: 'Depto', fun: 'newRecord', data: dep }
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    resp = false;
                    MsgError(data.split('§')[1]);
                } else {
                    MsgInfo('Registro incluido con exito.');
                    GetRecordExtras(oDepto);
                }
            }).fail(function () {
                alert("error");
            });
            return resp;
        }

        function ModificarDepartamento(id,Departamento) {
            var resp = true;
            var dep = Departamento + "|";
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: 'Depto', fun: 'updateRecord', id: id, data: dep }
            }).done(function (data) {
                if (data.split('§')[0] != "OK") {
                    resp = false;
                    MsgError(data.split('§')[1]);
                } else {
                    MsgInfo('Registro modificado con exito.');
                    GetRecordExtras(oDepto);
                    $('#txtNombDepto').val(Departamento)
                }
            }).fail(function () {
                alert("error");
            });
            return resp;
        }

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
                row["cedula"] = column2[i];
                row["nombre"] = column3[i];
                row["cargo"] = column4[i];
                row["resp"] = column5[i];
                row["tlf"] = column6[i];
                row["email"] = column7[i];
                row["estatus"] = column8[i];
                row["direccion"] = column9[i];
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
            column9 = [];
        }

        function LoadGridView(index) {
            column1.push(aSource[index].split('|')[1]);
            column2.push(aSource[index].split('|')[9]);
            column3.push(aSource[index].split('|')[2]);
            column4.push(aSource[index].split('|')[15]);
            column5.push(aSource[index].split('|')[16]);
            column6.push(aSource[index].split('|')[10] + ' / ' + aSource[index].split('|')[11]);
            column7.push(aSource[index].split('|')[13]);
        
            var valEstatus = aSource[index].split('|')[19];
            if (valEstatus == 0) { column8.push('Inactivo'); } else { column8.push('Activo'); }
            column9.push(aSource[index].split('|')[12]);
        }

        function ShowGridView() {
            $("#jqxgrid").jqxGrid('clearfilters');
            GetRecord(0);
            $(".overlay").fadeIn();
            $("#divLista").fadeIn();
            bShowGridView = true;
            intervalVarRefreshGridView = setInterval(function() { RefreshGridView() }, 1000);
        }
        


    </script>

</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <h1 class="titulo_iframe">Personal<a href="#" id="btn_cerrar"></a></h1>   
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="loadGridView" value="Carga data en Grid View" />
    </div>
    
    <div class="cont_grid" style="width:1250px;" id="divLista">
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
                        <input type="text" id="txtNominativo" onkeypress="javascript:return GetKeyPressed(event)"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>NOMBRES</label></div>
                <div class="cell">
                    <input type="text" id="txtNombre1" onkeypress="javascript:return ValidaCampoNombre(event, this)" style="width:100px;"/>
                    <input type="text" id="txtNombre2" onkeypress="javascript:return ValidaCampoNombre(event, this)" style="width:100px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>APELLIDOS</label></div>
                <div class="cell">
                    <input type="text" id="txtApellido1" onkeypress="javascript:return ValidaCampoNombre(event, this)" style="width:100px;"/>
                    <input type="text" id="txtApellido2" onkeypress="javascript:return ValidaCampoNombre(event, this)" style="width:100px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>FECHA DE NACIMIENTO</label></div>
                <div class="cell">
                    <input type="text" id="txtFN" onkeypress="javascript:return ValidaCampoFecha(event, this)" class=":fechaValida" style="width:70px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>SEXO</label></div>
                <div class="cell"><select id="selSexo" class="select" style="width:100px;" ></select></div>
            </div>
            <div class="row">
                <div class="cell"><Label>CÉDULA</label></div>
                <div class="cell">
                    <div id="selTipoCedula" style="left:10px;position:relative;left:10px;"></div>
                    <input type="text" id="txtCedula" onkeypress="javascript:return ValidaCampoCedula(event, this)" />
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. CELULAR</label></div>
                <div class="cell"><input type="text" id="txtTelCell" onkeypress="javascript:return ValidaCampoCelular(event, this)" class=":tlf-m" style="width:90px;"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. CASA</label></div>
                <div class="cell"><input type="text" id="txtTelCasa" onkeypress="javascript:return ValidaCampoTelefono(event, this)" class=":tlfl" style="width:90px;"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>EMAIL</label></div>
                <div class="cell"><input type="text" id="txtEmail" class=":email" style="width:140px;" maxlength="50"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>DIRECCION</label></div>
                <div class="cell">
                    <input type="text" id="txtDireccion" style="width:250px;" maxlength="150"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>RESPONSABLE</label></div>
                <div class="cell">
                    <input type="text" id="txtNombResponsable" style="width:100px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>DEPARTAMENTO</label></div>
                <div class="cell"><input type="text" id="txtNombDepto" style="width:100px;"/><button id="btAddDep" class="boton" style="position: relative; float: left; left: 20px;">Agregar</button><button id="btModDep" class="boton" style="position: relative; float: left; left: 20px;">Modificar</button></div>
            </div>
            <div class="row">
                <div class="cell"><Label>CARGO</label></div>
                <div class="cell"><input type="text" id="txtCargo" style="width:100px;" maxlength="50"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>FECHA DE INICIO</label></div>
                <div class="cell">
                    <input type="text" id="txtFI" onkeypress="javascript:return ValidaCampoFecha(event, this)" class=":fechaValida" style="width:70px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>NOTAS</label></div>
                <div class="cell"><input type="text" id="txtNotas" style="width:250px;" maxlength="250"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>ESTATUS</label></div>
                <div class="cell"><input type="button" value="" id="btEstatus" style="left:15px; height:24px;"/></div>
            </div>
        </div>
    </div>
    
</body>

</html>
