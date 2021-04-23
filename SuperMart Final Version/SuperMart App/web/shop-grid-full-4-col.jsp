<%@page import="DAOs.DaoVarifyStore"%>
<%@page import="DAOs.DaoProductsReview"%>
<%@page import="POJOs.PojoProductsReview"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="Utils.TimeF"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoProducts"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="POJOs.PojoUsers"%>
<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    }
    int strid = 0;
    if (request.getParameter("cid") != null) {
        strid = Integer.parseInt(request.getParameter("cid").toString());
    }
%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">

    <meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart-Stores</title>

        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>

        <style>
            /* Style the input field */
            html {
                scroll-behavior: smooth;
            }
            #myInput {
                padding: 20px;
                margin-top: -6px;
                border: 0;
                border-radius: 0;
                background: #f1f1f1;
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
                                        <h2>shop</h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">shop grid full width</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- breadcrumb area end -->

                <!-- page main wrapper start -->
                <div class="shop-main-wrapper pt-60 pb-60">
                    <div class="container">
                        <div class="row">
                            <!-- shop main wrapper start -->
                            <div class="col-lg-12">
                                <div class="shop-product-wrapper">
                                    <!-- shop product top wrap start -->
                                    <div class="shop-top-bar">
                                        <div class="row">
                                            <div class="col-xl-5 col-lg-4 col-md-3 order-2 order-md-1">
                                                <div class="top-bar-left">
                                                    <div class="product-view-mode">
                                                        <a class="active" href="#" data-target="grid-view"><i
                                                                class="fa fa-th"></i></a>
                                                        <a href="#" data-target="list-view"><i class="fa fa-list"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-7 col-lg-8 col-md-9 order-1 order-md-2">
                                                <div class="top-bar-right">
                                                    <div class="product-short">
                                                        <div class="">
                                                            <div class="dropdown">
                                                                <button style="background-color: white;color: black;border: 1px solid black;outline: none;width: 250px;" class="btn dropdown-toggle" 
                                                                        type="button" data-toggle="dropdown">Shop List
                                                                </button>
                                                                <ul class="dropdown-menu" style="width:250px;">
                                                                    <input class="form-control" id="myInput" type="text" placeholder="Search..">
                                                                <%
                                                                    List<PojoStore> storesName = DaoStore.getStores();
                                                                    for (PojoStore pojo : storesName) {
                                                                        int varified = DaoVarifyStore.getVerified(pojo.getStrid());
                                                                        if (varified != 1) {
                                                                            continue;
                                                                        }
                                                                %>
                                                                <li>
                                                                    <a href="#<%=pojo.getStrid()%>"><%=pojo.getStrname()%></a>
                                                                </li>
                                                                <%}%>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- shop product top wrap start -->

                                <!-- product item list start -->
                                <div class="shop-product-wrap grid-view row">
                                    <%
                                        List<PojoStore> stores = new ArrayList();
                                        if (strid == 0) {
                                            stores = DaoStore.getStores();
                                        } else {
                                            PojoStore pojostr = DaoStore.getStoreById(strid);
                                            if (pojostr != null) {
                                                stores.add(pojostr);
                                            } else {
                                                out.println("<h2>Store Not Found</h2>");
                                            }

                                        }

                                        for (PojoStore store : stores) {
                                            int varified = DaoVarifyStore.getVerified(store.getStrid());
                                            if (varified != 1) {
                                                continue;
                                            }
                                            //out.println(store.getStrid());
                                    %>

                                    <div class="col-12" id="<%=store.getStrid()%>">
                                        <div class="section-title text-center pt-62">
                                            <h2><%=store.getStrname()%></h2>
                                        </div>
                                    </div>

                                    <%
                                        List<PojoProducts> productls = DaoProducts.getProductByStrid(store.getStrid());
                                        for (PojoProducts products : productls) {
                                            varified = DaoVarifyStore.getVerified(products.getStrid());
                                            if (varified != 1) {
                                                continue;
                                            }
                                            String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
                                            //out.println(products.getPrdid());
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
                                                    <span class="regular-price">$<%=products.getPrdprize()%>/<%=products.getPrdunit()%></span>
                                                    <input type="hidden" class="store-id" value="12">
                                                    <input type="hidden" class="product-id" value="21">
                                                    <span class="old-price"><del></del></span>
                                                </div>
                                                <div class="product-action-button"  style="margin-top:10px;">
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
                                                    <div class="mt-2" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- product grid item end -->
                                    <!-- product list item start -->
                                    <div class="product-list-item mb-30">
                                        <div class="product-thumb">
                                            <a href="product-details.html">
                                                <img src="<%=products.getImgpath()%>" alt="">
                                            </a>

                                        </div>
                                        <div class="product-content-list">
                                            <div class="ratings">
                                                <%
                                                    int rat = Math.round(DaoProductsReview.getOverallReviewBYprdid(products.getPrdid()));
                                                    if (rat != 0) {
                                                        for (int i = 1; i <= 5; i++) {
                                                            if (i > rat) {
                                                                break;
                                                            }
                                                            out.println("<span><i class=\"ion-android-star\"></i></span>");
                                                        }
                                                    } else {
                                                        out.println("Not rated");
                                                    }
                                                %>
                                            </div>
                                            <div class="product-name">
                                                <h4><a href="single-product.jsp?prdid=<%=products.getPrdid()%>&prdname=<%=products.getPrdname()%>"><%=products.getPrdname()%></a>
                                                    <h5 class="h5">
                                                        <%=store.getStrname()%>
                                                    </h5>
                                                    (<%=products.getPrdpurchasedbycstm()%>)
                                                </h4>
                                            </div>
                                            <div class="price-box">
                                                <span class="regular-price">$<%=products.getPrdprize()%>/<%=products.getPrdunit()%></span>
                                                <span class="old-price"><del>$130.00</del></span>
                                            </div>
                                            <p><%=products.getPrddescription()%></p>
                                            <div class="">
                                                <div class="product-action-button" style="margin-top:10px;">
                                                    <%
                                                        sts = DaoATC.getOrdSts(cstmid, products.getPrdid());
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
                                                    <div class="mt-2" onclick="location.href = 'compare.jsp?pid=<%=products.getPrdid()%>&cid=<%=cstmid%>'"><a href="#">add to compare</a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <% }
                                        }%> 

                                    <!-- product list item end -->
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- shop main wrapper end -->
                </div>
            </div>
            <!-- page main wrapper end -->
        </main>
        <!-- main wrapper end -->

        <jsp:include page="footer.jsp"></jsp:include>

        <!-- Scroll to top start -->
        <div class="scroll-top not-visible">
            <i class="fa fa-angle-up"></i>
        </div>
        <!-- Scroll to Top End -->

        <!--=======================Javascript============================-->
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $(".dropdown-menu li").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
        <!--=== Aajax Request ===-->
        <script src="assets/js/ajaxrequest.js"></script>
        <!--=== All Vendor Js ===-->
        <script src="assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="assets/js/active1.js"></script>
        <script src="assets/js/active.js"></script>

    </body>

</html>