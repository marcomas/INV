//Plugin custom message 1.0
//Autor: Hervis Pichardo
//29-01-2016

(function( $ ){
    $.fn.message= function(opciones) {  

      //opciones por defecto
      var config = {
         color: "#000", //Color de fondo del mensaje
         delay: 4000, //Duracion del mensaje antes de desaparecer
         position: "top" // Posicion del mensaje (top / bottom)

         
      }

      //extiendo las opciones por defecto con las opciones del parámetro.
      jQuery.extend(config, opciones);
      elem = $(this);
      this.each(function(){

      //creo una variable elem con el elemento actual
      elem = $(this);
      
        //agrego estilo y iconos al head
         if(!$('head').find("#icons_message").length){
                $('head').append("<link rel='stylesheet' id='icons_message' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>");
                $('head').append('<style type="text/css">.hp_message{opacity: 0.9; font-weight: bold;font-size: 16px; font-family: Arial, sans serif; padding: 15px 20px; border-radius: 5px; color: #fff; position: absolute;} .hp_message span {top: -4px; position: relative;}</style>');
         }

        elem.append('<div class="hp_message" style="z-index: 99999; background:'+config.color+'; right: 50px;"><span>'+config.message+'</span></div>');
        
        //agrego icono al mensaje

        if(!config.icon){
            $(".hp_message").prepend('<i style="font-size: 26px; margin-right: 10px;" class="fa fa-check-square"></i>');
        }else {
            $(".hp_message").prepend('<i style="font-size: 26px; margin-right: 10px;" class="fa '+config.icon+'"></i>');

        }

        $(".hp_message").hide();

        //posicion del mensaje
        if(config.position == "top"){
            $(".hp_message").css("top","50px");
        }else if (config.position == "bottom"){
            $(".hp_message").css("bottom","50px");
        }
        

        //desaparezco el mensaje al tiempo preestablecido
        $(".hp_message").fadeIn("slow",function(){
            setTimeout(function(){
              $(".hp_message").fadeOut("slow",function(){
                 $(".hp_message").remove(); 
              });
            }, config.delay);
        });

        
      }); //fin this.each

   //siempre devolver this
   return this;
  };
})( jQuery );

