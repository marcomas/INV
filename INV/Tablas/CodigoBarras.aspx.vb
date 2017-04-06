Imports Common
Imports INV.Utilities
Partial Public Class CodigoBarras
    Inherits System.Web.UI.Page
    Private _IdArt As Integer
    Public Property IdArt As Integer
        Get
            Return _IdArt
        End Get
        Set(ByVal value As Integer)
            _IdArt = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        _IdArt = IIf(Request.Params("IdArt") = "", 0, Request.Params("IdArt"))
    End Sub

End Class