<%@ Page Title="Welcome" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="index.aspx.vb" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
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
            <div class="row">
                <div class="col-xs-12 col-sm-4 col-md-5">
                    <a href="#" class="home-category">
                        <img src="https://icicibank.foxboxstores.com/images/products/shirt-1514890915-5_crop.jpg" class="img-fluid">
                        <div class="category-info">
                            <h6>Men's Full Sleeve White Shirt - Medium</h6>
                            <h5>Arrow</h5>
                            <div class="category-button">Click Here</div>
                        </div>
                    </a>
                </div>

                <div class="col-xs-12 col-sm-8 col-md-7">
                    <h1 class="title1 text-uppercase">Apparels</h1>

                    <div class="product-listing">
                        <div class="owl-carousel">
                            <div class="listing-content">
                                <a class="cat-product-link" href="#">
                                    <asp:Image ID="productImage" runat="server" ImageUrl="http://bajajallianzlife.foxboxstores.com/images/products/Royal-Blue-Collared-T-shirt-With-Tipping_161118125926.jpg" />
                                    <h6>Royal Blue Collared T-shirt With Tipping</h6>
                                    <p>Arrow</p>
                                    <div class="pricing">
                                        <span class="selling-price">Rs. 999</span>
                                        <span class="mrp">Rs. 1099</span>
                                    </div>
                                </a>
                            </div>

                            <div class="listing-content">
                                <a class="cat-product-link" href="#">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="http://bajajallianzlife.foxboxstores.com/images/products/Royal-Blue-Collared-T-shirt-With-Tipping_161118125926.jpg" />
                                    <h6>Royal Blue Collared T-shirt With Tipping</h6>
                                    <p>Arrow</p>
                                    <div class="pricing">
                                        <span class="selling-price">Rs. 999</span>
                                        <span class="mrp">Rs. 1099</span>
                                    </div>
                                </a>
                            </div>

                            <div class="listing-content">
                                <a class="cat-product-link" href="#">
                                    <asp:Image ID="Image2" runat="server" ImageUrl="http://bajajallianzlife.foxboxstores.com/images/products/Royal-Blue-Collared-T-shirt-With-Tipping_161118125926.jpg" />
                                    <h6>Royal Blue Collared T-shirt With Tipping</h6>
                                    <p>Arrow</p>
                                    <div class="pricing">
                                        <span class="selling-price">Rs. 999</span>
                                        <span class="mrp">Rs. 1099</span>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="heighter"></div>
        </div>
    </div>

    <script src="/content/owl/owl.carousel.min.js" type="text/javascript"></script>
</asp:Content>

