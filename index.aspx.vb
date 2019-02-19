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
            Me.bindCategory()
        End If
    End Sub

    Private Sub bindCategory()
        Try
            Dim str As String = "SELECT * FROM category WHERE status = 'active' AND showHomePage = 'Yes' ORDER BY position"
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Dim con As New MySqlConnection(conString)
            Dim cmd As New MySqlCommand(str)
            con.Open()
            Dim da As New MySqlDataAdapter()
            cmd.Connection = con
            da.SelectCommand = cmd
            Dim dt As New DataTable()
            da.Fill(dt)
            lvCategoriesSection.DataSource = dt
            lvCategoriesSection.DataBind()
            con.Close()
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub lvCategoriesSection_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvCategoriesSection.ItemDataBound
        Dim lvCategoryProduct As ListView = TryCast(e.Item.FindControl("lvCategoryProduct"), ListView)
        Dim categoryName As Label = TryCast(e.Item.FindControl("categoryName"), Label)

        Dim str As String = "SELECT item_name, ID, slug, category, brandName, main_image, our_price, mrp, quantity, discountOff FROM products WHERE category = @category and status = 'active' ORDER BY ID DESC LIMIT 6"
        Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
        Dim con As New MySqlConnection(conString)
        Dim cmd As New MySqlCommand(str)
        cmd.Parameters.AddWithValue("@category", categoryName.Text)
        con.Open()
        Dim da As New MySqlDataAdapter()
        cmd.Connection = con
        da.SelectCommand = cmd
        Dim dt As New DataTable()
        da.Fill(dt)
        lvCategoryProduct.DataSource = dt
        lvCategoryProduct.DataBind()
        con.Close()
    End Sub
End Class
