
<%@page import="POJOs.PojoUsers"%>
<%@page import="DAOs.DaoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    PojoUsers pojo = null;
    String email = "";
    String password = "";
    int cstmid = 0;
    String name = "";
  
    String info = "";
    if (session.getAttribute("userpojo") != null) {
        pojo = (PojoUsers) session.getAttribute("userpojo");
        email = pojo.getCstmemail();
        password = pojo.getCstmpassword();
        cstmid = pojo.getCstmid();
        name = pojo.getCstmname();
        info = "<small class='text-success mt-3'>"+name+" are logging</small>";
    } else {
        if (session.getAttribute("email") != null) {
            email = session.getAttribute("email").toString();
        }
    }
    if (session.getAttribute("cinfo") != null) {
        info = session.getAttribute("cinfo").toString();
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
        <title>SuperMart-Login-Register</title>
        <!--=== All Plugins CSS ===-->
        <link href="assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="assets/css/style.css" rel="stylesheet">

        <!-- Modernizer JS -->
        <script src="assets/js/modernizr-2.8.3.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />


    </head>

    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <!-- main wrapper start -->
            <main>
                <% if(info!=""){
                %>
                <div class="container">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <strong><h4 class="text-center"><% 
                    out.println(info);
                    session.removeAttribute("cinfo");
                    %></h4></strong>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                    </div>
                <%}%>
                <!-- breadcrumb area start -->
                <div class="breadcrumb-area">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="breadcrumb-wrap text-center">
                                    <nav aria-label="breadcrumb">
                                        <h2>shop</h2>
                                        <ul class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">login-register</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- breadcrumb area end -->

                <!-- login register wrapper start -->
                <div class="login-register-wrapper pt-60 pb-60">
                    <div class="container">
                        <div class="member-area-from-wrap">
                            <div class="row">
                                <!-- Login Content Start -->
                                <div class="col-lg-6">
                                    <div class="login-reg-form-wrap  pr-lg-50">
                                        <h2>Sign In</h2>
                                    <form action="UserSignin" method="post">
                                        <div class="single-input-item ">
                                            <input type="email" id="email" placeholder="Enter your Email" value="<%=email%>" name="cemail" />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                            <!--<small>Error message</small>-->
                                        </div>
                                        <div class="single-input-item ">
                                            <input type="password" id="password" placeholder="Enter your Password" value="<%=password%>" name="cpwd" />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                            <!--<small>Error message</small>-->
                                        </div>
                                        <!--<div class="single-input-item">
                                            <div
                                                class="login-reg-form-meta d-flex align-items-center justify-content-between">
                                                <div class="remember-meta">
                                                    <div class="custom-control custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input" name="rem" id="rememberMe">
                                                        <label class="custom-control-label" for="rememberMe">Remember
                                                            Me</label>
                                                    </div>
                                                </div>
                                                <a href="#" class="forget-pwd">Forget Password?</a>
                                            </div>
                                        </div>-->
                                        <div class="single-input-item">
                                            <button class="btn btn__bg btn__sqr" id="login">Login</button>
                                            <%
                                                if(cstmid!=0){
                                            %>
                                            <a class="btn btn__bg btn__sqr text-white" href="header.jsp?lg=<%=cstmid%>">Logout</a>
                                            <% } %>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- Login Content End -->

                            <!-- Register Content Start -->
                            <div class="col-lg-6">
                                <div class="login-reg-form-wrap mt-md-60 mt-sm-60">
                                    <h2>Singup Form</h2>
                                    <form action="UserSignup" method="post">
                                        <div class="single-input-item">
                                            <input type="text" id="cname" placeholder="Full Name" name="cname"  />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div class="single-input-item">
                                            <input type="email" id="cemail" placeholder="Enter your Email" name="cemail"   />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div class="single-input-item">
                                            <input type="number" id="cmobile" min="1000000000" max="9999999999" step="1"
                                                   placeholder="Enter your Mobile" name="ccontact"  />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div class="single-input-item">
                                            <input type="text" id="caddress" placeholder="Enter your Address" name="cadd"  />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="single-input-item">
                                                    <input type="password" id="cpsw" placeholder="Enter your Password" name="ccpwd"  />
                                                    <i class="fas fa-check-circle"></i>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="single-input-item">
                                            <button class="btn btn__bg btn__sqr" id="register">Register</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- Register Content End -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- login register wrapper end -->
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


    <!-- Mirrored from htmldemo.hasthemes.com/selena/selena/login-register.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 15 Feb 2021 10:23:15 GMT -->

</html>