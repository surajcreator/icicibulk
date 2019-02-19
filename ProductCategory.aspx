<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="productCategory.aspx.vb" Inherits="ProductCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="common-page-wrapper listing-page">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-2">
                    <div class="xs-filter-box d-md-none">
                        <div class="row">
                            <div class="col-xs-5 mobile-filter">
                                <i class="fa fa-filter"></i>&nbsp;&nbsp; Filters
                            </div>

                            <div class="col-xs-7 text-right">
                                Sort: 
                            <asp:DropDownList ID="xsSort" runat="server" CssClass="dropdown-box-xs secondary-font" AutoPostBack="true">
                                <asp:ListItem Value="popularity">Most Popular</asp:ListItem>
                                <asp:ListItem Value="priceHigh">Price: Low To High</asp:ListItem>
                                <asp:ListItem Value="priceLow">Price: High To Low</asp:ListItem>
                            </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <div class="filter-blocks d-none d-sm-none d-md-block">
                        <h3 class="text-uppercase d-none d-sm-none d-md-block">Filter By</h3>
                        <br />
                        <div class="filter-items margin-bottom">
                            <h4 class="primary-font text-uppercase">Price Range</h4>
                            <asp:CheckBoxList ID="priceFilter" runat="server" CssClass="chk-filter" AutoPostBack="true">
                            </asp:CheckBoxList>
                        </div>

                        <div class="filter-items margin-bottom">
                            <h4 class="primary-font text-uppercase">Brand</h4>
                            <asp:CheckBoxList ID="brandFilter" runat="server" CssClass="chk-filter" AutoPostBack="true">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-12 col-md-10">
                    <asp:UpdatePanel ID="up1" runat="server">
                        <ContentTemplate>
                            <div class="product-wrapper">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                        <h3 class="text-uppercase">
                                        <asp:Label ID="categoryName" runat="server" Text="Apparels"></asp:Label></h3>
                                    </div>

                                    <div class="col-md-6 col-sm-6 d-none d-sm-none d-md-block text-right">
                                        <asp:Panel ID="pnlSort" runat="server">
                                            <h3 class="text-uppercase d-inline">Sort By:</h3>
                                            <div class="d-inline uppercase">
                                                <asp:DropDownList ID="sort" runat="server" CssClass="dropdown-box secondary-font" AutoPostBack="true">
                                                    <asp:ListItem Value="popularity">Most Popular</asp:ListItem>
                                                    <asp:ListItem Value="priceHigh">Price: Low To High</asp:ListItem>
                                                    <asp:ListItem Value="priceLow">Price: High To Low</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div class="row product-listing">
                                            <asp:ListView ID="products" runat="server" ClientIDMode="Static">
                                                <ItemTemplate>
                                                    <div class="col-md-4 col-sm-4 col-xs-12 listing-content margin-bottom">
                                                        <a class="cat-product-link" href='<%# Eval("category", "~/products/{0}/" + Eval("slug", "{0}") & "/" & Eval("ID")) %>'>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl='<%#  Eval("main_image") %>' />
                                                            <h6><%# Eval("item_name") %></h6>
                                                            <p><%# Eval("brandName") %></p>
                                                            <div class="pricing">
                                                                <span class="selling-price">Rs. <%# Eval("our_price") %></span>
                                                                <span class="mrp">Rs. <%# Eval("mrp") %></span>
                                                            </div>
                                                        </a>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:ListView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

