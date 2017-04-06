Imports Business
Imports Common
Imports INV.Utilities.Constants
Imports System.Reflection
Imports System.Reflection.Emit

Namespace Utilities

    Public Class DataHelper

        Shared Private _Session As HttpSessionState
        Shared Property Session() As HttpSessionState
            Get
                Return _Session
            End Get
            Set(ByVal value As HttpSessionState)
                _Session = value
            End Set
        End Property

#Region "Ejecucion de Stored Procedure"

        Public Shared Function ExecuteSP_INV( _
            ByVal spName As String, _
            ByVal parameters As ArrayList, _
            ByRef dt As DataTable, _
            Optional ByVal sucursal As Integer = 0, _
            Optional ByVal bSpecUserId As Boolean = True) As String

            If bSpecUserId Then
                If Not Session("UserId") Is Nothing Then SqlServer.StoredProcUtility.AddInputParameter(parameters, "@UserId", SqlDbType.Int, Session("UserId"), 8)
            End If

            ExecuteSP_INV = SqlServer.DataHelper.ExectuteSPAndPopulateDataTable( _
                QuickAccess.GetConnectionString(Constants.CONNECTION_STRING_INV), _
                spName, _
                parameters, _
                dt)
        End Function

#End Region

#Region "Records"

        Public Shared Function GetListCodigo( _
            ByVal tableName As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 51, 4)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetListCodigo = dataList
        End Function

        Public Shared Function GetListCodigoData( _
            ByVal tableName As String, _
            ByVal stringValues As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 51, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetListCodigoData = dataList
        End Function

        Public Shared Function GetProduct( _
           ByVal tableName As String, _
           ByVal stringValues As String, _
           ByVal QueryType As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, QueryType, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetProduct = dataList
        End Function

        Public Shared Function GetIdDepto( _
           ByVal tableName As String, _
           ByVal stringValues As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 52, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetIdDepto = dataList
        End Function

        Public Shared Function GetProductFoto( _
          ByVal tableName As String, _
          ByVal id As String, _
          ByVal QueryType As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, QueryType, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetProductFoto = dataList
        End Function

        Public Shared Function InsertRecord( _
         ByVal tableName As String, _
         ByVal id As String, _
         ByVal stringValues As String, _
         ByVal QueryType As Integer) As String

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, QueryType, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            InsertRecord = resMessage
        End Function

        Public Shared Function GetRecords( _
            ByVal tableName As String, _
            Optional ByVal id As Integer = 0, _
            Optional ByVal stringValues As String = "") As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList
            Dim resMessage As String = ""

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 5, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            If id <> 0 Then
                SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            End If

            If (tableName = "log") Then
                resMessage = ExecuteSP_INV(String.Format("spLogInv"), parameters, dt)
            Else
                resMessage = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            End If

            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetRecords = dataList
        End Function

        Public Shared Function SaveRecord( _
            ByVal tableName As String, _
            ByVal queryType As Integer, _
            ByVal id As Integer, _
            ByVal stringValues As String) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, queryType, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            SaveRecord = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
        End Function

        Public Shared Function NewRecord( _
            ByVal tableName As String, _
            ByVal queryType As Integer, _
            ByVal id As Integer, _
            ByVal stringValues As String, _
            ByRef dataList As List(Of String)) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, queryType, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            NewRecord = resMessage
        End Function

        Public Shared Function NewRecordTransito( _
           ByVal tableName As String, _
           ByVal stringValues As String, _
           ByRef dataList As List(Of String)) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 13, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, 0, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            NewRecordTransito = resMessage
        End Function

        Public Shared Function DeleteRecord( _
            ByVal tableName As String, _
            ByVal id As Integer, _
            Optional ByVal stringValues As String = "") As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 3, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            DeleteRecord = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
        End Function

        Public Shared Function DelFotogalleryArticulo( _
           ByVal tableName As String, _
           ByVal id As Integer, _
           Optional ByVal stringValues As String = "") As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 31, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            DelFotogalleryArticulo = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
        End Function

        Public Shared Function GetIdNewRecord( _
            ByVal tableName As String) As Integer

            Dim dt As New DataTable
            Dim parameters As New ArrayList
            GetIdNewRecord = 0

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 41, 4)
            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                If dt.Rows.Count > 0 Then
                    GetIdNewRecord = Trim(dt.Rows(0)("Id"))
                End If
            End If
        End Function

        Public Shared Function CambiaEstatus( _
            ByVal tableName As String, _
            ByVal id As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 203, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            CambiaEstatus = dataList
        End Function

        Public Shared Function CambiaConsumible( _
            ByVal tableName As String, _
            ByVal id As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 204, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)

            Dim resMessage As String = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            CambiaConsumible = dataList
        End Function
        Public Shared Function CambiaEmailV( _
            ByVal id As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 204, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)

            Dim resMessage As String = ExecuteSP_INV("spProfesional", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            CambiaEmailV = dataList
        End Function

        Public Shared Function CambiaTlfV( _
            ByVal id As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 205, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)

            Dim resMessage As String = ExecuteSP_INV("spProfesional", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            CambiaTlfV = dataList
        End Function

        Public Shared Function CheckExist( _
            ByVal queryType As Integer, _
            ByVal StringValues As String) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, queryType, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, StringValues, -1)
            CheckExist = ExecuteSP_INV("spCheckExist", parameters, dt)
        End Function

        Public Shared Function UpdatePerfilUsuario(
            ByVal id As Integer,
            ByVal stringValues As String) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 205, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, Session("UserId"), 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)
            UpdatePerfilUsuario = ExecuteSP_INV("spUsuario", parameters, dt)
        End Function
        Public Shared Function RecuperarRecord(
            ByVal tableName As String,
            ByVal id As Integer,
            Optional ByVal stringValues As String = "") As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 6, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            RecuperarRecord = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
        End Function



#End Region

#Region "Generico"

        Public Shared Function GetDefaultLanguage() As String
            Dim dt As New DataTable
            Dim parameters As New ArrayList
            Dim lingua As String = String.Empty

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 6, 8)
            Dim resMessage As String = ExecuteSP_INV("spConfiguracion", parameters, dt, 0, False)
            If (String.IsNullOrEmpty(resMessage)) Then
                If dt.Rows.Count > 0 Then
                    lingua = dt.Rows(0).Item("record")
                End If
            End If
            GetDefaultLanguage = lingua
        End Function

#End Region

#Region "Articulo"

        Public Shared Function GetNiveles() As List(Of String)
            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 55, 4)

            Dim resMessage As String = ExecuteSP_INV("spArticulo", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetNiveles = dataList
        End Function

        Public Shared Function CambiaEstatusArticulo( _
            ByVal id As Integer, _
            ByVal estatus As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 203, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, estatus, -1)

            Dim resMessage As String = ExecuteSP_INV("spArticulo", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            CambiaEstatusArticulo = dataList
        End Function

        Public Shared Function NewCategoriaArticulo( _
            ByVal stringValues As String, _
            ByRef dataList As List(Of String)) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 11, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            Dim resMessage As String = ExecuteSP_INV("spArticulo", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            NewCategoriaArticulo = resMessage
        End Function

        Public Shared Function ESArticulo( _
            ByVal queryType As Integer, _
            ByVal id As Integer, _
            ByVal StringValues As String) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, queryType, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, StringValues, -1)
            ESArticulo = ExecuteSP_INV("spEntradaSalida", parameters, dt)
        End Function

        Public Shared Function CambiaExistenciaArticulo(
            ByVal info As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 210, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, info, -1)

            Dim resMessage As String = ExecuteSP_INV("spArticulo", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            CambiaExistenciaArticulo = dataList
        End Function
        Public Shared Function GetEntradas(
            ByVal info As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 204, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, info, -1)

            Dim resMessage As String = ExecuteSP_INV("spEntradaSalida", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetEntradas = dataList
        End Function
        Public Shared Function GetSalidas(
            ByVal info As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 205, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, info, -1)

            Dim resMessage As String = ExecuteSP_INV("spEntradaSalida", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetSalidas = dataList
        End Function
#End Region

#Region "Session"

        Public Shared Function LogIn( _
            ByVal stringValues As String, _
            ByRef erroMessage As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 7, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, 50)
            erroMessage = ExecuteSP_INV("spUsuario", parameters, dt)
            If (String.IsNullOrEmpty(erroMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            LogIn = dataList
        End Function

        Public Shared Sub LogOut()
            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 70, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, Session("UserId"), 8)
            ExecuteSP_INV("spUsuario", parameters, dt)
        End Sub

        Public Shared Function GetUsuario() As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 4, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, Session("UserId"), 8)

            Dim resMessage As String = ExecuteSP_INV("spUsuario", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetUsuario = dataList
        End Function
        Public Shared Function RecoveryPswUsuario( _
           ByVal Username As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 207, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, Username, 50)

            Dim resMessage As String = ExecuteSP_INV("spUsuario", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            RecoveryPswUsuario = dataList
        End Function
        Public Shared Function GetEmailUser( _
            ByVal Username As String) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 208, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, Username, 50)

            Dim resMessage As String = ExecuteSP_INV("spUsuario", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetEmailUser = dataList
        End Function

        Public Shared Function GetPregutaRespuesta( _
            ByVal idUsuario As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList
            Dim resMessage As String = ""

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 53, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, idUsuario, 8)
            resMessage = ExecuteSP_INV("spUsuario", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            GetPregutaRespuesta = dataList
        End Function

        Public Shared Function CambiarPswUsuario( _
            ByVal id As Integer, _
            ByVal stringValues As String) As String

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 201, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, Session("UserId"), 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)
            CambiarPswUsuario = ExecuteSP_INV("spUsuario", parameters, dt)
        End Function

        Public Shared Function ChangePregutaRespuesta( _
            ByVal idUsuario As Integer, _
            ByVal stringValues As String) As String

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 202, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, idUsuario, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)
            ChangePregutaRespuesta = ExecuteSP_INV("spUsuario", parameters, dt)
        End Function

        Public Shared Function ResetPswUsuario( _
            ByVal id As Integer) As List(Of String)

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 204, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 8)

            Dim resMessage As String = ExecuteSP_INV("spUsuario", parameters, dt)
            If (String.IsNullOrEmpty(resMessage)) Then
                dataList = New List(Of String)
                For Each row As DataRow In dt.Rows
                    If dataList Is Nothing Then dataList = New List(Of String)
                    dataList.Add(row.Item("record"))
                Next
            End If
            ResetPswUsuario = dataList
        End Function

#End Region

#Region "Translate"

        Public Shared Function GetCaptionTranslate( _
            ByVal language As String) As Dictionary(Of String, String)

            Dim dt As New DataTable
            Dim parameters As New ArrayList
            Dim elenco As New Dictionary(Of String, String)

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 1, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Language", SqlDbType.VarChar, language, 2)
            Dim resMessage As String = ExecuteSP_INV("spGetTranslate", parameters, dt, 0, False)
            If (String.IsNullOrEmpty(resMessage)) Then
                For Each dr As DataRow In dt.Rows
                    elenco.Add(dr("KeyCaption"), dr("ValueCaptio"))
                Next
            End If
            GetCaptionTranslate = elenco
        End Function

        Public Shared Function GetMessageTranslate( _
            ByVal language As String) As Dictionary(Of String, String)

            Dim dt As New DataTable
            Dim parameters As New ArrayList
            Dim elenco As New Dictionary(Of String, String)

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 2, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Language", SqlDbType.VarChar, language, 2)
            Dim resMessage As String = ExecuteSP_INV("spGetTranslate", parameters, dt, 0, False)
            If (String.IsNullOrEmpty(resMessage)) Then
                For Each dr As DataRow In dt.Rows
                    elenco.Add(dr("KeyMessage"), dr("ValueMessage"))
                Next
            End If
            GetMessageTranslate = elenco
        End Function

#End Region

#Region "Fotogallery, Img, Logo"

        Public Shared Function GetImages( _
            ByVal id As Integer, _
            ByVal tableName As String, _
            Optional ByVal queryType As Integer = 500) As String

            Dim dataList As List(Of String) = Nothing
            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, queryType, 4)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.Int, id, 4)

            GetImages = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt).Trim()
        End Function

        Public Shared Sub SaveImages( _
            ByVal id As Long, _
            ByVal tableName As String, _
            ByVal stringValues As String, _
            Optional ByVal queryType As Integer = 200)

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, queryType, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.BigInt, id, 0)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@StringValues", SqlDbType.VarChar, stringValues, -1)

            ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
        End Sub

        Public Shared Function GetProxNumImg( _
            ByVal id As Long, _
            ByVal tableName As String) As Integer

            Dim dt As New DataTable
            Dim parameters As New ArrayList

            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@QueryType", SqlDbType.Int, 4000, 8)
            SqlServer.StoredProcUtility.AddInputParameter(parameters, "@Id", SqlDbType.BigInt, id, 0)

            GetProxNumImg = ExecuteSP_INV(String.Format("sp{0}", tableName), parameters, dt)
        End Function

#End Region

    End Class

End Namespace
