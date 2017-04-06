Imports System.Threading
Imports System.Globalization
Imports Missing = System.Reflection.Missing
Imports System.IO
Imports System.Net
Imports Common
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Web.Script.Serialization
Imports System.Reflection
Imports iTextSharp.text
Imports iTextSharp.text.pdf

Namespace Utilities

    Public Class Fun

        Private Shared _Session As HttpSessionState
        Shared Property Session() As HttpSessionState
            Get
                Return _Session
            End Get
            Set(ByVal value As HttpSessionState)
                _Session = value
            End Set
        End Property

        Private Shared w As StreamWriter = Nothing

#Region "Barcode"

        Public Shared Function GeneraBarcode(ByVal codice As String) As Bitmap
            Dim w As Integer = codice.Length * 40
            Dim img As Bitmap = New Bitmap(w, 100)
            Dim g As Graphics = Graphics.FromImage(img)
            Dim f As System.Drawing.Font = New System.Drawing.Font(Common.QuickAccess.GetAppSetting("FontBarcode"), 18)
            Dim oPoint As PointF = New PointF(2.0F, 2.0F)
            Dim oBrushWrite As SolidBrush = New SolidBrush(System.Drawing.Color.Black)
            Dim oBrush As SolidBrush = New SolidBrush(System.Drawing.Color.White)
            g.FillRectangle(oBrush, 0, 0, w, 100)
            g.DrawString("*" + codice + "*", f, oBrushWrite, oPoint)
            'response.ContentType = "image/jpeg"
            'img.Save(response.OutputStream, ImageFormat.Jpeg)
            GeneraBarcode = img
        End Function

#End Region

#Region "Print"

        Public Shared Sub SetDefaultPrint(ByVal printName As String)
            Dim oImpresora As Object
            oImpresora = CreateObject("WScript.Network")
            oImpresora.setdefaultprinter(printName)
        End Sub

#End Region

#Region "EXPORT DATA"
        Shared Font10 As Integer = 10

        Private Shared Sub BorrarArchivo(ByVal ruta As String)
            If File.Exists(ruta) Then
                File.Delete(ruta)
            End If
        End Sub

#Region "XLS VIEJO"
        Public Shared Function ExportToExcell( _
            ByVal ColumnsCaption As String, _
            ByVal Columns As String, _
            ByVal Data As String, _
            ByVal UserID As Integer) As String

            Dim col As List(Of String) = GetListColumns(Columns)
            Dim colCaption As List(Of String) = GetListColumns(ColumnsCaption)

            Dim reg As List(Of Object) = JsonDeserialize(Data)
            Dim file As String = "reporte.xls" 'UserID.ToString() & ".xls"
            Dim ruta As String = QuickAccess.GetAppSetting("FolderXLS") & file
            'Dim rutaHtml As String = QuickAccess.GetAppSetting("FolderXLS") & UserID.ToString() & ".html"
            Dim virtualfile As String = QuickAccess.GetAppSetting("VirtualFolderXLS") & file
            Dim result As String = ""

            BorrarArchivo(ruta)
            'GenerarArchivo(col, reg, ruta, result) => no funciona online, es necesario instalar EXCEL?
            'GetExcel(col, reg, rutaHtml)
            result = GetExcel(col, reg, ruta, colCaption)

            If String.IsNullOrEmpty(result) Then
                ExportToExcell = String.Format("OK§{0}", virtualfile)
            Else
                ExportToExcell = String.Format("KO§{0}", result)
            End If
        End Function
#End Region

