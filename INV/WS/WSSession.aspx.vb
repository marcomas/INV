Imports INV.Utilities
Imports INV.Utilities.Fun
Imports Common

Partial Public Class WSSession
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim result As New StringBuilder
        Dim tabla As String = Request.Params("tabla")
        Dim fun As String = Request.Params("fun")
        Dim data As String = Request.Params("data")
        Dim id As Integer = Request.Params("id")
        Dim codigo As String = Request.Params("codigo")
        Dim erroMessage As String = ""
        Dim dataList As List(Of String) = Nothing
        Dim resMessage As String = ""

        DataHelper.Session = Session

        Select Case fun
            Case "login"
                dataList = DataHelper.LogIn(data, erroMessage)
                WriteResult(dataList, result, erroMessage, fun)
                If Not (dataList Is Nothing) Then
                    If dataList.Count > 0 Then
                        Dim listLogOnUtente As ArrayList = HttpRuntime.Cache("listLogOnUtente")

                        Dim utente As New LogOnUtente
                        utente.Id = dataList(0).Split("|")(0)
                        utente.CognomeNome = dataList(0).Split("|")(1)
                        utente.Tipo = dataList(0).Split("|")(2)
                        Session("TipoUsuario") = utente.Tipo

                        utente.SessionId = Session.SessionID
                        utente.Username = dataList(0).Split("|")(3)
                        Session("Username") = utente.Username
                        listLogOnUtente.Add(utente)
                        Session("UserId") = utente.Id
                    End If
                End If
            Case "logout"
                Dim listLogOnUtente As ArrayList = HttpRuntime.Cache("listLogOnUtente")
                If (listLogOnUtente Is Nothing) Then
                    Session.Abandon()
                    Exit Sub
                End If
                For Each ut As LogOnUtente In listLogOnUtente
                    If (ut.SessionId.Equals(Session.SessionID)) Then
                        DataHelper.LogOut()
                        listLogOnUtente.Remove(ut)
                        Exit For
                    End If
                Next
                Session.Abandon()
            Case "getPregutaRespuesta"
                dataList = DataHelper.GetPregutaRespuesta(id)
                WriteResult(dataList, result)
            Case "changePregutaRespuesta"
                resMessage = DataHelper.ChangePregutaRespuesta(id, data)
                WriteResult(resMessage, result)
            Case "changePswUsuario"
                resMessage = DataHelper.CambiarPswUsuario(id, data)
                result.Append(resMessage)
            Case "recoveryPswUsuario"
                dataList = DataHelper.RecoveryPswUsuario(data)
                result.Append(resMessage)
            Case "updatePerfilUsuario"
                resMessage = DataHelper.UpdatePerfilUsuario(id, data)
                WriteResult(dataList, result)
            Case "getEmailUser"
                dataList = DataHelper.GetEmailUser(data)
                WriteResult(dataList, result)
            Case "getUsuario"
                dataList = DataHelper.GetUsuario()
                WriteResult(dataList, result)
        End Select

        result.Append("§")
        Response.Write(result)
    End Sub

    Private Sub WriteResult(ByVal dataList As List(Of String), ByRef result As StringBuilder, Optional ByVal erroMessage As String = "", Optional ByVal fun As String = "")
        Dim firstItem As Boolean = True

        If erroMessage <> "" Then
            result.Append(String.Format("KO§{0}", erroMessage))
        Else
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
                    If (fun = "login") Then
                        result.Append(String.Format("KO§{0}", Session("msgUserNoAccess")))
                    Else
                        result.Append(String.Format("KO§{0}", Session("msgNoRecords")))
                    End If
                End If
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