Imports INV.Utilities
Imports INV.Utilities.Fun

Partial Public Class WSCheckExist
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim result As New StringBuilder
        Dim fun As String = Request.Params("fun")
        Dim data As String = Request.Params("data")
        Dim resMessage As String = ""

        DataHelper.Session = Session

        Select Case fun
            Case "cliente"
                resMessage = DataHelper.CheckExist(1, data)
        End Select

        result.Append(String.Format("OK§{0}§", resMessage))
        Response.Write(result)
    End Sub

End Class