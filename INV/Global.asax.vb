Imports System.Web.SessionState
Imports INV.Utilities

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        HttpRuntime.Cache.Insert("urlFoto", Common.QuickAccess.GetAppSetting("urlFoto"))

        Try
            Dim listLogOnUtente As New ArrayList
            HttpRuntime.Cache.Insert("listLogOnUtente", listLogOnUtente)
        Catch ex As Exception
        End Try
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Session("Language") = "ES"
        Session("CaptionTranslate") = DataHelper.GetCaptionTranslate(Session("Language"))
        Session("MessageTranslate") = DataHelper.GetMessageTranslate(Session("Language"))
        Session("OpenArticulo") = 0
        Session("OcultarNotifica") = 0
        ' Fires when the session is started
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session ends
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub

End Class