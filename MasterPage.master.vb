Imports System.Data
Imports System.Net.Mail
Imports MySql.Data.MySqlClient
Partial Class MasterPage
    Inherits System.Web.UI.MasterPage
    Private Sub checkLoginStatus()
        If HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
            Response.Redirect("/welcome")
        End If
    End Sub

    Private Sub MasterPage_Load(sender As Object, e As EventArgs) Handles Me.Load
        If HttpContext.Current.Request.Cookies("myCart") Is Nothing Then
            Me.autogenerateCookie()
        End If

        If Not Me.IsPostBack Then
            Me.bindMenus()
            Me.loginStatus()
        End If
    End Sub

    Private Sub loginStatus()
        If Not HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
            btnLogout.Visible = True
            mobilebtnLogout.Visible = True

            mobilebtnLogin.Visible = False

            welcome.Visible = True
            mobilebtnAccount.Visible = True
            Me.getUsersDetails()
        Else
            btnLogout.Visible = False
            mobilebtnLogout.Visible = False

            mobilebtnLogin.Visible = True

            linkLogin.Visible = True
            welcome.Visible = False
            mobilebtnAccount.Visible = False
        End If
    End Sub

    Private Sub getUsersDetails()
        Try
            If Not HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
                Dim userName As String = Request.Cookies("userLogin").Value
                Dim query As String = "SELECT ID, username, firstName FROM users WHERE username = @username or email = @username"
                Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
                Using con As New MySqlConnection(conString)
                    Using cmd As New MySqlCommand(query)
                        Using sda As New MySqlDataAdapter()
                            cmd.Parameters.AddWithValue("@username", userName)
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dt As New DataTable()
                                sda.Fill(dt)
                                If dt.Rows.Count > 0 Then
                                    welcome.Text = "Welcome " + dt.Rows(0)("firstName").ToString
                                    userID.Text = dt.Rows(0)("ID").ToString
                                End If
                            End Using
                        End Using
                    End Using
                End Using
            End If
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub bindMenus()
        Try
            Dim str As String = "SELECT * FROM category WHERE status = 'active' and use_for = 'menu' ORDER BY position LIMIT 4"
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Dim con As New MySqlConnection(conString)
            Dim cmd As New MySqlCommand(str)
            con.Open()
            Dim da As New MySqlDataAdapter()
            cmd.Connection = con
            da.SelectCommand = cmd
            Dim dt As New DataTable()
            da.Fill(dt)
            responsiveMenu.DataSource = dt
            responsiveMenu.DataBind()

            lvMenus.DataSource = dt
            lvMenus.DataBind()

            footerMenu.DataSource = dt
            footerMenu.DataBind()
            con.Close()
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub autogenerateCookie()
        Dim alphabets As String = "abcdefghijklmnopqrstuvwxyz"
        Dim numbers As String = "1234567890"
        Dim length As New Label
        Dim alphanumeric As New Label

        length.Text = "10"
        alphanumeric.Text = "4"
        Dim characters As String = numbers
        If alphanumeric.Text = "4" Then
            characters += Convert.ToString(alphabets) & numbers
        End If

        Dim lengthTake As Integer = Integer.Parse(length.Text)
        Dim otp As String = String.Empty
        For i As Integer = 0 To lengthTake - 1
            Dim character As String = String.Empty
            Do
                Dim index As Integer = New Random().Next(0, characters.Length)
                character = characters.ToCharArray()(index).ToString()
            Loop While otp.IndexOf(character) <> -1
            otp += character
        Next
        cookieID.Text = otp
        Response.Cookies("myCart").Value = cookieID.Text
        Response.Cookies("myCart").Expires = DateTime.Now.AddDays(365)
    End Sub

    Private Sub getCartCount()
        Try
            Dim query As String = "select COUNT(quantity) as itemCount from orders where (cookieID = @cookieID) and status = 'In Cart' "
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Using con As New MySqlConnection(conString)
                Using cmd As New MySqlCommand(query)
                    Using sda As New MySqlDataAdapter()
                        cmd.Parameters.AddWithValue("@userID", userID.Text)
                        cmd.Parameters.AddWithValue("@cookieID", Request.Cookies("myCart").Value)
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dt As New DataTable()
                            sda.Fill(dt)
                            If dt.Rows.Count > 0 Then
                                lblCountItem.Text = dt.Rows(0)("itemCount").ToString
                                xsCartCount.Text = lblCountItem.Text
                            End If
                        End Using
                    End Using
                End Using
            End Using
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Protected Sub logout()
        Response.Cookies("userLogin").Expires = DateTime.Now.AddDays(-1)
        Response.Redirect(Request.Url.AbsoluteUri)
    End Sub

    Protected Sub search()
        Response.Redirect("/search-results?find=" + txtSearch.Text)
    End Sub

    Protected Sub mobileSearch()
        txtSearch.Text = txtMobSerach.Text
        Me.search()
    End Sub

    Private Sub MasterPage_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        Me.getCartCount()
    End Sub

    Private Sub btnCallback_Click(sender As Object, e As EventArgs) Handles btnCallback.Click
        Try
            Dim mail As New MailMessage()
            Dim SmtpServer As New SmtpClient()
            mail.To.Add("info@brandstik.com")
            mail.Bcc.Add("divya@brandstik.com, info@foxboxretail.com")
            mail.From = New MailAddress("info@brandstik.com")
            mail.Subject = "Bajaj Brandstore - New Call Back Request From " & callBackNumber.Text & ""
            mail.Body = "Call Back Number - " & callBackNumber.Text & "<br />Nature Of Request - " & requestReason.SelectedItem.ToString & "<br />Website - " & Request.Url.AbsoluteUri & ""
            mail.IsBodyHtml = True
            SmtpServer.Port = 25
            SmtpServer.Credentials = New System.Net.NetworkCredential("info@foxboxstores.com", "foxbox@2017")
            SmtpServer.Host = "relay-hosting.secureserver.net"
            SmtpServer.EnableSsl = False
            SmtpServer.Send(mail)
            pnlActionMessage.Visible = True
            pnlActionContent.Visible = False
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub
End Class

