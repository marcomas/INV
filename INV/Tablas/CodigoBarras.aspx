<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CodigoBarras.aspx.vb" Inherits="INV.CodigoBarras" %>

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
    
    <link rel="stylesheet" href="../Scripts/jqwidgets/jqwidgets/styles/jqx.base.css" type="text/css" />
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

    <script type="text/javascript">

        var tabla = "articulo"
        var aSource = new Array();
        var theme;

        var getAdapter = function () {
            // prepare the data
            var data = aSource;
            var source =
            {
                localdata: data,
                datatype: "array",
                datafields:
                [
                    { name: 'barcode', type: 'string' },
                ],
                updaterow: function (rowid, rowdata, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    commit(true);
                }
            };

            var dataAdapter = new $.jqx.dataAdapter(source);
            return dataAdapter;
        }


        function loadgrid() {
            $("#jqxgrid").jqxGrid(
            {
                width: 410,
                height: 440,
                source: getAdapter(),
                theme: theme,
                showstatusbar: true,
                renderstatusbar: function (statusbar) {
                    // appends buttons to the status bar.
                    var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
                    var addButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../images/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Nuevo</span></div>");
                    var deleteButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../images/close.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Eliminar</span></div>");
                    var reloadButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../images/refresh.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Actualizar</span></div>");
                    container.append(addButton);
                    container.append(deleteButton);
                    container.append(reloadButton);
                    statusbar.append(container);
                    addButton.jqxButton({ theme: theme, width: 90, height: 20 });
                    deleteButton.jqxButton({ theme: theme, width: 90, height: 20 });
                    reloadButton.jqxButton({ theme: theme, width: 90, height: 20 });
                    // add new row.
                    addButton.click(function (event) {
                        var html = '<input type="text" value="" id="txtCodBarra" onkeypress="javascript:return GetKeyPressed(event)"/>';
                        myMsg = $.msgBox({
                            title: "Agregar Cod. Barra",
                            content: "<div style='text-align: center;'>" + html + "</div>",
                            type: "info",
                            buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                            success: function (result) {
                                if (result == "Aceptar") {
                                    AgregarCodBarra($('#txtCodBarra').val());
                                }
                            }
                        });

                        $('#txtCodBarra').focus();
                        $("#txtCodBarra").jqxInput({ placeHolder: "Cod. Barras", height: 5, width: 200, minLength: 1 });
                        
                    });
                    // delete selected row.
                    deleteButton.click(function (event) {
                        var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
                        var rowscount = $("#jqxgrid").jqxGrid('getdatainformation').rowscount;
                        if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
                            $.msgBox({
                                title: "Eliminar ",
                                content: "Esta seguro que eliminar el item?",
                                type: "confirm",
                                buttons: [{ value: "Aceptar" }, { value: "Cancelar" }],
                                success: function (result) {
                                    if (result == "Aceptar") {
                                        DeleteRecord(selectedrowindex);
                                    }
                                }
                            });
                        }
                        else {
                            MsgAlert("Seleccione un Cod. Barra.");
                        }
                    });
                    // reload grid data.
                    reloadButton.click(function (event) {
                        GetRecord();
                    });
                    // search for a record.
                },
                columns: [
                  { text: 'Cod. Barra', columntype: 'textbox', datafield: 'barcode', width: 270 },
                ]
            });
        }

        function AgregarCodBarra(cod) {
            var encontro = false;
            for (i = 0; i < aSource.length; i++) {
                if (aSource[i]['barcode'] == esp[0]) {
                    encontro = true;
                }
            }
            if (encontro == true) {
                MsgAlert("Cod. Barra ya Ingresado.");
            }
            else {
                var row = {};
                row["barcode"] = esp[0];
                aSource[aSource.length] = row;
                AddRecord()
            }
        }


        function DeleteRecord(index) {
            var dataresp = aSource;
            aSource.splice(index, 1);
            var info = '';
            for (i = 0; i < aSource.length; i++) {
                info += aSource[i]['barcode'] + "|"
            }
            $.ajax({
                type: "POST",
                url: "../WS/WSTablas.aspx",
                data: { tabla: tabla, fun: 'updateBarCode', data: info, id: '<%=IdArt%>' }
                }).done(function (data) {
                    if (data.split('§')[0] == "OK") {
                        var id = $("#jqxgrid").jqxGrid('getrowid', index);
                        $("#jqxgrid").jqxGrid('deleterow', id);
                    }
                }).fail(function () {
                    aSource = dataresp;
                    alert("error");
                });
            }

            function AddRecord() {
                var info = '';
                for (i = 0; i < aSource.length; i++) {
                    info += aSource[i]['barcode'] + "|"
                }
                $.ajax({
                    type: "POST",
                    url: "../WS/WSTablas.aspx",
                    data: { tabla: tabla, fun: 'updateBarCode', data: info, id: '<%=IdArt%>' }
                }).done(function (data) {
                    if (data.split('§')[0] == "OK") {
                        loadgrid();
                    }
                }).fail(function () {
                    aSource = dataresp;
                    alert("error");
                });
            }

            function GetRecord() {
                $.ajax({
                    type: "POST",
                    url: "../WS/WSTablas.aspx",
                    data: { tabla: tabla, fun: 'GetBarCode', id: '<%=IdArt%>' }
                }).done(function (data) {
                    if (data.split('§')[0] == "OK") {
                        var source = data.split('§')[1];
                        LoadDataFromSource(source)
                        loadgrid();
                    }
                }).fail(function () { alert("error"); });
            }

            function LoadDataFromSource(source) {
                var DataSource = source.split('$');
                for (i = 0; i < DataSource.length; i++) {
                    var row = {};
                    row["barcode"] = DataSource[i];
                    aSource[i] = row;
                }
            }


            $(document).ready(function () { theme = getDemoTheme() });
            GetRecord();
    </script>
</head> 

<body class="body_iframe1">
    <div id='jqxWidget'>
        <div id="jqxgrid">
        </div>
        <div id="jqxwindow">
           
        </div>
    </div>
</body>
    
