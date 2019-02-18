Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class index
    Inherits System.Web.UI.Page

    Private Sub checkLoginStatus()
        If HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
            Response.Redirect("/welcome")
        End If
    End Sub

    Private Sub bindSliders()
        Try
            Dim str As String = "SELECT * FROM sliders WHERE status = 'active' ORDER BY position"
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Dim con As New MySqlConnection(conString)
            Dim cmd As New MySqlCommand(str)
            con.Open()
            Dim da As New MySqlDataAdapter()
            cmd.Connection = con
            da.SelectCommand = cmd
            Dim dt As New DataTable()
            da.Fill(dt)
            sSlider.DataSource = dt
            sSlider.DataBind()
            con.Close()
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub index_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            'Me.checkLoginStatus()
            Me.bindSliders()
        End If
    End Sub
End Class
