Imports Common
Imports INV.Utilities
Imports System.IO
Imports System.Data.SqlClient

Partial Public Class UploadFoto
    Inherits System.Web.UI.Page

#Region "Properties"

    Private _IdRecord As Integer
    Property IdRecord() As Integer
        Get
            Return _IdRecord
        End Get
        Set(ByVal value As Integer)
            _IdRecord = value
        End Set
    End Property

    Private _Folder As String
    Property Folder() As String
        Get
            Return _Folder
        End Get
        Set(ByVal value As String)
            _Folder = value
        End Set
    End Property

#End Region

    Private Sub Form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Form1.Load
        _IdRecord = Request.Params("Id")
        _Folder = Request.Params("Folder")
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpload.Click
        Dim urlFoto As String = HttpRuntime.Cache("urlFoto")
        Dim DIR As String = String.Format("../imgINV/{0}/{1}/", _Folder, _IdRecord)

        Try
            FileUtility.CreateFolderIfNotExist(Server.MapPath(DIR))
            Dim NumImg As Integer = DataHelper.GetProxNumImg(_IdRecord, _Folder)
            Dim fileRename As String = String.Format("img_{0}_{1}", _IdRecord, NumImg)
            Common.FileUtility.RenameFile(String.Format("{0}{1}", Server.MapPath(urlFoto), "foto.jpg"), "foto.jpg", fileRename)

            File.Move( _
                String.Format("{0}{1}", Server.MapPath(urlFoto), String.Format("{0}.jpg", fileRename)), _
                String.Format("{0}{1}", Server.MapPath(DIR), String.Format("{0}.jpg", fileRename)) _
            )

            DataHelper.SaveImages(_IdRecord, _Folder, String.Format("{0}.jpg", fileRename), 2000)

            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "PrepareLoadFoto", "PrepareLoadFoto();", True)
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CerrarForm", "CerrarForm();", True)
            Session("UploadName") = fileRename + ".jpg"
        Catch ex As Exception
        End Try
    End Sub

End Class