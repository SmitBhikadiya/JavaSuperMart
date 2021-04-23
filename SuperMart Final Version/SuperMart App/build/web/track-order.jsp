
<%@page import="DAOs.DaoOrdersStatus"%>
<%@page import="POJOs.PojoOrdersStatus"%>
<%@page import="POJOs.PojoOrdersList"%>
<%@page import="DAOs.DaoOrdersList"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoOrders"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="POJOs.PojoOrders"%>
<%@page import="java.util.List"%>
<%@page import="POJOs.PojoATC"%>
<%@page import="DAOs.DaoATC"%>
<%@page import="POJOs.PojoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    } else {
        session.setAttribute("info", "please login first");
        response.sendRedirect("login-register.jsp");
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
        <title>SuperMart-Track-Order</title>

        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>

        <style>
            .cancel{
                background-color: #bb0000;
                padding:8px;
                border: 1px solid red;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <!-- Quick view modal start -->

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
                                                <p>Order Accepted<br><span class="accepttime"></span></p>
                                            </div>
                                            <div id="ontheway" class="order-tracking">
                                                <span class="is-complete"></span>
                                                <p>On The Way<br></p>
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
                                            <div>Pin : <strong class="pin">NA</strong></div>
                                            <div class="msg"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Quick view modal end -->
            <!-- main wrapper start -->
            <main>
                <!-- breadcrumb area start -->
                <div class="breadcrumb-area">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="breadcrumb-wrap text-center">
                                    <nav aria-label="breadcrumb">
                                        <h2>Order Tracker</h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Track</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- breadcrumb area end -->

                <!-- cart main wrapper start -->
                <div class="cart-main-wrapper pt-60 pb-60">
                    <div class="container">
                    <%
                        List<PojoOrders> orders = DaoOrders.getOrdersBy(cstmid);
                        int orderno = 0;
                        if (orders.size() <= 0) {
                            out.println("<h4>Nothing To Track <strong><a href='index.jsp'>Go To Shop</a> | <a href='my-account.jsp'>Order History</a></strong></h4>");
                        }
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
                            List<PojoATC> list = DaoATC.getATCByIds(strid, ordid, 1);
                            if (list.size() > 0) {
                                int total = 0;
                                orderno = orderno + 1;

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
                                                    <td>$<%=atc.getPrdqty() * atc.getPrdprize()%></td>
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
                                                                <%=pojo.getOrdcharge()%>
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
                                            <td class="order-sub-total">
                                                <button onclick="trackMe(this)" class="pro-track" data-toggle="modal"
                                                        data-target="#quick_view">
                                                    <span data-toggle="tooltip" title="Track Your Order">Track</span>
                                                </button>
                                                <input type="hidden" id="atime">
                                                <a class="ml-3 cancel text-white" onclick="cancelMe(this)">Cancel</a>
                                                <p class="msg"></p>
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
                    <% }
                        }%>
                </div>
            </div>
            <!-- cart main wrapper end -->
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

        <!--=== All Vendor Js ===-->
        <script src="assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="assets/js/active.js"></script>
        <script src="assets/js/active1.js"></script>
        <script>
                                                    function cancelMe(me) {
                                                        var odid = $(me).parent().parent().find(".myordid").val();
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "OrderListUpdate",
                                                            data: {canid: odid},
                                                            success: function (data) {
                                                                myFunc(odid);
                                                                //alert("(Status : " + data + ")");
                                                            }
                                                        });
                                                    }
        </script>
        <script>
            // for canceling the order
            setMe();

            function setMe() {
                // alert();
                $(".cancel").each(function () {
                    var cancel = $(this);
                    var oid = $(this).parent().parent().find(".myordid").val();
                    //alert(oid);
                    $.get("OrderListUpdate", {ordid: oid}, function (res) {
                        //console.log(">>>>" + res);
                        if (res == "null" || res == "") {
                            $(cancel).parent().find(".msg").html("");
                            $(cancel).hide();
                            return;
                        }

                        var arr = res.split("@");
                        var st = arr[0];
                        var time = arr[1];
                        console.log(st + " " + time);
                        if (st == 0) {
                            $(cancel).show();
                        } else {
                            //console.log(time);
                            if ((st == 1 || st == 2 || st == 3) && time != "0") {

                                var t1 = new Date();
                                //console.log(time);
                                var t2 = new Date(time);
                                t2.setMinutes(t2.getMinutes() + 5);
                                // console.log(t1+".|."+t2);
                                var min1 = t1.getMinutes();
                                var min2 = t2.getMinutes();

                                var timer_int;
                                if (t1.getTime() < t2.getTime()) {
                                    $(cancel).show();
                                    $(cancel).parent().find(".msg").show();
                                    $(cancel).parent().find(".msg").html("<h5>You can cancel your up to " + (t2.getHours() + ":" + t2.getMinutes() + ":" + t2.getSeconds()) + " </h5>");

                                } else {
                                    $(cancel).parent().find(".msg").hide();
                                    $(cancel).hide();
                                    clearInterval(timer_int);
                                }
                            } else {
                                clearInterval(timer_int);
                                $(cancel).parent().find(".msg").html("");
                                $(cancel).hide();
                            }
                        }
                    });
                });
            }
            var int = setInterval(function () {
                setMe();
            }, 2000);

            // for tracking a order
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
                    $(".pin").parent().html("<h5 class='mt-3 bg-success p-1 text-light'>Order delivered to you successfully</h5><br><a href='my-account.jsp'>Go To Order History</a> | <a href='feedback.jsp?odid="+odid+"'>Your Feedback</a>");
                    return;
                }
                var arr = data.split("@");
                var name = arr[0];
                var asts = arr[1];
                var dileverytime = arr[2];
                var contact = arr[3];
                var orderarrivalat = arr[4];
                var pin = arr[5];
                var accepttime = arr[6];

                $(".acceptby").parent().show();
                $(".acceptcon").parent().show();
                $(".deliveryat").parent().show();

                if (name == "null") {
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
                $(".pin").text(pin);
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
                    $(".pin").parent().html("<h5 class='mt-3 bg-danger p-1 text-light'>Order has been canceled</h5>");
                    ordered.removeClass("completed");
                    accepted.removeClass("completed");
                    ontheway.removeClass("completed");
                    delivered.removeClass("completed");

                    interval = setInterval(function () {
                        myFunc(odid);
                    }, 1000);
                } else {
                    ordered.removeClass("completed");
                    accepted.removeClass("completed");
                    delivered.removeClass("completed");
                    ontheway.removeClass("completed");
                }
            }

            function myFunc(odid) {
                clearInterval(interval);
                $.ajax({
                    type: "POST",
                    url: "OrderListUpdate",
                    data: {ordhidsrr: odid},
                    success: function (data) {
                        if(confirm("Order has been cancel | please try later | go to cart")){
                            window.location.href='cart.jsp';
                        }else{
                            window.location.reload();
                        }
                        //alert("Order Cancel Due to Some issue please try again");
                    }
                });
            }

            function trackMe(event) {
                var odid = $(event).parent().parent().find(".myordid").val();
                var mystr = $(event).parent().parent().find(".mystrid").val();
                //alert(odid);
                $.ajax({
                    type: "POST",
                    url: "OrderListUpdate",
                    data: {trkdata: odid},
                    success: function (data) {
                        //alert(data);
                        mangeThings(data, odid, mystr);
                    }
                });
            }
        </script>

    </body>

</html>