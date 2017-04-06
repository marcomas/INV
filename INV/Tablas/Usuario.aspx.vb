Partial Public Class Usuario
    Inherits System.Web.UI.Page

#Region "Properties"

    Private _bMA As Integer
    Property bMA() As Integer
        Get
            Return _bMA
        End Get
        Set(ByVal value As Integer)
            _bMA = value
        End Set
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        _bMA = Request.Params("bMA") ' Flag que indica que se está entrando en Modalidad Account
    End Sub

End Class