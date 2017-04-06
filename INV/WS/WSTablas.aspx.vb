Imports INV.Utilities
Imports INV.Utilities.Fun

Partial Public Class WSTablas
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim result As New StringBuilder
        Dim tabla As String = Request.Params("tabla")
        Dim fun As String = Request.Params("fun")
        Dim data As String = Request.Params("data")
        Dim id As Integer = Request.Params("id")
        Dim codigo As String = Request.Params("codigo")
        Dim querytype As String = Request.Params("querytype")
        Dim columns As String = Request.Params("columnsexports")
        Dim dataList As List(Of String) = Nothing
        Dim resMessage As String = ""

        DataHelper.Session = Session

        Select Case fun
            Case "getRecord"
                DataList = DataHelper.GetRecords(tabla, id, data)
                WriteResult(dataList, result)
            Case "getFotogalleryArticulo"
                dataList = DataHelper.GetProductFoto(tabla, id, 58)
                WriteResult(dataList, result)
            Case "delFotogalleryArticulo"
                resMessage = DataHelper.DelFotogalleryArticulo(tabla, id, data)
                WriteResult(resMessage, result)
            Case "getProduct"
                dataList = DataHelper.GetProduct(tabla, data, querytype)
                WriteResult(dataList, result)
            Case "getIdDepto"
                dataList = DataHelper.GetIdDepto(tabla, data)
                WriteResult(dataList, result)
            Case "InsertFoto"
                resMessage = DataHelper.InsertRecord(tabla, id, data, 21)
                WriteResult(resMessage, result)
            Case "AddBarCode"
                resMessage = DataHelper.InsertRecord(tabla, id, data, 12)
                WriteResult(resMessage, result)
            Case "getListCodigo"
                dataList = DataHelper.GetListCodigo(tabla)
                WriteResult(dataList, result)
            Case "getNiveles"
                dataList = DataHelper.GetNiveles()
                WriteResult(dataList, result)
            Case "newRecord"
                resMessage = DataHelper.NewRecord(tabla, 1, 0, data, dataList)
                If (resMessage = "") Then WriteResult(dataList, result) Else result.Append(String.Format("KO§{0}", resMessage))
            Case "newRecordTransito"
                resMessage = DataHelper.NewRecordTransito(tabla, data, dataList)
                If (resMessage = "") Then WriteResult(dataList, result) Else result.Append(String.Format("KO§{0}", resMessage))
            Case "updateRecord"
                resMessage = DataHelper.SaveRecord(tabla, 2, id, data)
                WriteResult(resMessage, result)
            Case "deleteRecord"
                resMessage = DataHelper.DeleteRecord(tabla, id)
                WriteResult(resMessage, result)
            Case "newCategoriaArticulo"
                resMessage = DataHelper.NewCategoriaArticulo(data, dataList)
                If (resMessage = "") Then WriteResult(dataList, result) Else result.Append(String.Format("KO§{0}", resMessage))
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
            Case "recuperarRecord"
                resMessage = DataHelper.RecuperarRecord(tabla, id)
                If (resMessage = "") Then WriteResult(resMessage, result) Else result.Append(String.Format("KO§{0}", resMessage))
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
