<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Usuario.aspx.vb" Inherits="INV.Usuario" %>

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

    <script>

        //-- CONSTANTES --//
        var aTipo = Array("|0", "Administrador|1", "Operador|2");
        var tabla = 'usuario';

        //-- VARIABLES --//
        var aSource = new Array();
        var aCodigos = new Array();
        var aNombres = new Array();
        var aSearch = new Array();
        var intervalVarLoadAllData;
        var bMA = '<%=bMA %>';

        //-- SETUP --//
        $(function() {
            Init();

            $('#txtSearch').change(function() {
                var index = aSearch.indexOf($('#txtSearch').val());
                if (index > -1) { GetValue(1, index); }
            });

            $('#btEstatus').click(function() {
                if ($('#idRecord').val() == 0) { return; }
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
            aCtrl.push(new objParamsField('txtUsername', 'texto', 100, 1, '', '', '', 0, 0, 0, 0, 0, 0, 1));
            aCtrl.push(new objParamsField('selTipo', 'tipo', 50, 1, 'x', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('selEstatus', 'tipo', 50, 1, 'x', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTlfo', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTlfi', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtTlfc', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtEmail', 'texto', 150, 1, 'x', '', '', 0, 0, 0, 0, 0));

            GetRecord(1);
            ClearFieldsToInit();

            if (bMA == 1) {
                $("#toolbar_tabla").fadeOut();
                GetRecordMA();
                $('#btEstatus').hide();
            }
        }

        function GetRecordMA() {
            UnloadData_1();
            UnloadData_Columns();

            $.ajax({
                type: "POST",
                url: "../WS/WSSession.aspx",
                data: { fun: 'getUsuario' },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] != "OK") {
                    if (bShowMessage == true) { MsgError(data.split('§')[1]); }
                    LoadData_2();
                    ClearFieldsToInit();
                } else {
                    var source = data.split('§')[1];
                    LoadDataFromSource(source);
                    intervalVarLoadData = setInterval(function() { LoadDataAll(0) }, 2000);
                }
            }).fail(function() { alert("error"); });
        }

        function GetValue(type, index) {
            $('#txtSearch').val(aCodigos[index] + '|' + aNombres[index]);
            $('#txtCodigo').val(aCodigos[index]);
            $('#txtNominativo').val(aNombres[index]);

            if (bMA == 0) {
                ViewButtonsEditAndDelete(true);
            }
            
            SetData(index);
            SetEstatusFields(aSource[index].split('|')[9], 'btEstatus', 'Inactivo', 'Activo');
        }

        function GetInfo() {
            var info =
                $('#txtNombre1').val() + '|' +
                $('#txtNombre2').val() + '|' +
                $('#txtApellido1').val() + '|' +
                $('#txtApellido2').val() + '|' +
                $('#selTipo').val() + '|' +
                $('#txtTlfo').val() + '|' +
                $('#txtTlfi').val() + '|' +
                $('#txtTlfc').val() + '|' +
                $('#txtEmail').val() + '|';
                
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

            if (bMA == 1) {
                GetValue(1, 0);
                PrepareFieldsToSearchRecord();
            } else {
                if (fun == 2) { PrepareFieldsToSearchRecord(); }
                if (fun == 3) { PrepareFieldsToSaveRecord(); }
            }
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
            $('#txtUsername').val('');
            $('#txtTlfo').val('');
            $('#txtTlfi').val('');
            $('#txtTlfc').val('');
            $('#txtEmail').val('');

            $('#selTipo').empty();
            for (i = 0; i < aTipo.length; i++) {
                $('#selTipo').append(new Option(aTipo[i].split('|')[0], aTipo[i].split('|')[1]));
            }
        }
        
    </script>
        
    <script>
        
        //-- GRID VIEW --//
        var widthGridView = 750;
        var bShowGridView = false;
        var column1 = new Array();
        var column2 = new Array();
        var column3 = new Array();
        var column4 = new Array();
        var column5 = new Array();
        var intervalVarRefreshGridView;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $("#jqxgrid").on('rowselect', function(event) {
                var codigo = event.args.row.codigo;
                var index = aCodigos.indexOf(codigo);
                if (index > -1) { GetValue(1, index); }
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
                        { name: 'username', type: 'string' },
                        { name: 'nominativo', type: 'string' },
                        { name: 'tipo', type: 'string' },
                        { name: 'estatus', type: 'string' }
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
                          { text: 'Código', columntype: 'textbox', filtertype: 'textbox', datafield: 'codigo', width: 1 },
                          { text: 'Username', columntype: 'textbox', filtertype: 'textbox', datafield: 'username', width: 200 },
                          { text: 'Nombre y Apellido', columntype: 'textbox', filtertype: 'textbox', datafield: 'nominativo', width: 300 },
                          { text: 'Tipo', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'tipo', width: 150 },
                          { text: 'Estatus', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'estatus', width: 100 }
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
                row["username"] = column2[i];
                row["nominativo"] = column3[i];
                row["tipo"] = column4[i];
                row["estatus"] = column5[i];
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
        }

        function LoadGridView(index) {
            column1.push(aSource[index].split('|')[1]);
            column2.push(aSource[index].split('|')[7]);
            column3.push(aSource[index].split('|')[2]);

            var valTipo = aSource[index].split('|')[8];
            column4.push(aTipo[valTipo].split('|')[0]);

            var valEstatus = aSource[index].split('|')[9];
            if (valEstatus == 0) { column5.push('Inactivo'); } else { column5.push('Activo'); }
        } 

        function ShowGridView() {
            $("#jqxgrid").jqxGrid('clearfilters');
            GetRecord(0);
            $(".overlay").fadeIn();
            $("#divLista").fadeIn();
            $("#jqxgrid").fadeIn();
            $(".close_grid").click(function() {
                $("#divLista").fadeOut();
                $("#jqxgrid").fadeOut();
                $(".overlay").fadeOut();
                SetOcultarNotifica(0);
            });
            bShowGridView = true;
            intervalVarRefreshGridView = setInterval(function() { RefreshGridView() }, 1000);
        }
        
    </script>

</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <h1 class="titulo_iframe">Usuarios<a href="#" id="btn_cerrar"></a></h1>    
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="loadGridView" value="Carga data en Grid View" />
    </div>
    
    <div class="cont_grid" style="width:750px;" id="divLista">
        <h1 class="title_grid">&nbsp;</h1>
        <span class="close_grid"></span>
        <div id="jqxgrid"></div>
    </div>
    
    <div class="seccion">
        <div class="barra" id="toolbar_tabla"></div>
        <div class="title_seccion">&nbsp;</div>
        <div class="table" id="divTabla">
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
                <div class="cell"><Label>USERNAME</label></div>
                <div class="cell">
                    <input type="text" id="txtUsername" style="width:100px;"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>TIPO DE USUARIO</label></div>
                <div class="cell"><select id="selTipo" class="select" style="width:100px;"></select></div>
            </div>
            <div class="row">
                <div class="cell"><Label>ESTATUS</label></div>
                <div class="cell"><input type="button" value="" id="btEstatus" style="left:15px; height:24px; margin-top: 5px;"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. DE OFICINA</label></div>
                <div class="cell">
                    <input type="text" id="txtTlfo" style="width:100px;" onkeypress="javascript:return ValidaCampoTelefono(event, this)" class=":tlfl"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. INTERNO</label></div>
                <div class="cell">
                    <input type="text" id="txtTlfi" style="width:100px;" onkeypress="javascript:return ValidaCampoTelefono(event, this)" class=":tlfl"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>TEL. CELULAR</label></div>
                <div class="cell">
                    <input type="text" id="txtTlfc" style="width:100px;" onkeypress="javascript:return ValidaCampoCelular(event, this)" class=":tlf-m"/>
                </div>
            </div>
            <div class="row">
                <div class="cell"><Label>EMAIL</label></div>
                <div class="cell">
                    <input type="text" id="txtEmail" style="width:100px;" class=":email"/>
                </div>
            </div>
        </div>
    </div>
    
</body>

</html>