#Region "XLS"

        Public Shared Function ExportToExcellXLS( _
            ByVal ColumnsCaption As String, _
            ByVal Columns As String, _
            ByVal Data As String, _
            ByVal UserID As Integer) As String

            Dim col As List(Of String) = GetListColumns(Columns)
            Dim colCaption As List(Of String) = GetListColumns(ColumnsCaption)

            Dim reg As List(Of Object) = JsonDeserialize(Data)
            Dim file As String = String.Format("Reports_{0}.xls", UserID.ToString())
            Dim ruta As String = QuickAccess.GetAppSetting("FolderXLS") & file
            Dim virtualfile As String = QuickAccess.GetAppSetting("VirtualFolderXLS") & file
            Dim result As String = ""

            BorrarArchivo(ruta)
            result = GetExcel(col, reg, ruta, colCaption)

            If String.IsNullOrEmpty(result) Then
                ExportToExcellXLS = String.Format("OK§{0}", virtualfile)
            Else
                ExportToExcellXLS = String.Format("KO§{0}", result)
            End If
        End Function

        Public Shared Function JsonSerialize(ByVal jsonString As String) As String
            Dim objJSSerializer As New JavaScriptSerializer
            Dim lista As String
            lista = objJSSerializer.Serialize(jsonString)
            Return lista
        End Function

        Public Shared Function JsonDeserialize(ByVal jsonString As String) As List(Of Object)
            Dim lista As New List(Of Object)
            Dim objJSSerializer As New JavaScriptSerializer
            Try
                lista = objJSSerializer.Deserialize(Of List(Of Object))(jsonString)
            Catch ex As Exception

            End Try
            Return lista
        End Function

        Private Shared Function GetExcel( _
            ByVal col As List(Of String), _
            ByVal reg As List(Of Object), _
            ByVal ruta As String, _
            ByVal colCaption As List(Of String)) As String

            Dim result As String = ""

            Try
                Dim fs As FileStream = New FileStream(ruta, FileMode.Create, FileAccess.ReadWrite)
                w = New StreamWriter(fs)

                EscribeCabecera(colCaption)
                EscribeLineas(col, reg)
                EscribePiePagina()
            Catch ex As Exception
                result = ex.Message
            Finally
                If Not w Is Nothing Then w.Close()
                FileClose(1)
                GC.Collect()
                GetExcel = result
            End Try

        End Function

        Private Shared Sub EscribeCabecera( _
            ByVal colCaption As List(Of String))

            Dim html As StringBuilder = New StringBuilder()
            html.Append("<!DOCTYPE html>")
            html.Append("<body>")
            html.Append("<table>")
            html.Append("<thead>")
            html.Append("<tr style='background: yellow; font-weight:bold;'>")
            For i = 1 To colCaption.Count
                html.Append(String.Format("<td>{0}</td>", colCaption(i - 1)))
            Next
            html.Append("</tr>")
            html.Append("</thead>")

            w.Write(html.ToString())
        End Sub

        Private Shared Sub EscribeLineas( _
            ByVal col As List(Of String), _
            ByVal reg As List(Of Object))

            Dim color As String = "white"
            Dim fila As Integer = 2
            w.Write("<tbody>")
            For Each r In reg
                If color = "white" Then color = "#e2e2e2" Else color = "white"
                w.Write(String.Format("<tr style='background: {0}'>", color))
                For j = 1 To col.Count
                    Dim valor As String = r(col(j - 1).ToLower)
                    If col(j - 1).Contains("fecha") Then
                        If valor <> "" Then
                            valor = String.Format("{0}/{1}/{2}", r(col(j - 1)).ToString.Substring(8, 2), r(col(j - 1)).ToString.Substring(5, 2), r(col(j - 1)).ToString.Substring(0, 4))
                        End If
                    End If
                    w.Write(String.Format("<td>{0}</td>", valor))
                Next
                w.Write("</tr>")
                fila = fila + 1
            Next
            w.Write("</tbody>")
        End Sub

        Private Shared Sub EscribePiePagina()
            Dim html As New StringBuilder()
            html.Append("</table>")
            html.Append("</body>")
            html.Append("</html>")
            w.Write(html.ToString())
        End Sub

        Private Shared Sub GenerarArchivo( _
            ByVal col As List(Of String), _
            ByVal reg As List(Of Object), _
            ByVal ruta As String, _
            ByRef result As String)

            Dim app As Microsoft.Office.Interop.Excel._Application = New Microsoft.Office.Interop.Excel.Application()
            Dim workbook As Microsoft.Office.Interop.Excel._Workbook = app.Workbooks.Add(Type.Missing)
            Dim worksheet As Microsoft.Office.Interop.Excel._Worksheet = Nothing

            result = ""

            Try
                worksheet = workbook.Sheets(1)
                worksheet = workbook.ActiveSheet
                'Aca se agregan las cabeceras de nuestro datagrid.
                For i = 1 To col.Count
                    worksheet.Cells(1, i) = col(i - 1)
                Next
                Dim fila As Integer = 2
                'Aca le damos el formato a nuestro excel
                For Each r In reg
                    For j = 1 To col.Count
                        worksheet.Cells(fila, j) = r(col(j - 1).ToLower)
                    Next
                    fila = fila + 1
                Next

                worksheet.Rows.Item(1).Font.bold = 1
                worksheet.Rows.Item(1).HorizontalAlignment = 3
                worksheet.Columns.AutoFit()

                app.DisplayAlerts = False
                worksheet.SaveAs(ruta)
                'eliminamos el proceso de excell para que no quede en memoria
                KillProcess("EXCEL")
            Catch ex As Exception
                result = ex.Message
                Throw New Exception(ex.Message)
            Finally
                workbook.Close()
                workbook = Nothing
                worksheet = Nothing
                app.Quit()
                app = Nothing
                FileClose(1)
                GC.Collect()
            End Try
        End Sub

        Private Shared Sub KillProcess(ByVal NameProc As String)
            Dim proc As Process() = Process.GetProcessesByName(NameProc)
            For Each p As Process In proc
                p.Kill()
            Next
        End Sub

        Private Shared Function GetListColumns(ByVal Columns As String) As List(Of String)
            Dim col As New List(Of String)
            Columns.Split("|").Count()
            For i = 1 To Columns.Split("|").Count()
                col.Add(Columns.Split("|")(i - 1))
            Next
            Return col
        End Function

