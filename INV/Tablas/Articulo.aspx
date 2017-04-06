<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Articulo.aspx.vb" Inherits="INV.Articulo" %>

<!DOCTYPE html>
<html>

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
    <script src="../js/toolbarGeneric.js?0.0.0.6"></script>
    <script src="../js/commextrass.js?0.0.0.6"></script>
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
        var tabla = 'articulo';
        var columnsExports = 'codigo|nombre|nivel|um|sm|e|estatus';
        var columnsExportCaption = 'Codigo|Nombre|Nivel|UM|Stock min.|Existencia|Estatus';
        var numreport = 9;
        
        //-- VARIABLES --//
        var aSource = new Array();
        var aCodigos = new Array();
        var aNombres = new Array();
        var aSearch = new Array();
        var oUM;
        var intervalVarLoadAllData;
        var bNewCategoria = 0;
        var codArtSelected = '';
        var intervalVar;
        var isConsumible = 0;
    
    </script>
    
    <script>    
        //-- SETUP --//
        $(function() {

            $("#divLista").fadeOut();
            $("#divNiveles").fadeOut();

            Init();

            $('#txtSearch').change(function() {
                var index = aSearch.indexOf($('#txtSearch').val());
                var codigo = aCodigos[index];
                if (index > -1) { GetValue(index); }

                imagesGallery = 0;
                codArtSelected = codigo;
                if (!$("#galeria").is(":visible"))
                    $("#galeria").css('display', 'block');
            });

            $(".close_grid").click(function() {
                $(".cont_grid").fadeOut();
                $("#divLista").fadeOut();
                $("#divNiveles").fadeOut();
                $("#divUploadFoto").fadeOut();
                $(".overlay").fadeOut();
                clearInterval(intervalVar);
                SetOcultarNotifica(0);
            });

            $('#btNivel').click(function() {
                if (bEditOrNew) {
                    _ShowGridView();
                }
            });

            $('#btEstatus').click(function() {
                if (!bEditOrNew && idRecordSelected > -1) {
                    MsgCambiarEstatus();
                }
            });
            
            $('#btConsumible').click(function () {
                if (!bEditOrNew && idRecordSelected > -1) {
                    CambiaConsumible();
                }
            });

            $('#btImprimirBarCode').click(function () {
                if (!bEditOrNew && idRecordSelected > -1) {
                    $.msgBox({
                        title: "Imprimir",
                        content: "Esta Seguro que desea Imprimir el Codigo de Barra?",
                        type: "confirm",
                        buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                        success: function (result) {
                            if (result == "Aceptar") {
                                window.open("../Print/PrintBarCode.aspx?Codigo=" + $('#txtCodigo1').val(), "_blank ");
                            }
                        }
                    });
                    return false;
                }
            });
        });

        function NewCategoria() {
            var info = GetInfo();

            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { tabla: tabla, fun: 'newCategoriaArticulo', data: info },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] != "OK") {
                    MsgError(data.split('§')[1]);
                } else {
                    GoToSave();
                    bEditOrNew = false;
                    EventChangeStatusToolbar();
                    idRecordSelected = data.split('§')[1].split('|')[0];
                    GetRecord(3);
                }
            });
        }

        function CambiaConsumible() {
            idRecordSelected = $('#idRecord').val();

            $.ajax({
                type: "POST",
                url: "../WS/WSChangeEstatusFields.aspx",
                data: { tabla: tabla, fun: 'cambiaConsumible', id: idRecordSelected },
                async: false
            }).done(function (data) {
                if (data.split('§')[0] == "OK") {
                    SetEstatusFields(data.split('§')[1].split('$')[0], 'btConsumible', 'No', 'Si');
                    if (data.split('§')[1].split('$')[0] == false) {
                        $('.is_consumible').hide();
                        $('.not_is_consumible').fadeIn();
                        
                    } else {
                        $('.is_consumible').fadeIn();
                        $('.not_is_consumible').hide();
                    }
                }
            });
        }

        function MsgInsertCategoriaOrArticulo() {
            var htmlBotones = '';
            htmlBotones += "<input type='button' class='buttonhover1' value='Categoria' onclick='javascript:InsertCategoriaOrArticulo(\"Categoria\")' style='width:200px;'><br style='font-size: x-large;'>";
            htmlBotones += "<input type='button' class='buttonhover1' value='Articulo consumible' onclick='javascript:InsertCategoriaOrArticulo(\"ArticuloC\")' style='width:200px;'><br style='font-size: x-large;'>";
            htmlBotones += "<input type='button' class='buttonhover1' value='Articulo único' onclick='javascript:InsertCategoriaOrArticulo(\"ArticuloU\")' style='width:200px;'><br style='font-size: x-large;'>";

            myMsg = $.msgBox({
                title: "Selecciona Categoria/Articulo",
                content: "<div style='text-align: center;'>" + htmlBotones + "</div>",
                type: "info",
                buttons: [{ value: "Cancelar"}],
                success: function(result) {
                    $(".overlay").fadeOut();
                }
            });
        }

        function InsertCategoriaOrArticulo(s) {
            if (s == 'Categoria') {
                $(".is_articulo").hide();
                isConsumible = 0;
                bNewCategoria = 1;
            } else if (s == 'ArticuloC') {
                $(".is_articulo").fadeIn();
                $(".not_is_consumible").hide();
                bNewCategoria = 0;
                isConsumible = 1;
            } else {
                $(".is_articulo").fadeIn();
                $(".is_consumible").hide();
                bNewCategoria = 0;
                isConsumible = 0;
            }

            $(".msgBoxBackGround").hide();
            $(".msgBox").hide();
            _ShowGridView();
        }

        function MsgCambiarEstatus() {
            var htmlBotones = '';
            var aEstatus = 'Disponible|Ocupado|Dañado|En reparación|En mantenimiento|Extraviado'.split('|');
            for (i = 0; i < aEstatus.length; i++) {
                if (aEstatus[i] != $('#txtEstatus').val()) {
                    htmlBotones += JQUERY4U.UTIL.formatVarString(
                        "<input type='button' class='buttonhover1' value='{1}' onclick='javascript:CambiarEstatus(\"{1}\")' style='width:200px;'><br style='font-size: x-large;'>", aEstatus[i]);
                } 
            }

            myMsg = $.msgBox({
                title: "Selecciona el Estatus",
                content: "<div style='text-align: center;'>" + htmlBotones + "</div>",
                type: "info",
                buttons: [{ value: "Cancelar"}],
                success: function(result) {
                    $(".overlay").fadeOut();
                }
            });
        }

        function CambiarEstatus(e) {
            var info = getIdEstatus(e) + '|';

            $.ajax({
                type: "POST",
                url: "../WS/WSChangeEstatusFields.aspx",
                data: { fun: 'cambiaEstatusArticulo', id: idRecordSelected, data: info },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] == "OK") {
                    $('#txtEstatus').val(getEstatus(parseInt(data.split('§')[1])));
                }
            });

            $(".msgBoxBackGround").hide();
            $(".msgBox").hide();
        }
        
        function Init() {
            // id, type, length, notNull, msgAlert, msgError, format, isSearch, isCodigo, isFocusToSearch, isFocusToEdit, isFocusToNew, isEdit, isReadonly
            aCtrl.push(new objParamsField('idRecord', 'hid', 8, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtCodigo', 'texto', 10, 1, '', '', '', 0, 1, 1, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNombre', 'texto', 100, 1, '', '', '', 1, 0, 0, 0, 0, 0, 1));
            aCtrl.push(new objParamsField('txtCodigo1', 'texto', 50, 1, '', '', '', 0, 0, 0, 1, 1));
            aCtrl.push(new objParamsField('txtNombre1', 'texto', 50, 1, 'x', '', '', 0, 0, 0, 1, 1));
            aCtrl.push(new objParamsField('txtDescr2Nivel', 'texto', 50, 1, 'x', '', '', 0, 0, 0, 0, 0, 0, 1));
            aCtrl.push(new objParamsField('txtUM', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNumStockMinimo', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtNumExistencia', 'texto', 50, 1, '', '', '', 0, 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtDescr2Nota', 'texto', 10, 1, '', '', '', 0, 0, 0, 0, 0));
            aCtrl.push(new objParamsField('txtEstatus', 'texto', 10, 1, '', '', '', 0, 0, 0, 0, 0, 0, 1));

            GetRecord(1);
            oUM = new objExtras('um', $("#txtUM")); GetRecordExtras(oUM);
            intervalVarLoadAllData = setInterval(function() { InitFiels() }, 1000);
        }

        function InitFiels() {
            clearInterval(intervalVarLoadAllData);
            if (oUM.load) {
                ClearFieldsToInit();
            } else {
                intervalVarLoadAllData = setInterval(function() { InitFiels() }, 1000);
            }
        }

        function GetValue(index) {
            $('#txtSearch').val(aCodigos[index] + '|' + aNombres[index]);
            $('#txtCodigo').val(aCodigos[index]);
            $('#txtNombre').val(aNombres[index]);

            SetEstatusFields(aSource[index].split('|')[12], 'btConsumible', 'No', 'Si');

            ViewButtonsEditAndDelete(true);
            SetData(index);
            
            if (aSource[index].split('|')[12] == false) {
                $('.is_consumible').hide();
                $('#txtEstatus').val(getEstatus(parseInt(aSource[index].split('|')[11])));
                $('.not_is_consumible').fadeIn();
            } else {
                $('.is_consumible').fadeIn();
                $('.not_is_consumible').hide();
            }

            GetFotogallery();
        }

        function GetInfo() {
            var info =
                $('#txtNombre1').val() + '|' +
                $('#txtDescr2Nivel').val() + '|' +
                $('#txtUM').val() + '|' +
                $('#txtNumStockMinimo').val() + '|' +
                $('#txtNumExistencia').val() + '|' +
                $('#txtDescr2Nota').val() + '|' + 
                isConsumible + '|';
                
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
            if (fun == 3) {
                PrepareFieldsToSaveRecord();
                
                var index = GetIndexSourceFroIdRecord(idRecordSelected);
                if (aSource[index].split('|')[12] == false) {
                    $('.is_consumible').hide();
                    $('#txtEstatus').val(getEstatus(parseInt(aSource[index].split('|')[11])));
                    $('.not_is_consumible').fadeIn();
                    $('#txtEstatus').fadeIn();
                } else {
                    $('.is_consumible').fadeIn();
                    $('.not_is_consumible').hide();
                }
            }
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
            $('#txtCodigo1').val('');
            $('#txtNombre1').val('');
            $('#txtDescr2Nivel').val('');
            $('#txtUM').val('');
            $('#txtNumStockMinimo').val('');
            $('#txtNumExistencia').val('');
            $('#txtDescr2Nota').val('');
            $('#txtEstatus').val('');
        }
        
    </script> 
        
    <script>

        //-- GRID VIEW --//
        var widthGridView = 1160;
        var bShowGridView = false;
        var column1 = new Array();
        var column2 = new Array();
        var column3 = new Array();
        var column4 = new Array();
        var column5 = new Array();
        var column6 = new Array();
        var column7 = new Array();
        var intervalVarRefreshGridView;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $("#jqxgrid").on('rowselect', function(event) {
                var codigo = event.args.row.codigo;
                var index = aCodigos.indexOf(codigo);
                if (index > -1) { GetValue(index); }
                PrepareFieldsToSearchRecord();
                codArtSelected = codigo;
                ResetGallery();
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
                        { name: 'nivel', type: 'string' },
                        { name: 'um', type: 'string' },
                        { name: 'sm', type: 'string' },
                        { name: 'e', type: 'string' },
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
                          { text: 'Codigo', columntype: 'textbox', filtertype: 'textbox', datafield: 'codigo', width: 120 },
                          { text: 'Nombre', columntype: 'textbox', filtertype: 'textbox', datafield: 'nombre', width: 200 },
                          { text: 'Nivel', columntype: 'textbox', filtertype: 'textbox', datafield: 'nivel', width: 400 },
                          { text: 'UM', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'um', width: 100 },
                          { text: 'Stock min.', columntype: 'textbox', filtertype: 'textbox', datafield: 'sm', width: 100 },
                          { text: 'Existencia', columntype: 'textbox', filtertype: 'textbox', datafield: 'e', width: 100 },
                          { text: 'Estatus', columntype: 'textbox', filtertype: 'checkedlist', datafield: 'estatus', width: 140 }
                        ]
                    });
                //                $("#jqxgrid").jqxGrid('setcolumnproperty', 'codigo', 'hidden', true);
            });
            $("#jqxwindow").jqxWindow({ resizable: false, theme: theme, autoOpen: false, width: 260, height: 180 });
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
                row["nivel"] = column3[i];
                row["um"] = column4[i];
                row["sm"] = column5[i];
                row["e"] = column6[i];
                row["estatus"] = column7[i];
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
        }

        function LoadGridView(index) {
            column1.push(aSource[index].split('|')[1]);
            column2.push(aSource[index].split('|')[2]);
            column3.push(aSource[index].split('|')[5]);
            column4.push(aSource[index].split('|')[6]);
            column5.push(aSource[index].split('|')[7]);
            column6.push(aSource[index].split('|')[8]);
            column7.push(getEstatus(parseInt(aSource[index].split('|')[11])));
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
    
    <script>

        //-- GRID VIEW --//
        var _column1 = new Array();
        var aNiveles = new Array();
        var intervalVarFocus;

        $(document).ready(function() {
            var theme = getDemoTheme();

            $("#_jqxgrid").on('rowselect', function(event) {
                $('#txtDescr2Nivel').val(event.args.row.nivel);
                $(".close_grid").click();
                intervalVarFocus = setInterval(function() { clearInterval(intervalVarFocus); $('#txtNombre1').focus(); }, 500);                
            });

            $("#_loadGridView").click(function() {
                // prepare the data
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
                        { name: 'nivel', type: 'string' }
                    ],
                    datatype: "array"
                };
                var dataAdapter = new $.jqx.dataAdapter(source);

                $("#_jqxgrid").jqxGrid(
                {
                    width: 545,
                    source: dataAdapter,
                    theme: theme,
                    showfilterrow: true,
                    filterable: true,
                    sortable: true,
                    pageable: true,
                    pagesize: 15,
                    autoheight: true,
                    columnsresize: true,
                    selectionmode: 'singlerow',
                    ready: function() {
                        $("#_jqxgrid").jqxGrid('sortby', 'id', 'asc');
                    },
                    showstatusbar: false,
                    columns: [
                      { text: 'Categoria', columntype: 'textbox', filtertype: 'textbox', datafield: 'nivel', width: 545 }
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
                row["nivel"] = _column1[i];
                data[i] = row;
            }
            return data;
        }

        function _UnloadData_Columns() {
            aNiveles = [];
            _column1 = [];
        }

        function _LoadGridView(index) {
            _column1.push(aNiveles[index].split('|')[0]);
        }

        function _ShowGridView() {
            $("#_jqxgrid").jqxGrid('clearfilters');
            GetRecordNiveles();
            $(".overlay").fadeIn();
            $("#divNiveles").fadeIn();
            intervalVarRefreshGridView = setInterval(function() { _RefreshGridView() }, 1000);
        }
        
        function _LoadDataFromSource(source) {
            _UnloadData_Columns();
            aNiveles = source.split('$');
            for (i = 0; i < aNiveles.length; i++) {
                _LoadGridView(i);
            }
        }
        
        function GetRecordNiveles() {
            _UnloadData_Columns();

            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { fun: 'getNiveles' },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] != "OK") {
                    MsgInfo('No existen Categorias.');
                } else {
                    var source = data.split('§')[1];
                    _LoadDataFromSource(source);
                }
            });
        }
        
        function MostrarMensajeBarCode() {
            $.msgBox({
                title: "Guardar",
                content: "Desea asignar un codigo de barra al articulo?",
                type: "confirm",
                buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                success: function (result) {
                    if (result == "Aceptar") {
                        CapturarBarCode();
                    }
                }
            });
        }

        function CapturarBarCode() {
            var html = '<input type="text" value="" id="txtCodBarra" onkeypress="javascript:return GetKeyPressed(event)"/>';
                myMsg = $.msgBox({
                    title: "Agregar Cod. Barra",
                    content: "<div style='text-align: center;'>" + html + "</div>",
                    type: "info",
                    bCloseMsgBox : false,
                    buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                    success: function (result) {
                        if (result == "Aceptar") {
                            bCloseMsgBox=AddBarCode($('#txtCodBarra').val());
                        }
                        else {
                            bCloseMsgBox = true;
                            $(".overlay").fadeOut();
                        }
                    }
                });

                $('#txtCodBarra').focus();
                $("#txtCodBarra").jqxInput({ placeHolder: "Cod. Barras", height: 5, width: 200, minLength: 1 });
         }

        function AddBarCode(barcode) {
            var resp = true;
            barcode += "|";
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: tabla, fun: 'AddBarCode', data: barcode, id: $('#idRecord').val() }
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

        function GetFotogallery() {
            images = [];
            fotos = [];
            $('#contenedor').html('');
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: tabla, fun: 'getFotogalleryArticulo', id: $('#idRecord').val() }
            }).done(function(data) {
                if (data.split('§')[0] == "OK") {
                    var str = data.split('§')[1].trim();
                    if (str != '') {
                        var a = str.split('$');
                        for (i = 0; i < a.length; i++) {
                            AddContenedorFotogallery(a[i].split('|')[1].split('.')[0], a[i].split('|')[1]);
                        }
                    }
                }
            });
        }

        function AddContenedorFotogallery(id, img) {
            var div = "<div class='img_gallery' id ='" + id + "'><img src='../imgINV/articulo/" + $('#idRecord').val() + "/" + img + "' style='width: 100%;height:100%;'></div>";
            $("#contenedor").append(div);
            if (!$("#btn_delimg").is(":visible")) {
                $("#btn_delimg").css({"display": "inline-block","float":"right"});
            }
            images.push(id);
            imagesGallery++;
        }

        function DelFotogallery(id) {
            var img =  id + '.jpg'
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                async: false,
                data: { tabla: tabla, fun: 'delFotogalleryArticulo', id: $('#idRecord').val(), data: img + '|' }
            }).done(function(data) {
                if (data.split('§')[0] == "OK") {
                    var urlFoto = "../imgINV/articulo/" + $('#idRecord').val() + "/" + img;
                    $.ajax({
                        type: "POST",
                        url: "../WS/WSToolsServer.aspx",
                        data: { fun: 'deleteFile', data: urlFoto },
                        async: false
                    }).done(function (data) {
                        if (images.length > 0)
                            images.splice(id, 1);
                        imagesGallery--;
                    });
                }
            });
        }
        
    </script>

	<script>

        //-- GALLERY --//
	    var imagesGallery = 0;
	    var imagesGalleryDel = 0;
	    var fotos = new Array();
	    var images = new Array();

	    function ResetGallery() {
	        images = [];
	        fotos = [];
	        $('#contenedor').html('');
	        imagesGallery = 0;
	        imagesGalleryDel = 0;
	        if (!$("#galeria").is(":visible"))
	            $("#galeria").css('display', 'block');
	    }

	    $(document).ready(function () {

	        $("#contenedor").empty();

	        $("#btn_addimg").on('click', function() {
	            if (($('#idRecord').val() != 0) && (images.length < 4)) {
	                if (!bEditOrNew) {
	                    idRecordSelected = $('#idRecord').val();
	                    $('#iframeUploadFoto').attr("src", '../Utilities/UploadFoto.aspx?Id=' + idRecordSelected + '&Folder=articulo');
	                    $(".overlay").fadeIn();
	                    $("#divUploadFoto").fadeIn();
	                    intervalVar = setInterval(function () { CheckFinUpload() }, 1000);
	                }
	            } else {
	                MsgAlert('Ya se han cargado todas las fotos permitidas.');
	            }
	        });

	        $('#iframeUploadFoto').ready(function () {
	            //Everything you need.
	            $('body', $('#iframeUploadFoto').contents()).html('');
	            $("#btnUpload").attr("disabled", true);
	        });

	        function CheckFinUpload() {
	            $.ajax({
	                type: "POST",
	                url: "../WS/WSSessionVar.aspx",
	                data: { name: 'UploadName', fun: 'get' },
	                async: false
	            }).done(function (data) {
	                var namefoto = data.split('$')[0];
	                if (namefoto != null && namefoto != '' && namefoto != 'KO') {
	                    ResetFinUpload();
	                    GuardarFoto(namefoto);
	                    AddContenedorFotogallery(namefoto.split('.')[0], namefoto);
	                }
	                
	            });
	        }

	        function GuardarFoto(foto) {
	            var resp = true;
	            foto += "|";
	            $.ajax({
	                type: "POST",
	                url: "../WS/WSTablas.aspx",
	                async: false,
	                data: { tabla: tabla, fun: 'InsertFoto', data: foto, id: $('#idRecord').val() }
	            }).done(function (data) {
	                if (data.split('§')[0] != "OK") {
	                    resp = false;
	                    MsgError(data.split('§')[1]);
	                }
	            }).fail(function () {
	                alert("error");
	            });
	            return resp;
	        }

	        function ResetFinUpload() {
	            $.ajax({
	                type: "POST",
	                url: "../WS/WSSessionVar.aspx",
	                data: { name: 'UploadName', fun: 'set',value:'' },
	                async: false
	            }).done();
	        }
            
	        $('.div_content_gallery').delegate(".img_gallery", "click", function() {
	            if ($(this).hasClass('img_selected')) {
	                --imagesGalleryDel;
	                $(this).removeClass('img_selected');
	            } else {
	                ++imagesGalleryDel;
	                $(this).addClass('img_selected');
	            }
	        });

	        $("#btn_delimg").on('click', function () {
	            if (imagesGalleryDel === 0) {
	               MsgAlert('Debe seleccionar al menos una imagen para eliminar.');
	            } else {
	                $.msgBox({
	                    title: "Información",
	                    content: "¿Está seguro de eliminar la(s) foto(s) seleccionada(s)?",
	                    type: "confirm",
	                    buttons: [{ value: "Si" }, { value: "No" }],
	                    success: function (result) {
	                        if (result == "Si") {
	                            $('.img_gallery').each(function () {	                                
	                                if ($(this).hasClass('img_selected')) {
	                                    DelFotogallery($(this).attr('id'));
	                                    $(this).remove();
	                                    imagesGallery--;
	                                }
	                            });
	                            
	                            if ($("#contenedor > .img_gallery").length === 0) {
	                                $("#btn_delimg").css("display", "none");
	                            }
	                        }
	                    }
	                });
	            }	            
	            return false;	            
	        });
	    });

    </script>
