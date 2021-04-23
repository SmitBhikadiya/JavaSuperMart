<%@page import="DAOs.DaoVarifyStore"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="DAOs.DaoProductsReview"%>
<%@page import="POJOs.PojoProductsReview"%>
<%@page import="java.sql.SQLException"%>
<%@page import="POJOs.PojoCompare"%>
<%@page import="POJOs.PojoUsers"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="Utils.TimeF"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.ZonedDateTime"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.Instant"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DaoStore"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    }
%>

<%!
    public int totalprd(int strid) throws SQLException {
        return DaoStore.productCnt(strid);
    }
%>
<!DOCTYPE html>
<html lang="en" >

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart</title>


        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">
        <!--=== my own css ===-->
        <link href="assets/css/mycss.css" rel="stylesheet">

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>



        <style rel="stylesheet">
            .slick-track{
                width: 320px;
            }
            .s-status{
                transform: rotate(40deg);
            }
        </style>

    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>


            <!-- main wrapper start -->
            <main>
                <!-- hero slider area start -->
                <section class="hero-slider-area">
                    <div class="hero-slider-active slider-arrow-style">
                        <div class="single-slider hero-bg hero-bg__1 d-flex align-items-center">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="content-inner">
                                            <div class="slider-content">
                                                <h1>tasty healthy <br>we sell what's<br>good for you </h1>
                                                <p>We supply highly quality, premium organic products</p>
                                                <a href="shop-grid-full-4-col.jsp" class="btn">shop now</a>
                                            </div>
                                            <div class="slider-img">
                                                <img src="assets/img/slider/slide_2.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="single-slider hero-bg hero-bg__1 d-flex align-items-center">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="content-inner">
                                            <div class="slider-content">
                                                <h1>Great offers<br>on fruits <br>and vegetables </h1>
                                                <p>We supply highly quality, premium organic products</p>
                                                <a href="shop-grid-full-4-col.jsp" class="btn">shop now</a>
                                            </div>
                                            <div class="slider-img">
                                                <img src="assets/img/slider/slide_1.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- hero slider area start -->

                <!-- service features start -->
                <section class="service-features pt-30">
                    <div class="container">
                        <div class="service-features-inner theme-color">
                            <div class="single-features-item">
                                <div class="features-icon">
                                    <i class="ion-paper-airplane"></i>
                                </div>
                                <div class="features-content">
                                    <h5>Free Shipping</h5>
                                    <p>Free delivery on all orders over $99</p>
                                </div>
                            </div>
                            <div class="single-features-item">
                                <div class="features-icon">
                                    <i class="ion-social-usd"></i>
                                </div>
                                <div class="features-content">
                                    <h5>Free Shipping</h5>
                                    <p>Free delivery on all orders over $99</p>
                                </div>
                            </div>
                            <div class="single-features-item">
                                <div class="features-icon">
                                    <i class="ion-help-buoy"></i>
                                </div>
                                <div class="features-content">
                                    <h5>Free Shipping</h5>
                                    <p>Free delivery on all orders over $99</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- service features end -->

                <!-- popular category start -->
                <section class="popular-category bg-gray mt-minus pt-60 pb-60 pb-md-30 pb-sm-30">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="section-title text-center pt-62">
                                    <h2>Our Shops</h2>
                                </div>
                            </div>
                        </div>

                        <div class="container">

                            <div class="shoplist">
                            <%
                                List<PojoStore> stores = DaoStore.getStores();
                                for (PojoStore pojo : stores) {
                                    int varified = DaoVarifyStore.getVerified(pojo.getStrid());
                                    if (varified != 1) {
                                        continue;
                                    }
                                    String status = TimeF.isOpen(pojo.getStropentime(), pojo.getStrclosetime());
                                    boolean isOpen = false;
                                    String img = "closed.png";
                                    if (status == "Open") {
                                        img = "open.png";
                                        isOpen = true;
                                    }
                            %>
                            <div class="main1" onclick="location.href = 'shop-grid-full-4-col.jsp?cid=<%=pojo.getStrid()%>';" >
                                <div class="container1">
                                    <div class="imag1">
                                        <img src="<%=pojo.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") {%> style="height: 100%;filter: grayscale(100%);" <%} else {%> style="height: 100%;"<%} %> class="card-img" alt="...">
                                    </div>
                                    <div class="text-container1">
                                        <p class="s-status" <%if (status == "Closed") {%> style="background-color:red;" <%}%> >     
                                            <%=status%>
                                        </p>
                                        <div class="shop-info">
                                            <h4 class="card-title"><%=pojo.getStrname()%></h4>
                                            <img class="shop-status" src="assets/img/<%=img%>" width="20%" height="20%"
                                                 alt="">
                                        </div>
                                        <hr style="margin-top: 0;">
                                        <h6 class="card-text">*Visit Our Store*</h6>
                                        <h6 class="card-text">Total Items : <%=totalprd(pojo.getStrid())%></h6>
                                        <a href="#" class="btn btn-success text-white shop-btn">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>

                        <hr style="border: 1px solid gray;">
                    </div>
                </div>
                </div> <!-- end single item -->

                </div>
                </div>
            </section>
            <!-- popular category end -->

            <!-- product tab area start -->
            <section class="product-tab pt-60 pb-30">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h2>Our Products</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <!-- product tab menu start -->
                            <div class="product-tab-menu pb-30">
                                <ul class="nav justify-content-center">
                                    <li>
                                        <a class="active" data-toggle="tab" href="#tab_one">All</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#tab_two">Grocery</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#tab_three">Fruits</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#tab_four">Vegetables</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#tab_five">Fast Food</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#tab_six">Cold Drinks</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- product tab menu end -->
                            <div class="tab-content">
                                <div class="tab-pane fade active show" id="tab_one">
                                    <div class="product-tab-wrapper">
                                        <div class="row">
                                            <%
                                                List<PojoProducts> li = DaoProducts.getProducts();
                                                if (li.isEmpty()) {%>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="breadcrumb-wrap text-center">
                                                            <nav aria-label="breadcrumb">
                                                                <h2>Sorry <a href="" onclick="return false;">Items</a> is Not Avilable</h2>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <%}
                                                for (PojoProducts products : li) {
                                                    int varified = DaoVarifyStore.getVerified(products.getStrid());
                                                    if (varified != 1) {
                                                        continue;
                                                    }
                                                    PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());

                                            %>
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="product-item mb-50">
                                                    <div class="product-thumb">
                                                        <a href="#">
                                                            <img src="<%=products.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> alt="">
                                                        </a>
                                                    </div>
                                                    <div class="product-content text-center">
                                                        <div class="product-name">
                                                            <h4 class="h4">
                                                                <a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                                <h5 class="h5">
                                                                    <%=store.getStrname()%>
                                                                </h5>
                                                            </h4>
                                                            (<%=products.getPrdpurchasedbycstm()%>)
                                                        </div>
                                                        <div class="price-box">
                                                            <span class="regular-price"><%=products.getPrdprize()%>₹/<%=products.getPrdunit()%></span>
                                                            <input type="hidden" class="store-id" value="12">
                                                            <input type="hidden" class="product-id" value="21">
                                                            <% 
                                                            if(products.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((products.getPrdprize() * products.getPrddiscount()) / 100) + products.getPrdprize()); %></del>₹</span>
                                                            <% } %>
                                                        </div>
                                                        <div class="" style="margin-top:10px;">
                                                            <%
                                                                int sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
                                                                System.out.println("Prdid: " + products.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
                                                                if (status == "Closed") {
                                                                    out.println("<kbd class='bg-danger'> Unavailable </kbd>");
                                                                } else {
                                                                    if (sts == 0) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'cart.jsp'" <% }%> >Go To Cart</button>
                                                            <%
                                                            } else if (sts == 1) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'track-order.jsp'" <% }%> >Track Order</button>
                                                            <%

                                                            } else {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=products.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <div class="" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                        </div>                                           
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab_two">
                                    <div class="product-tab-wrapper">
                                        <div class="row">
                                            <%
                                                li.clear();
                                                li = DaoProducts.getProductsByType("grocery");
                                                if (li.isEmpty()) {%>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="breadcrumb-wrap text-center">
                                                            <nav aria-label="breadcrumb">
                                                                <h2>Sorry <a href="" onclick="return false;">Grocery</a> is Not Avilable</h2>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <%}
                                                for (PojoProducts products : li) {
                                                    int varified = DaoVarifyStore.getVerified(products.getStrid());
                                                    if (varified != 1) {
                                                        continue;
                                                    }
                                                    PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                            %>
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="product-item mb-50">
                                                    <div class="product-thumb">
                                                        <a href="#">
                                                            <img src="<%=products.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> alt="">
                                                        </a>
                                                    </div>
                                                    <div class="product-content text-center">
                                                        <div class="product-name">
                                                            <h4 class="h4">
                                                                <a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                                <h5 class="h5">
                                                                    <%=store.getStrname()%>
                                                                </h5>
                                                                (<%=products.getPrdpurchasedbycstm()%>)
                                                            </h4>
                                                        </div>
                                                        <div class="price-box">
                                                            <span class="regular-price"><%=products.getPrdprize()%>₹/<%=products.getPrdunit()%></span>
                                                            <input type="hidden" class="store-id" value="12">
                                                            <input type="hidden" class="product-id" value="21">
                                                            <% 
                                                            if(products.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((products.getPrdprize() * products.getPrddiscount()) / 100) + products.getPrdprize()); %></del>₹</span>
                                                            <% } %>
                                                        </div>
                                                        <div class="" style="margin-top:10px;">
                                                            <%
                                                                int sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
                                                                System.out.println("Prdid: " + products.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
                                                                if (status == "Closed") {
                                                                    out.println("<kbd class='bg-danger'> Unavailable </kbd>");
                                                                } else {
                                                                    if (sts == 0) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'cart.jsp'" <% }%> >Go To Cart</button>
                                                            <%
                                                            } else if (sts == 1) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'track-order.jsp'" <% }%> >Track Order</button>
                                                            <%

                                                            } else {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=products.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <div class="" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab_three">
                                    <div class="product-tab-wrapper">
                                        <div class="row">
                                            <%
                                                li.clear();
                                                li = DaoProducts.getProductsByType("fruits");
                                                if (li.isEmpty()) {%>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="breadcrumb-wrap text-center">
                                                            <nav aria-label="breadcrumb">
                                                                <h2>Sorry <a href="" onclick="return false;">Fruits</a> is Not Avilable</h2>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <%}
                                                for (PojoProducts products : li) {
                                                    int varified = DaoVarifyStore.getVerified(products.getStrid());
                                                    if (varified != 1) {
                                                        continue;
                                                    }
                                                    PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                            %>
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="product-item mb-50">
                                                    <div class="product-thumb">
                                                        <a href="#">
                                                            <img src="<%=products.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> alt="">
                                                        </a>
                                                    </div>
                                                    <div class="product-content text-center">
                                                        <div class="product-name">
                                                            <h4 class="h4">
                                                                <a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                                <h5 class="h5">
                                                                    <%=store.getStrname()%>
                                                                </h5>
                                                                (<%=products.getPrdpurchasedbycstm()%>)
                                                            </h4>
                                                        </div>
                                                        <div class="price-box">
                                                            <span class="regular-price"><%=products.getPrdprize()%>/<%=products.getPrdunit()%>₹</span>
                                                            <input type="hidden" class="store-id" value="12">
                                                            <input type="hidden" class="product-id" value="21">
                                                           <% 
                                                            if(products.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((products.getPrdprize() * products.getPrddiscount()) / 100) + products.getPrdprize()); %></del>₹</span>
                                                            <% } %>
                                                        </div>
                                                        <div class="" style="margin-top:10px;">
                                                            <%
                                                                int sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
                                                                System.out.println("Prdid: " + products.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
                                                                if (status == "Closed") {
                                                                    out.println("<kbd class='bg-danger'> Unavailable </kbd>");
                                                                } else {
                                                                    if (sts == 0) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'cart.jsp'" <% }%> >Go To Cart</button>
                                                            <%
                                                            } else if (sts == 1) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'track-order.jsp'" <% }%> >Track Order</button>
                                                            <%

                                                            } else {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=products.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <div class="" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab_four">
                                    <div class="product-tab-wrapper">
                                        <div class="row">
                                            <%
                                                li.clear();
                                                li = DaoProducts.getProductsByType("vegetables");
                                                if (li.isEmpty()) {%>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="breadcrumb-wrap text-center">
                                                            <nav aria-label="breadcrumb">
                                                                <h2>Sorry <a href="" onclick="return false;">Vegetables</a> is Not Avilable</h2>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <%}
                                                for (PojoProducts products : li) {
                                                    int varified = DaoVarifyStore.getVerified(products.getStrid());
                                                    if (varified != 1) {
                                                        continue;
                                                    }
                                                    PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                            %>
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="product-item mb-50">
                                                    <div class="product-thumb">
                                                        <a href="#">
                                                            <img src="<%=products.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> alt="">
                                                        </a>
                                                    </div>
                                                    <div class="product-content text-center">
                                                        <div class="product-name">
                                                            <h4 class="h4">
                                                                <a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                                <h5 class="h5">
                                                                    <%=store.getStrname()%>
                                                                </h5>
                                                                (<%=products.getPrdpurchasedbycstm()%>)
                                                            </h4>
                                                        </div>
                                                        <div class="price-box">
                                                            <span class="regular-price"><%=products.getPrdprize()%>/<%=products.getPrdunit()%>₹</span>
                                                            <input type="hidden" class="store-id" value="12">
                                                            <input type="hidden" class="product-id" value="21">
                                                          <% 
                                                            if(products.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((products.getPrdprize() * products.getPrddiscount()) / 100) + products.getPrdprize()); %></del>₹</span>
                                                            <% } %>
                                                        </div>
                                                        <div class="" style="margin-top:10px;">
                                                            <%
                                                                int sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
                                                                System.out.println("Prdid: " + products.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
                                                                if (status == "Closed") {
                                                                    out.println("<kbd class='bg-danger'> Unavailable </kbd>");
                                                                } else {
                                                                    if (sts == 0) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'cart.jsp'" <% }%> >Go To Cart</button>
                                                            <%
                                                            } else if (sts == 1) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'track-order.jsp'" <% }%> >Track Order</button>
                                                            <%

                                                            } else {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=products.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <div class="" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab_five">
                                    <div class="product-tab-wrapper">
                                        <div class="row">
                                            <%
                                                li.clear();
                                                li = DaoProducts.getProductsByType("fast food");
                                                if (li.isEmpty()) {%>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="breadcrumb-wrap text-center">
                                                            <nav aria-label="breadcrumb">
                                                                <h2>Sorry <a href="" onclick="return false;">Fast Food</a> is Not Avilable</h2>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <%}
                                                for (PojoProducts products : li) {
                                                    int varified = DaoVarifyStore.getVerified(products.getStrid());
                                                    if (varified != 1) {
                                                        continue;
                                                    }
                                                    PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                            %>
                                            <div class="col-lg-3 col-md-4 col-sm-6">

                                                <div class="product-item mb-50">
                                                    <div class="product-thumb">
                                                        <a href="#">
                                                            <img src="<%=products.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> alt="">
                                                        </a>
                                                    </div>
                                                    <div class="product-content text-center">
                                                        <div class="product-name">
                                                            <h4 class="h4">
                                                                <a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                                <h5 class="h5">
                                                                    <%=store.getStrname()%>
                                                                </h5>
                                                                (<%=products.getPrdpurchasedbycstm()%>)
                                                            </h4>
                                                        </div>
                                                        <div class="price-box">
                                                            <span class="regular-price"><%=products.getPrdprize()%>/<%=products.getPrdunit()%>₹</span>
                                                            <input type="hidden" class="store-id" value="12">
                                                            <input type="hidden" class="product-id" value="21">
                                                            <% 
                                                            if(products.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((products.getPrdprize() * products.getPrddiscount()) / 100) + products.getPrdprize()); %></del>₹</span>
                                                            <% } %>
                                                        </div>
                                                        <div class="" style="margin-top:10px;">
                                                            <%
                                                                int sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
                                                                System.out.println("Prdid: " + products.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
                                                                if (status == "Closed") {
                                                                    out.println("<kbd class='bg-danger'> Unavailable </kbd>");
                                                                } else {
                                                                    if (sts == 0) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'cart.jsp'" <% }%> >Go To Cart</button>
                                                            <%
                                                            } else if (sts == 1) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'track-order.jsp'" <% }%> >Track Order</button>
                                                            <%

                                                            } else {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=products.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <div class="" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab_six">
                                    <div class="product-tab-wrapper">
                                        <div class="row">
                                            <%
                                                li.clear();
                                                li = DaoProducts.getProductsByType("cold drinks");
                                                if (li.isEmpty()) {%>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="breadcrumb-wrap text-center">
                                                            <nav aria-label="breadcrumb">
                                                                <h2>Sorry <a href="" onclick="return false;">Home & Kitchen</a> is Not Avilable</h2>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <%}
                                                for (PojoProducts products : li) {
                                                    int varified = DaoVarifyStore.getVerified(products.getStrid());
                                                    if (varified != 1) {
                                                        continue;
                                                    }
                                                    PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                            %>
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="product-item mb-50">
                                                    <div class="product-thumb">
                                                        <a href="#">
                                                            <img src="<%=products.getImgpath()%>" height="264px" width="100%" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> alt="">
                                                        </a>
                                                    </div>
                                                    <div class="product-content text-center">
                                                        <div class="product-name">
                                                            <h4 class="h4">
                                                                <a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                                <h5 class="h5">
                                                                    <%=store.getStrname()%>
                                                                </h5>
                                                                (<%=products.getPrdpurchasedbycstm()%>)
                                                            </h4>
                                                        </div>
                                                        <div class="price-box">
                                                            <span class="regular-price"><%=products.getPrdprize()%>/<%=products.getPrdunit()%>₹</span>
                                                            <input type="hidden" class="store-id" value="12">
                                                            <input type="hidden" class="product-id" value="21">
                                                           <% 
                                                            if(products.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((products.getPrdprize() * products.getPrddiscount()) / 100) + products.getPrdprize()); %></del>₹</span>
                                                            <% } %>
                                                        </div>
                                                        <div class="" style="margin-top:10px;">
                                                            <%
                                                                int sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
                                                                System.out.println("Prdid: " + products.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
                                                                if (status == "Closed") {
                                                                    out.println("<kbd class='bg-danger'> Unavailable </kbd>");
                                                                } else {
                                                                    if (sts == 0) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'cart.jsp'" <% }%> >Go To Cart</button>
                                                            <%
                                                            } else if (sts == 1) {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="location.href = 'track-order.jsp'" <% }%> >Track Order</button>
                                                            <%

                                                            } else {
                                                            %>
                                                            <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=products.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <div class="" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- product tab area end -->

            <!-- popular category start -->
            <section class="popular-category pt-60 pb-60 pb-md-30 pb-sm-30">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h2>Popular Categories</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <%
                            List<PojoProducts> prod = DaoProducts.getPopulerCategory(4);
                            int i = 0;
                            for (PojoProducts pro : prod) {
                                ++i;
                                System.out.println("single-product.jsp?ctid=" + pro.getCatid() + "&category=" + pro.getPrdcategory());

                        %>
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="category-single-item mb-md-30 mb-sm-30">
                                <div class="category-item-inner color<%=i%> text-center">
                                    <div class="category-content">
                                        <h2><a href="single-product.jsp?ctid=<%=pro.getCatid()%>&category=<%=pro.getPrdcategory()%>"><%=pro.getPrdcategory()%></a></h2>
                                        <p><%=pro.getCount()%> product</p>
                                    </div>
                                    <div class="category-thumb">
                                        <a href="#">
                                            <img src="assets/img/category/cat-<%=i%>.png" alt="">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }%><!-- end single item -->
                    </div>
                </div>
            </section>
            <!-- popular category end -->

            <jsp:include page="footer.jsp"></jsp:include>


        </main>
        <!-- main wrapper end -->


        <!-- Scroll to top start -->
        <div class="scroll-top not-visible">
            <i class="fa fa-angle-up"></i>
        </div>
        <!-- Scroll to Top End -->


        <!--=======================Javascript============================-->
        <script src="assets/js/ajaxrequest.js"></script>
        <!--=== All Vendor Js ===-->
        <script src="assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="assets/js/active.js"></script>

        <script src="assets/js/active1.js"></script>

    </body>

</html>