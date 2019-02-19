Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class ProductCategory
    Inherits System.Web.UI.Page
    Dim productCounter As Integer = 0

    Private Sub checkLoginStatus()
        If HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
            Response.Redirect("/login")
        End If
    End Sub

    Private Sub countProductsFromQuery()
        Dim strCategory As String = Me.Page.RouteData.Values("category")
        strCategory = strCategory.Replace("-", " ")
        Dim myQuery As String = String.Empty

        If strCategory = "all" Then
            myQuery = "SELECT COUNT(ID) as itemCount FROM products WHERE status = 'active'"
        Else
            myQuery = "SELECT COUNT(ID) as itemCount FROM products WHERE category = @category and status = 'active'"
        End If

        Dim query As String = myQuery
        Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
        Using con As New MySqlConnection(conString)
            Using cmd As New MySqlCommand(query)
                Using sda As New MySqlDataAdapter()
                    cmd.Parameters.AddWithValue("@category", strCategory)
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    Using dt As New DataTable()
                        sda.Fill(dt)
                        If dt.Rows.Count > 0 Then
                            productCounter = dt.Rows(0)("itemCount").ToString
                        End If
                    End Using
                End Using
            End Using
        End Using
    End Sub

    Private Sub ProductCategory_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            'Me.checkLoginStatus
            Me.bindProducts()
        End If
    End Sub

    Private Sub bindProducts()
        Try
            Dim strCategory As String = Me.Page.RouteData.Values("category")
            strCategory = strCategory.Replace("-", " ")
            Dim myQuery As String = String.Empty

            If strCategory = "all" Then
                myQuery = "SELECT item_name, ID, slug, category, brandName, main_image, mrp, our_price, quantity, discountOff FROM products WHERE status = 'active' ORDER BY ID DESC"
            Else
                myQuery = "SELECT item_name, ID, slug, category, brandName, main_image, mrp, our_price, quantity, discountOff FROM products WHERE category = @category and status = 'active' ORDER BY ID DESC"
            End If

            Dim str As String = myQuery
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Dim con As New MySqlConnection(conString)
            Dim cmd As New MySqlCommand(str)
            cmd.Parameters.AddWithValue("@category", strCategory)
            con.Open()
            Dim da As New MySqlDataAdapter()
            cmd.Connection = con
            da.SelectCommand = cmd
            Dim dt As New DataTable()
            da.Fill(dt)
            ViewState("products") = dt
            products.DataSource = dt
            products.DataBind()
            con.Close()
            countProductsFromQuery()
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub
End Class
