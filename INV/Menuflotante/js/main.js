
jQuery(document).ready(function($){
 

function asd () {
	alert("Ejecuta funcion externa");

}

//http://fortawesome.github.io/Font-Awesome/icons/

var btns1 = [
	{
		"name": "Agregar item",
		"icon": "fa-plus",
		"funcion": function(){
			$(".btn2").find("li:last-child").after("<li>Item nuevo</li>");
		}	
   	},

   	{
		"name": "Editar 2",
		"icon": "fa-pencil",
		"color": "#83a400",
		"funcion": function(){
			asd();
		}	
   	},

   	{
		"name": "Eliminar",
		"icon": "fa-camera-retro",
		"color": "#8b2123",
		"funcion": function(){
			alert("Alert interno");
		}	
   	},

   
	
];

 $("#asdf").menuFlotante({
 	botones: btns1,
 	clase: "btn1",
 	claseMenu: "menu1",
 	icons: true,
 });
    


    
});

