<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UploadSingleFile.aspx.vb" Inherits="INV.UploadSingleFile" %>

<!DOCTYPE html>

<head runat="server">
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>INV</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">
    
    <script type="text/javascript" src="../Scripts/jqwidgets/scripts/jquery-1.8.3.min.js"></script> 
    <script src="../js/jquery.MultiFile.js"></script>      
    
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
            text-align: right;  
        }  
      
        .Multifile-vk-panel {  
            width: 400px;  
            height: 65px;  
        }  
    </style> 
    
    <script>

        $(document).ready(function() {

            var filename = $('#txtFiles').val();
            var pathFile = '../imgINV/' + '<%=Folder %>' + '/' + '<%=IdRecord %>' + '/' + filename;
            
            if ('<%=SubFolder %>' != '') {
                pathFile = '../imgINV/' + '<%=Folder %>' + '/' + '<%=SubFolder %>' + '/' + filename;
            }
            $('#viewImg').attr('src', pathFile);

        });
    
    </script>
     
</head>

<body>
    <div id="divContFiles" runat="server" style="float:right;">
        <div id="div1" style="float:right; position:relative;">
            <input type="text" id="txtFiles" style="top:-7px; position:relative;" runat="server" disabled="disabled"/>
        </div>
    </div>
    <form id="Form1" runat="server">          
        <div class="Multifile-vk-panel">  
            <div>
                <asp:FileUpload ID="FileUploadVKSample" runat="server" class="multi" accept="gif|jpg|png" maxlength="7" /> 
            </div>  
            <div class="Multifile-UploadAll-div-Button">
                <asp:Button ID="btnUpload" runat="server" Text="Carica file" CssClass="Multifile-UploadAllButton" OnClick="btnUpload_Click" /> 
                <asp:Button ID="btnDelete" runat="server" Text="Elimina file" CssClass="Multifile-UploadAllButton" OnClick="btnDelete_Click" /> 
            </div>
            <img id="viewImg" width="100px" height="100px" />
        </div>
    </form>
</body>

</html>
