Imports INV.Utilities
Imports Common

Partial Public Class PrintBarCode
    Inherits System.Web.UI.Page

#Region "Properties"

    Private _Codigo As String
    Property Codigo() As String
        Get
            Return _Codigo
        End Get
        Set(ByVal value As String)
            _Codigo = value
        End Set
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        _Codigo = Request.Params("Codigo")
        Fun.SetDefaultPrint("Brother QL-700")
    End Sub

End Class