#End Region

#Region "PDF"

        Public Shared Function ExportToExcellPDF( _
            ByVal Columns As String, _
            ByVal Data As String, _
            ByVal UserID As Integer, _
            ByVal numReport As Integer) As String

            Dim col As List(Of String) = GetListColumns(Columns)
            Dim reg As List(Of Object) = JsonDeserialize(Data)
            Dim file As String = String.Format("ReportGeneral_{0}.pdf", UserID.ToString())
            Dim ruta As String = QuickAccess.GetAppSetting("FolderPDF") & file
            Dim virtualfile As String = QuickAccess.GetAppSetting("VirtualFolderPDF") & file
            Dim result As String = ""

            BorrarArchivo(ruta)
            Dim filename As String = ""

            Select numReport
                Case 1
                    filename = GetPdf_StockBajo(col, reg, ruta)
                Case 2
                    filename = GetPdf_PorIngresar(col, reg, ruta)
                    '    Case 3
                    'filename = GetPdf_Riepilogo_3(col, reg, ruta)
            End Select

            If String.IsNullOrEmpty(filename) Then
                ExportToExcellPDF = String.Format("KO§{0}", result)
            Else
                ExportToExcellPDF = String.Format("OK§{0}", virtualfile)
            End If
        End Function

        Private Shared Function GetPdf_StockBajo( _
            ByVal col As List(Of String), _
            ByVal reg As List(Of Object), _
            ByVal filename As String) As String

            Dim doc As Document = New Document(PageSize.A4)
            Dim font As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8)
            Dim Totale As Double = 0
            Dim saltoDeLinea As Paragraph = New Paragraph(vbCrLf, font)
            Dim Directorio As String = QuickAccess.GetAppSetting("FolderPDF")

            Dim pathFilename As String = ""
            Dim fontBold As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 10, iTextSharp.text.Font.BOLD)
            'Dim logo As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(String.Format("{0}logo.png", QuickAccess.GetAppSetting("FolderImgPrint")))
            'logo.SetAbsolutePosition(0, 20)
            'logo.ScaleAbsolute(60, 50)
            'logo.Alignment = iTextSharp.text.Image.ALIGN_LEFT

            Try

                filename = String.Format("Stock_Bajo.pdf")
                pathFilename = String.Format("{0}{1}", Directorio, filename)
                Dim pdfWrite = PdfWriter.GetInstance(doc, New FileStream(pathFilename, FileMode.Create))

                Dim pdftbHeader As PdfPTable = New PdfPTable(1)
                'Dim pdfcellImage As PdfPCell = New PdfPCell(logo, True)
                'pdfcellImage.FixedHeight = 40.0F
                'pdfcellImage.HorizontalAlignment = Element.ALIGN_LEFT
                'pdfcellImage.VerticalAlignment = Element.ALIGN_LEFT
                'pdfcellImage.Border = iTextSharp.text.Rectangle.NO_BORDER
                'pdftbHeader.AddCell(pdfcellImage)
                'Dim linea As PdfPCell = New PdfPCell()
                'linea.Border = iTextSharp.text.Rectangle.BOTTOM_BORDER
                'pdftbHeader.AddCell(linea)
                Dim titulo As PdfPCell = New PdfPCell(New Phrase(vbCrLf & "ARTICULOS CON STOCK BAJO", fontBold))
                titulo.Border = iTextSharp.text.Rectangle.NO_BORDER
                titulo.HorizontalAlignment = Element.ALIGN_CENTER
                pdftbHeader.AddCell(titulo)

                Dim phHeader As Phrase = New Phrase()
                phHeader.Add(pdftbHeader)

                Dim header As HeaderFooter = New HeaderFooter(phHeader, False)
                header.Border = iTextSharp.text.Rectangle.NO_BORDER
                header.Alignment = Element.ALIGN_CENTER
                doc.Header = header

                doc.SetMargins(0.0F, 0.0F, 20.0F, 20.0F)
                doc.Open()

                Dim t1 As PdfPTable = New PdfPTable(10)

                CreatePdfPCell(t1, 2, "Codigo", True)
                CreatePdfPCell(t1, 3, "Nombre", True)
                CreatePdfPCell(t1, 2, "Nivel", True)
                CreatePdfPCell(t1, 1, "Exist.", True)
                CreatePdfPCell(t1, 1, "Stock Min.", True)
                CreatePdfPCell(t1, 1, "Diferencia", True)

                For i = 0 To reg.Count - 1
                    CreatePdfPCell(t1, 2, reg(i)("codigo"))
                    CreatePdfPCell(t1, 3, reg(i)("nombre"))
                    CreatePdfPCell(t1, 2, reg(i)("nivel"))
                    CreatePdfPCell(t1, 1, reg(i)("exist"))
                    CreatePdfPCell(t1, 1, reg(i)("stock"))
                    CreatePdfPCell(t1, 1, reg(i)("dif"))
                Next

                doc.Add(saltoDeLinea)
                doc.Add(saltoDeLinea)
                doc.Add(t1)
                doc.Close()

            Catch ex As Exception
                Console.WriteLine(ex.Message)
                filename = ""
            End Try

            GetPdf_StockBajo = filename

        End Function

        Private Shared Function GetPdf_PorIngresar( _
            ByVal col As List(Of String), _
            ByVal reg As List(Of Object), _
            ByVal filename As String) As String

            Dim doc As Document = New Document(PageSize.A4)
            Dim font As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8)
            Dim Totale As Double = 0
            Dim saltoDeLinea As Paragraph = New Paragraph(vbCrLf, font)
            Dim Directorio As String = QuickAccess.GetAppSetting("FolderPDF")

            Dim pathFilename As String = ""
            Dim fontBold As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 10, iTextSharp.text.Font.BOLD)
            'Dim logo As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(String.Format("{0}logo.png", QuickAccess.GetAppSetting("FolderImgPrint")))
            'logo.SetAbsolutePosition(0, 20)
            'logo.ScaleAbsolute(60, 50)
            'logo.Alignment = iTextSharp.text.Image.ALIGN_LEFT

            Try

                filename = String.Format("PorIngresar.pdf")
                pathFilename = String.Format("{0}{1}", Directorio, filename)
                Dim pdfWrite = PdfWriter.GetInstance(doc, New FileStream(pathFilename, FileMode.Create))

                Dim pdftbHeader As PdfPTable = New PdfPTable(1)
                'Dim pdfcellImage As PdfPCell = New PdfPCell(logo, True)
                'pdfcellImage.FixedHeight = 40.0F
                'pdfcellImage.HorizontalAlignment = Element.ALIGN_LEFT
                'pdfcellImage.VerticalAlignment = Element.ALIGN_LEFT
                'pdfcellImage.Border = iTextSharp.text.Rectangle.NO_BORDER
                'pdftbHeader.AddCell(pdfcellImage)
                'Dim linea As PdfPCell = New PdfPCell()
                'linea.Border = iTextSharp.text.Rectangle.BOTTOM_BORDER
                'pdftbHeader.AddCell(linea)
                Dim titulo As PdfPCell = New PdfPCell(New Phrase(vbCrLf & "ARTICULOS CON FECHA REINGRESO VENCIDA", fontBold))
                titulo.Border = iTextSharp.text.Rectangle.NO_BORDER
                titulo.HorizontalAlignment = Element.ALIGN_CENTER
                pdftbHeader.AddCell(titulo)

                Dim phHeader As Phrase = New Phrase()
                phHeader.Add(pdftbHeader)

                Dim header As HeaderFooter = New HeaderFooter(phHeader, False)
                header.Border = iTextSharp.text.Rectangle.NO_BORDER
                header.Alignment = Element.ALIGN_CENTER
                doc.Header = header

                doc.SetMargins(0.0F, 0.0F, 20.0F, 20.0F)
                doc.Open()

                Dim t1 As PdfPTable = New PdfPTable(10)

                CreatePdfPCell(t1, 2, "Codigo", True)
                CreatePdfPCell(t1, 2, "Nombre", True)
                CreatePdfPCell(t1, 2, "Nivel", True)
                CreatePdfPCell(t1, 1, "Estatus", True)
                CreatePdfPCell(t1, 1, "Reintegra", True)
                CreatePdfPCell(t1, 2, "Responsable", True)

                For i = 0 To reg.Count - 1
                    CreatePdfPCell(t1, 2, reg(i)("codigo"))
                    CreatePdfPCell(t1, 2, reg(i)("nombre"))
                    CreatePdfPCell(t1, 2, reg(i)("nivel"))
                    CreatePdfPCell(t1, 1, reg(i)("estatus"))
                    CreatePdfPCell(t1, 1, reg(i)("fecha"))
                    CreatePdfPCell(t1, 2, reg(i)("resp"))
                Next

                doc.Add(saltoDeLinea)
                doc.Add(saltoDeLinea)
                doc.Add(t1)
                doc.Close()

            Catch ex As Exception
                Console.WriteLine(ex.Message)
                filename = ""
            End Try

            GetPdf_PorIngresar = filename

        End Function


        Private Shared Sub CreatePdfPCell(ByRef t As PdfPTable, ByVal colspan As Integer, ByVal testo As String, Optional ByVal bgColor As Boolean = False)
            Dim cell As PdfPCell = Nothing
            Dim font As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, Font10)

            If bgColor Then
                font.Color = iTextSharp.text.Color.WHITE
                cell = New PdfPCell(New Phrase(testo, font))
                cell.BackgroundColor = iTextSharp.text.Color.GRAY
            Else
                font.Color = iTextSharp.text.Color.BLACK
                cell = New PdfPCell(New Phrase(testo, font))
            End If

            cell.Colspan = colspan
            t.AddCell(cell)
        End Sub

        Private Shared Sub CreatePdfPCell_NO_BORDER(ByRef t As PdfPTable, ByVal colspan As Integer, ByVal testo As String, Optional ByVal bgColor As Boolean = False)
            Dim cell As PdfPCell = Nothing
            Dim font As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, Font10)

            If bgColor Then
                font.Color = iTextSharp.text.Color.WHITE
                cell = New PdfPCell(New Phrase(testo, font))
                cell.BackgroundColor = iTextSharp.text.Color.GRAY
            Else
                font.Color = iTextSharp.text.Color.BLACK
                cell = New PdfPCell(New Phrase(testo, font))
            End If

            cell.Colspan = colspan
            cell.Border = PdfCell.NO_BORDER
            t.AddCell(cell)
        End Sub

