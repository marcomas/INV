var idMenuFlotante = '';
//var varcodigo = true;

jQuery(document).ready(function($) {

    $("#jqxgrid").mousedown(function(ev) {
        if (ev.which == 3) {
            idMenuFlotante = "jqxgrid";
        }
    });

    //http://fortawesome.github.io/Font-Awesome/icons/

    var btns1 = [
	    {
	        "name": "editar",
	        "icon": "",
	        "color": "#13C100",
	        "funcion": function() {
	            $('.overlay').fadeIn();
	            $('#divEditItemGrid').fadeIn();
	            $("#txtNombreEdit").val(nombreDepto);
	            $("#txtNombreEdit").focus();
	        }
	    },
	    {
	        "name": "eliminar",
	        "icon": "",
	        "color": "#FFD900",
	        "funcion": function() {
	            MsgDelete();
	        }
	    },
    ];

    $("#idBody").menuFlotante({
        id1: "jqxgrid",
        botones1: btns1,
        width: "220px",
        fontsize: "14px",
        icons: true
    });

});

