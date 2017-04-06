<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UploadFoto.aspx.vb" Inherits="INV.UploadFoto" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>INV</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">
    
    <script type="text/javascript" src="../Scripts/jqwidgets/scripts/jquery-1.8.3.min.js"></script> 
    
    <style type="text/css">  
        .MultiFile-label a {  
            width: 50px;  
            height: 30px;  
            background-color: #fb4141;  
            color: #FFF;  
            border: 0;  
            padding: 3px 7px;  
            text-decoration: none;  
        }  
  
        .MultiFile-label a:hover {  
            width: 50px;  
            height: 30px;  
            background-color: red;  
            color: #e5e5e5;  
            border: 0;  
            padding: 3px 7px;  
            text-decoration: none;  
        }  
  
        .MultiFile-list {  
            height: 65px;  
            width: 400px;  
            padding: 10px 16px;  
            border: dashed silver 1px;  
            background-color: #f9f4f4;  
        }  
      
        .MultiFile-label {  
            padding-top: 5px;  
            padding-bottom: 5px;  
            margin-top: 10px;  
        }  
      
        .Multifile-UploadAllButton {  
            width: 75px;  
            height: 30px;  
            background-color: #6262e9;  
            color: #FFF;  
            border: 0;  
            text-decoration: none;  
            text-align: center;  
        }  
      
            .Multifile-UploadAllButton:hover {  
                width: 75px;  
                height: 30px;  
                background-color: #2f2fe7;  
                color: #e5e5e5;  
                border: 0;  
                text-decoration: none;  
                text-align: center;  
                cursor: pointer;  
            }  
      
        .Multifile-UploadAll-div-Button { 
            margin-top:5px; 
            text-align: right;  
        }  
      
        .Multifile-vk-panel {  
            width: 100%;  
            height: 65px;  
        }  
    </style> 
    
    <script>

        //-- CONSTANTES --//
        var urlFoto = '<%=HttpRuntime.Cache("urlFoto")%>' + 'foto.jpg';

        //-- VARIABLES --//
        var intervalVarLoadFoto;
        var intervalVarCloseFoto;

        $(document).ready(function() {
        
            PrepareLoadFoto();

            $('#btDescartarFoto').click(function() {
                PrepareLoadFoto();
            });

        });

        function LoadFoto() {
            clearInterval(intervalVarLoadFoto);

            $.ajax({
                type: "POST",
                url: "../WS/WSToolsServer.aspx",
                data: { fun: 'verificaExistenciaFile', data: urlFoto },
                async: false
            }).done(function(data) {
                if (data.split('§')[0] == "OK") {
				rand = Math.floor((Math.random()*1000000)+1);
				var urlFotoNoCache = urlFoto + '?cache=' + rand;
                    $('#viewImg').attr('src', urlFotoNoCache);
                } else {
                    intervalVarLoadFoto = setInterval(function() { LoadFoto() }, 1000);
                }
            });
        }

        function PrepareLoadFoto() {
            $('#viewImg').attr('src', '');

            $.ajax({
                type: "POST",
                url: "../WS/WSToolsServer.aspx",
                data: { fun: 'deleteFile', data: urlFoto },
                async: false
            }).done(function(data) {
                intervalVarLoadFoto = setInterval(function() { LoadFoto() }, 1000);
            });
        }

        function CerrarForm() {
            var padre = $(window.parent.document);
            $(padre).find(".overlay").animate({ left: "0px" }, 1000);
            $(padre).find(".overlay").fadeOut();
            $(padre).find("#divUploadFoto").fadeOut(1000);
            clearInterval(intervalVarLoadFoto);
        }
    </script>
     
</head>

<body>
    <form id="Form1" runat="server">          
        <div class="Multifile-vk-panel"> 
            <img src="" id="viewImg" width="200" height="200" />
            <div class="Multifile-UploadAll-div-Button">
                <asp:Button ID="btnUpload" runat="server" Text="Guardar" CssClass="Multifile-UploadAllButton" OnClick="btnUpload_Click" /> 
                <input type="button" id="btDescartarFoto" value="Descartar" Class="Multifile-UploadAllButton"/>
            </div>
            
        </div>
    </form>
</body>

</html>
