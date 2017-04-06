(function($){
    $.widget("custom.menuFlotante", {
        widgetEventPrefix:"hp", 
        options:{
            width: "200px",
            fontsize: "14px",
            icons: false,
        },
        _create: function(){
        	var _menu = this;
        	_menu.cont= this.element;

//		    if(varcodigo){
                if(_menu.options.icons){
                    $('head').append("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>");
                }
                        	
                _menu.cont.css("overflow","visible");
                _menu.parent = this.cont.parent();
                $("body").not("ul").click(function(){
                   $(".menu_flotante").fadeOut("fast",function(){
                      $(this).remove();
                   });
                });
                
                _menu.parent.on("mousedown",_menu.cont,function(e){

        		     if(e.which == 3) {
        		 	    $(document).bind("contextmenu",function(e){
                            return false;
                        });

                        //eliminio anteriores y creo menu flotante
        		 	    $(".menu_flotante").remove();
        		 	    if (_menu.options.id1 != idMenuFlotante && _menu.options.id2 != idMenuFlotante) { return false; }
                        var btnes;
        		 	    if (_menu.options.id1 == idMenuFlotante) { 
                            btnes = _menu.options.botones1;
                        } else if (_menu.options.id2 == idMenuFlotante) { 
                            btnes = _menu.options.botones2;
                        }
                        idMenuFlotante = '';
                        _menu.cont.prepend("<div class='menu_flotante'></div>");
                        var btns ="";
                        for (i = 0; i < btnes.length; i++){

                            if(_menu.options.icons){
                                btns += "<div class='m_btn' rel='"+i+"' style='color: "+btnes[i].color+"; font-size:"+_menu.options.fontsize+"'><i class='fa "+btnes[i].icon+"'></i> "+btnes[i].name+"</div>";
                            }else if (!_menu.options.icons){
                    	       btns += "<div class='m_btn' rel='"+i+"'>"+btnes[i].name+"</div>";
                            }
                        
                	    }
                	    _menu.cont.find(".menu_flotante").append(btns).hide().fadeIn();
                        _menu.cont.find(".menu_flotante").css("width",_menu.options.width);
                        _menu.cont.find(".menu_flotante").css("z-index","10000");
					    _menu.cont.find(".menu_flotante").on("click",".m_btn",function(e){
						    var id = $(this).attr("rel");
                            $(this).parent().fadeOut("fast",function(){
                                $(this).remove();
                            });
						    btnes[id].funcion();

					    });


                        var posX = e.pageX;
                        var posY = e.pageY;
                        _menu.cont.find(".menu_flotante").css("left",posX);
                        _menu.cont.find(".menu_flotante").css("top",posY);

        		     }
        	    });
//		    } //fin varcodigo          
            
        },       
      
    });
    
    
    
} (jQuery));


