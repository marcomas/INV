var sexoDefault = 'F';
var sinoDefault = '0';
var tipoDefault = '1';
var aSexo = Array("Femenino|F", "Masculino|M");
//var aTipoCedulaRif = Array("M", "E", "V", "J");
var aTipoCedulaRif = Array("E", "V", "J");
var aSiNo = Array("Si|1", "No|0");
var aInterno = Array("Si|1", "No|0");
var aTipoUsuario = Array("", "Administrador|1", "Sub-Administrador|2", "Operador Telefonico|3", "Asistente|4", "Profesional|5", "Recepcion|6", "Cliente|7");

var intervalVarLoadData;
var indexRecordSelected = -1;
var idRecordSelected = -1;
var aCtrl = new Array();

function objParamsField(_id, _type, _length, _notNull, _msgAlert, _msgError, _format, _isSearch, _isCodigo, _isFocusToSearch, _isFocusToEdit, _isFocusToNew, _isEdit, _isReadonly, _defaultValue, _noClean, _width) {
    this.id = _id;
    this.type = _type;
    this.length = _length;
    this.notNull = _notNull;
    this.msgAlert = _msgAlert;
    this.msgError = _msgError;
    this.format = _format;
    this.isSearch = _isSearch;
    this.isCodigo = _isCodigo;
    this.isFocusToSearch = _isFocusToSearch;
    this.isFocusToEdit = _isFocusToEdit;
    this.isFocusToNew = _isFocusToNew;
    if (_type == 'hid') { _isEdit = 0; } if (_isEdit == null) { _isEdit = 1; } this.isEdit = _isEdit;
    if (_type == 'hid') { _isReadonly = 1; } if (_isReadonly == null) { _isReadonly = 0; } this.isReadonly = _isReadonly;
    if (_type == 'hid') { _defaultValue = ''; } if (_defaultValue == null) { _defaultValue = ''; } this.defaultValue = _defaultValue;
    if (_type == 'hid') { _noClean = 0; } if (_noClean == null) { _noClean = 0; } this.noClean = _noClean;
    if (_type == 'hid') { _width = 0; } if (_width == null) { _width = GetWidth(_id); } this.width = _width;
    return this;
}

function GetIndexSourceFroIdRecord(id) {
    for (i = 0; i < aSource.length; i++) {
        if (aSource[i].split('|')[0] == id) {
            return i;
        }
    }
    return -1;
}

var intervalVarLoadRedraw;
var intervalRedraw = 100;
function Redraw(tipoCedula, tipoRif) {
    clearInterval(intervalVarLoadRedraw);
    if (tipoCedula != '') {
        $('#selTipoCedula').val(tipoCedula);
    }
}

function SaveIndexRecordSelected() {
    var value = '';
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.isCodigo == 1) {
            value = $('#' + oCtrl.id).val();
            break;
        }
    }
    for (i = 0; i < aCodigos.length; i++) {
        if (value == aCodigos[i]) {
            indexRecordSelected = i;
            break;
        }
    }
}

function ClearFieldsToInit() {
    if ($("#selTipoCedula")) { $("#selTipoCedula").jqxDropDownList({ disabled: true, source: aTipoCedulaRif }); }
    if ($("#selCategoria")) { $("#selCategoria").jqxDropDownList({ disabled: true }); }
    for (i = 0; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') { $('#' + oCtrl.id + 'Msg').html(''); }
        if (oCtrl.noClean == 0) {
            if (oCtrl.type == 'hid') {
                $('#' + oCtrl.id).val(0);
            } else if (oCtrl.type == 'texto') {
                $('#' + oCtrl.id).val('');
            } else if (oCtrl.type == 'estatus') {
                $('#' + oCtrl.id).val(estatusDefault);
            } else if (oCtrl.type == 'sexo') {
                $('#' + oCtrl.id).val(sexoDefault);
            } else if (oCtrl.type == 'sino') {
                $('#' + oCtrl.id).val(sinoDefault);
            } else if (oCtrl.type == 'int') {
                $('#' + oCtrl.id).val('0');
            } else if (oCtrl.type == 'tipo') {
                $('#' + oCtrl.id).val(tipoDefault);
            }
        }
        $('#' + oCtrl.id).attr('disabled', 'disabled');
        /* ATENCION */
        if (document.getElementById(oCtrl.id) != null) {
            document.getElementById(oCtrl.id).style.width = oCtrl.width + 'px';
        }
        /**/
        if (oCtrl.defaultValue != '') { $('#' + oCtrl.id).val(oCtrl.defaultValue); }
    }
}

