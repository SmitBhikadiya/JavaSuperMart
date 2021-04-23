
<%@page import="POJOs.PojoATC"%>
<%@page import="java.util.List"%>
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

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart-Cart</title>

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
                                        <h2>Cart</h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">cart</li>
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
                        <div class="row">
                            <div class="col-lg-12">
                                <!-- Cart Table Area -->
                                <div class="cart-table table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="pro-thumbnail">Thumbnail</th>
                                                <th class="pro-title">Product</th>
                                                <th class="pro-price">Price</th>
                                                <th class="pro-price">Discount</th>
                                                <th class="pro-quantity">Quantity</th>
                                                <th class="pro-subtotal">Total</th>
                                                <th class="pro-remove">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <form action="#" method="GET">
                                        <%
                                            List<PojoATC> atc = DaoATC.getATCByCstmId(cstmid);
                                           // int total_dis = 0;
                                            for (PojoATC pojo : atc) {
                                                int dis = ((pojo.getPrdprize() * pojo.getPrddiscount()) / 100) + pojo.getPrdprize();
                                                //out.println(pojo.getPrdname());
                                               // total_dis = total_dis + dis;
%>
                                        <tr class="item">
                                        <input type="hidden" class="ordlistid" value="<%=pojo.getOrdlistid()%>">
                                        <td class="pro-thumbnail"><a href="#"><img class="img-fluid" src="<%=pojo.getImgpath()%>" alt="Product" /></a></td>
                                        <td class="pro-title"><a href="#"><%=pojo.getPrdname()%></a></td>
                                        <td class="pro-price"><span><%=pojo.getPrdprize()%>₹</span></td>
                                        <td class="pro-discount"><span><% 
                                                            if(pojo.getPrddiscount()!=0){%>
                                                            <span class="old-price"><del><% out.println(dis); %></del><p class="text-success"><%=pojo.getPrddiscount()%>% off</p></span>
                                                            <% }else{ out.println("-"); } %></span></td>
                                        <td class="pass-quantity"><input class="form-control" type="number" value="<%=pojo.getPrdqty()%>" min="1" max="<%=pojo.getStock()%>"></td>
                                        <td class="pro-subtotal"><span><%=pojo.getPrdprize() * pojo.getPrdqty()%>₹</span></td>
                                        <td class="pro-remove"><a href="delOrder.jsp?olid=<%=pojo.getOrdlistid()%>"><i class="fa fa-trash-o"></i></a></td>
                                        </tr>
                                        <% }%>
                                    </form>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-5 ml-auto">
                            <!-- Cart Calculation Area -->
                            <div class="cart-calculator-wrapper">
                                <div class="cart-calculate-items">
                                    <h3>Cart Totals</h3>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <tr class="ship_charge">
                                                <td colspan="2" class="text-danger">go to checkout to see more about order details</td>
                                            </tr>
                                            <tr class="total">
                                                <td>Total</td>
                                                <td class="total-amount">300₹</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <a onclick="proceedtocheckout(this)" class="btn btn-dark text-white d-block">Proceed To Checkout</a>
                            </div>
                        </div>
                    </div>
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
        <!--=== Ajax Request ===-->
        <script src="assets/js/ajaxrequest.js"></script>
        <!--=== All Vendor Js ===-->
        <script src="assets/js/vendor.js"></script>
        <!--=== All Plugins Js ===-->
        <script src="assets/js/plugins.js"></script>
        <!--=== Active Js ===-->
        <script src="assets/js/active.js"></script>
        
        <script src="assets/js/active1.js"></script>

        <script> 
                                    function proceedtocheckout(event) {
                                                var ordlist = [];
                                                $('.item').each(function () {
                                                     var ordlsid = parseInt($(this).children(".ordlistid").val());
                                                     var prdqty = parseInt($(this).children(".pass-quantity").find("input").val());
                                                     var prdtotal = parseInt($(this).children(".pro-subtotal").text().replace("₹",""));
                                                     ordlist.push(ordlsid);
                                                     ordlist.push(prdqty);
                                                     ordlist.push(prdtotal);
                                                });
                                                console.table(ordlist);

                                                $.ajax({
                                                    type: "POST",
                                                    url: "OrderListUpdate",
                                                    data: {data : JSON.stringify(ordlist)},
                                                    
                                                    cache:false,
                                                    success: function (data) {
                                                        window.location.href = "checkout.jsp";
                                                    }
                                                });
                                                
                                            }
                                    $(document).ready(function () {

                                        /* Set rates */
                                        var fadeTime = 100;
                                        recalculateCart();
                                        /* Assign actions */
                                        $('.pass-quantity input').change(function () {
                                            updateQuantity(this);
                                        });

                                        $('.pro-remove').click(function () {
                                            removeItem(this);
                                        });


                                        /* Recalculate cart */
                                        function recalculateCart() {
                                            var subtotal = 0;

                                            /* Sum up row totals */
                                            $('.item').each(function () {
                                                var item_total = parseFloat($(this).children('.pro-subtotal').text().replace("₹", ""));
                                                subtotal += item_total;
                                            });
                                            var shipcharge = 0;
                                            $(".sub-total-amount").text(subtotal+"₹");

                                            /* Calculate totals */
                                            if (subtotal >= 500) {
                                                $(".shipping-charge").text("0₹");
                                            } else {
                                                shipcharge = 0;
                                                $(".shipping-charge").text("0₹");
                                            }
                                            var total = subtotal + shipcharge;
                                            $(".total-amount").text(total+"₹");
                                        }


                                        /* Update quantity */
                                        function updateQuantity(quantityInput) {
                                            /* Calculate line price */
                                            //alert($(quantityInput).val());
                                            var productRow = $(quantityInput).parent().parent();
                                            var price = parseFloat(productRow.children('.pro-price').text().replace("₹", ""));

                                            var quantity = $(quantityInput).val();
                                            if (quantity <= 0) {
                                                $(quantityInput).val("1");
                                                quantity = 1;
                                            }
                                            var linePrice = price * quantity;

                                            /* Update line price display and recalc cart totals */
                                            productRow.children('.pro-subtotal').each(function () {
                                                $(this).fadeOut(fadeTime, function () {
                                                    $(this).text(linePrice.toFixed(2)+"₹");
                                                    recalculateCart();
                                                    $(this).fadeIn(fadeTime);
                                                });
                                            });
                                        }

                                        /* Remove item from cart */
                                        function removeItem(removeButton) {
                                            /* Remove row from DOM and recalc cart total */
                                            var productRow = $(removeButton).parent();
                                            productRow.slideUp(fadeTime, function () {
                                                productRow.remove();
                                                recalculateCart();
                                            });
                                        }
                                        // refrence link : https://www.solodev.com/blog/web-design/how-to-use-number-type-inputs-to-dynamically-change-a-shopping-cart-total.stml
                                    });
        </script>
    </body>


    <!-- Mirrored from htmldemo.hasthemes.com/selena/selena/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 15 Feb 2021 10:23:30 GMT -->
</html>