<%@ Page Title="Shopping Cart" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="cart.aspx.vb" Inherits="productCategory" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dark-hr {
            margin: 0 !important;
            border-top: 1px solid #aaa;
        }
    </style>
        <asp:Panel ID="pnlHidden" runat="server" Visible="false">
        <asp:Label ID="preOrderID" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="userID" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="requestedBy" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="openFor" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="employeeID" runat="server"></asp:Label>
        <asp:Label ID="lblShippingCharges" runat="server" Text="40"></asp:Label>
        <!--used only for distributor-->
        <asp:Label ID="orderID" runat="server"></asp:Label>

        <asp:Label ID="qty1" runat="server"></asp:Label>
        <asp:Label ID="qty2" runat="server"></asp:Label>
        <asp:Label ID="qty3" runat="server"></asp:Label>
        <asp:Label ID="qty4" runat="server"></asp:Label>
        <asp:Label ID="qty5" runat="server"></asp:Label>
        <asp:Label ID="qty6" runat="server"></asp:Label>
    </asp:Panel>

    <div class="common-page-wrapper cart-page">
        <div class="custom-container container-fluid cart-wrapper">
            <div class="title-block border-all border-radius-normal">
                <h3 class="text-uppercase text-center padding-20">Shopping Cart</h3>
            </div>
            <p>&nbsp;</p>

            <!--distributor cart-->
            <asp:Panel ID="pnlCartUI2" runat="server">
                <div class="row">
                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                        <div class="order-details border-all border-radius-normal">
                            <div class="border-bottom">
                                <div class="row">
                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <h4 class="text-left text-uppercase padding-20">Your Order</h4>
                                </div>

                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <h4 class="text-right uppercase padding-20">
                                        <asp:Label ID="cart2Count" runat="server"></asp:Label>
                                        Item(s)</h4>
                                </div>
                            </div>
                            </div>
                            
                            <div class="clearfix"></div>

                            <div class="order-detail-section">
                                <asp:UpdatePanel ID="upGeneral" runat="server">
                                    <ContentTemplate>
                                        <asp:ListView ID="cartItems2" runat="server">
                                            <ItemTemplate>
                                                <div class="row">
                                                    <asp:Panel ID="pnlHidden" runat="server" Visible="false">
                                                        <asp:Label ID="costPrice" Text='<%# Eval("costPrice") %>' runat="server"></asp:Label>
                                                    </asp:Panel>

                                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                                        <div class="product-display padding-20">
                                                            <asp:Image ID="productImage" runat="server" ImageUrl="http://bajajallianzlife.foxboxstores.com/images/products/Royal-Blue-Collared-T-shirt-With-Tipping_161118125926.jpg" CssClass="pull-left" Width="100" />
                                                            <asp:Label ID="itemID" runat="server" Text='<%# Eval("item_ID") %>' Visible="false"></asp:Label>
                                                            <div class="product-display-data">
                                                                <h4 class="text-capitalize">
                                                                    <asp:Label ID="productName" runat="server" Text='<%# Eval("item_name") %>'></asp:Label>
                                                                </h4>

                                                                <h5 class="secondary-font"><%# Eval("brandName") %></h5>

                                                                <asp:Panel ID="ifCouponapplies" runat="server" class="text-success" Visible="false">
                                                                    <i class="fa fa-plus-circle"></i>Discount applied
                                                                </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                                                        <div class="product-display-info padding-20">
                                                            <div class="row">
                                                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3">
                                                                    <div class="cart-section-data">
                                                                        <h4 class="text-left uppercase">
                                                                            <span class="d-none">MRP</span>
                                                                            <span>Item Price</span>
                                                                        </h4>
                                                                        <span class="d-none">Rs.<asp:Label ID="mrp" runat="server" Text='<%# Eval("mrp") %>'></asp:Label></span>

                                                                        <span>Rs.<asp:Label ID="item_price" runat="server" Text='<%# Eval("amount") %>'></asp:Label></span>
                                                                    </div>
                                                                </div>



                                                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
                                                                    <div class="cart-section-data">
                                                                        <h4 class="text-left uppercase">Quantity</h4>
                                                                        <asp:Label ID="maxQty" runat="server" Text='<%# Eval("maxOrderQty") %>' Visible="false"></asp:Label>
                                                                        <asp:LinkButton ID="btnMinus" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="decrementButton" CssClass="pull-left btn-counter minus" Visible="false"><i class="fa fa-minus"></i></asp:LinkButton>
                                                                        <asp:TextBox ID="quantity" runat="server" CssClass="input-text width-half-a pull-left text-center" ClientIDMode="Static" Text='<%# Eval("quantity") %>' Enabled="false"></asp:TextBox>
                                                                        <asp:LinkButton ID="btnPlus" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="incrementButton" CssClass="pull-left btn-counter plus" Visible="false"><i class="fa fa-plus"></i></asp:LinkButton>
                                                                        <asp:LinkButton ID="btnUpdateQty" runat="server" CssClass="btn btn-link" Text="Edit" CommandName="changeQty" CommandArgument='<%# Eval("item_ID") %>'></asp:LinkButton>
                                                                    </div>
                                                                </div>


                                                                <%--<div class="col-lg-2 col-md-2 col-sm-3 col-xs-4">
                                                            <div class="cart-section-data">
                                                                <h4 class="text-left uppercase"><span>GST</span></h4>
                                                                <asp:Label ID="lblgstPercent" runat="server" Visible="false" Text='<%# Eval("gst") %>'></asp:Label>
                                                                <span>Rs.<asp:Label ID="lblGSTprice" runat="server"></asp:Label></span>
                                                            </div>
                                                        </div>--%>



                                                                <div class="col-lg-4 col-md-4 col-sm-2 col-xs-5">
                                                                    <div class="cart-section-data">
                                                                        <h4 class="text-left uppercase">
                                                                            <span class="d-none">You Save</span>
                                                                            <span>GST & Handling Charges</span>
                                                                        </h4>
                                                                        <span>Rs.<asp:Label ID="lblShippingCharge" runat="server"></asp:Label>
                                                                        </span>

                                                                        <span class="d-none">Rs.<asp:Label ID="saving" runat="server"></asp:Label>
                                                                            <asp:Label ID="discountAmount" runat="server" Visible="false" Text="0"></asp:Label>
                                                                        </span>
                                                                        <span>
                                                                            <asp:Label ID="shippingRule" runat="server" Text='<%# Eval("shippingRule") %>' Visible="false"></asp:Label>
                                                                            <asp:Label ID="baseShippingCharges" runat="server" Text='<%# Eval("shipping_charges") %>' Visible="false"></asp:Label>
                                                                            <asp:Label ID="lblShippingCharges" runat="server"></asp:Label></span>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-4">
                                                                    <div class="cart-section-data">
                                                                        <h4 class="text-left uppercase">Total Price</h4>
                                                                        Rs.<asp:Label ID="total_price" runat="server"></asp:Label>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-4">
                                                                    <div class="cart-section-data">
                                                                        <h4 class="text-left uppercase invisible">Action</h4>
                                                                        <asp:LinkButton ID="btnRemove" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="Remove Item" CssClass="text-danger" Style="text-decoration: none" ToolTip="Remove">
                                                                <i class="fa fa-remove"></i>
                                                                        </asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>

                                        <div class="coupon-panel d-none">
                                            <div class="row">
                                                <div class="col-md-4 col-sm-4 col-xs-12">
                                                </div>
                                                <div class="col-md-8 col-sm-8 col-xs-12 text-right">
                                                    <label class="cart-coupon-label" for="txtCoupon" style="width: 150px; text-align: right; position: relative">Enter Coupon Code:<br />
                                                    </label>
                                                    <asp:TextBox ID="txtCoupon" runat="server" ClientIDMode="Static" CssClass="coupon-box" autocomplete="off"></asp:TextBox>
                                                    <asp:Label ID="lblInvalidCoupon" runat="server" CssClass="block text-danger" Text="Invalid Code" Visible="false"></asp:Label>
                                                    <asp:LinkButton ID="btnApply" runat="server" Text="Apply" CssClass="coupon-button text-uppercase" OnClick="applyCouponCode"></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="order-details">
                                            <div class="row">
                                                <div class="cart-grandtotal d-none">
                                                    <div class="col-md-9 col-sm-9 col-xs-6">
                                                        <div class="product-display  text-right">
                                                            <h4>Subtotal</h4>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3 col-sm-3 col-xs-6">
                                                        <div class="product-display text-right">
                                                            <h4>Rs.
                                                    <asp:Label ID="cart2Subtotal" runat="server"></asp:Label></h4>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div>&nbsp;</div>

                        <div class="order-details border-all border-radius-normal gift-wrapping-box d-none" style="padding: 25px">
                            <asp:UpdatePanel ID="upGift" runat="server">
                                <ContentTemplate>
                                    <div class="secondary-font">
                                        <div>
                                            <i class="fa fa-gift" style="font-size: 22px"></i>&nbsp;
                                           <label for="chkGiftWrapping" class="secondary-font">
                                               <asp:CheckBox ID="chkGiftWrapping" AutoPostBack="true" runat="server" ClientIDMode="Static" />
                                               Click here to add Gift Wrapping @ Rs.50</label>
                                        </div>
                                        <asp:Panel ID="pnlGiftTxt" runat="server" Visible="false">
                                            <asp:TextBox ID="giftMessage" runat="server" TextMode="MultiLine" CssClass="form-control" ClientIDMode="Static" placeholder="Enter your message"></asp:TextBox></asp:Panel>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <div class="clearfix"></div>
                        </div>

                        <div>&nbsp;</div>
                        <div class="order-detail-section border-all border-radius-normal text-center shipping-note margin-bottom d-none">
                            <i class="fa fa-truck"></i>&nbsp; Free economy shipping on & above orders Rs.500
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:UpdatePanel ID="up3" runat="server">
                            <ContentTemplate>
                                <div class="order-details border-all border-radius-normal">
                                    <h4 class="text-left text-uppercase padding-20 border-bottom">Cart Summary</h4>

                                    <div class="cart-summary">
                                        <table width="100%">
                                            <tbody>
                                                <tr>
                                                    <td>Subtotal</td>
                                                    <td>Rs.
                                                        <asp:Label ID="cart2summarySubtotal" runat="server"></asp:Label></td>
                                                </tr>

                                                <%-- <tr>
                                                    <td>GST</td>
                                                    <td>Rs. <asp:Label ID="cart2TotalGST" runat="server"></asp:Label></td>
                                                </tr>--%>

                                                <tr>
                                                    <td>GST & Handling Charges</td>
                                                    <td class="free">
                                                        <asp:Label ID="cart2summaryshippingCharges" runat="server"></asp:Label>
                                                        <asp:Label ID="cart2Summaryfreeshipping" runat="server" Text="Free" CssClass="text-success"></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <asp:Panel ID="pnlGwrapping" runat="server" Visible="false">
                                                        <td>Gift Wrapping</td>
                                                        <td>Rs.
                                                            <asp:Label ID="lblGiftWrapCost" runat="server" Text="0"></asp:Label></td>
                                                    </asp:Panel>
                                                </tr>

                                                <tr>
                                                    <td>Total Discount</td>
                                                    <td>
                                                        <asp:Label ID="cart2summaryDiscount" runat="server" Text="0"></asp:Label></td>
                                                </tr>

                                                <tr>
                                                    <td class="no-border">Final Payment</td>
                                                    <td class="no-border"><strong>Rs.
                                                        <asp:Label ID="cart2FinalAmount" runat="server"></asp:Label></strong></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <div>&nbsp;</div>

                        <asp:LinkButton ID="cart2Checkout" OnClick="btnCart2Checkout" runat="server" CssClass="button secondary-button text-uppercase btn-width-full" Text="Proceed to Checkout"></asp:LinkButton>

                        <div>&nbsp;</div>

                        <a href="http://balicbulk.foxboxstores.com/" class="button primary-button text-uppercase btn-width-full">Continue Shopping</a>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmptyCart" runat="server" CssClass="text-center" Visible="false">
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <img src="/images/common/empty_cart.png" style="max-width: 100%" />
                    </div>

                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <h4 class="empty-cart-title">Shopping Cart is empty !</h4>
                        <div>&nbsp;</div>
                        <div>&nbsp;</div>
                        <a href="/index" class="button secondary-button-dark text-uppercase">Start Shopping Now</a>
                    </div>
                </div>
            </asp:Panel>
            <!--distributor cart-->
        </div>
    </div>


    <asp:UpdatePanel ID="upQtyModal" runat="server">
        <ContentTemplate>
            <div id="modalQty" class="modal fade" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title secondary-font">Update Quantity</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-4 col-sm-12 col-xs-12 margin-bottom">
                                    <div class="product-main-image">
                                        <asp:Image ID="productImage" runat="server" Style="width: 100%" />
                                    </div>
                                </div>

                                <div class="col-md-8 col-sm-12 col-xs-12 margin-bottom">
                                    <div class="product-info-block">
                                        <h2 class="capitalize">
                                            <asp:Label ID="productID" runat="server" Visible="false"></asp:Label>
                                            <asp:Label ID="productTitle" Text="Ottaline Full Sleeves Mens Shirt" runat="server"></asp:Label>
                                        </h2>
                                        <h3 class="capitalize secondary-font info-brand">
                                            <asp:Label ID="brandTitle" runat="server" Text="Ottaline"></asp:Label>
                                        </h3>

                                        <asp:Panel ID="pnlDetails" runat="server">
                                            <div class="row">
                                                <div class="margin-bottom">
                                                    <asp:Panel ID="pnlPricing" CssClass="col-md-12 col-sm-12 col-xs-12" runat="server">
                                                        <h3 class="inline-block capitalize secondary-color txt-weight-bold secondary-font">Rs.<asp:Label
                                                            ID="sellingPrice" runat="server" Text="Rs.480"></asp:Label>
                                                        </h3>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <h4 class="inline-block capitalize strike txt-weight-bold mrp-price secondary-font"><strike>MRP.
                                                <asp:Label ID="mrp" runat="server" Text="Rs.999"></asp:Label></strike></h4>
                                                        &nbsp;&nbsp;&nbsp;
                                        <div class="inline-block relative">
                                            <asp:Panel ID="pnlDiscount" runat="server" class="discount-round" Style="position: static">
                                                <div class="discount-round-inner">
                                                    <asp:Label ID="discountPercent" runat="server"></asp:Label>%<br />
                                                    Off
                                                </div>
                                            </asp:Panel>
                                        </div>
                                                    </asp:Panel>

                                                    <div class="clearfix"></div>
                                                    <div>&nbsp;</div>
                                                    <div class="col-xs-12">
                                                        <div class="table-responsive secondary-font text-center">
                                                            <table class="price-table">
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="width-40">Qty</td>
                                                                        <td id="tdQty1" runat="server">
                                                                            <asp:Label ID="moq" runat="server"></asp:Label>
                                                                            -
                                                        <asp:Label ID="qty1Range" runat="server"></asp:Label></td>
                                                                        <td id="tdQty2" runat="server" class="colored">
                                                                            <asp:Label ID="qty2Range" runat="server"></asp:Label></td>
                                                                        <td id="tdQty3" runat="server">
                                                                            <asp:Label ID="qty3Range" runat="server"></asp:Label></td>
                                                                        <td id="tdQty4" runat="server">
                                                                            <asp:Label ID="qty4Range" runat="server"></asp:Label></td>
                                                                        <td id="tdQty5" runat="server">
                                                                            <asp:Label ID="qty5Range" runat="server"></asp:Label></td>
                                                                        <td id="tdQty6" runat="server">
                                                                            <asp:Label ID="qty6Range" runat="server"></asp:Label></td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td class="width-40">Save</td>
                                                                        <td id="tdSave1" runat="server" class="colored-1">
                                                                            <asp:Label ID="discountPercent1" runat="server"></asp:Label></td>
                                                                        <td id="tdSave2" runat="server">
                                                                            <asp:Label ID="discountPercent2" runat="server"></asp:Label></td>
                                                                        <td id="tdSave3" runat="server">
                                                                            <asp:Label ID="discountPercent3" runat="server"></asp:Label></td>
                                                                        <td id="tdSave4" runat="server">
                                                                            <asp:Label ID="discountPercent4" runat="server"></asp:Label></td>
                                                                        <td id="tdSave5" runat="server">
                                                                            <asp:Label ID="discountPercent5" runat="server"></asp:Label></td>
                                                                        <td id="tdSave6" runat="server">
                                                                            <asp:Label ID="discountPercent6" runat="server"></asp:Label></td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td class="width-40">Price</td>
                                                                        <td id="tdPrice1" runat="server">
                                                                            <asp:Label ID="discountPrice1" runat="server"></asp:Label></td>
                                                                        <td id="tdPrice2" runat="server">
                                                                            <asp:Label ID="discountPrice2" runat="server"></asp:Label></td>
                                                                        <td id="tdPrice3" runat="server">
                                                                            <asp:Label ID="discountPrice3" runat="server"></asp:Label></td>
                                                                        <td id="tdPrice4" runat="server">
                                                                            <asp:Label ID="discountPrice4" runat="server"></asp:Label></td>
                                                                        <td id="tdPrice5" runat="server">
                                                                            <asp:Label ID="discountPrice5" runat="server"></asp:Label></td>
                                                                        <td id="tdPrice6" runat="server">
                                                                            <asp:Label ID="discountPrice6" runat="server"></asp:Label></td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td class="width-40">Production Time (In Days)</td>
                                                                        <td id="tdTime1" runat="server">
                                                                            <asp:Label ID="time1" runat="server"></asp:Label></td>
                                                                        <td id="tdTime2" runat="server">
                                                                            <asp:Label ID="time2" runat="server"></asp:Label></td>
                                                                        <td id="tdTime3" runat="server">
                                                                            <asp:Label ID="time3" runat="server"></asp:Label></td>
                                                                        <td id="tdTime4" runat="server">
                                                                            <asp:Label ID="time4" runat="server"></asp:Label></td>
                                                                        <td id="tdTime5" runat="server">
                                                                            <asp:Label ID="time5" runat="server"></asp:Label></td>
                                                                        <td id="tdTime6" runat="server">
                                                                            <asp:Label ID="time6" runat="server"></asp:Label></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>

                                                    <asp:Panel ID="pnlstockView" CssClass="col-md-6 col-sm-6 col-xs-12 text-right d-none"
                                                        runat="server">
                                                        <h3 class="inline-block capitalize primary-color txt-weight-bold">Stock -
                                            <asp:Label ID="stock" runat="server"></asp:Label>
                                                        </h3>
                                                    </asp:Panel>
                                                    <div class="clearfix"></div>
                                                </div>
                                            </div>

                                            <asp:Panel ID="pnlSize" runat="server" Visible="false" class="margin-bottom">
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                                        <div runat="server" class="size-variable">
                                                            <asp:RadioButtonList ID="sizes" runat="server" ClientIDMode="Static"
                                                                CssClass="sizes" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                                <asp:ListItem Value="Medium">M</asp:ListItem>
                                                                <asp:ListItem Value="Large">L</asp:ListItem>
                                                                <asp:ListItem Value="Xtra Large">XL</asp:ListItem>
                                                                <asp:ListItem Value="Xtra Xtra Large">XXL</asp:ListItem>
                                                                <asp:ListItem Value="Xtra Xtra Xtra Large">XXXL</asp:ListItem>
                                                            </asp:RadioButtonList>

                                                            <a id="sizechartActivator" class="size-chart-button secondary-font txt-weight-bold"
                                                                style="cursor: pointer">Size Chart</a>

                                                            <div class="size-chart-popover">
                                                                <div class="size-chart-inner">
                                                                    <ul class="nav nav-tabs">
                                                                        <li class="active"><a data-toggle="tab" href="#home">Size
                                                                Options</a></li>
                                                                        <li><a data-toggle="tab" href="#menu1">Measurement Guide</a></li>
                                                                        <li><a data-toggle="tab" href="#sizeAdvice">Size Advice</a></li>
                                                                    </ul>

                                                                    <i class="fa fa-remove close-size"></i>

                                                                    <div>&nbsp;</div>
                                                                    <div class="tab-content">
                                                                        <div id="home" class="tab-pane fade in active">
                                                                            <asp:Panel ID="femaleSizePanel" runat="server" Visible="false">
                                                                                <table class="table basic-size-table">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>Size</td>
                                                                                            <td>Chest</td>
                                                                                            <td>Shoulder</td>
                                                                                            <td>Length</td>
                                                                                            <td>Waist</td>
                                                                                            <td>Hip</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>M</td>
                                                                                            <td>36</td>
                                                                                            <td>17.5</td>
                                                                                            <td>28</td>
                                                                                            <td>32</td>
                                                                                            <td>37</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>L</td>
                                                                                            <td>38</td>
                                                                                            <td>18</td>
                                                                                            <td>29</td>
                                                                                            <td>34</td>
                                                                                            <td>39</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>XL</td>
                                                                                            <td>40</td>
                                                                                            <td>18.5</td>
                                                                                            <td>30</td>
                                                                                            <td>36</td>
                                                                                            <td>41</td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </asp:Panel>

                                                                            <asp:Panel ID="maleSizePanel" runat="server" Visible="false">
                                                                                <table class="table basic-size-table">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td class="col-md-3">Size</td>
                                                                                            <td class="col-md-3">Chest</td>
                                                                                            <td class="col-md-3">Shoulder</td>
                                                                                            <td class="col-md-3">Length</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>M</td>
                                                                                            <td>40</td>
                                                                                            <td>17</td>
                                                                                            <td>27</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>L</td>
                                                                                            <td>42</td>
                                                                                            <td>18</td>
                                                                                            <td>28</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>XL</td>
                                                                                            <td>44</td>
                                                                                            <td>18.5</td>
                                                                                            <td>29</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td>XXL</td>
                                                                                            <td>46</td>
                                                                                            <td>19</td>
                                                                                            <td>30</td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <asp:Panel ID="xxxlPnl" runat="server"
                                                                                                Visible="false">
                                                                                                <td>XXXL</td>
                                                                                                <td>48</td>
                                                                                                <td>19.5</td>
                                                                                                <td>31</td>
                                                                                            </asp:Panel>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </div>

                                                                        <div id="menu1" class="tab-pane fade">
                                                                            <asp:Panel ID="femaleMesurementPanel" runat="server"
                                                                                Visible="false">
                                                                                <img src="http://bajajallianzlife.foxboxstores.com/images/womens-mesurement-guide.jpg" class="img-responsive" />
                                                                            </asp:Panel>

                                                                            <asp:Panel ID="maleMesurementPanel" runat="server" Visible="false">
                                                                                <img src="http://bajajallianzlife.foxboxstores.com/images/mens-mesurement-guide.jpg" class="img-responsive" />
                                                                            </asp:Panel>
                                                                        </div>

                                                                        <div id="sizeAdvice" class="tab-pane fade">
                                                                            <img src="http://bajajallianzlife.foxboxstores.com/images/products/76212-Size-chart_221018105828.jpg"
                                                                                class="img-responsive" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="clearfix"></div>

                                                        <div>
                                                            <strong>
                                                                <asp:RequiredFieldValidator ID="rvSize" runat="server"
                                                                    ControlToValidate="sizes" ValidationGroup="sizeGroupVal"
                                                                    ErrorMessage="Please select a size to proceed" CssClass="alert alert-danger secondary-font size-validator"
                                                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                                            </strong>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>

                                            <div>
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12 col-xs-12 secondary-font">
                                                            <strong>Quantity</strong><br />
                                                        <div class="row">
                                                            <div class="col-md-3 col-sm-12 col-xs-12">
                                                                <asp:Label ID="maxQty" runat="server" Visible="false"></asp:Label>
                                                                <asp:TextBox ID="quantity" runat="server" CssClass="input-text width-full pull-left text-center"
                                                                    ClientIDMode="Static" Text="1" style="padding:5px 15px; font-size:30px"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-9 col-sm-12 col-xs-12">
                                                                <asp:LinkButton ID="changeQty" NavigateUrl="/cart" runat="server" CssClass="button secondary-button uppercase btn-width-full margin-bottom" Style="display: block" OnClick="changeQuantity">Update Quantity</asp:LinkButton>
                                                            </div>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>

                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </ContentTemplate>

        <Triggers>
            <asp:PostBackTrigger ControlID="changeQty" />
        </Triggers>
    </asp:UpdatePanel>

    <script>
        function openQtyModal() {
            $('#modalQty').modal('show');
        }
    </script>

    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
</asp:Content>