function ClearFieldsToInitNew() {
    for (i = 0; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') { $('#' + oCtrl.id + 'Msg').html(''); }
        if (oCtrl.noClean == 0) {
            if (oCtrl.type == 'hid') {
                $('#' + oCtrl.id).val(0);
            } else if (oCtrl.type == 'texto') {
                $('#' + oCtrl.id).val('');
            } else if (oCtrl.type == 'estatus') {
                $('#' + oCtrl.id).val(estatusDefault);
            } else if (oCtrl.type == 'sexo') {
                $('#' + oCtrl.id).val(sexoDefault);
            } else if (oCtrl.type == 'sino') {
                $('#' + oCtrl.id).val(sinoDefault);
            } else if (oCtrl.type == 'int') {
                $('#' + oCtrl.id).val('0');
            } else if (oCtrl.type == 'tipo') {
                $('#' + oCtrl.id).val(tipoDefault);
            }
        }
        if (oCtrl.defaultValue != '') { $('#' + oCtrl.id).val(oCtrl.defaultValue); }
    }
}

function PrepareFieldsToNewRecord() {
    if ($("#selTipoCedula")) { $("#selTipoCedula").jqxDropDownList({ disabled: false, source: aTipoCedulaRif }); }
    if ($("#selCategoria")) { $("#selCategoria").jqxDropDownList({ disabled: true }); }
    UnloadData_1();
    LoadData_2();
    var ctrlIdToFocus = '';
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') { $('#' + oCtrl.id + 'Msg').html(''); }
        if (oCtrl.noClean == 0) {
            $('#' + oCtrl.id).val('');
        }
        if (oCtrl.isCodigo == 1 && oCtrl.isFocusToNew == 0) {
            $('#' + oCtrl.id).attr('disabled', 'disabled');
        } else if (oCtrl.isReadonly == 1) {
            $('#' + oCtrl.id).attr('disabled', 'disabled');
        } else {
            $('#' + oCtrl.id).removeAttr("disabled");
        }
        if (oCtrl.isFocusToNew == 1) { ctrlIdToFocus = oCtrl.id; }
        if (oCtrl.defaultValue != '') { $('#' + oCtrl.id).val(oCtrl.defaultValue); }
    }
    $('#' + ctrlIdToFocus).focus();
}

function PrepareFieldsToEditRecord() {
    if ($("#selTipoCedula")) { $("#selTipoCedula").jqxDropDownList({ disabled: false, source: aTipoCedulaRif }); }
    if ($("#selCategoria")) { $("#selCategoria").jqxDropDownList({ disabled: true }); }
    LoadData_1();
    LoadData_2();
    SetData(indexRecordSelected);
    var ctrlIdToFocus = '';
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') { $('#' + oCtrl.id + 'Msg').html(''); }
        if (oCtrl.isEdit == 0) {
            $('#' + oCtrl.id).attr('disabled', 'disabled');
        } else {
            $('#' + oCtrl.id).removeAttr("disabled");
        }
        if ($("#selTipoCedula")) {
            if (
                (
                oCtrl.id == 'txtCedula' || oCtrl.id == 'txtDireccion' || oCtrl.id == 'txtTelefono' || oCtrl.id == 'txtCelular' ||
                oCtrl.id == 'selEstatus' || oCtrl.id == 'txtEmail' || oCtrl.id == 'txtApellido1' || oCtrl.id == 'txtApellido2' ||
                oCtrl.id == 'txtCuentaBancaria'
                ) && $("#selTipoCedula").val() == 'M') {
                $('#' + oCtrl.id).attr('disabled', 'disabled');
            }
        }
        if (oCtrl.isFocusToEdit == 1) { ctrlIdToFocus = oCtrl.id; }
    }
    $('#' + ctrlIdToFocus).focus();
}