#End Region



#End Region

#Region "WSToolsServer"

        Public Shared Function SendMailParametric( _
            ByVal emailTo As String, _
            ByVal emailCc As String, _
            ByVal subject As String, _
            ByVal body As String) As String

            Dim Captions As Dictionary(Of String, String) = Session("CaptionTranslate")
            Dim Messages As Dictionary(Of String, String) = Session("MessageTranslate")
            Dim httpSITO As String = QuickAccess.GetAppSetting("httpSITO")
            Dim sbBody As New StringBuilder

            sbBody.Append("<html>")
            sbBody.Append("<meta charset='utf-8'>")
            sbBody.Append("<meta http-equiv='X-UA-Compatible' content='IE=edge'>")
            sbBody.Append("<meta name='viewport' content='width=device-width, initial-scale=1'>")
            sbBody.Append("<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>")
            sbBody.Append(String.Format("<link href='{0}css/bootstrap.css' rel='stylesheet' media='all'>", httpSITO))
            sbBody.Append("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>")
            sbBody.Append(String.Format("<link href='{0}css/style.css' rel='stylesheet'>", httpSITO))
            sbBody.Append(String.Format("<link rel='stylesheet' href='{0}css/jquery-ui.css'>", httpSITO))
            sbBody.Append(String.Format("<link rel='stylesheet' type='text/css' href='{0}css/jquery.fancybox.css'>", httpSITO))
            sbBody.Append("<style type='text/css' media='all'>" & _
                                "h6 {font-weight: bold; font-size: 14px;}" & _
                                "h5 {font-weight: bold; font-size: 16px; border-bottom: 1px solid #000; padding-bottom: 10px;}" & _
                                ".col-md-6 {width: 49%; float: left; padding: 0px;}" & _
                                ".box2 {margin-bottom: 0px !important;}" & _
                                ".datagrid table { border-collapse: collapse; text-align: left; width: 100%; }" & _
                                ".datagrid table a {font-weight: bold;  color: #000;}" & _
                                ".datagrid {font: normal 15px/150% Arial, Helvetica, sans-serif; background: #fff; overflow: hidden; border: 1px solid #000; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; }" & _
                                ".datagrid table td, .datagrid table th { padding: 3px 10px; }" & _
                                ".datagrid table thead th {background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ccc), color-stop(1, #ccc) );background:-moz-linear-gradient( center top, #ccc 5%, #ccc 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ccc', endColorstr='#ccc');background-color:#ccc; color:#000; font-size: 15px; font-weight: bold; border-left: 1px solid #000; border-bottom: 1px solid #000; } " & _
                                ".datagrid table thead th:first-child {border-bottom: 1px solid #000; border-left: none; border-right: none; border-top: none;}" & _
                                ".datagrid table tbody td { padding: 10px;color: #000; border-left: 1px solid #000;font-size: 15px;font-weight: normal; }" & _
                                ".datagrid table tbody .alt td { background: #ccc; color: #000; }" & _
                                ".datagrid table tbody td:first-child { border-left: none; }.datagrid table tbody tr:last-child td { border-bottom: none; }" & _
                                ".datagrid table tfoot {background: #ccc; color: #000; font-weight: bold; border-top: 1px solid #000; }" & _
                                ".datagrid table tfoot td div { border-top: 1px solid #000;background: #ccc;} " & _
                                ".datagrid table tfoot td { border-left: 1px solid #000; padding: 5px 10px; font-size: 15px } .datagrid table tfoot td div{ padding: 2px; }" & _
                                ".datagrid table tfoot td ul { margin: 0; padding:0; list-style: none; text-align: right; }" & _
                                ".datagrid table tfoot  li { display: inline; }" & _
                                ".datagrid table tfoot li a {  text-decoration: none; display: inline-block;  padding: 2px 8px; margin: 1px;color: #FFFFFF;border: 1px solid #000;-webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #000), color-stop(1, #000) );background:-moz-linear-gradient( center top, #000 5%, #000 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#000', endColorstr='#000');background-color:#000; }" & _
                                ".datagrid table tfoot ul.active, .datagrid table tfoot ul a:hover { text-decoration: none;border-color: #000; color: #FFFFFF; background: none; background-color:#2BB900;}" & _
                                "div.dhtmlx_window_active, div.dhx_modal_cover_dv { position: fixed !important; }" & _
                                ".box2 {padding: 15px; background: #fff; margin-bottom: 15px;}" & _
                                ".address h6 strong {color: #000 ;}" & _
                                ".a-right{text-align: right;}" & _
                                ".a-center {text-align: center;}" & _
                            "</style>")
            sbBody.Append("<body class='index'>")
            sbBody.Append(body)
            sbBody.Append("</body></html>")

            SendMailParametric = Common.MailUtility.SendMailWithCcAddress(subject, sbBody.ToString, emailTo, emailCc)
        End Function

#End Region


    End Class

End Namespace
