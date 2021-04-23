
<%@page import="DAOs.DaoOrders"%>
<%@page import="POJOs.PojoUsers"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    }

    String lg = request.getParameter("lg");
    if (cstmid != 0 && lg != null) {
        session.removeAttribute("userpojo");
        session.setAttribute("cinfo", "You are logout!!");
        response.sendRedirect("login-register.jsp");
    }
%>

<style>
    .dropbtn {
        background-color: #4CAF50;
        color: white;
        padding: 16px;
        font-size: 16px;
        border: none;
    }

    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        width: 250px;
        position: absolute;
        background-color: white;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {background-color: #ddd;}

    .dropdown .dc1 {display: block;}
    .dropdown .dc2 {display: block;height: 200px;overflow-y: scroll;}
</style>

<jsp:include page="searchScript.jsp"></jsp:include>
    <!-- Start Header Area -->
    <header class="header-area">
        <!-- header top start -->
        <div class="header-top">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3">
                        <div class="logo">
                            <a href="index.jsp">
                                <img src="assets/img/logo/logo.png" width="250px" alt="Brand Logo">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="header-settings-area">
                            <div class="header-top-left">
                                <nav>
                                    <ul class="d-flex justify-content-center">
                                        <li>
                                            <div class="dropdown header-top-dropdown">
                                                <a class="dropdown-toggle" id="myaccount" data-toggle="dropdown"
                                                   aria-haspopup="true" aria-expanded="false">
                                                    my account
                                                    <i class="fa fa-angle-down"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="myaccount">
                                                    <a class="dropdown-item" href="my-account.jsp">my account</a>
                                                    <a class="dropdown-item" href="about-us.jsp">about us</a>
                                                <%
                                                    if (cstmid == 0) {
                                                %>
                                                <a class="dropdown-item" href="login-register.jsp">
                                                    login/register</a>
                                                    <% } else {%>
                                                <a class="dropdown-item" href="header.jsp?lg=<%=cstmid%>" >logout</a>
                                                <% } %>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <div class="header-top-right">
                            <div class="header-search-box dropdown">
                                <form autocomplete="off">
                                    <input type="text" id="Itemshop" placeholder="Search By Shop or Product">

                                    <div class="dropdown-content dc1" id="showList">

                                    </div>
                                </form>                                
                            </div>
                            <div class="mini-cart-wrap">
                                <button onclick="location.href = 'cart.jsp'"><i class="ion-bag"></i>
                                    <span class="notification">

                                        <%
                                                    System.out.println("Hello");
                                            if (session.getAttribute("userpojo") != null) {
                                                PojoUsers us = (PojoUsers) session.getAttribute("userpojo");
                                                int csid = us.getCstmid();
                                                out.println(DaoOrders.getOrderCnt(csid));
                                            } else {
                                                out.println(0);
                                            }
                                        %>

                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- header top end -->

    <!-- main menu start -->
    <div class="main-menu-area sticky">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="main-menu">
                        <div class="sticky-logo">
                            <a href="index.html">
                                <img src="assets/img/logo/logo_sticky.png" alt="brand logo">
                            </a>
                        </div>
                        <!-- main menu navbar start -->
                        <nav id="mobile-menu" aria-label="">
                            <ul>
                                <li><a href="index.jsp">Home</a></li>
                                <li>
                                    <a href="shop-grid-full-4-col.jsp">shop</a>
                                </li>
                                <li><a href="compare.jsp">Compare</a></li>
                                <li><a href="track-order.jsp">track order</a></li>
                                <li><a href="contact-us.jsp">Contact</a></li>
                            </ul>
                        </nav>
                        <!-- main menu navbar end -->
                    </div>
                </div>
                <div class="col-12 d-block d-lg-none">
                    <div class="mobile-menu"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- main menu end -->

</header>
<!-- end Header Area -->