<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="Utils.TimeF"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoCompare"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DaoCompare"%>
<%@page import="POJOs.PojoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
    int cstmid = 0;
    System.out.println("Hu");
    if (session.getAttribute("userpojo") != null) {
        PojoUsers pojo = (PojoUsers) session.getAttribute("userpojo");
        cstmid = pojo.getCstmid();
        System.out.println("User are logging");
    } else {
        response.sendRedirect("login-register.jsp");
    }
%>
<%
    if (request.getParameter("did") != null) {
        int cmprid = Integer.parseInt(request.getParameter("did"));
        DaoCompare.removeComparison(cmprid);
    }
%>
<%
    if (request.getParameter("pid") != null && request.getParameter("cid") != null) {
        int prdid = Integer.parseInt(request.getParameter("pid"));
        cstmid = Integer.parseInt(request.getParameter("cid"));
        PojoCompare pc = DaoCompare.getComparisonByIds(prdid, cstmid);
        if (pc == null) {
            DaoCompare.addComparison(new PojoCompare(prdid, cstmid));
        }
    }
%>

<%
    List<PojoCompare> comparation = DaoCompare.getComparison(cstmid);
%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart-Compare</title>
        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>


    </head>

    <body>

        <jsp:include page="header.jsp"></jsp:include>
            <!-- main wrapper start -->

            <!-- breadcrumb area start -->
            <div class="breadcrumb-area">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="breadcrumb-wrap text-center">
                                <nav aria-label="breadcrumb">
                                    <h2>Compare <a href="index.jsp">Back To Mart</a></h2>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">compare</li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- breadcrumb area end -->

            <!-- compare main wrapper start -->
            <div class="compare-page-wrapper pt-60 pb-60">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- Compare Page Content Start -->
                            <div class="compare-page-content-wrap">
                                <div class="compare-table table-responsive">
                                <%
                                    if (comparation.size() > 0 && cstmid != 0) {

                                        ArrayList<ArrayList<String>> list = new ArrayList();
                                        int i = 0;
                                        for (PojoCompare pojo : comparation) {
                                            System.out.println("hii");

                                            System.out.println(pojo.getCmprid() + " " + pojo.getPrdid() + " " + pojo.getCstmid());
                                            PojoProducts pojoprd = DaoProducts.getProductsById(pojo.getPrdid());
                                            if (pojoprd == null) {
                                                DaoCompare.removeComparison(pojo.getCmprid());
                                                response.sendRedirect("compare.jsp");
                                                return;
                                                //System.out.println("Comparation Remove from You bcz Product are not available");
                                            }
                                            String strname = DaoStore.getStoreById(pojoprd.getStrid()).getStrname();
                                            list.add(new ArrayList());
                                            list.get(i).add(pojoprd.getImgpath());
                                            list.get(i).add(pojoprd.getPrdname());
                                            System.out.println(pojoprd.getPrdcategory() + "<br>");
                                            list.get(i).add(pojoprd.getPrdcategory());
                                            list.get(i).add(pojoprd.getPrddescription());
                                            list.get(i).add(String.valueOf(pojoprd.getPrdprize()));
                                            list.get(i).add(String.valueOf(pojoprd.getPrdunit()));
                                            list.get(i).add(String.valueOf(pojoprd.getPrdtotalqty()));
                                            list.get(i).add(String.valueOf(pojoprd.getPrddiscount()));
                                            list.get(i).add(String.valueOf(pojoprd.getPrdid()));
                                            list.get(i).add(String.valueOf(pojo.getCmprid()));
                                            list.get(i).add(strname);
                                            System.out.println(list.get(i) + "<br>");
                                            i = i + 1;
                                        }
                                        System.out.println("hii");
                                %>
                                <table class="table table-bordered mb-0">
                                    <tbody>
                                        <tr>
                                            <td class="first-column">Product</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="product-image-title">
                                                <a class="image">
                                                    <img class="img-fluid" style="height:300px;" src="<%=list.get(i).get(0)%>" alt="Compare Product">
                                                </a>
                                                <a class="category"><%=list.get(i).get(2)%></a>
                                                <a class="title"><h4><%=list.get(i).get(1)%></h4></a>
                                            </td>
                                            <% } %>
                                        </tr>
                                        <tr>
                                            <td class="first-column">Shop Name</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="pro-stock"><%=list.get(i).get(10)%> </td>
                                            <% } %>
                                        </tr>
                                        <tr>
                                            <td class="first-column">Description</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="pro-desc">
                                                <%
                                                    if (list.get(i).get(3) == null) {
                                                        out.println("Best Qulity Products");
                                                    } else {
                                                        out.println(list.get(i).get(3));
                                                    }
                                                %>
                                            </td>
                                            <% } %>

                                        </tr>
                                        <tr>
                                            <td class="first-column">Price</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="pro-price">$<%=list.get(i).get(4)%>/<%=list.get(i).get(5)%></td>
                                            <% } %>
                                        </tr>
                                        <tr>
                                            <td class="first-column">Discount</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="pro-color"><%=list.get(i).get(7)%> %</td>
                                            <% } %>
                                        </tr>
                                        <tr>
                                            <td class="first-column">Stock</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="pro-stock"><%=list.get(i).get(6)%> <%=list.get(i).get(5)%></td>
                                            <% } %>
                                        </tr>
                                        <tr>
                                            <td class="first-column">Add to cart</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td>
                                                
                                                <%
                                                    PojoProducts products = DaoProducts.getProductsById(Integer.parseInt(list.get(i).get(8)));
                                                        PojoStore store = DaoStore.getStoreById(products.getStrid());
                                                        String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());
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
                                                
                                               <% } %>
                                        </tr>

                                        <tr>
                                            <td class="first-column">Remove</td>
                                            <% for (i = 0; i < list.size(); i++) {
                                            %>
                                            <td class="pro-remove">
                                                <button onclick="location.href = 'compare.jsp?did=<%=list.get(i).get(9)%>'"><i class="fa fa-trash-o"></i></button>
                                            </td>
                                            <% } %>
                                        </tr>
                                    </tbody>
                                </table>
                                <% } else {
                                        out.println("<h4 class='h4'>Comparation List is empty <a href='index.jsp'>Go To Mart</a></h4>");
                                    }
                                %>
                            </div>
                        </div>
                        <!-- Compare Page Content End -->
                    </div>
                </div>
            </div>
        </div>
        <!-- compare main wrapper end -->

        <!-- main wrapper end -->

        <!--== Start Footer Area Wrapper ==-->
        <jsp:include page="footer.jsp"></jsp:include>
        <!--== End Footer Area Wrapper ==-->

        <!-- Scroll to top start -->
        <div class="scroll-top not-visible">
            <i class="fa fa-angle-up"></i>
        </div>
        <!-- Scroll to Top End -->

        <!--=======================Javascript============================-->
        <!--=== Ajax Request ===-->
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