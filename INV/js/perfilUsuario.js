

$("#cerrarPerfilUser").click(function() {
    $("#divPerfilUser").hide();
});

$("#guardarDatospersonales").click(function() {
    var info = $('#telOficina').val() + '|' + $('#telInterno').val() + '|' + $('#telCelular').val() + '|' + $('#telCorreo').val() + '|';

    $.ajax({
        type: "POST",
        url: "../WS/WSSession.aspx",
        data: { fun: 'updatePerfilUsuario', data: info, id: 0 },
        async: false
    }).done(function(data) { });
    msjPerfil("Datos modificados con exito");
    return false;
});

$("#btnGuardarContrasena").click(function() {
    if ($('#contrasenaNueva').val() != $('#contrasenaNuevaConf').val()) {
        msjPerfil("Confirmación erronea,Vuelva a intentar");
        return false;
    } else {
        if ($('#contrasenaNueva').val() == '') {
            msjPerfil("Debe asignar una nueva contraseña");
            return false;
        } else {
            var info = $('#contrasenaActual').val() + '|' + $('#contrasenaNueva').val() + '|';
            $.ajax({
                type: "POST",
                url: "../WS/WSSession.aspx",
                data: { fun: 'changePswUsuario', data: info, id: 0 },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] != "OK") {
                    msjPerfil("Contraseña actual incorrecta");
                } else {
                    msjPerfil("Contraseña modificada con exito");
                    $('#contrasenaNueva').val('');
                    $('#contrasenaNuevaConf').val('');
                    $('#contrasenaActual').val('');
                }
            });
            return false;
        }
    }
});

function PoblarFormPerfil() {
    var infoLogin = $('#txtUsuario').val() + '|' + $('#txtPsw').val() + '|';

    $.ajax({
        type: "POST",
        url: "WS/WSSession.aspx",
        data: { name: 'usuario', fun: 'getUsuario', data: infoLogin },
        async: true
    }).done(function(data) {
        var nUsuario = data.split('§')[1].split('|')[1];
        var tUsuario = data.split('§')[1].split('|')[6];
        var tlUsuario = data.split('§')[1].split('|')[9];
        var tiUsuario = data.split('§')[1].split('|')[10];
        var tcUsuario = data.split('§')[1].split('|')[11];
        var eUsuario = data.split('§')[1].split('|')[12];
        $('#nUsuario').html(nUsuario + '<span> (' + tUsuario + ')</span>');
        $('#nUsuarioPerfil').html(nUsuario);
        $('#tUsuarioPerfil').html(tUsuario);
        $("#telOficina").val(tlUsuario);
        $("#telInterno").val(tiUsuario);
        $("#telCelular").val(tcUsuario);
        $("#telCorreo").val(eUsuario);
    });
}

$("#img_user").click(function() {
    PoblarFormPerfil();
    $(".user_box").fadeIn();
    return false;
});

$('#cambiarContrasena').click(function(e) {
    e.preventDefault();
    $('.eventPassword').toggleClass('passwordChange');
    $('#contrasenaActual').focus();
    var tex = $(this).text();
    if (tex === 'Cancelar') {
        $(this).text('Cambiar contraseña');
        $('#forgetPassword').hide();
    } else {
        $(this).text('Cancelar');
        $('#forgetPassword').show();
    }
    return false;
});

$('.eventDatospersonales input').focusin(function() {
    $('#guardarDatospersonales').show();
    return false;
});

$('.modal-trigger').leanModal({
    dismissible: true,
    opacity: .5,
    in_duration: 300,
    out_duration: 200,
    starting_top: '10%',
    ending_top: '1%',
    ready: function() { console.log('Calendario abierto'); },
    complete: function() {
        console.log('calendario cerrado');
    }
}
		);
$('#btnTop,#topMsj').hover(function() {
    $('#topMsj').css('right', '0');
}, function() {
    $('#topMsj').css('right', '-600px');
});
$('#btnBottom,#bottomMsj').hover(function() {
    $('#bottomMsj').css('right', '0');
}, function() {
    $('#bottomMsj').css('right', '-600px');
});
setInterval(intFunc, 2000);
function intFunc() {
    $('#btnTop,#btnBottom').css('background', '#30E5E5');
    $('#btnTop,#btnBottom').css('color', '#fff');
    setTimeout(function() {
        $('#btnTop,#btnBottom').css('background', '#fff');
        $('#btnTop,#btnBottom').css('color', '#000');
    }, 1000)
}
function msjPerfil(text) {
    var conten = $("#msjPerfil");
    $(conten).text(text);
    setTimeout(function() {
        $(conten).text("");
    }, 4000);
}