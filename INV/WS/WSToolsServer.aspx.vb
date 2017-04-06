Imports Common
Imports INV.Utilities

Partial Public Class WSToolsServer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim result As New StringBuilder
        Dim f As String = Request.Params("fun")
        Dim data As String = Request.Params("data")
        Dim resMessage As String = ""

        DataHelper.Session = Session
        Fun.Session = Session

        Select Case f
            Case "sendMail"
                Dim emailTo As String = data.Split("|")(0)
                Dim emailCc As String = data.Split("|")(1)
                Dim subject As String = data.Split("|")(2)
                Dim body As String = data.Split("|")(3)

                body = body.Replace("{", "<")
                body = body.Replace("}", ">")

                resMessage = Fun.SendMailParametric(emailTo, emailCc, subject, body)
                If String.IsNullOrEmpty(resMessage) Then
                    result.Append(String.Format("OK§"))
                Else
                    result.Append(String.Format("KO§{0}§", resMessage))
                End If
        End Select

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