
<%@page import="DAOs.DaoAdminUser"%>
<%@page import="POJOs.PojoUsers"%>
<%@page import="DAOs.DaoUsers"%>
<%@page import="DAOs.DaoFeedback"%>
<%@page import="POJOs.PojoFeedback"%>
<%@page import="POJOs.PojoOrders"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="DAOs.DaoOrders"%>
<%@page import="POJOs.PojoOrdersStatus"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoOrdersList"%>
<%@page import="DAOs.DaoOrdersList"%>
<%@page import="java.util.List"%>
<%@page import="POJOs.PojoOrderRequest"%>
<%@page import="DAOs.DaoOrderRequest"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="DAOs.DaoShopkeeper"%>
<%@page import="POJOs.PojoATC"%>
<%@page import="POJOs.PojoATC"%>
<%@page import="DAOs.DaoOrdersStatus"%>
<%@page import="POJOs.PojoAdminUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String aid = request.getParameter("adid");
    if (aid != null) {
        String aname = request.getParameter("adminname");
        String aemail = request.getParameter("adminemail");
        String acontact = request.getParameter("admincontact");
        String apwd = request.getParameter("adminpwd");
        String aadd = request.getParameter("adminaddress");
        DaoAdminUser.updateAdminBy(new PojoAdminUser(Integer.parseInt(aid), aname, aemail, acontact, apwd, aadd));
        System.out.println("Servicer update successfully");
    }
%>

