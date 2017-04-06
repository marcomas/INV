Imports Common
Imports INV.Utilities

Partial Public Class UploadFile
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
        If Not IsPostBack Then
            Session(_Folder) = DataHelper.GetImages(_IdRecord, _Folder)
            AddFileToSelect()
        End If
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpload.Click
        Dim DIR As String = String.Format("../imgINV/{0}/{1}/", _Folder, _IdRecord)
        Try
            FileUtility.CreateFolderIfNotExist(Server.MapPath(DIR))

            Dim hfCollection As HttpFileCollection = Request.Files
            For i As Integer = 0 To hfCollection.Count - 1
                Dim hPostedFile As HttpPostedFile = hfCollection(i)
                If hPostedFile.ContentLength > 0 Then
                    If FileUtility.FileExist(Server.MapPath(DIR) & "\" & System.IO.Path.GetFileName(hPostedFile.FileName)) Then Continue For
                    hPostedFile.SaveAs(Server.MapPath(DIR) & "\" & System.IO.Path.GetFileName(hPostedFile.FileName))

                    If String.IsNullOrEmpty(Session(_Folder)) Then
                        Session(_Folder) = String.Format("{0}", hPostedFile.FileName)
                    Else
                        Session(_Folder) = String.Format("{0}&{1}", Session(_Folder), hPostedFile.FileName)
                    End If

                    AddFileToSelect()
                    DataHelper.SaveImages(_IdRecord, _Folder, Session(_Folder))
                End If
            Next
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnDelete.Click
        Dim DIR As String = String.Format("../imgINV/{0}/{1}/", _Folder, _IdRecord)
        Try
            FileUtility.DeleteFile(Server.MapPath(DIR) & "\" & System.IO.Path.GetFileName(Session("filename")))
            Session(_Folder) = Session(_Folder).replace(Session("filename"), "")
            Session(_Folder) = Session(_Folder).replace("&&", "&")
            If Session(_Folder).ToString.IndexOf("&", 0) = 0 Then Session(_Folder) = Session(_Folder).ToString.Substring(1)
            If Session(_Folder).ToString.IndexOf("&", Session(_Folder).ToString.Length) = 0 Then Session(_Folder) = Session(_Folder).ToString.Substring(0, Session(_Folder).ToString.Length - 1)
            AddFileToSelect()
            DataHelper.SaveImages(_IdRecord, _Folder, Session(_Folder))
        Catch ex As Exception
        End Try
    End Sub

    Private Sub AddFileToSelect()
        Dim files As String = Session(_Folder)
        selFiles.Items.Clear()
        selFiles.Items.Add("")
        For Each f As String In files.Split("&")
            If f.Trim <> "" Then selFiles.Items.Add(f)
        Next
    End Sub

End Class