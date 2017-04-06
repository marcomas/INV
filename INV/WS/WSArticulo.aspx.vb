Imports INV.Utilities
Imports INV.Utilities.Fun

Partial Public Class WSArticulo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim result As New StringBuilder
        Dim tabla As String = Request.Params("tabla")
        Dim fun As String = Request.Params("fun")
        Dim data As String = Request.Params("data")
        Dim id As Integer = Request.Params("id")
        Dim codigo As String = Request.Params("codigo")
        Dim dataList As List(Of String) = Nothing
        Dim resMessage As String = ""

        DataHelper.Session = Session

        Select Case fun
            Case "entradaArticuloC"
                resMessage = DataHelper.ESArticulo(21, id, data)
                WriteResult(resMessage, result)
            Case "entradaArticuloU"
                resMessage = DataHelper.ESArticulo(22, id, data)
                WriteResult(resMessage, result)
            Case "salidaArticuloC"
                resMessage = DataHelper.ESArticulo(31, id, data)
                WriteResult(resMessage, result)
            Case "salidaArticuloU"
                resMessage = DataHelper.ESArticulo(32, id, data)
                WriteResult(resMessage, result)
            Case "cambiaExistenciaArticulo"
                dataList = DataHelper.CambiaExistenciaArticulo(data)
                WriteResult(dataList, result)
            Case "getEntradas"
                dataList = DataHelper.GetEntradas(data)
                WriteResult(dataList, result)
            Case "getSalidas"
                dataList = DataHelper.GetSalidas(data)
                WriteResult(dataList, result)
        End Select

        result.Append("§")
        Response.Write(result)
    End Sub

    Private Sub WriteResult(ByVal dataList As List(Of String), ByRef result As StringBuilder)
        Dim firstItem As Boolean = True

        If (dataList Is Nothing) Then
            result.Append(String.Format("KO§{0}", Session("msgErroNotExpected")))
        Else
            If dataList.Count > 0 Then
                result.Append("OK§")
                For Each item As String In dataList
                    If firstItem Then
                        result.Append(item)
                    Else
                        result.Append(String.Format("${0}", item))
                    End If
                    firstItem = False
                Next
            Else
                result.Append(String.Format("KO§{0}", Session("msgNoRecords")))
            End If
        End If
    End Sub

    Private Sub WriteResult(ByVal resMessage As String, ByRef result As StringBuilder)
        If (String.IsNullOrEmpty(resMessage)) Then
            result.Append(String.Format("OK§{0}", ID))
        Else
            result.Append(String.Format("KO§{0}", resMessage))
        End If
    End Sub

End Class