<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("skuser");
    String name = "";
    String strname = "";
    int adid = 0;
    int strid = 0;
    String type = "";
    System.out.println("h");
    if (user != null) {
        user = DaoAdminUser.getAdminById(user.getAdid());
        System.out.println("h");
        adid = user.getAdid();
        name = user.getAdname();
        System.out.println("h");
        if (!user.getAdtype().equals("shopkeeper")) {
            response.sendRedirect("../admin-login-register.jsp");
        } else {
            type = user.getAdtype();
            strid = DaoShopkeeper.getShopkeeperById(adid).getStrid();
            System.out.println(strid);
            if (strid == 0) {
                response.sendRedirect("skStoreRegistration.jsp");
            } else {
                strname = DaoStore.getStoreById(strid).getStrname();
            }
        }
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
    System.out.println("h");
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="static/bootstrap/bootstrap.min.css">
        <!-- External CSS -->
        <link rel="stylesheet" href="static/css/skDashboard.css">
        <link rel="stylesheet" href="static/css/skcard.css">

        <title>Shopkeeper-Dashboard</title>

        <!--=== All Plugins CSS ===-->
        <link href="../assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="../assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="../assets/css/style.css" rel="stylesheet">
        <!--=== my own css ===-->
        <link href="../assets/css/mycss.css" rel="stylesheet">

        <style>
            *{
                scroll-behavior: smooth;
            }
            .jumboLink:hover {
                text-decoration: none;
            }

            .accordion {
                position: relative;
                background-color: #eee;
                color: #444;
                cursor: pointer;
                padding: 18px;
                width: 100%;
                border: none;
                text-align: left;
                outline: none;
                font-size: 17px;
                transition: 0.4s;
            }

            .active1, .accordion:hover {
                background-color: #ccc;
            }

            .accordion:after {
                content: '\2630';
                position: absolute;
                top: 35%;
                right: 3%;
                color: #777;
                font-weight: bold;
                float: right;
                font-size: 20px;
                margin-left: 5px;
            }

            .active1:after {
                content: "\2716";
            }

            .panel {
                padding: 0 18px;
                background-color: white;
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.2s ease-out;
            }
            .content{
                display: flex;
                flex-direction: row;
            }

            /* back to top btn */
            #myBtn {
                display: none;
                position: fixed;
                bottom: 20px;
                right: 30px;
                z-index: 99;
                font-size: 18px;
                border: none;
                outline: none;
                color: white;
                cursor: pointer;
                border-radius: 4px;
            }

            #myBtn:hover {
                background-color: #555;
            }
        </style>
    </head>

    <body>
        <div class="modal" id="Add_Shopkeeper">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row">
                                <div class="col-12 col-md-12 pt45 pb20">
                                    <div class="text-center bg-gray p-2">
                                        <h4>Update Shopkeeper</h4>
                                    </div>
                                    <hr style="border: 1px solid gray;">
                                    <div class="col-lg-12">
                                        <div class="login-reg-form-wrap mt-md-60 mt-sm-60">
                                            <!--<h2>Singup Form</h2>-->
                                            <form action="shopkeeperDashboard.jsp" method="post">
                                                <input type="hidden" name="adid" id="cadid">
                                                <div class="single-input-item">
                                                    <input type="text" id="cname" placeholder="Full Name" name="adminname"  />
                                                    <i class="fas fa-check-circle"></i>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                </div>
                                                <div class="single-input-item">
                                                    <input type="email" id="cemail" placeholder="Enter your Email" name="adminemail"   />
                                                    <i class="fas fa-check-circle"></i>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                </div>
                                                <div class="single-input-item">
                                                    <input type="number" id="cmobile" min="1000000000" max="9999999999" step="1"
                                                           placeholder="Enter your Mobile" name="admincontact"  />
                                                    <i class="fas fa-check-circle"></i>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                </div>

                                                <div class="single-input-item">
                                                    <input type="password" id="cpsw" placeholder="Enter your Password" name="adminpwd"  />
                                                    <i class="fas fa-check-circle"></i>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                </div>
                                                <div class="single-input-item">
                                                    <input type="text" id="caddress" placeholder="Enter your Address" name="adminaddress"  />
                                                    <i class="fas fa-check-circle"></i>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                </div>

                                                <div class="single-input-item">
                                                    <button class="btn btn_bg btn_sqr" id="register">Update</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <hr style="border: 1px solid gray;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
        <div class="modal" id="quick_view">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row">
                                <div class="col-12 col-md-10 pt45 pb20">
                                    <div class="row justify-content-between">
                                        <div id="ordered" class="order-tracking">
                                            <span class="is-complete"></span>
                                            <p>Ordered<br><span class="arrivaltime"></span></p>
                                        </div>
                                        <div id="accepted" class="order-tracking">
                                            <span class="is-complete"></span>
                                            <p>Order Accepted<br></p>
                                        </div>
                                        <div id="ontheway" class="order-tracking">
                                            <span class="is-complete"></span>
                                            <p>Reached To Shop<br></p>
                                        </div>
                                        <div id="delivered" class="order-tracking">
                                            <span class="is-complete"></span>
                                            <p>Delivered<br><span class="deliveredtime"></span></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="mt-3 d-block justify-content-center">
                                        <div class="mr-2 text-black">Servicer : <strong class="acceptby">NA</strong></div>
                                        <div>Contact : <strong class="acceptcon">NA</strong></div>
                                        <div>Approximate Time : <strong class="deliveryat">NA</strong></div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Start Header Area -->
        <header class="header-area">
            <!-- header top start -->
            <div class="header-top">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-3">
                            <div class="logo">
                                <a href="index.jsp">
                                    <img src="../assets/img/logo/logo.png" width="250px" alt="Brand Logo">
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <div class="header-settings-area">
                                <div class="header-top-left">
                                    <div><%=name%></div>
                                    <div><%=strname%></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- header top end -->

            <!-- main menu start -->
            <div class="main-menu-area">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="main-menu">
                                <div class="sticky-logo">
                                    <a href="index.html">
                                        <img src="../assets/img/logo/logo_sticky.png" alt="brand logo">
                                    </a>
                                </div>
                                <!-- main menu navbar start -->
                                <nav id="mobile-menu" aria-label="">
                                    <ul>
                                        <li><a href="index.jsp">Home</a></li>
                                        <li>
                                            <a href="skStoreRegistration.jsp">My Store</a>
                                        </li>
                                        <li><a href="#">Order <i class="fa fa-angle-down"></i></a>
                                            <ul class="dropdown">
                                                <li><a href="shopkeeperDashboard.jsp">Latest Request</a></li>
                                                <li><a href="#order-pending">Pending Orders</a></li> 
                                                <li><a href="#order-history">Order History</a></li>
                                            </ul>
                                        </li>
                                        <li>
                                            <input type="hidden" id="adid" value="<%=adid%>">
                                            <a onclick="updateMe(this)" data-toggle="modal"
                                               data-target="#Add_Shopkeeper">
                                                <span data-toggle="tooltip" title="Add Shopkeeper">Account</span>
                                            </a>
                                        </li>
                                        <li><a href="../Admin_Logout?type=<%=type%>">Logout</a></li>
                                    </ul>
                                </nav>
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

        <!--All remaining Orders-->

        <div class="container" id="latest-request" style="margin-bottom:25px; ">
            <div class="text-center mt-2 bg-gray p-2">
                <h4>Orders Request</h4>
            </div><hr>
            <div class="">
                <%
                    if (strid != 0) {
                        //PojoStore store = DaoStore.getStoreById(strid);
                        //System.out.println(">>"+store.getStrhavingserviser());
                        List<PojoOrderRequest> pojol = DaoOrderRequest.getOrderDataByStrid(strid, 1, 0, 1);
                        if (pojol.size() > 0) {
                            int i = 1;
                            String paymethod = "";
                            for (PojoOrderRequest order : pojol) {
                                //out.println(order.getOrdid());
                                paymethod = order.getPaymethod();
                                int ordid = order.getOrdid();

                %>
                <div class="checkout-page-wrapper row mt-3">
                    <!-- Order Summary Details -->
                    <div class="col-lg-12">
                        <div class="order-summary-details mt-md-50 mt-sm-50 checkout-billing-details-wrap checkoutaccordion" id="checkOutAccordion">
                            <button class="accordion">
                                <table style="">
                                    <tr>
                                        <td>Order : </td>
                                        <td><a href="#"><%=i++%></a></td>
                                    </tr>
                                    <tr>
                                        <td>From : </td>
                                        <td><a href="#"><%=order.getCstmaddress()%></a></td>
                                    </tr>
                                    <tr>
                                        <td>At : </td>
                                        <td><a href="#"><%=order.getOrdarrivalat()%></a></td>
                                    </tr>
                                </table>
                            </button>
                            <div class="panel">
                                <!-- Order Summary Table -->
                                <div class="order-summary-table table-responsive text-center">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Image</th>
                                                <th>Products</th>
                                                <th>Prize</th>
                                                <th>Quantity</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                //System.out.println("Hello");
                                                int total = 0;
                                                List<PojoOrdersList> list = DaoOrdersList.getOrdByOrdid(order.getOrdid());
                                                for (PojoOrdersList ls : list) {
                                                    //System.out.println("Hello" + ls.getPrdid());
                                                    PojoProducts prd = DaoProducts.getProductsById(ls.getPrdid());
                                                    //System.out.println("Hello" + prd.getPrdname());
                                                    total += ls.getPrdtotalamount();
                                            %>
                                            <tr>
                                                <td class="pro-thumbnail"><a href="#"><img class="img-fluid" src="../<%=prd.getImgpath()%>"
                                                                                           alt="Product" width="60px"/></a></td>

                                                <td><a href="../single-product.jsp?prdid=<%=prd.getPrdid()%>"> <%=prd.getPrdname()%> </a></td>
                                                <td><%=prd.getPrdprize()%>₹/<%=prd.getPrdunit()%></td>
                                                <td><%=ls.getPrdqty()%></td>
                                                <% System.out.println("Hello");%>
                                                <td><%=ls.getPrdtotalamount()%>₹</td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3"></td>
                                                <td>Payment method</td>
                                        <input class="order-id" type="hidden" value="">
                                        <td class="order-total" title="Cash On Dilevery"><strong><%=paymethod%></strong></td>
                                        </tr>
                                        <tr>
                                                <td colspan="3"></td>
                                                <td>Delivery Charge</td>
                                       
                                        <td class="order-total" title="Delivery Charge"><strong><%=order.getOrdcharge()%></strong></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
                                            <td>Total Amount</td>
                                            <td class=""><kbd><%=total+order.getOrdcharge()%>₹</kbd></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
                                            <td>Set Approximately Time</td>
                                            <td>
                                                <div class="d-flex justify-content-center align-item-center">
                                                    <input type="hidden" class="order_id" value="<%=ordid%>">
                                                    <input type="hidden" class="ad_id" value="<%=adid%>" >
                                                    <div class="mr-3">
                                                        <select name="aprox time" class="aprox_time" required>
                                                            <option value="00:15">00:15 hour</option>
                                                            <option value="00:30" selected>00:30 hour</option>
                                                            <option value="00:45">00:45 hour</option>
                                                            <option value="01:00">01:00 hour</option>
                                                            <option value="01:30">01:30 hour</option>
                                                            <option value="02:00">02:00 hour</option>
                                                            <option value="02:30">02:30 hour</option>
                                                            <option value="03:00">03:00 hour</option>
                                                            <option value="03:30">03:30 hour</option>
                                                            <option value="04:00">04:00 hour</option>
                                                            <option value="05:00">05:00 hour</option>
                                                            <option value="06:00">06:00 hour</option>
                                                        </select>
                                                    </div>
                                                    <div class="mr-3"><a href="#" onclick="acceptMe(this)" style="color:white; background-color: #62d2a2; padding:10px; border-radius: 5px">Accept</a></div>
                                                    <div><a href="#" style="color:red;" onclick="cancelMe(this)">Cancel</a></div>
                                                </div>
                                            </td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <!-- Order Payment Method -->
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                    if (DaoStore.getStoreById(strid).getStrhavingserviser() == 0) {
                %>
                <div class="cart-main-wrapper pb-60">
                    <div class="container">
                        <%
                            List<PojoOrders> orders = DaoOrders.getOrdersByStrid(strid);
                            int orderno = 0;
                            if (orders.size() <= 0) {
                                out.println("<h5 class='text-center'>Not Found Any Request For tracking</h5>");
                            }
                            String billing_add = "";
                            String customer_name = "";
                            for (PojoOrders pojo : orders) {

                                PojoUsers puser = DaoUsers.getUserById(pojo.getCstmid());
                                int ordid = pojo.getOrdid();
                                billing_add = puser.getCstmaddress();
                                customer_name = puser.getCstmname();
                                strid = pojo.getStrid();

                                List<PojoOrdersList> pojolist = DaoOrdersList.getOrdByOrdid(ordid);
                                if (pojolist.size() == 0) {
                                    DaoOrders.deleteOrderById(ordid);
                                    PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                                    if (sts != null) {
                                        DaoOrdersStatus.deleteOrderById(ordid);
                                    }
                                    continue;
                                }
                                List<PojoATC> list = DaoATC.getATCByIds(strid, ordid, 1);
                                if (list.size() > 0) {
                                    int total = 0;
                                    orderno = orderno + 1;
                        %>
                        <div class="row mt-5">
                            <!-- Order Summary Details -->
                            <div class="col-lg-12">
                                <div class="order-summary-details mt-md-50 mt-sm-50">
                                    <button class="accordion">
                                        <table style="">
                                            <tr>
                                                <td>Order : </td>
                                                <td><a href="#"><%=orderno%></a></td>
                                            </tr>
                                            <tr>
                                                <td>Customer : </td>
                                                <td><a href="#"><%=customer_name%></a></td>
                                            </tr>
                                            <tr>
                                                <td>Address : </td>
                                                <td><a href="#"><%=billing_add%></a></td>
                                            </tr>
                                        </table>
                                    </button>

                                    <div class="order-summary-content panel">
                                        <!-- Order Summary Table -->
                                        <div class="order-summary-table table-responsive text-center">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Image</th>
                                                        <th>Products</th>
                                                        <th>Quantity</th>
                                                        <th>Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (PojoATC atc : list) {
                                                            int subtotal = atc.getPrdprize() * atc.getPrdqty();
                                                            total = total + subtotal;
                                                    %>
                                                    <tr>
                                                        <td class="pro-thumbnail"><a href="#"><img class="img-fluid" src="../<%=atc.getImgpath()%>"
                                                                                                   alt="Product" width="60px"/></a></td>

                                                        <td><a href="product-detailes.jsp"><%=atc.getPrdname()%></a></td>
                                                        <td><%=atc.getPrdqty()%><%=atc.getPrdunit()%> x <%=atc.getPrdprize()%>₹</td>
                                                        <td><%=atc.getPrdqty() * atc.getPrdprize()%>₹</td>
                                                    </tr>

                                                    <% }%>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td>Sub Total</td>
                                                <input class="order-id" type="hidden" value="<%=ordid%>">
                                                <td class="order-total"><strong><%=total%>₹</strong></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <td>Delivery Charge</td>
                                                    <td class="d-flex justify-content-center">
                                                        <ul class="shipping-type">
                                                            <li>
                                                                <div class="custom-control custom-radio">
                                                                    <%=pojo.getOrdcharge()%>₹
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <td>Total Amount</td>
                                                    <td class="order-sub-total"><h2><%=total+pojo.getOrdcharge()%>₹</h2></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <td>Track Your Order</td>
                                                <input class="mystrid" type="hidden" value="<%=strid%>">
                                                <input class="myordid" type="hidden" value="<%=ordid%>">
                                                <td class="order-sub-total"><button onclick="trackMe(this)" class="pro-track" data-toggle="modal"
                                                                                    data-target="#quick_view"><span data-toggle="tooltip"
                                                                                    title="Track Your Order">Track</span></button></td>

                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                        <!-- Order Payment Method -->

                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }
                            }%>
                    </div>
                </div>
                <%
                } else {
                %>
                <p class='text-center'>No more request found (<a href='shopkeeperDashboard.jsp'>Refresh</a>)</p>
                <% }
                        }
                    }
                %>
            </div>
        </div>
        <%
            String html = "";
            List<PojoOrderRequest> allpending = DaoOrderRequest.getOrderDataByStrid(strid, 1, 1, 1);
            if (allpending.size() > 0) {
        %>
        <div class="container">
            <div class="text-center mt-2 bg-gray p-2"><h4>Accepted Orders</h4></div><hr><br>
            <div class="shoplist">
                <%
                    int i = 1;
                    for (PojoOrderRequest pending : allpending) {
                        int ordid = pending.getOrdid();
                        PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                        List<PojoOrdersList> ls = DaoOrdersList.getOrdByOrdid(ordid);

                %>
                <div class="main1">
                    <div class="container1" style='overflow-y:scroll;flex-direction: column;'>
                        <div class="pt-2" style="background-color:#ccc;width: 100%;text-align: center;"><h4>Order No : <%=i++%></h4></div>
                        <div class="content">
                            <div class="p-3">
                                <div><h5> Customer name</h5>>> <%=pending.getCstmname()%></div>
                                <div><h5>Address</h5>>> <%=pending.getCstmaddress()%></div>
                                <div><h5> Contact</h5>>> <%=pending.getCstmcontact()%></div>
                                <div><h5> Aprox Time</h5>>> <%=sts.getDeliverytime()%></div>
                                <div><h5> Payment Method</h5>>> <%=pending.getPaymethod()%></div>
                                <div><h5> Total Bill</h5>>> $<%=pending.getOrdtotalbill()%></div>
                                <div class="mt-3">
                                    <form action="../SK_Store_Order_Manage" method="POST">
                                        <input type="hidden" name='odid' value="<%=pending.getOrdid()%>">
                                        <input type="text" name="pin" class="form-control" placeholder="Enter Pin">
                                        <button class="mt-2 form-control btn btn-success text-white">Delivered</button>
                                    </form>
                                </div>
                            </div>
                            <div class="p-3" style="overflow-x:scroll;">
                                <table class="table">
                                    <tr>
                                        <th>Product</th>
                                        <th>Prize * Qty</th>
                                        <th>Total</th>
                                    </tr>
                                    <%
                                        for (PojoOrdersList po : ls) {
                                            PojoProducts prd = DaoProducts.getProductsById(po.getPrdid());
                                    %>
                                    <tr>
                                        <td><a href='single-product.jsp?prdid="<%=prd.getPrdid()%>"' > <%=prd.getPrdname()%></a></td>
                                        <td>$ <%=prd.getPrdprize()%> * <%=po.getPrdqty()%> </td>
                                        <td>$ <%=po.getPrdtotalamount()%></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <% } %>

        <div class="card mt-5" id="order-history">
            <div class="card-header text-center">
                <h4>Orders History</h4>
            </div>
            <div class="container mt-3">
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Order</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Address</th>
                            <th>Servicer</th>
                            <th>Feedback</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<PojoOrderHistory> list = DaoOrderHistory.getOrderHistoryByStrid(strid);
                            int i = 1;
                            for (PojoOrderHistory pojo : list) {
                                PojoFeedback feed = DaoFeedback.getFeedbackByordid(pojo.getOrdid());
                                int feedid = 0;
                                if (feed != null) {
                                    feedid = feed.getOrdratid();
                                }
                        %>
                        <tr>
                            <td><%=i++%></td>
                            <td><%=pojo.getDeliveredtime()%></td>
                            <td><%=pojo.getBillingname()%></td>
                            <td><%=pojo.getBillingaddress()%></td>

                            <% System.out.println(pojo.getAcceptedtype());
                                if (pojo.getAcceptedtype().equals("Servicer")) {%>
                            <td><%=pojo.getDeliveredby()%> (<%="servicer"%>)</td>
                            <% } else {%>
                            <td><%=pojo.getDeliveredby()%> (self)</td>
                            <% }%>
                            <td><a href="../feedback.jsp?viewid=<%=feedid%>">feedback</a></td>
                            <td><a href="order-history.jsp?id=<%=pojo.getOrdhistoryid()%>"
                                   class="btn btn-dark text-white">View</a></td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <img src="static/img/top.png" onclick="topFunction()" id="myBtn" title="Go to top" width="50px" alt="">

        <script>
            function updateMe(me) {
                var adid = $(me).parent().find("#adid").val();
                // alert(adid);
                var upd = "upd";
                $.ajax({
                    url: "../Admin_SignUp",
                    type: "POST",
                    data: {adid: adid, upd: upd},
                    success: function (res) {
                        // alert(res);
                        var arr = res.split("$");
                        if (arr.length > 0) {
                            $("#cadid").val(arr[0]);
                            $("#cname").val(arr[1]);
                            $("#cemail").val(arr[2]);
                            $("#cmobile").val(arr[3]);
                            $("#cpsw").val(arr[4]);
                            $("#caddress").val(arr[5]);
                        }
                    }
                });
            }
        </script>

        <script>

            function trackMe(me) {
                $(me).removeAttr("disabled");
            }

            function acceptMe(me) {
                var parent = $(me).parent().parent();
                var odid = $(parent).find(".order_id").val();
                var adid = $(parent).find(".ad_id").val();
                var aprox_time = $(parent).find(".aprox_time").val();
                //alert(odid + " " + aprox_time);
                if (confirm("Are you sure?\nWill You deliver this Order in " + aprox_time + " h?\ndid you chaeck product avaiblity before accept?")) {
                    var order = $(parent).closest(".checkout-page-wrapper");
                    order.fadeOut("slow");
                    $.ajax({
                        url: "../SK_Store_Order_Manage",
                        data: {odid: odid, atime: aprox_time, adid: adid},
                        success: function (res) {
                            if (res == 0 || res == "0") {
                                alert("Order has been cancelled by the customer");
                            } else {
                                $(".shoplist").html(res);
                            }
                            window.location.href = "shopkeeperDashboard.jsp";
                        }
                    });

                }
            }

            function cancelMe(me) {
                var parent = $(me).parent().parent();
                var odid = $(parent).find(".order_id").val();
                var adid = $(parent).find(".ad_id").val();
                //alert(odid);
                if (confirm("Are You Sure?")) {
                    var order = $(parent).closest(".checkout-page-wrapper");
                    order.fadeOut("slow");
                    $.ajax({
                        url: "../SK_Store_Order_Manage",
                        data: {ordrmid: odid, adid: adid},
                        success: function (res) {
                            //alert(res);
                        }
                    });

                }
            }

            window.addEventListener('resize', function () {
                if ($(window).width() < 550) {
                    $("#table-responsive").addClass('table-responsive');
                } else {
                    $("#table-responsive").removeClass('table-responsive');
                }
            });


            //Get the button
            var mybutton = document.getElementById("myBtn");

            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction()
            };

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    mybutton.style.display = "block";
                } else {
                    mybutton.style.display = "none";
                }
            }

            // When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }

        </script>
        <script>
            var acc = document.getElementsByClassName("accordion");
            var i;

            for (i = 0; i < acc.length; i++) {
                acc[i].addEventListener("click", function () {
                    this.classList.toggle("active1");
                    var panel = this.nextElementSibling;
                    if (panel.style.maxHeight) {
                        panel.style.maxHeight = null;
                    } else {
                        panel.style.maxHeight = panel.scrollHeight + "px";
                    }
                });
            }
        </script>

        <script>
            var interval;
            function mangeThings(data, odid, mystr) {
                var ordered = $("#ordered");
                var accepted = $("#accepted");
                var ontheway = $("#ontheway");
                var delivered = $("#delivered");

                if (data == "null") {
                    ordered.addClass("completed");
                    accepted.addClass("completed");
                    ontheway.addClass("completed");
                    delivered.addClass("completed");
                    $(".acceptby").parent().hide();
                    $(".acceptcon").parent().hide();
                    $(".deliveryat").parent().hide();
                    $(".arrivaltime").hide();
                    $(".accepttime").hide();
                    return;
                }
                var arr = data.split("@");
                var name = arr[0];
                var asts = arr[1];
                var dileverytime = arr[2];
                var contact = arr[3];
                var orderarrivalat = arr[4];
                var accepttime = arr[6];

                $(".acceptby").parent().show();
                $(".acceptcon").parent().show();
                $(".deliveryat").parent().show();

                if (name == "null" || name == "cancel") {
                    name = "NA";
                }
                if (contact == "null") {
                    contact = "NA";
                }
                if (dileverytime == "null") {
                    dileverytime = "NA";
                }
                $(".acceptby").text(name);
                $(".acceptcon").text(contact);
                $(".deliveryat").text(dileverytime);
                $(".arrivaltime").text("at: " + orderarrivalat);
                $(".accepttime").text("at: " + accepttime);
                //alert(asts);
                if (asts == 0) {
                    ordered.addClass("completed");
                    accepted.removeClass("completed");
                    delivered.removeClass("completed");
                    ontheway.removeClass("completed");
                } else if (asts == 1) {
                    ordered.addClass("completed");
                    accepted.addClass("completed");
                    ontheway.addClass("completed");
                    delivered.removeClass("completed");

                } else if (asts == 2) {
                    ordered.addClass("completed");
                    accepted.addClass("completed");
                    ontheway.removeClass("completed");
                    delivered.removeClass("completed");

                } else if (asts == 3) {
                    ordered.addClass("completed");
                    accepted.addClass("completed");
                    ontheway.addClass("completed");
                    delivered.removeClass("completed");

                } else if (asts == 5) {
                    ordered.removeClass("completed");
                    accepted.removeClass("completed");
                    ontheway.removeClass("completed");
                    delivered.removeClass("completed");

                    interval = setInterval(function () {
                        myFunc();
                    }, 1000);
                } else if (name == "NA") {
                    ordered.removeClass("completed");
                    accepted.removeClass("completed");
                    delivered.removeClass("completed");
                    ontheway.removeClass("completed");
                    alert("Order is cancelled by the customer");
                    interval = setInterval(function () {
                        myFunc();
                    }, 1000);
                } else {

                }
            }


            function myFunc() {
                clearInterval(interval);
                window.location.reload();
            }

            function trackMe(event) {
                var odid = $(event).parent().parent().find(".myordid").val();
                var mystr = $(event).parent().parent().find(".mystrid").val();
                //alert(odid);
                $.ajax({
                    type: "POST",
                    url: "../OrderListUpdate",
                    data: {trkdata: odid},
                    success: function (data) {
                        //alert(data);
                        mangeThings(data, odid, mystr);
                    }
                });
            }
        </script>

        <!-- External JS -->
        <script src="static/js/skDashboard.js"></script>
        <script src="static/js/vendor.js"></script>

        <!--=== All Vendor Js ===-->
        <script src="../assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="../assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="../assets/js/active.js"></script>

        <script src="../assets/js/active1.js"></script>
        <!-- Modernizer JS -->
        <script src="../assets/js/modernizr-2.8.3.min.js"></script>

    </body>

</html>