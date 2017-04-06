function objExtras(_tabla, _txtSearch, _fun, _load, _width) {
    this.tabla = _tabla;
    this.aSearch = new Array();
    this.txtSearch = _txtSearch;
    this.intervalVarLoadDataExtras;
    if (_fun == null) { _fun = 'getListCodigo'; } this.fun = _fun;
    if (_width == null) { _width = 400; } this.width = _width;
    this.load = false;
    return this;
}

function GetRecordExtras(o, dataRef, t) {
    if (dataRef == null) {
        dataRef = '';
    } else {
        dataRef = dataRef + '|';
    }

    if (t == null) { t = 1000; }

    o.load = false;
    $.ajax({
        type: "POST",
        url: "../WS/WSTablas.aspx",
        data: { tabla: o.tabla, fun: o.fun, data: dataRef, id: 0 },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] == "OK") {
            var source = data.split('§')[1];
            LoadDataFromSourceExtras(source, o);
            o.intervalVarLoadDataExtras = setInterval(function() { LoadDataExtras(o) }, t);
        } else {
            CleanDataExtras(o);
            o.load = true;
        }
    }).fail(function() { alert("error"); });
}

function LoadDataFromSourceExtras(source, o) {
    o.aSearch = [];
    o.txtSearch.jqxInput({ placeHolder: "", height: 5, width: o.width, minLength: 1, source: o.aSearch });

    var a = source.split('$');
    for (i = 0; i < a.length; i++) {
        o.aSearch.push(a[i]);
    }
}

function LoadDataExtras(o) {
    clearInterval(o.intervalVarLoadDataExtras);
    o.txtSearch.jqxInput({ placeHolder: "", height: 5, width: o.width, minLength: 1, source: o.aSearch });
    o.load = true;
}

function CleanDataExtras(o) {
    o.aSearch = [];
    o.txtSearch.jqxInput({ placeHolder: "", height: 5, width: o.width, minLength: 1, source: o.aSearch });
}