</head>

<body class="body_iframe">
    <div class="overlay"></div>
    <h1 class="titulo_iframe">Articulo<a href="#" id="btn_cerrar"></a></h1>   
    
    <div style="display:none">
        <input style='margin-top: 10px;' type="button" id="loadGridView" value="Carga data en Grid View" />
        <input style='margin-top: 10px;' type="button" id="_loadGridView" value="Carga data en Grid View" />
    </div>
    
    <!-- Upload Foto -->
    <div class="cont_grid" style="width: 215px; top: 20%; left: 60%; height:280px;" id="divUploadFoto">
        <h1 class="title_grid">Foto</h1>
        <span class="close_grid"></span>
        <iframe id="iframeUploadFoto" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
    
    <div class="cont_grid" style="width:1160px;" id="divLista">
        <h1 class="title_grid">&nbsp;</h1>
        <span class="close_grid"></span>
        <button id="btExportToExcel" title="Exportar a Excel" style="left:15px; height:30px;margin-top:-3%;float:left;" class="clasebtExportToExcel"><img src="../images/icon_excel.png"/></button>
        <div id="jqxgrid"></div>
    </div>
    
    <div class="cont_grid" style="width:550px;left:40%;" id="divNiveles">
        <h1 class="title_grid">&nbsp;</h1>
        <span class="close_grid"></span>
        <div id="_jqxgrid"></div>      
    </div>    

    <div class="seccion" style="position:relative; top:0px; height:500px;">
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
                <div class="cell"><Label>NIVEL</label></div>
                <div class="cell"><input type="text" id="txtDescr2Nivel" /><button id="btNivel" class="boton" style="position: relative; float: right; left: 20px;">Categoria</button></div>
            </div>
            <div class="row">
                <div class="cell"><Label>CÓDIGO</label></div>
                <div class="cell"><input type="text" id="txtCodigo1" /><button id="btImprimirBarCode" class="boton" style="position: relative; float: left; left: 20px;">Imprimir CodigoBarra</button></div>
            </div>
            <div class="row">
                <div class="cell"><Label>NOMBRE</label></div>
                <div class="cell"><input type="text" id="txtNombre1" /></div>
            </div>
            <div class="row is_consumible is_articulo">
                <div class="cell"><Label>UM</label></div>
                <div class="cell"><input type="text" id="txtUM" /></div>
            </div>
            <div class="row is_consumible is_articulo">
                <div class="cell"><Label>STOCK MINIMO</label></div>
                <div class="cell"><input type="text" id="txtNumStockMinimo" onkeypress="javascript:return ValidaCampoNumero(event, this)"/></div>
            </div>
            <div class="row is_consumible is_articulo">
                <div class="cell"><Label>EXISTENCIA</label></div>
                <div class="cell"><input type="text" id="txtNumExistencia"/></div>
            </div>
            <div class="row">
                <div class="cell"><Label>NOTA</label></div>
                <div class="cell"><textarea id="txtDescr2Nota" cols="10" style="position: relative; float: left; left: 14px; height: 50px; margin-top: 0px; margin-bottom: 0px;"></textarea></div>
            </div>
            <div class="row is_articulo">
                <div class="cell"><Label>CONSUMIBLE</label></div>
                <div class="cell"><input type="button" value="" id="btConsumible" style="left:15px; height:24px;"/></div>
            </div>
            <div class="row not_is_consumible is_articulo">
                <div class="cell"><Label>ESTATUS</label></div>
                <div class="cell"><input type="text" id="txtEstatus"/><button id="btEstatus" class="boton" style="position: relative; float: left; left: 20px;">Estatus</button></div>
            </div>

        </div>
        <div class="div_gallery" id="galeria">  
          <div class="barra" id="toolbar_gallery">
            <label>Galeria</label>
            <div style="display: inline-block;float:right;" id="btn_addimg" class="boton icon-social-addthis" title="Agregar"></div>
            <div style="display: none;" id="btn_delimg" class="boton icon-eliminar" title="Eliminar"></div>
          </div>
  
          <div class="div_content_gallery" id="contenedor"></div>
        </div>
    </div>
    
</body>

</html>
