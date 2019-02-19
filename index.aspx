<%@ Page Title="Welcome" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="index.aspx.vb" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link rel="stylesheet" type="text/css" href="/Content//owl/owl.carousel.min.css" />
    <link rel="stylesheet" type="text/css" href="/Content/owl/owl.theme.default.min.css" />

    <div class="main-slider">
        <div id="demo" class="carousel slide" data-ride="carousel">

            <!-- Indicators -->
            <ul class="carousel-indicators">
                <li data-target="#demo" data-slide-to="0" class="active"></li>
                <li data-target="#demo" data-slide-to="1"></li>
                <li data-target="#demo" data-slide-to="2"></li>
            </ul>

            <!-- The slideshow -->
            <div class="carousel-inner">
                <asp:ListView ID="sSlider" runat="server">
                    <ItemTemplate>
                        <div class="carousel-item">
                            <asp:HyperLink ID="sliderLink" runat="server" NavigateUrl='<%# Eval("link") %>'>
                                <asp:Image ID="pmSliderImage" Style="width: 100%" runat="server" CssClass="img-fluid" ImageUrl='<%# Eval("primaryImage") %>' />
                            </asp:HyperLink>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>

            <!-- Left and right controls -->
            <a class="carousel-control-prev" href="#demo" data-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
            <a class="carousel-control-next" href="#demo" data-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>

        </div>
    </div>

    <div class="home-categories-wrapper">
        <div class="container-fluid">
            <asp:ListView ID="lvCategoriesSection" runat="server" ClientIDMode="Static">
                <ItemTemplate>
                    <div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-md-5">
                                <a href='<%# Eval("iconLink") %>' class="home-category">
                                    <img src='<%# Eval("icon") %>' class="img-fluid">
                                    <div class="category-info">
                                        <h6><%# Eval("primaryText") %></h6>
                                        <h5><%# Eval("secondaryText") %></h5>
                                        <div class="category-button">Click Here</div>
                                    </div>
                                </a>
                            </div>

                            <div class="col-xs-12 col-sm-8 col-md-7">
                                <h1 class="title1 text-uppercase d-inline">
                                    <asp:Label ID="categoryName" runat="server" Text='<%# Eval("name") %>'></asp:Label></h1>

                                <div class="pull-right secondary-font text-uppercase">
                                    <asp:HyperLink ID="categoryLink" runat="server" NavigateUrl='<%# "/products/" & Eval("slug") %>' Style="color: #1C7DBA" CssClass="btn btn-sm btn-default"><strong>View All</strong></asp:HyperLink></li>
                                </div>
                                <div class="clearfix"></div>

                                <div class="product-listing">
                                    <div class="owl-carousel">
                                        <asp:ListView ID="lvCategoryProduct" ClientIDMode="Static" runat="server">
                                            <ItemTemplate>
                                                <div class="listing-content">
                                                    <asp:HyperLink ID="productLink" runat="server" CssClass="cat-product-link" NavigateUrl='<%# Eval("category", "~/products/{0}/" + Eval("slug", "{0}") & "/" & Eval("ID")) %>'>
                                                        <asp:Image ID="productImage" runat="server" ImageUrl='<%#  Eval("main_image") %>' />
                                                        <h6><%# Eval("item_name") %></h6>
                                                        <p><%# Eval("brandName") %></p>
                                                        <div class="pricing">
                                                            <span class="selling-price">Rs. <%# Eval("our_price") %></span>
                                                            <span class="mrp">Rs. <%# Eval("mrp") %></span>
                                                        </div>
                                                    </asp:HyperLink>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="heighter"></div>
                    </div>
                </ItemTemplate>

                <AlternatingItemTemplate>
                    <div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-8 col-md-7">
                                <h1 class="title1 text-uppercase d-inline">
                                    <asp:Label ID="categoryName" runat="server" Text='<%# Eval("name") %>'></asp:Label></h1>

                                <div class="pull-right secondary-font text-uppercase">
                                    <asp:HyperLink ID="categoryLink" runat="server" NavigateUrl='<%# "/products/" & Eval("slug") %>' Style="color: #1C7DBA" CssClass="btn btn-sm btn-default"><strong>View All</strong></asp:HyperLink></li>
                                </div>
                                <div class="clearfix"></div>

                                <div class="product-listing">
                                    <div class="owl-carousel">
                                        <asp:ListView ID="lvCategoryProduct" ClientIDMode="Static" runat="server">
                                            <ItemTemplate>
                                                <div class="listing-content">
                                                    <asp:HyperLink ID="productLink" runat="server" CssClass="cat-product-link" NavigateUrl='<%# Eval("category", "~/products/{0}/" + Eval("slug", "{0}") & "/" & Eval("ID")) %>'>
                                                        <asp:Image ID="productImage" runat="server" ImageUrl='<%#  Eval("main_image") %>' />
                                                        <h6><%# Eval("item_name") %></h6>
                                                        <p><%# Eval("brandName") %></p>
                                                        <div class="pricing">
                                                            <span class="selling-price">Rs. <%# Eval("our_price") %></span>
                                                            <span class="mrp">Rs. <%# Eval("mrp") %></span>
                                                        </div>
                                                    </asp:HyperLink>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-12 col-sm-4 col-md-5">
                                <a href='<%# Eval("iconLink") %>' class="home-category">
                                    <img src='<%# Eval("icon") %>' class="img-fluid">
                                    <div class="category-info">
                                        <h6><%# Eval("primaryText") %></h6>
                                        <h5><%# Eval("secondaryText") %></h5>
                                        <div class="category-button">Click Here</div>
                                    </div>
                                </a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="heighter"></div>
                    </div>
                </AlternatingItemTemplate>
            </asp:ListView>
        </div>
    </div>

    <script src="/content/owl/owl.carousel.min.js" type="text/javascript"></script>
</asp:Content>

