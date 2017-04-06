Partial Public Class WSSessionVar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fun As String = Request.Params("fun")
        Dim name As String = Request.Params("name")
        Dim value As String = Request.Params("value")

        If fun = "set" Then
            Session(name) = value
        ElseIf fun = "get" Then
            If Not Session(name) Is Nothing Then
                value = String.Format("{0}$", Session(name))
            Else
                value = "KO$"
            End If
        End If

        Response.Write(value)
    End Sub

End Class