<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrintBarCode.aspx.vb" Inherits="INV.PrintBarCode" %>

<!DOCTYPE html>

    <head>
        <meta charset="ISO-8859-1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/style.css?0.0.0.1">
        <script src="js/vendor/modernizr-2.6.2.min.js"></script>
        <script src="js/vendor/jquery-1.9.0.min.js"></script>
        
        <style type="text/css" media="print"> 
           @media print{@page {size: landscape;}}
        </style>
        
        <style type="text/css">
            #defaultfont {
              font-family: "Times New Roman",Times,serif;
                font-size:14px;
            }

            #dtlEtiketten_ctl00_lblBarcode22 {
                font-family: "Free 3 of 9";
                font-size:32px;
            }
        </style>
        
        <script type="text/javascript">
            $(document).ready(function() {
                print();
            });
        </script>
    </head>
    <body>
        <div style="position:relative; top:-15px;">
            <span id="dtlEtiketten_ctl00_lblBarcode22">*<%=Codigo %>*</span>
            <div style="position:relative; top:-10px; left:40px;"><span id="defaultfont"><%=Codigo %></span></div>
        </div>
    </body>

</html>
