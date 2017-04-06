(function($){
    $.widget("custom.menuFlotante", {
        widgetEventPrefix:"hp", 
        options:{
            clase: "",
            claseMenu: "",
            icons: false,
        },
        _create: function(){
        	var _menu = this;
        	_menu.cont= this.element;

            if(_menu.options.icons){
                $('head').append("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>");
            }

        	_menu.cont.addClass(_menu.options.clase);
            _menu.parent = this.cont.parent();
            _menu.cont.css("cursor","pointer");
           _menu.cont.on("mousedown",_menu.cont,function(e){
        		 if(e.which == 3) {
        		 	$(document).bind("contextmenu",function(e){
                        return false;
                    });

                    //eliminio anteriores y creo menu flotante
        		 	$(".menu_flotante").remove();
                    _menu.cont.prepend("<div class='menu_flotante'></div>");
                    var btnes = _menu.options.botones;
                    var btns ="";
                    for (i = 0; i < btnes.length; i++){

                        if(_menu.options.icons){
                            btns += "<div class='m_btn' rel='"+i+"' style='color: "+btnes[i].color+"'><i class='fa "+btnes[i].icon+"'></i> "+btnes[i].name+"</div>";
                        }else if (!_menu.options.icons){
                    	   btns += "<div class='m_btn' rel='"+i+"'>"+btnes[i].name+"</div>";
                        }
                    
                	}
                	_menu.cont.find(".menu_flotante").append(btns).hide().fadeIn();
                	_menu.cont.find(".menu_flotante").addClass(_menu.options.claseMenu);

					_menu.cont.find(".menu_flotante").on("click",".m_btn",function(e){
						var id = $(this).attr("rel");
                        $(this).parent().fadeOut("fast",function(){
                            $(this).remove();
                        });
						_menu.options.botones[id].funcion();

					});


                    var posX = e.pageX;
                    var posY = e.pageY;
                    _menu.cont.find(".menu_flotante").css("left",posX);
                    _menu.cont.find(".menu_flotante").css("top",posY);

        		 }
        	});

           
            
        },
       
      
    });
    
    
    
} (jQuery));