function PrepareFieldsToSaveRecord() {
    var tipoCedula = '';
    var tipoRif = '';
    if ($("#selTipoCedula")) { $("#selTipoCedula").jqxDropDownList({ disabled: true, source: aTipoCedulaRif }); }
    if ($("#selCategoria")) { $("#selCategoria").jqxDropDownList({ disabled: true }); }
    var index = GetIndexSourceFroIdRecord(idRecordSelected);
    for (i = 0; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.id == 'txtCedula') {
            tipoCedula = aSource[index].split('|')[i].split('-')[0];
            $('#selTipoCedula').val(tipoCedula);
            if (tipoCedula == 'M') {
                $('#txtCedula').val(aSource[index].split('|')[i].split('-')[1] + '-' + aSource[index].split('|')[i].split('-')[2]);
            } else {
                $('#txtCedula').val(aSource[index].split('|')[i].split('-')[1]);
            }
        } else {
            $('#' + oCtrl.id).val(aSource[index].split('|')[i]);
        }
        $('#' + oCtrl.id).attr('disabled', 'disabled');
    }
    intervalVarLoadRedraw = setInterval(function() { Redraw(tipoCedula, tipoRif) }, intervalRedraw);
}

function PrepareFieldsToSearchRecord() {
    if ($("#selTipoCedula")) { $("#selTipoCedula").jqxDropDownList({ disabled: true, source: aTipoCedulaRif }); }
    if ($("#selCategoria")) { $("#selCategoria").jqxDropDownList({ disabled: true }); }
    var ctrlIdToFocus = '';
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.isSearch == 1) {
            $('#' + oCtrl.id).removeAttr("disabled");
        } else {
            $('#' + oCtrl.id).attr('disabled', 'disabled');
        }
        if (oCtrl.isFocusToSearch == 1) { ctrlIdToFocus = oCtrl.id; }
    }
    $('#' + ctrlIdToFocus).focus();
}

function PrepareFieldsToRollbackEditRecord() {
    var tipoCedula = '';
    var tipoRif = '';
    if ($("#selTipoCedula")) { $("#selTipoCedula").jqxDropDownList({ disabled: true, source: aTipoCedulaRif }); }
    if ($("#selCategoria")) { $("#selCategoria").jqxDropDownList({ disabled: true }); }
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') { $('#' + oCtrl.id + 'Msg').html(''); }
        if (oCtrl.id == 'txtCedula') {
            tipoCedula = aSource[indexRecordSelected].split('|')[i].split('-')[0];
            $('#selTipoCedula').val(tipoCedula);
            if (tipoCedula == 'M') {
                $('#txtCedula').val(aSource[indexRecordSelected].split('|')[i].split('-')[1] + '-' + aSource[indexRecordSelected].split('|')[i].split('-')[2]);
            } else {
                $('#txtCedula').val(aSource[indexRecordSelected].split('|')[i].split('-')[1]);
            }
        } else {
            $('#' + oCtrl.id).val(aSource[indexRecordSelected].split('|')[i]);
        }
        $('#' + oCtrl.id).attr('disabled', 'disabled');
    }
    intervalVarLoadRedraw = setInterval(function() { Redraw(tipoCedula, tipoRif) }, intervalRedraw);
}

function SetData(index) {
    LoadData_2();
    var tipoCedula = '';
    var tipoRif = '';
    if (index < 0) { return; }
    idRecordSelected = aSource[index].split('|')[0];
    for (i = 0; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') { $('#' + oCtrl.id + 'Msg').html(''); }
        if (oCtrl.id == 'txtCedula') {
            tipoCedula = aSource[index].split('|')[i].split('-')[0];
            $('#selTipoCedula').val(tipoCedula);
            if (tipoCedula == 'M') {
                $('#txtCedula').val(aSource[index].split('|')[i].split('-')[1] + '-' + aSource[index].split('|')[i].split('-')[2]);
            } else {
                $('#txtCedula').val(aSource[index].split('|')[i].split('-')[1]);
            }
        } else {
            $('#' + oCtrl.id).val(aSource[index].split('|')[i]);
        }
    }
    intervalVarLoadRedraw = setInterval(function() { Redraw(tipoCedula, tipoRif) }, intervalRedraw);
}

function CheckFieldsToAlert() {
    if (!blok) { MsgError('corregir'); return false; }

    var blokField = false;
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        $('#' + oCtrl.id).removeClass("errorFields");
        if ($('#' + oCtrl.id).val() == '' && oCtrl.msgAlert != '') {
            $('#' + oCtrl.id).addClass('errorFields');
            blokField = true;
        }
    }
    if (blokField) {
        MsgError('Algunos campos vacios son obligatorios');
        return false;
    }
    return true;
}

