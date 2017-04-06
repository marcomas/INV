Imports Common
Imports INV.Utilities

Partial Public Class UploadSingleFile
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

    Private _SubFolder As String
    Property SubFolder() As String
        Get
            Return _SubFolder
        End Get
        Set(ByVal value As String)
            _SubFolder = value
        End Set
    End Property

    Private _QType As Integer
    Property QueryType() As Integer
        Get
            Return _QType
        End Get
        Set(ByVal value As Integer)
            _QType = value
        End Set
    End Property

#End Region

    Dim _QueryTypeGet As Integer = 500
    Dim _QueryTypeSet As Integer = 200

    Private Sub Form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Form1.Load
        _IdRecord = Request.Params("Id")
        _Folder = Request.Params("Folder")
        _SubFolder = IIf(String.IsNullOrEmpty(Request("SubFolder")), "", Request("SubFolder"))
        _QueryTypeGet = IIf(Not String.IsNullOrEmpty(Request("qtypeget")), Request("qtypeget"), 500)
        _QueryTypeSet = IIf(Not String.IsNullOrEmpty(Request("qtypeset")), Request("qtypeset"), 200)

        If Not IsPostBack Then
            txtFiles.Value = DataHelper.GetImages(_IdRecord, _Folder, _QueryTypeGet)
        End If
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpload.Click
        Dim DIR As String = ""

        If String.IsNullOrEmpty(_SubFolder) Then
            DIR = String.Format("../imgINV/{0}/{1}/", _Folder, _IdRecord)
        Else
            DIR = String.Format("../imgINV/{0}/{1}/", _Folder, _SubFolder)
        End If

        Try
            FileUtility.DeleteFile(Server.MapPath(DIR) & "\" & System.IO.Path.GetFileName(txtFiles.Value))
            FileUtility.CreateFolderIfNotExist(Server.MapPath(DIR))

            Dim hfCollection As HttpFileCollection = Request.Files
            For i As Integer = 0 To hfCollection.Count - 1
                Dim hPostedFile As HttpPostedFile = hfCollection(i)
                If hPostedFile.ContentLength > 0 Then
                    hPostedFile.SaveAs(Server.MapPath(DIR) & "\" & System.IO.Path.GetFileName(hPostedFile.FileName))
                    txtFiles.Value = String.Format("{0}", hPostedFile.FileName)
                    DataHelper.SaveImages(_IdRecord, _Folder, txtFiles.Value, _QueryTypeSet)
                End If
            Next
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnDelete.Click
        Dim DIR As String = ""

        If String.IsNullOrEmpty(_SubFolder) Then
            DIR = String.Format("../imgINV/{0}/{1}/", _Folder, _IdRecord)
        Else
            DIR = String.Format("../imgINV/{0}/{1}/", _Folder, _SubFolder)
        End If

        Try
            FileUtility.DeleteFile(Server.MapPath(DIR) & "\" & System.IO.Path.GetFileName(txtFiles.Value))
            txtFiles.Value = ""
            DataHelper.SaveImages(_IdRecord, _Folder, "", _QueryTypeSet)
        Catch ex As Exception
        End Try
    End Sub

End Class