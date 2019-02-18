Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class productCategory
    Inherits System.Web.UI.Page
    Dim UTCTime As DateTime = Date.UtcNow
    Dim IndianTime As DateTime = UTCTime.AddHours(5.5)
    Dim RedefinedTime As DateTime = DateTime.Parse(IndianTime)
    Dim RedefinedDate As DateTime = DateTime.Parse(IndianTime)

    Private Sub checkLoginStatus()
        If HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
            Response.Redirect("/welcome")
        End If
    End Sub

    Private Sub productCategory_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            'Me.checkLoginStatus()
            'Me.getUsersDetails()
            Me.BindCartItems()
            'Me.calculateShippingCharges()
        End If
    End Sub

    Private Sub BindCartItems()
        Try
            Dim str As String = "select *,quantity*amount as total_item_cost from orders where cookieID = @cookieID and status = @status"
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Dim con As New MySqlConnection(conString)
            Dim cmd As New MySqlCommand(str)
            cmd.Parameters.AddWithValue("@status", "In Cart")
            cmd.Parameters.AddWithValue("@cookieID", Request.Cookies("myCart").Value)
            cmd.Parameters.AddWithValue("@userID", userID.Text)
            con.Open()
            Dim da As New MySqlDataAdapter()
            cmd.Connection = con
            da.SelectCommand = cmd
            Dim dt As New DataTable()
            da.Fill(dt)
            cartItems2.DataSource = dt
            cartItems2.DataBind()
            Me.sumCart2Total()
            cart2Count.Text = dt.Rows.Count.ToString
            con.Close()

            If cart2Count.Text <= 0 Then
                pnlEmptyCart.Visible = True
                pnlCartUI2.Visible = False
            End If
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub getUsersDetails()
        Try
            If Not HttpContext.Current.Request.Cookies("userLogin") Is Nothing Then
                Dim userName As String = Request.Cookies("userLogin").Value
                Dim query As String = "SELECT ID, username FROM users WHERE username = @username or email = @username"
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

    Private Sub cartItems2_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles cartItems2.ItemDataBound
        If e.Item.ItemType = ListViewItemType.DataItem Then
            If TryCast(e.Item.FindControl("quantity"), TextBox).Text = "1" Then
                TryCast(e.Item.FindControl("btnMinus"), LinkButton).Enabled = False
            End If
            Dim newPrice As Integer = DirectCast(e.Item.FindControl("item_price"), Label).Text
            Dim mrpPrice As Integer = DirectCast(e.Item.FindControl("mrp"), Label).Text
            Dim quantity As Integer = DirectCast(e.Item.FindControl("quantity"), TextBox).Text
            Dim baseshippingCharge As Integer = TryCast(e.Item.FindControl("baseShippingCharges"), Label).Text
            Dim shippingCharge As Integer = (baseshippingCharge * quantity)
            TryCast(e.Item.FindControl("lblShippingCharges"), Label).Text = shippingCharge
            Dim gst As Integer = 0
            Dim totalPrice As Integer = 0
            'Dim gstPercent As String = TryCast(e.Item.FindControl("lblgstPercent"), Label).Text

            Dim saving As Integer = 0
            'Dim lblGSTprice As String = TryCast(e.Item.FindControl("lblGSTprice"), Label).Text
            'If String.IsNullOrEmpty(lblGSTprice) OrElse lblGSTprice = 0 Then
            '    Dim mrpTotal As Integer = mrpPrice * quantity
            Dim newTotal As Integer = newPrice * quantity
            '    gst = (newTotal * (gstPercent / 100))
            totalPrice = newTotal + shippingCharge
            '    saving = mrpTotal - newTotal
            '    DirectCast(e.Item.FindControl("saving"), Label).Text = saving

            '    TryCast(e.Item.FindControl("lblGSTprice"), Label).Text = gst
            'End If

            TryCast(e.Item.FindControl("total_price"), Label).Text = totalPrice
        End If
    End Sub

    Private Sub sumCart2Total()
        Dim intCart2Subtotal As Integer = 0
        Dim productTotalWithoutGst As Integer = 0
        Dim productTotal As Integer = 0
        Dim shippingRule As String = ""
        Dim shippingRuleCharge As Integer = 0
        Dim shippingRuleValue As Integer = 0
        Dim totalGST As Integer = 0
        For Each itm As ListViewDataItem In cartItems2.Items
            productTotal += TryCast(itm.FindControl("total_price"), Label).Text
            'productTotalWithoutGst += (TryCast(itm.FindControl("item_price"), Label).Text * TryCast(itm.FindControl("quantity"), TextBox).Text)
            shippingRule = TryCast(itm.FindControl("shippingRule"), Label).Text
            If shippingRule = "yes" OrElse shippingRule = "Yes" Then
                shippingRuleValue = 0
                shippingRuleCharge += Val(TryCast(itm.FindControl("lblShippingCharges"), Label).Text)
            Else
                shippingRuleValue += 1
            End If
            'totalGST += TryCast(itm.FindControl("lblGSTprice"), Label).Text
        Next
        cart2Subtotal.Text = productTotal
        cart2summarySubtotal.Text = productTotal - shippingRuleCharge

        'cart2TotalGST.Text = totalGST


        If shippingRuleValue = 0 Then
            cart2summaryshippingCharges.Text = shippingRuleCharge
        Else
            If productTotal >= 500 Then
                cart2summaryshippingCharges.Text = 0 + shippingRuleCharge
            Else
                cart2summaryshippingCharges.Text = Val(lblShippingCharges.Text) + shippingRuleCharge
            End If
        End If

        Session("totalShippingCharge") = cart2summaryshippingCharges.Text
        If cart2summaryshippingCharges.Text = 0 Then
            cart2summaryshippingCharges.Visible = False
            cart2Summaryfreeshipping.Visible = True
        Else
            cart2summaryshippingCharges.Visible = True
            cart2Summaryfreeshipping.Visible = False
        End If

        cart2FinalAmount.Text = (productTotal + cart2summaryshippingCharges.Text) - cart2summaryDiscount.Text
    End Sub

    Private Sub cartItems2_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles cartItems2.ItemCommand
        Dim ID As Integer = e.CommandArgument
        If e.CommandName = "Remove Item" Then
            Try
                Dim con As New MySqlConnection
                Dim cmd As New MySqlCommand
                con.ConnectionString = ConfigurationManager.ConnectionStrings("conio").ConnectionString()
                cmd.Connection = con
                con.Open()
                cmd.CommandText = "DELETE FROM orders WHERE ID = @ID"
                cmd.Parameters.AddWithValue("@ID", ID)
                cmd.ExecuteNonQuery()
                con.Close()
                Me.BindCartItems()
                If Not String.IsNullOrEmpty(txtCoupon.Text) Then
                    Me.applyCouponCode()
                End If
                Me.sumCart2Total()
            Catch ex As Exception
                Response.Write(ex)
            End Try
        End If

        Dim costPrice As String = TryCast(e.Item.FindControl("costPrice"), Label).Text
        Dim purchasePrice As String = String.Empty
        If e.CommandName = "incrementButton" Then
            Dim userQty As Integer = 0
            Dim maxOrderQty As Integer = 0

            userQty = TryCast(e.Item.FindControl("quantity"), TextBox).Text
            maxOrderQty = TryCast(e.Item.FindControl("maxQty"), Label).Text

            If Not userQty > maxOrderQty Then
                Try
                    If String.IsNullOrEmpty(costPrice) Then
                        costPrice = 0
                    End If
                    Dim quantity As Integer = 0
                    Dim price As Integer = 0
                    Dim totalAmount As Integer = 0
                    price = TryCast(e.Item.FindControl("item_price"), Label).Text
                    quantity = Val(TryCast(e.Item.FindControl("quantity"), TextBox).Text) + 1 - 1
                    totalAmount = price * quantity
                    purchasePrice = costPrice * quantity
                    Dim con As New MySqlConnection
                    Dim cmd As New MySqlCommand
                    con.ConnectionString = ConfigurationManager.ConnectionStrings("conio").ConnectionString()
                    cmd.Connection = con
                    con.Open()
                    cmd.CommandText = "UPDATE orders Set quantity = @quantity, costPrice = @costPrice, purchasePrice = @purchasePrice, total_amount = @totalAmount WHERE ID = @ID"
                    cmd.Parameters.AddWithValue("@quantity", quantity)
                    cmd.Parameters.AddWithValue("@totalAmount", totalAmount)
                    cmd.Parameters.AddWithValue("@costPrice", costPrice)
                    cmd.Parameters.AddWithValue("@purchasePrice", purchasePrice)
                    cmd.Parameters.AddWithValue("@ID", ID)
                    cmd.ExecuteNonQuery()
                    con.Close()
                    Me.BindCartItems()
                    If Not String.IsNullOrEmpty(txtCoupon.Text) Then
                        Me.applyCouponCode()
                    End If
                    Me.sumCart2Total()
                Catch ex As Exception
                    Response.Write(ex)
                End Try
            End If
        End If

        If e.CommandName = "decrementButton" Then
            If DirectCast(e.Item.FindControl("quantity"), TextBox).Text = "1" Then
                DirectCast(e.Item.FindControl("btnMinus"), LinkButton).Enabled = False
            Else
                Try
                    If String.IsNullOrEmpty(costPrice) Then
                        costPrice = 0
                    End If
                    Dim quantity As Integer = 0
                    Dim price As Integer = 0
                    Dim totalAmount As Integer = 0
                    price = TryCast(e.Item.FindControl("item_price"), Label).Text
                    quantity = Val(TryCast(e.Item.FindControl("quantity"), TextBox).Text) - 1
                    totalAmount = price * quantity
                    purchasePrice = costPrice * quantity
                    Dim con As New MySqlConnection
                    Dim cmd As New MySqlCommand
                    con.ConnectionString = ConfigurationManager.ConnectionStrings("conio").ConnectionString()
                    cmd.Connection = con
                    con.Open()
                    cmd.CommandText = "UPDATE orders Set quantity = @quantity, costPrice = @costPrice, purchasePrice = @purchasePrice, total_amount = @totalAmount WHERE ID = @ID"
                    cmd.Parameters.AddWithValue("@quantity", quantity)
                    cmd.Parameters.AddWithValue("@costPrice", costPrice)
                    cmd.Parameters.AddWithValue("@purchasePrice", purchasePrice)
                    cmd.Parameters.AddWithValue("@totalAmount", totalAmount)
                    cmd.Parameters.AddWithValue("@ID", ID)
                    cmd.ExecuteNonQuery()
                    con.Close()
                    Me.BindCartItems()
                    If Not String.IsNullOrEmpty(txtCoupon.Text) Then
                        Me.applyCouponCode()
                    End If
                    Me.sumCart2Total()
                Catch ex As Exception
                    Response.Write(ex)
                End Try
            End If
        End If

        If e.CommandName = "changeQty" Then
            ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "Pop", "openQtyModal();", True)
            productID.Text = ID
            Dim query As String = "SELECT quantity FROM orders WHERE item_ID = @itemID and cookieID = @cookieID"
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Using con As New MySqlConnection(conString)
                Using cmd As New MySqlCommand(query)
                    Using sda As New MySqlDataAdapter()
                        cmd.Parameters.AddWithValue("@itemID", productID.Text)
                        cmd.Parameters.AddWithValue("@cookieID", Request.Cookies("myCart").Value)
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dt As New DataTable()
                            sda.Fill(dt)
                            If dt.Rows.Count > 0 Then
                                quantity.Text = dt.Rows(0)("quantity").ToString
                            End If
                        End Using
                    End Using
                End Using
            End Using
            Me.getProductDetails()
        End If
    End Sub

    'Protected Sub quantity_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
    '    Dim quantity As DropDownList = CType(sender, DropDownList)
    '    Dim cartItems2 As ListViewItem = CType(quantity.NamingContainer, ListViewItem)
    '    Dim getQTYList As DropDownList = CType(cartItems2.FindControl("quantity"), DropDownList)
    'End Sub

    Protected Sub applyCouponCode()
        Try
            Dim myDate As New Label
            Dim mySubtotal As Integer = cart2Subtotal.Text
            Dim itemTotal As Integer = 0
            Dim minimumVal As Integer = 0
            Dim customerDiscount As Integer = 0
            Dim masterDiscount As Integer = 0
            For Each item As ListViewDataItem In cartItems2.Items
                Dim myItemID As String = TryCast(item.FindControl("itemID"), Label).Text
                itemTotal = TryCast(item.FindControl("total_price"), Label).Text

                Dim query As String = "SELECT * FROM coupons WHERE item_ID = @itemID AND status = 'active' AND expiry_date >= CURDATE() AND code = @code"
                Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
                Using con As New MySqlConnection(conString)
                    Using cmd As New MySqlCommand(query)
                        Using sda As New MySqlDataAdapter()
                            cmd.Parameters.AddWithValue("@itemID", myItemID)
                            cmd.Parameters.AddWithValue("@code", txtCoupon.Text)
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dt As New DataTable()
                                sda.Fill(dt)
                                If dt.Rows.Count > 0 Then
                                    minimumVal = dt.Rows(0)("minimum_spend").ToString
                                    Dim discountPercent As Integer = dt.Rows(0)("discount").ToString
                                    Dim discountCode As String = dt.Rows(0)("code").ToString
                                    If mySubtotal >= minimumVal AndAlso txtCoupon.Text = discountCode Then
                                        customerDiscount = itemTotal * discountPercent / 100
                                        masterDiscount += customerDiscount
                                        TryCast(item.FindControl("ifCouponapplies"), Panel).Visible = True
                                        TryCast(item.FindControl("discountAmount"), Label).Text = customerDiscount
                                    End If
                                Else
                                    lblInvalidCoupon.Visible = True
                                End If
                            End Using
                        End Using
                    End Using
                End Using
            Next

            'Dim cart2SummaryTotal As Integer = cart2summarySubtotal.Text
            'If cart2SummaryTotal >= lblShippingCharges.Text Then
            '    cart2summaryshippingCharges.Text = lblShippingCharges.Text
            'Else
            '    cart2summaryshippingCharges.Text = 0
            'End If

            Me.sumCart2Total()
            cart2Subtotal.Text = mySubtotal
            cart2summaryDiscount.Text = masterDiscount
            cart2FinalAmount.Text = cart2FinalAmount.Text - masterDiscount
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub calculateShippingCharges()
        Dim cart2SummaryTotal As Integer = cart2summarySubtotal.Text
        If cart2SummaryTotal >= 500 Then
            cart2summaryshippingCharges.Text = 0
        Else
            cart2summaryshippingCharges.Text = lblShippingCharges.Text
        End If
    End Sub

    Protected Sub btnCart2Checkout()
        Try
            Dim myCookieID As String = Request.Cookies("myCart").Value
            For Each item As ListViewDataItem In cartItems2.Items
                Dim myTotalAmount As Integer = 0
                myTotalAmount = TryCast(item.FindControl("total_price"), Label).Text

                Dim myDiscount As Integer = 0
                myDiscount = TryCast(item.FindControl("discountAmount"), Label).Text


                Dim finalTotalAmount As Integer = myTotalAmount - myDiscount
                Dim productShippingCharge As String = TryCast(item.FindControl("lblShippingCharges"), Label).Text

                Dim myItemID As String = TryCast(item.FindControl("itemID"), Label).Text
                Dim con As New MySqlConnection
                Dim cmd As New MySqlCommand
                con.ConnectionString = ConfigurationManager.ConnectionStrings("conio").ConnectionString()
                cmd.Connection = con
                con.Open()
                cmd.CommandText = "UPDATE orders Set coupon_code = @couponCode, coupon_discount = @couponDiscount, gstPrice = @gstPrice , total_amount = @totalAmount WHERE cookieID = @cookieID and item_ID = @itemID and shippingRule = 'no'"
                cmd.Parameters.AddWithValue("@couponCode", txtCoupon.Text)
                cmd.Parameters.AddWithValue("@couponDiscount", TryCast(item.FindControl("discountAmount"), Label).Text)
                cmd.Parameters.AddWithValue("@gstPrice", "0")
                cmd.Parameters.AddWithValue("@shippingCharges", productShippingCharge)
                cmd.Parameters.AddWithValue("@totalAmount", finalTotalAmount)
                cmd.Parameters.AddWithValue("@cookieID", myCookieID)
                cmd.Parameters.AddWithValue("@itemID", TryCast(item.FindControl("itemID"), Label).Text)
                cmd.ExecuteNonQuery()
                con.Close()
            Next
            Response.Redirect("/checkout")
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Private Sub chkGiftWrapping_CheckedChanged(sender As Object, e As EventArgs) Handles chkGiftWrapping.CheckedChanged
        Dim masterpay As Integer = cart2FinalAmount.Text
        If chkGiftWrapping.Checked = True Then
            pnlGiftTxt.Visible = True
            lblGiftWrapCost.Text = 50
            pnlGwrapping.Visible = True
            cart2FinalAmount.Text = Val(masterpay) + 50
            Session("giftwrapping") = "yes"
            Session("giftwrappingCost") = 50
            Session("giftwrappingMsg") = giftMessage.Text
        Else
            pnlGiftTxt.Visible = False
            pnlGwrapping.Visible = False
            cart2FinalAmount.Text = Val(masterpay) - 50
            Session("giftwrapping") = "no"
            Session("giftwrappingCost") = 0
            Session("giftwrappingMsg") = giftMessage.Text
        End If
    End Sub

    Protected Sub addCartFunction()

    End Sub

    Private Sub getProductDetails()
        Try
            Dim sizing As String = String.Empty
            Dim query As String = "SELECT * FROM products WHERE (visible = 'bulk' or visible = 'both') and ID = @ID and status = 'active'"
            Dim conString As String = ConfigurationManager.ConnectionStrings("conio").ConnectionString
            Using con As New MySqlConnection(conString)
                Using cmd As New MySqlCommand(query)
                    Using sda As New MySqlDataAdapter()
                        cmd.Parameters.AddWithValue("@ID", productID.Text)
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dt As New DataTable()
                            sda.Fill(dt)
                            If dt.Rows.Count > 0 Then
                                productID.Text = dt.Rows(0)("ID").ToString
                                productImage.ImageUrl = dt.Rows(0)("main_image").ToString
                                productTitle.Text = dt.Rows(0)("item_name").ToString
                                brandTitle.Text = dt.Rows(0)("brandName").ToString
                                sellingPrice.Text = dt.Rows(0)("our_price").ToString
                                mrp.Text = dt.Rows(0)("mrp").ToString
                                discountPercent.Text = dt.Rows(0)("discountOff").ToString
                                moq.Text = dt.Rows(0)("moq").ToString

                                'quantity.Text = moq.Text
                                maxQty.Text = dt.Rows(0)("maxOrderQty").ToString

                                If Not sellingPrice.Text = "0" Then
                                    mrp.Text = dt.Rows(0)("mrp").ToString
                                    moq.Text = dt.Rows(0)("moq").ToString
                                    'quantity.Text = "1"

                                    Dim differenceDiscount As Integer = mrp.Text - sellingPrice.Text
                                    Dim discount As Integer = differenceDiscount / mrp.Text * 100

                                    qty1Range.Text = dt.Rows(0)("quantity1").ToString
                                    qty2Range.Text = Val(dt.Rows(0)("quantity1").ToString) + 1 & " - " & dt.Rows(0)("quantity2").ToString

                                    qty3Range.Text = Val(dt.Rows(0)("quantity2").ToString) + 1 & " - " & dt.Rows(0)("quantity3").ToString

                                    qty4Range.Text = Val(dt.Rows(0)("quantity3").ToString) + 1 & " - " & dt.Rows(0)("quantity4").ToString
                                    qty5Range.Text = dt.Rows(0)("quantity5").ToString
                                    qty6Range.Text = dt.Rows(0)("quantity6").ToString

                                    qty1.Text = dt.Rows(0)("quantity1")
                                    qty2.Text = dt.Rows(0)("quantity2")
                                    qty3.Text = dt.Rows(0)("quantity3")
                                    qty4.Text = dt.Rows(0)("quantity4")
                                    qty5.Text = dt.Rows(0)("quantity5")
                                    qty6.Text = dt.Rows(0)("quantity6")

                                    time1.Text = dt.Rows(0)("time1").ToString
                                    time2.Text = dt.Rows(0)("time2").ToString
                                    time3.Text = dt.Rows(0)("time3").ToString
                                    time4.Text = dt.Rows(0)("time4").ToString
                                    time5.Text = dt.Rows(0)("time5").ToString
                                    time6.Text = dt.Rows(0)("time6").ToString


                                    discountPrice1.Text = dt.Rows(0)("discountPrice1").ToString
                                    discountPrice2.Text = dt.Rows(0)("discountPrice2").ToString
                                    discountPrice3.Text = dt.Rows(0)("discountPrice3").ToString
                                    discountPrice4.Text = dt.Rows(0)("discountPrice4").ToString
                                    discountPrice5.Text = dt.Rows(0)("discountPrice5").ToString
                                    discountPrice6.Text = dt.Rows(0)("discountPrice6").ToString

                                    Dim difference1 As Integer = mrp.Text - discountPrice1.Text
                                    Dim discount1 As Integer = difference1 / mrp.Text * 100
                                    discountPercent1.Text = discount1.ToString + "%"

                                    Dim difference2 As Integer = mrp.Text - discountPrice2.Text
                                    Dim discount2 As Integer = difference2 / mrp.Text * 100
                                    discountPercent2.Text = discount2.ToString + "%"

                                    Dim difference3 As Integer = mrp.Text - discountPrice3.Text
                                    Dim discount3 As Integer = difference3 / mrp.Text * 100
                                    discountPercent3.Text = discount3.ToString + "%"

                                    Dim difference4 As Integer = mrp.Text - discountPrice4.Text
                                    Dim discount4 As Integer = difference4 / mrp.Text * 100
                                    discountPercent4.Text = discount4.ToString + "%"

                                    Dim difference5 As Integer = mrp.Text - discountPrice5.Text
                                    Dim discount5 As Integer = difference5 / mrp.Text * 100
                                    discountPercent5.Text = discount5.ToString + "%"

                                    Dim difference6 As Integer = mrp.Text - discountPrice6.Text
                                    Dim discount6 As Integer = difference6 / mrp.Text * 100
                                    discountPercent6.Text = discount6.ToString + "%"


                                    If qty1.Text = 0 Then
                                        tdQty1.Visible = False
                                        tdPrice1.Visible = False
                                        tdTime1.Visible = False
                                        tdSave1.Visible = False
                                    End If

                                    If qty2.Text = 0 Then
                                        tdQty2.Visible = False
                                        tdPrice2.Visible = False
                                        tdTime2.Visible = False
                                        tdSave2.Visible = False
                                        discountPrice2.Text = discountPrice1.Text
                                    End If

                                    If qty3.Text = 0 Then
                                        tdQty3.Visible = False
                                        tdPrice3.Visible = False
                                        tdTime3.Visible = False
                                        tdSave3.Visible = False
                                        discountPrice3.Text = discountPrice2.Text
                                    End If

                                    If qty4.Text = 0 Then
                                        tdQty4.Visible = False
                                        tdPrice4.Visible = False
                                        tdTime4.Visible = False
                                        tdSave4.Visible = False
                                        discountPrice4.Text = discountPrice3.Text
                                    End If

                                    If qty5.Text = 0 Then
                                        tdQty5.Visible = False
                                        tdPrice5.Visible = False
                                        tdTime5.Visible = False
                                        tdSave5.Visible = False
                                        discountPrice5.Text = discountPrice4.Text
                                    End If

                                    If qty6.Text = 0 Then
                                        tdQty6.Visible = False
                                        tdPrice6.Visible = False
                                        tdTime6.Visible = False
                                        tdSave6.Visible = False
                                        discountPrice6.Text = discountPrice5.Text
                                    End If

                                    If qty2.Text.Contains("+") Then
                                        qty2Range.Text = "Above " & qty2.Text.Replace("+", " ")

                                    ElseIf qty3.Text.Contains("+") Then
                                        qty3Range.Text = "Above " & qty3.Text.Replace("+", " ")

                                    ElseIf qty4.Text.Contains("+") Then
                                        qty4Range.Text = "Above " & qty4.Text.Replace("+", " ")

                                    ElseIf qty5.Text.Contains("+") Then
                                        qty5Range.Text = "Above " & qty5.Text.Replace("+", " ")

                                    ElseIf qty6.Text.Contains("+") Then
                                        qty6Range.Text = "Above " & qty6.Text.Replace("+", " ")
                                    End If
                                End If

                                stock.Text = dt.Rows(0)("quantity").ToString
                                sizing = dt.Rows(0)("size_variant").ToString
                            End If
                        End Using
                    End Using
                End Using
            End Using
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub

    Protected Sub changeQuantity()
        Try
            Dim intQuantity As Integer = quantity.Text
            Dim intMOQ As Integer = moq.Text
            If intQuantity >= intMOQ Then

                If qty2.Text = 0 Then
                    qty2.Text = qty1.Text
                    time2.Text = time1.Text
                End If

                If qty3.Text = 0 Then
                    qty3.Text = qty2.Text
                    time3.Text = time2.Text
                End If

                If qty4.Text = 0 Then
                    qty4.Text = qty3.Text
                    time4.Text = time3.Text
                End If

                If qty5.Text = 0 Then
                    qty5.Text = qty4.Text
                    time5.Text = time4.Text
                End If

                If qty6.Text = 0 Then
                    qty6.Text = qty5.Text
                    time6.Text = time5.Text
                End If

                Dim deliveryTimeSlab As String = String.Empty
                Dim calculatedPrice As Integer = 0
                Dim selectedQuantity As Integer = quantity.Text
                If selectedQuantity <= qty1.Text AndAlso selectedQuantity < qty2.Text Then
                    calculatedPrice = discountPrice1.Text
                    deliveryTimeSlab = time1.Text

                ElseIf selectedQuantity <= qty2.Text AndAlso selectedQuantity < qty3.Text Then
                    calculatedPrice = discountPrice2.Text
                    deliveryTimeSlab = time2.Text

                ElseIf selectedQuantity <= qty3.Text AndAlso selectedQuantity < qty4.Text Then
                    calculatedPrice = discountPrice3.Text
                    deliveryTimeSlab = time3.Text

                ElseIf selectedQuantity <= qty4.Text AndAlso selectedQuantity < qty5.Text Then
                    calculatedPrice = discountPrice4.Text
                    deliveryTimeSlab = time4.Text

                ElseIf selectedQuantity <= qty5.Text AndAlso selectedQuantity < qty6.Text Then
                    calculatedPrice = discountPrice5.Text
                    deliveryTimeSlab = time5.Text

                ElseIf selectedQuantity >= qty6.Text Then
                    calculatedPrice = discountPrice6.Text
                    deliveryTimeSlab = time6.Text
                End If

                Dim totalAmount As Integer = 0
                totalAmount = calculatedPrice * selectedQuantity

                Dim cookieID As String = Request.Cookies("myCart").Value
                Dim myDate As New Label
                Dim myTime As New Label
                myTime.Text = RedefinedTime.ToString("hh:mm tt")
                myDate.Text = RedefinedDate.ToString("dd/MM/yy")

                Dim con As New MySqlConnection
                Dim cmd As New MySqlCommand
                con.ConnectionString = ConfigurationManager.ConnectionStrings("conio").ConnectionString()
                cmd.Connection = con
                con.Open()
                cmd.CommandText = "UPDATE orders Set quantity = @quantity, amount = @amount, total_amount = @totalAmount WHERE cookieID = @cookieID and item_ID = @itemID"
                cmd.Parameters.AddWithValue("@quantity", quantity.Text)
                cmd.Parameters.AddWithValue("@amount", calculatedPrice)
                cmd.Parameters.AddWithValue("@totalAmount", totalAmount)
                cmd.Parameters.AddWithValue("@cookieID", Request.Cookies("myCart").Value)
                cmd.Parameters.AddWithValue("@itemID", productID.Text)
                cmd.ExecuteNonQuery()
                con.Close()
                Me.BindCartItems()
                Me.applyCouponCode()
            End If
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub
End Class
