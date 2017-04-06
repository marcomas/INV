
function sendMail(to, cc, subject, body) {
    var info = to + '|' + cc + '|' + subject + '|' + body;
    $.ajax({
        type: "POST",
        url: "WS/WSToolsServer.aspx",
        data: { fun: 'sendMail', data: info },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] == "KO") {
            alert(data.split('§')[1]);
        } else {
            createPopup(msgMailInviata, "out");
        }
    }).fail(function() {
        alert('entro al ajax por fail'); 
        alert("error");
    });
}

function sendMailPasswordAccesoCMS(to, cc, subject, body) {
    var info = to + '|' + cc + '|' + subject + '|' + body;
    $.ajax({
        type: "POST",
        url: "WS/WSToolsServer.aspx",
        data: { fun: 'sendMail', data: info },
        async: false
    }).done(function(data) {
        if (data.split('§')[0] == "KO") {
            alert(data.split('§')[1]);
            $('#errorMessage').text('No se pudo enviar el email, contacte al administrador del sistema');
        } else {
            $('#errorMessage').text('Se ha enviado una nueva contraseña, dirijase a su Email');
            $('#olvidoPass').text('Olvide mi contraseña');
        }
    }).fail(function() {
        alert("error");
    });
}
