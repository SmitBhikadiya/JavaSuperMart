
<%@page import="Utils.MasterSetting"%>
<%@page import="Utils.TimeF"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalTime"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="POJOs.PojoOrdersStatus"%>
<%@page import="DAOs.DaoOrdersStatus"%>
<%@page import="DAOs.DaoOrdersList"%>
<%@page import="POJOs.PojoOrdersList"%>
<%@page import="DAOs.DaoOrders"%>
<%@page import="POJOs.PojoOrders"%>
<%@page import="java.util.List"%>
<%@page import="POJOs.PojoATC"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="POJOs.PojoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PojoUsers user = null;
    int cstmid = 0;
    String name = "";
    String email = "";
    String contact = "";
    String add = "";
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        name = user.getCstmname();
        email = user.getCstmemail();
        contact = user.getCstmcontact();
        add = user.getCstmaddress();
        cstmid = user.getCstmid();
        System.out.println(user.getCstmname());
    } else {
        session.setAttribute("info", "please login first");
        request.getRequestDispatcher("login-register.jsp").forward(request, response);
    }
    System.out.println(cstmid);
%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart-Checkout</title>
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
            <main>
                <!-- breadcrumb area start -->
                <div class="breadcrumb-area">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="breadcrumb-wrap text-center">
                                    <nav aria-label="breadcrumb">
                                        <h2>checkout<a href="cart.jsp"> Back To Cart</a></h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">checkout</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- breadcrumb area end -->

                <!-- checkout main wrapper start -->
                <div class="checkout-page-wrapper pt-60 pb-54">
                    <div class="container">

                        <div class="row">
                            <!-- Checkout Billing Details -->
                            <div class="col-lg-6">
                                <div class="checkout-billing-details-wrap checkoutaccordion" id="checkOutAccordion">
                                    <h2 style="cursor: pointer"><span data-toggle="collapse" data-target="#billing">Billing Details <i class="fa fa-angle-down"></i></span></h2>
                                    <div class="billing-form-wrap collapse" id="billing" data-parent="#checkOutAccordion">

                                        <form action="#">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="single-input-item">
                                                        <label for="f_name" class="required">Full Name</label>
                                                        <input type="text" id="f_name" value="<%=name%>" placeholder="First Name" disabled="true"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="single-input-item">
                                            <label for="email" class="required">Email Address</label>
                                            <input type="email" id="email" placeholder="Email Address" value="<%=email%>" disabled="true" />
                                        </div>

                                        <div class="single-input-item">
                                            <label for="address" class="required mt-20">address</label>
                                            <input type="text" id="street-address" placeholder="address" value="<%=add%>"
                                                   disabled="true" />
                                            <a href="my-account.jsp">Change The Address</a>
                                        </div>

                                        <div class="single-input-item">
                                            <label for="phone">Contact</label>
                                            <input type="text" id="phone" value="<%=contact%>" placeholder="Contact" disabled="true" />
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        int flag = 0;
                        List<PojoOrders> orders = DaoOrders.getOrdersBy(cstmid);
                        int orderno = 0;
                        for (PojoOrders pojo : orders) {
                            PojoStore store = DaoStore.getStoreById(pojo.getStrid());
                            String strname = store.getStrname();
                            int ordid = pojo.getOrdid();
                            int strid = store.getStrid();

                            List<PojoOrdersList> pojolist = DaoOrdersList.getOrdByOrdid(ordid);
                            if (pojolist.size() == 0) {
                                DaoOrders.deleteOrderById(ordid);
                                PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                                if (sts != null) {
                                    DaoOrdersStatus.deleteOrderById(ordid);
                                }
                                continue;
                            }
                            List<PojoATC> list = DaoATC.getATCByIds(strid, ordid, 0);
                            int ship_charge = 0;
                            if (list.size() > 0) {
                                int total = 0;
                                orderno = orderno + 1;
                                flag = 1;
                    %>
                    <div class="row mt-5">
                        <!-- Order Summary Details -->
                        <div class="col-lg-12">
                            <div class="order-summary-details mt-md-50 mt-sm-50">
                                <h2>Order-<%=orderno%> : <%=strname%></h2>
                                <div class="order-summary-content">
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
                                                    <td class="pro-thumbnail"><a href="#"><img class="img-fluid" src="<%=atc.getImgpath()%>"
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
                                                            <div class="custom-control custom-radio charge">
                                                                <%

                                                                    if (total <= 50) {
                                                                        ship_charge = MasterSetting.LESS_50;
                                                                        out.println(ship_charge + "₹");
                                                                    } else if (total <= 150) {
                                                                        ship_charge = MasterSetting.LESS_150;
                                                                        out.println(ship_charge + "₹");
                                                                    } else {
                                                                        out.println(MasterSetting.ABOVE_150);
                                                                    }
                                                                %>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"></td>
                                                <td>Total Amount</td>
                                                <td class="order-sub-total"><h2><%=total+ship_charge%>₹</h2></td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                    <!-- Order Payment Method -->
                                    <div class="order-payment-method">
                                        <div class="single-payment-method show">
                                            <div class="payment-method-name">
                                                <div class="custom-control custom-radio">
                                                    <input type="radio" value="cash" class="custom-control-input"
                                                           checked />
                                                    <label class="custom-control-label" for="cashon">Cash On Delivery</label>
                                                </div>
                                            </div>
                                            <div class="payment-method-details" data-method="cash">
                                                <p>Pay with cash upon delivery.</p>
                                            </div>
                                        </div>
                                        <div class="single-payment-method show">
                                            <div class="payment-method-name">
                                                <div class="custom-control custom-radio">
                                                    <input type="radio" id="cashon" name="paymentmethod" value="cash1" class="custom-control-input" disabled="true"/>
                                                    <label class="custom-control-label" for="cashon">Online Payment : not available</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="summary-footer-area">
                                            <input type="hidden" class="ship" value="<%=ship_charge%>" >
                                            <div class="custom-control custom-checkbox mb-14">
                                                <input type="checkbox" class="custom-control-input" checked />
                                                <label class="custom-control-label" for="terms">I have read and agree to
                                                    the website <a title="There are no rules and regulation enjoy">terms and conditions.</a></label>
                                            </div>
                                            <%
                                                store = DaoStore.getStoreById(pojo.getStrid());
                                                String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());

                                                if (status == "Closed") {
                                                    out.println("<kbd class='bg-danger mr-3'> Store is closed right now </kbd><a href='checkout.jsp'>refresh</a>");
                                                } else {
                                            %>

                                            <button type="submit" onclick="placeOrder(this)" class="btn btn__bg">Place Order</button>                                            
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }
                        }%>
                    <% if (flag == 0) {
                            out.println("<h3 class='mt-3'><a href='cart.jsp'>Go To Cart</a> | <a href='index.jsp'>Continue Shopping | <a href='track-order.jsp'>Track Order</a></h3>");
                        }%>
                </div>
            </div>

            <!-- checkout main wrapper end -->
        </main>
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
        <script>

            function placeOrder(event) {
                var billtotal = parseInt($(event).parent().parent().parent().find(".order-total").text().replace("$", ""));
                var odid = parseInt($(event).parent().parent().parent().find(".order-id").val());
                //var address = $("#street-address").val();
                var ship = $(event).parent().find(".ship").val();
                var ordlist = [billtotal, odid];
                //alert(ship + " " + ordlist);
                $.ajax({
                    type: "POST",
                    url: "OrderListUpdate",
                    data: {checkdata: JSON.stringify(ordlist), ship: ship},
                    cache: false,
                    success: function (data) {
                        console.log(">>" + data);
                        if (data == 0 || data == "0") {
                            alert("The Store is closed right now");
                        }
                        window.location.href = "checkout.jsp";
                    }
                });
            }
        </script>
        <!--=== All Vendor Js ===-->
        <script src="assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="assets/js/active.js"></script>
        <script src="assets/js/active1.js"></script>
    </body>


    <!-- Mirrored from htmldemo.hasthemes.com/selena/selena/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 15 Feb 2021 10:23:31 GMT -->
</html>