<%@page import="DAOs.DaoOrderHistoryList"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="DAOs.DaoVarifyStore"%>
<%@page import="Utils.TimeF"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="POJOs.PojoProductsReview"%>
<%@page import="DAOs.DaoProductsReview"%>
<%@page import="POJOs.PojoUsers"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    }
%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart-Products</title>

        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">

        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>

        <style> 
            #tab_three{
                position: relative;
            }
            .w3-display-left{
                position: absolute;
                top: 27%;
                left: -2%
            }
            .w3-display-right{
                position: absolute;
                top: 27%;
                right: -3.5%
            }
            .mySlides {
                display:none;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <!-- main wrapper start -->
            <main>
                <!-- breadcrumb area start -->
                <div class="breadcrumb-area">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="breadcrumb-wrap text-center">
                                    <nav aria-label="breadcrumb">
                                        <h2>Product</h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">product details</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- breadcrumb area end -->

            <%
                int prdid;
                String prdname = "";
                String description = "";
                if (request.getParameter("prdid") != null) {
                    prdid = Integer.parseInt(request.getParameter("prdid"));
                    PojoProducts pojo = DaoProducts.getProductsById(prdid);
                    prdname = pojo.getPrdname();
                    description = pojo.getPrddescription();
                    String category = pojo.getPrdcategory();
            %>
            <%
                PojoStore store = DaoStore.getStoreById(pojo.getStrid());
                String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                String shopname = store.getStrname();
                int strid = store.getStrid();

            %>
            <!-- page main wrapper start -->
            <div class="product-details-wrapper pt-60 pb-60">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5 col-md-6">
                            <div class="product-large-slider img-zoom mb-20 slider-arrow-style slider-arrow-style__style-2">
                                <div class="pro-large-img" style="border: 1px solid black;">
                                    <img src="<%=pojo.getImgpath()%>" alt="" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%> />
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-7 col-md-6">
                            <div class="product-details-des">
                                <div class="product-content-list">

                                    <div class="product-name">
                                        <h1><a ><%=prdname%></a></h1>
                                    </div>
                                    <div class="product-name">
                                        <h4>Store : <a href="shop-grid-full-4-col.jsp?cid=<%=strid%>"><%=shopname%></a></h4>
                                    </div>
                                    <div class="product-name">
                                        <h4>Category : <%=pojo.getPrdcategory()%></h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><h2><%=pojo.getPrdprize()%>₹</h2></span>
                                        <%
                                            if (pojo.getPrddiscount() != 0) {
                                        %>
                                        <span class="old-price"><del><% out.println(((pojo.getPrdprize() * pojo.getPrddiscount()) / 100) + pojo.getPrdprize()); %></del>₹</span>
                                                <% } %>
                                    </div>
                                    <div class="action-link mb-20">

                                        <%
                                            int sts = DaoATC.getOrdSts(cstmid, pojo.getPrdid());
                                            System.out.println("Prdid: " + pojo.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
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
                                        <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=pojo.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                        <%
                                                }
                                            }
                                        %>
                                        <a href="#" data-toggle="tooltip" class="ml-3" title="Compare" onclick="location.href = 'compare.jsp?pid=<%=pojo.getPrdid()%>&cid=<%=cstmid%>'"><i
                                                class="ion-ios-shuffle"></i></a>
                                    </div>                           

                                    <div class="availability mb-14">
                                        <h5>Availability:</h5>
                                        <span><%=pojo.getPrdtotalqty()%> in stock</span>
                                    </div>
                                    <div class="availability mb-20">
                                        <h5>Already Purchased:</h5>
                                        <span>(<%=pojo.getPrdpurchasedbycstm()%>)</span>
                                    </div>
                                    <div class="share-icon">
                                        <h5>share:</h5>
                                        <a href="" id="facebook"><i class="fa fa-facebook"></i></a>
                                        <a href="" id="twitter"><i class="fa fa-twitter"></i></a>
                                        <a href="" id="whatsup"><i class="fa fa-whatsapp"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <!-- product details reviews start -->
                            <div class="product-details-reviews pt-60">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="product-review-info">
                                            <div class="review-tab">
                                                <ul class="nav">
                                                    <li>
                                                        <a class="active" data-toggle="tab" href="#tab_three">reviews</a>
                                                    </li>
                                                    <li>
                                                        <a data-toggle="tab" href="#tab_one">description</a>
                                                    </li>

                                                </ul>
                                            </div>
                                            <div class="tab-content reviews-tab" style="width:980px;">
                                                <div class="tab-pane fade" id="tab_one">
                                                    <div class="tab-one">
                                                        <p><%=description%></P>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade show active" id="tab_three">
                                                    <%
                                                        String rev_btn = "Continue";
                                                        int rating = 5;
                                                        String name = "";
                                                        String email = "";
                                                        String msg = "";
                                                        int revid = 0;
                                                        if (user != null) {
                                                            PojoProductsReview review = DaoProductsReview.getReviewByIds(cstmid, prdid);
                                                            if (review != null) {
                                                                revid = review.getReviewid();
                                                                name = review.getRname();
                                                                email = review.getRemail();
                                                                msg = review.getRmsg();
                                                                rating = review.getRrating();
                                                                rev_btn = "Update";
                                                            }
                                                        }
                                                    %>
                                                    <button class="w3-button w3-black w3-display-left" id="btn1" onclick="plusDivs(-1)">&#10094;</button>
                                                    <button class="w3-button w3-black w3-display-right" id="btn2" onclick="plusDivs(1)">&#10095;</button>
                                                    <form action="OrderListUpdate" method="POST" class="review-form">
                                                        <input type="hidden" name="prdid" value="<%=prdid%>">
                                                        <input type="hidden" name="prdname" value="<%=prdname%>">
                                                        <input type="hidden" name="cstmid" value="<%=cstmid%>">
                                                        <div class="">
                                                            <%
                                                                List<PojoProductsReview> reviews = DaoProductsReview.getReviewByPrdid(prdid);
                                                                int count = reviews.size();%>
                                                            <input type="hidden" name="count" id="countReview" value="<%=count%>">
                                                            <h5><%=count%> review for <span><%=prdname%></span></h5>
                                                            <%
                                                                for (PojoProductsReview review : reviews) {
                                                                    int rat = review.getRrating();

                                                            %>
                                                            <div class="total-reviews mySlides">
                                                                <div class="rev-avatar">
                                                                    <img src="assets/img/about/avatar.jpg" alt="">
                                                                </div>
                                                                <div class="review-box">
                                                                    <div class="ratings">
                                                                        <%                                                                        for (int i = 1; i <= 5; i++) {
                                                                                if (i <= rat) {
                                                                                    out.println("<span><i class='ion-android-star'></i></span>");
                                                                                }
                                                                            }
                                                                        %>
                                                                    </div>
                                                                    <div class="post-author">
                                                                        <p><span><%=review.getRname()%> -</span> <%=review.getTimestamp()%></p>
                                                                    </div>
                                                                    <p><%=review.getRmsg()%></p>
                                                                </div>
                                                            </div>
                                                            <%}%>
                                                        </div>
                                                        <%
                                                            if (user != null) {

                                                                count = DaoOrderHistoryList.getHistoryListCntByIds(cstmid, prdid);
                                                                if (count > 0) {
                                                        %>
                                                        <input type="hidden" name="revid" value="<%=revid%>">
                                                        <div class="form-group row">
                                                            <div class="col">
                                                                <label class="col-form-label"><span
                                                                        class="text-danger">*</span>
                                                                    Your name</label>
                                                                <input type="text" name="name" value="<%=name%>" class="form-control" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col">
                                                                <label class="col-form-label"><span
                                                                        class="text-danger">*</span>
                                                                    Your email</label>
                                                                <input type="email" name="email" value="<%=email%>" class="form-control" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col">
                                                                <label class="col-form-label"><span
                                                                        class="text-danger">*</span>
                                                                    Your Review</label>
                                                                <textarea class="form-control" name="message" required><%=msg%></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col">
                                                                <label class="col-form-label"><span
                                                                        class="text-danger">*</span>
                                                                    Rating</label>
                                                                &nbsp;&nbsp;&nbsp; Bad&nbsp;
                                                                <%
                                                                    for (int i = 1; i <= 5; i++) {
                                                                        String atr = "";
                                                                        if (rating == i) {
                                                                            atr = "checked";
                                                                        }
                                                                        out.println("<input type='radio' value=" + i + " name='rating' " + atr + ">&nbsp;");
                                                                    }
                                                                %>

                                                                Good
                                                            </div>
                                                        </div>
                                                        <div class="buttons">
                                                            <button class="btn btn__btn-gray"
                                                                    type="submit"><%=rev_btn%></button>
                                                        </div>
                                                        <% } else {
                                                                    out.println("<h4>You have not ordered this product!! Shop Now!!</h4>");
                                                                }

                                                            } else {
                                                                out.println("<h4>You are not <a href='login-register.jsp'>login</a></h4>");
                                                            } %>
                                                    </form> <!-- end of review-form -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- product details reviews end -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- page main wrapper end -->

            <!-- similar product area start -->
            <section class="related-product pb-30">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h2>similar product</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <%
                            if (request.getParameter("prdname") != null) {
                                String prdName = request.getParameter("prdname");
                                List<PojoProducts> simi = DaoProducts.getProductsByName(prdName);
                                for (PojoProducts pojo2 : simi) {
                                    int varified = DaoVarifyStore.getVerified(pojo2.getStrid());
                                    if (varified != 1) {
                                        continue;
                                    }
                                    store = DaoStore.getStoreById(pojo2.getStrid());
                                    status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                    // store = DaoStore.getStoreById(pojo2.getStrid());
                        %>
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-item mb-50">
                                <div class="product-thumb">
                                    <a href="#">
                                        <img src="<%=pojo2.getImgpath()%>" height="264px" width="100%" alt="" <%if (status == "Closed") { %> style="filter: grayscale(100%);" <% }%>>
                                    </a>
                                </div>
                                <div class="product-content text-center">
                                    <div class="product-name">
                                        <h4 class="h4">
                                            <a href="single-product.jsp?prdid=<%=pojo2.getPrdid()%>&prdname=<%=pojo2.getPrdname()%>"><%=pojo2.getPrdname()%></a>
                                            <h5 class="h5">
                                                <%=store.getStrname()%>
                                            </h5>
                                        </h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><%=pojo2.getPrdprize()%>₹/<%=pojo2.getPrdunit()%></span>
                                        <input type="hidden" class="store-id" value="12">
                                        <input type="hidden" class="product-id" value="21">
                                        <%
                                            if (pojo2.getPrddiscount() != 0) {
                                        %>
                                        <span class="old-price"><del><% out.println(((pojo2.getPrdprize() * pojo2.getPrddiscount()) / 100) + pojo2.getPrdprize()); %></del>₹</span>
                                                <% } %>
                                    </div>
                                    <div class="" style="margin-top:10px;">
                                        <%
                                            sts = DaoATC.getOrdSts(cstmid, pojo2.getPrdid());
                                            System.out.println("Prdid: " + pojo2.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
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
                                        <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=pojo2.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                        <%
                                                }
                                            }
                                        %>
                                        <div class="" onclick="location.href = 'compare.jsp?pid=<%=pojo2.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%}
                            } else {
                                out.println("<a href='#'>Product not found</a>");
                            }%>
                    </div>
                </div>
            </section>
            <!-- similar product area end -->

            <!-- related product area start -->
            <section class="related-product pb-30">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h2>related product</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <%
                            List<PojoProducts> cate = DaoProducts.getProductsByType(category);
                            if (!(cate.isEmpty())) {
                                for (PojoProducts pojo1 : cate) {
                                    int varified = DaoVarifyStore.getVerified(pojo1.getStrid());
                                    if (varified != 1) {
                                        continue;
                                    }
                                    store = DaoStore.getStoreById(pojo1.getStrid());
                                    status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                    store = DaoStore.getStoreById(pojo1.getStrid());
                        %>
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-item mb-50">
                                <div class="product-thumb">
                                    <a href="#">
                                        <img src="<%=pojo1.getImgpath()%>" height="264px" width="100%" alt="">
                                    </a>
                                </div>
                                <div class="product-content text-center">
                                    <div class="product-name">
                                        <h4 class="h4">
                                            <a href="single-product.jsp?prdid=<%=pojo1.getPrdid()%>&prdname=<%=pojo1.getPrdname()%>"><%=pojo1.getPrdname()%></a>
                                            <h5 class="h5">
                                                <%=store.getStrname()%>
                                            </h5>
                                        </h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><%=pojo1.getPrdprize()%>₹/<%=pojo1.getPrdunit()%></span>
                                        <input type="hidden" class="store-id" value="12">
                                        <input type="hidden" class="product-id" value="21">
                                        <%
                                            if (pojo1.getPrddiscount() != 0) {
                                        %>
                                        <span class="old-price"><del><% out.println(((pojo1.getPrdprize() * pojo1.getPrddiscount()) / 100) + pojo1.getPrdprize()); %></del>₹</span>
                                                <% } %>
                                    </div>
                                    <div class="" style="margin-top:10px;">
                                        <%

                                            sts = DaoATC.getOrdSts(cstmid, pojo1.getPrdid());
                                            System.out.println("Prdid: " + pojo1.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
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
                                        <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=pojo1.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                        <%
                                                }
                                            }
                                        %>
                                        <div class="" onclick="location.href = 'compare.jsp?pid=<%=pojo1.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }
                        } else {%>
                        <div class="container">
                            <div class="row">
                                <div class="col-12">
                                    <div class="breadcrumb-wrap text-center">
                                        <nav aria-label="breadcrumb">
                                            <h2>Sorry <a href="" onclick="return false;"><%=category%></a> is Not Avilable</h2>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <% }
                        %>
                    </div>
                </div>
            </section>                     
            <!-- related product area end -->
            <% } else {
                if (request.getParameter("ctid") != null) {
                    String category = request.getParameter("category");
            %>
            <!-- related product area start -->
            <section class="related-product pb-30 mt-3">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h2><%=category%></h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <%
                            List<PojoProducts> cate = DaoProducts.getProductsByType(category);
                            if (!(cate.isEmpty())) {
                                for (PojoProducts obj : cate) {
                                    PojoStore store = DaoStore.getStoreById(obj.getStrid());
                                    store = DaoStore.getStoreById(obj.getStrid());
                                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                        %>
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-item mb-50">
                                <div class="product-thumb">
                                    <a href="#">
                                        <img src="<%=obj.getImgpath()%>" height="264px" width="100%" alt="">
                                    </a>
                                </div>
                                <div class="product-content text-center">
                                    <div class="product-name">
                                        <h4 class="h4">
                                            <a href="single-product.jsp?prdid=<%=obj.getPrdid()%>&prdname=<%=obj.getPrdname()%>"><%=obj.getPrdname()%></a>
                                            <h5 class="h5">
                                                <%=store.getStrname()%>
                                            </h5>
                                        </h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><%=obj.getPrdprize()%>₹/<%=obj.getPrdunit()%></span>
                                        <input type="hidden" class="store-id" value="12">
                                        <input type="hidden" class="product-id" value="21">
                                        <%
                                            if (obj.getPrddiscount() != 0) {
                                        %>
                                        <span class="old-price"><del><% out.println(((obj.getPrdprize() * obj.getPrddiscount()) / 100) + obj.getPrdprize()); %></del>₹</span>
                                                <% } %>
                                    </div>
                                    <div class="" style="margin-top:10px;">
                                        <%
                                            int sts = DaoATC.getOrdSts(cstmid, obj.getPrdid());
                                            System.out.println("Prdid: " + obj.getPrdid() + " Cstmid: " + cstmid + " Status: " + sts);
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
                                        <button class="btn btn-dark text-white" <% if (status != "Closed") {%> onclick="addmetocart(<%=obj.getPrdid()%>,<%=cstmid%>)" <% }%> >Add To Cart</button>
                                        <%
                                                }
                                            }
                                        %>
                                        <div class="" onclick="location.href = 'compare.jsp?pid=<%=obj.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <% }
                        } else {%>
                        <div class="container">
                            <div class="row">
                                <div class="col-12">
                                    <div class="breadcrumb-wrap text-center">
                                        <nav aria-label="breadcrumb">
                                            <h2>Sorry <a href="" onclick="return false;"><%=category%></a> is Not Avilable</h2>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <% }
                                }
                            }%>
                    </div>
                </div>
            </section>
            <!-- related product area end -->
        </main>
        <!-- main wrapper end -->

        <jsp:include page="footer.jsp"></jsp:include>

        <!-- Scroll to top start -->
        <div class="scroll-top not-visible">
            <i class="fa fa-angle-up"></i>
        </div>
        <!-- Scroll to Top End -->

        <!--=======================Javascript============================-->
        <!--=== All Vendor Js ===-->
        <script src="assets/js/ajaxrequest.js"></script>
        <script src="assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="assets/js/active.js"></script>
        <script src="assets/js/active1.js"></script>

        <script>
                                                var count = parseInt(document.getElementById('countReview').value);
//            alert(count);
                                                if (count == 0) {
//                alert(count);
                                                    document.getElementById("btn1").style.display = "none";
                                                    document.getElementById("btn2").style.display = "none";
                                                }
        </script>

        <script>
            $(document).ready(function () {
                var Url = location.href;
                $("#facebook").attr("href", "https://www.facebook.com/sharer.php?url=" + Url);
                $("#twitter").attr("href", "https://twitter.com/share?url=" + Url);
                $("#whatsup").attr("href", "https://api.whatsapp.com/send?text=" + Url);
            });
        </script>

        <script>
            var slideIndex = 1;
            showDivs(slideIndex);

            function plusDivs(n) {
                showDivs(slideIndex += n);
            }

            function showDivs(n) {
                var i;
                var x = document.getElementsByClassName("mySlides");
                if (n > x.length) {
                    slideIndex = 1;
                }
                if (n < 1) {
                    slideIndex = x.length;
                }
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = "none";
                }
                x[slideIndex - 1].style.display = "block";
            }


        </script>

    </body>

</html>