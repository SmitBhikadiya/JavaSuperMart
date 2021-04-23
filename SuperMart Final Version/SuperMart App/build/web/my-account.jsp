
<%@page import="POJOs.PojoFeedback"%>
<%@page import="DAOs.DaoFeedback"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    PojoUsers user = null;
    int cstmid = 0;
    String cstmname = "";
    String cstmaddress = "";
    String cstmcontact = "";
    String cstmemail = "";
    String cstmpassword = "";
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmname = user.getCstmname();
        cstmid = user.getCstmid();
        cstmaddress = user.getCstmaddress();
        cstmcontact = user.getCstmcontact();
        cstmpassword = user.getCstmpassword();
        cstmemail = user.getCstmemail();
    } else {
        response.sendRedirect("login-register.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">


    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>SuperMart-My-Account</title>
        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
        
        <style>
            .single-input-item i {
                visibility: hidden;
                position: absolute;
                top: 52px;
                right: 15px;
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
                                        <h2>Your Account</h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">my account</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- breadcrumb area end -->

                <!-- my account wrapper start -->
                <div class="my-account-wrapper pt-60 pb-60">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <!-- My Account Page Start -->
                                <div class="myaccount-page-wrapper">
                                    <!-- My Account Tab Menu Start -->
                                    <div class="row">
                                        <div class="col-lg-3 col-md-4">
                                            <div class="myaccount-tab-menu nav" role="tablist">
                                                <a href="#account-info" class="active" data-toggle="tab"><i class="fa fa-user"></i>
                                                    Account
                                                    Details</a>
                                                <a href="#orders" data-toggle="tab"><i class="fa fa-cart-arrow-down"></i>
                                                    Orders History</a>
                                                <a href="#payment-method" data-toggle="tab"><i class="fa fa-credit-card"></i>
                                                    Payment
                                                    Method</a>
                                                <a href="#address-edit" data-toggle="tab"><i class="fa fa-map-marker"></i>
                                                    address</a>
                                                <a href="header.jsp?lg=<%=cstmid%>"><i class="fa fa-sign-out"></i> Logout</a>
                                            </div>
                                        </div>
                                        <!-- My Account Tab Menu End -->

                                        <!-- My Account Tab Content Start -->
                                        <div class="col-lg-9 col-md-8">
                                            <div class="tab-content" id="myaccountContent">


                                                <!-- Single Tab Content Start -->
                                                <div class="tab-pane fade" id="orders" role="tabpanel">
                                                    <div class="myaccount-content">
                                                        <h3>Orders</h3>
                                                        <div class="myaccount-table table-responsive text-center">
                                                            <table class="table table-bordered">
                                                                <thead class="thead-light">
                                                                    <tr>
                                                                        <th>Order</th>
                                                                        <th>Date</th>
                                                                        <th>Store</th>
                                                                        <th>Feedback</th>
                                                                        <th>Bill</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                <%
                                                                    List<PojoOrderHistory> list = DaoOrderHistory.getOrderHistoryByCstmid(cstmid);
                                                                    int i = 1;
                                                                    for (PojoOrderHistory pojo : list) {
                                                                        String strname = DaoStore.getStoreById(pojo.getStrid()).getStrname();
                                                                        PojoFeedback feed = DaoFeedback.getFeedbackByordid(pojo.getOrdid());
                                                                        int feedid = 0;
                                                                        if(feed!=null){
                                                                            feedid = feed.getOrdratid();
                                                                        }
                                                                %>
                                                                <tr>
                                                                    <td><%=i++%></td>
                                                                    <td><%=pojo.getDeliveredtime()%></td>
                                                                    <td><%=strname%></td>
                                                                    <td><a href="feedback.jsp?ordid=<%=pojo.getOrdid()%>&feedid=<%=feedid%>">feedback</a></td>
                                                                    <td><a href="order-history.jsp?id=<%=pojo.getOrdhistoryid()%>"
                                                                           class="btn btn-dark text-white">View</a></td>
                                                                </tr>
                                                                <% }%>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Single Tab Content End -->

                                            <!-- Single Tab Content Start -->
                                            <div class="tab-pane fade" id="payment-method" role="tabpanel">
                                                <div class="myaccount-content">
                                                    <h3>Payment Method</h3>
                                                    <p class="saved-message" title="Cash On Delivery">COD</p>
                                                </div>
                                            </div>
                                            <!-- Single Tab Content End -->

                                            <!-- Single Tab Content Start -->
                                            <div class="tab-pane fade" id="address-edit" role="tabpanel">
                                                <div class="myaccount-content">
                                                    <h3>Billing Address</h3>
                                                    <address>
                                                        <p><strong><%=cstmname%></strong></p>
                                                        <p><%=cstmaddress%></p>
                                                        <p>Mobile: <%=cstmcontact%></p>
                                                    </address>

                                                </div>
                                            </div>
                                            <!-- Single Tab Content End -->

                                            <!-- Single Tab Content Start -->
                                            <div class="tab-pane fade show active" id="account-info" role="tabpanel">
                                                <div class="myaccount-content">
                                                    <h3>Account Details</h3>
                                                    <div class="account-details-form">
                                                        <form action="UserSignup" method="POST">
                                                            <input type="hidden" name="cstmid" value="<%=cstmid%>">

                                                            <div class="single-input-item">
                                                                <label for="Your Name" class="required">Your
                                                                    Name</label>
                                                                <input type="text" id="display-name"
                                                                       placeholder="Full Name" name="cname" value="<%=cstmname%>" />
                                                                <i class="fas fa-check-circle"></i>
                                                                <i class="fas fa-exclamation-circle"></i>
                                                            </div>
                                                            <div class="single-input-item">
                                                                <label for="email" class="required">Email Address</label>
                                                                <input type="email" id="email"
                                                                       placeholder="Email Address" name="cemail" value="<%=cstmemail%>" />
                                                                <i class="fas fa-check-circle"></i>
                                                                <i class="fas fa-exclamation-circle"></i>
                                                                <input type="hidden" name="ccpwd" value="<%=cstmpassword%>">
                                                            </div>
                                                            <div class="single-input-item">
                                                                <label for="address" class="required">Billing Address</label>
                                                                <input type="text" id="address"
                                                                       placeholder="Enter Address" name="cadd" value="<%=cstmaddress%>" />
                                                                <i class="fas fa-check-circle"></i>
                                                                <i class="fas fa-exclamation-circle"></i>
                                                            </div>
                                                            <div class="single-input-item">
                                                                <label for="contact" class="required">Contact</label>
                                                                <input type="number" max="9999999999" min="1000000000" step="1" id="contact"
                                                                       placeholder="Enter Contact" name="ccontact" value="<%=cstmcontact%>" />
                                                                <i class="fas fa-check-circle"></i>
                                                                <i class="fas fa-exclamation-circle"></i>
                                                            </div>
                                                            <div class="single-input-item">
                                                                <button class="btn btn__bg btn__sqr" id="update" name="update">Save Changes</button>
                                                            </div>
                                                        </form>
                                                        <form action="UserSignup" class="mt-3" method="POST">
                                                            <input type="hidden" name="cstmid" value="<%=cstmid%>">
                                                            <fieldset>
                                                                <legend>Password change</legend>
                                                                <div class="single-input-item">
                                                                    <input type="hidden" name="cemail" value="<%=cstmemail%>">
                                                                    <label for="current-pwd" class="required">Current
                                                                        Password</label>
                                                                    <input type="password" id="current-pwd"
                                                                           placeholder="Current Password" name="ccpwd" />
                                                                    <i class="fas fa-check-circle"></i>
                                                                    <i class="fas fa-exclamation-circle"></i>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-lg-6">
                                                                        <div class="single-input-item">
                                                                            <label for="new-pwd" class="required">New
                                                                                Password</label>
                                                                            <input type="password" id="new-pwd"
                                                                                   placeholder="New Password" name="cnpwd" />
                                                                            <i class="fas fa-check-circle"></i>
                                                                            <i class="fas fa-exclamation-circle"></i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <div class="single-input-item">
                                                                            <label for="confirm-pwd"
                                                                                   class="required">Confirm
                                                                                Password</label>
                                                                            <input type="password" id="confirm-pwd"
                                                                                   placeholder="Confirm Password" />
                                                                            <i class="fas fa-check-circle"></i>
                                                                            <i class="fas fa-exclamation-circle"></i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                            <div class="single-input-item">
                                                                <button class="btn btn__bg btn__sqr" name="update" id="update1">Save Changes</button>
                                                            </div>
                                                        </form>        
                                                    </div>
                                                </div>
                                            </div> <!-- Single Tab Content End -->
                                        </div>
                                    </div> <!-- My Account Tab Content End -->
                                </div>
                            </div> <!-- My Account Page End -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- my account wrapper end -->
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
    </body>


    <!-- Mirrored from htmldemo.hasthemes.com/selena/selena/my-account.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 15 Feb 2021 10:23:15 GMT -->

</html>