function CleanFieldsToAlert() {
    for (i = 1; i < aCtrl.length; i++) {
        var oCtrl = aCtrl[i];
        if (oCtrl.msgAlert != '') {
            $(".label_error").remove();
        }
    }
    return true;
}

function GetWidth(id) {
    var width = 0;

    if (id.indexOf('txtDescr2') == 0) {
        width = 500;
    } else if (id.indexOf('txtEstatus') == 0 || id.indexOf('txtFN') == 0 || id.indexOf('txtFF') == 0 || id.indexOf('txtFP') == 0 || id.indexOf('txtFV') == 0 || id.indexOf('txtFR') == 0 || id.indexOf('sel') == 0 || id.indexOf('txtFI') == 0 || id.indexOf('txtFE') == 0 || id.indexOf('txtFC') == 0 || id.indexOf('txtFUA') == 0 || id.indexOf('txtIdioma') == 0 || id.indexOf('txtCodKey') == 0) {
        width = 150;
    } else if (id.indexOf('txtCod') == 0 || id.indexOf('txtRIF') == 0 || id.indexOf('txtNControl') == 0 || id.indexOf('txtNFactura') == 0 || id.indexOf('txtUsua') == 0 || id.indexOf('txtClave') == 0 || id.indexOf('txtZone') == 0 || id.indexOf('txtCitta') == 0 || id.indexOf('txtZone') == 0 || id.indexOf('txtCoord') == 0 || id.indexOf('txtCap') == 0) {
        width = 150;
    } else if (id.indexOf('txtMonto') == 0 || id.indexOf('txtSubTo') == 0 || id.indexOf('txtTotal') == 0 || id.indexOf('txtSaldo') == 0 || id.indexOf('txtCosto') == 0 || id.indexOf('txtEspeci') == 0 || id.indexOf('txtPassw') == 0 || id.indexOf('txtUsername') == 0 || id.indexOf('txtPIVA') == 0) {
        width = 150;
    } else if (id.indexOf('txtNomb') == 0 || id.indexOf('txtApe') == 0 || id.indexOf('txtNot') == 0 || id.indexOf('txtCed') == 0 || id.indexOf('txtRif') == 0 || id.indexOf('txtNivel') == 0) {
        width = 250;
    } else if (id.indexOf('txtMin') == 0 || id.indexOf('txtMax') == 0 || id.indexOf('txtDescuento') == 0 || id.indexOf('txtRetencion') == 0 || id.indexOf('txtRispo') == 0) {
        width = 150;
    } else if (id.indexOf('txtWWW') == 0 || id.indexOf('txtEmail') == 0 || id.indexOf('txtZona') == 0 || id.indexOf('txtCiudad') == 0 || id.indexOf('txtRegion') == 0 || id.indexOf('txtClave') == 0 || id.indexOf('txtValor') == 0 || id.indexOf('txtFecha') == 0 || id.indexOf('txtDichi') == 0 || id.indexOf('txtEduca') == 0 || id.indexOf('txtAfilia') == 0 || id.indexOf('txtCertifi') == 0 || id.indexOf('txtAsocia') == 0 || id.indexOf('txtPremi') == 0 || id.indexOf('txtSeguro') == 0 || id.indexOf('txtEstado') == 0) {
        width = 200;
    } else if (id.indexOf('txtNomi') == 0 || id.indexOf('txtDescr') == 0 || id.indexOf('txtMsg') == 0 || id.indexOf('txtDirec') == 0) {
        width = 400;
    } else if (id.indexOf('txtTel') == 0 || id.indexOf('txtCelu') == 0 || id.indexOf('txtFAX') == 0 || id.indexOf('txtTabla') == 0 || id.indexOf('txtAccion') == 0 || id.indexOf('txtCargo') == 0 || id.indexOf('txtTlf') == 0) {
        width = 150;
    } else if (id.indexOf('txtUM') == 0 || id.indexOf('txtExis') == 0 || id.indexOf('txtProv') == 0 || id.indexOf('txtArrivo') == 0 || id.indexOf('txtLengua') == 0) {
        width = 100;
    } else if (id.indexOf('txtNum') == 0 || id.indexOf('txtRan') == 0 || id.indexOf('txtLimite') == 0 || id.indexOf('txtCant') == 0) {
        width = 50;
    }
    
    return width;
}