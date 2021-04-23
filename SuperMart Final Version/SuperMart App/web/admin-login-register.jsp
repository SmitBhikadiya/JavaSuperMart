
<%@page import="POJOs.PojoAdminUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String info = "";
    if (session.getAttribute("info") != null) {
        info = session.getAttribute("info").toString();
    }
%>
<%
    PojoAdminUser pojo = (PojoAdminUser) session.getAttribute("adminuser");
    String email = "";
    String name = "";
    String password = "";
    String usertype = "";
    String type = (String) session.getAttribute("type");
    if(type!=null){
        usertype = type.toLowerCase();
    }
    System.out.println(usertype);
    if (pojo != null) {
        name = pojo.getAdname();
        email = pojo.getAdemail();
        password = pojo.getAdpassword();
        //info = usertype + "<a href='#'>" + name + "</a>" + " is logging";
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
        <title>SuperMart-Admin</title>
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

    <body onload="myfun()">


        <!-- main wrapper start -->
        <main>

            <!-- breadcrumb area start -->
            <div class="breadcrumb-area">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="breadcrumb-wrap text-center">
                                <nav aria-label="breadcrumb">
                                    <h2>Admin Login-Register</h2>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.jsp">Shop</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">login-register</li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% if (info != "") {
            %>
            <div class="container">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <strong><h4 class="text-center"><%
                        out.println(info);
                        info = "";
                        session.removeAttribute("info");
                            %></h4></strong>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
            <%}%>
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
                                    <form action="Admin_SignIn" method="post">
                                        <div class="single-input-item">
                                            <select name="admintype" id="typeS">
                                                <% if (usertype.equals("servicer")) { %>
                                                <option value="shopkeeper">Shopkeeper</option>
                                                <option value="servicer" selected="true">Servicer</option>
                                                <option value="admin" >Admin</option>
                                                <% } else if (usertype.equals("admin")) {%>
                                                    <option value="shopkeeper">Shopkeeper</option>
                                                    <option value="servicer">Servicer</option>
                                                    <option value="admin" selected="true">Admin</option>
                                                <%} else { %>
                                                <option value="shopkeeper" selected="true">Shopkeeper</option>
                                                <option value="servicer">Servicer</option>
                                                <option value="admin" >Admin</option>
                                                <% }%>
                                            </select>
                                        </div>
                                        <div class="single-input-item">
                                            <input type="email" id="email" placeholder="Enter your Email" value="<%=email%>" name="adminemail"  />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>    
                                        <div class="single-input-item">
                                            <input type="password" id="password" placeholder="Enter your Password" value="<%=password%>" name="adminpwd"  />
                                            <i class="fas fa-check-circle"></i>
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>                                      
                                       <!-- <div class="single-input-item">
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
                                        </div>  -->                                         
                                        <div class="single-input-item">
                                            <button class="btn btn__bg btn__sqr" id="login">Login</button>
                                            <%
                                                if(name!=""){
                                            %>
                                            <a class="btn btn__bg btn__sqr text-white" href="UserLogout?id=fhdsff">Logout</a>
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
                                    <form action="Admin_SignUp" method="post">
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
                                            <select name="admintype" id="typeR">
                                                <option value="shopkeeper" selected="true">Admin Type:- Shopkeeper</option>
                                                <option value="servicer">Servicer</option>
                                            </select>
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
        <script>
        function myfun() {
            var niceselect = document.getElementsByClassName('nice-select');
            for(var i=0; i< niceselect.length; i++){
                niceselect[i].hidden = true;
            }
            var type = document.getElementById('typeS');
            type.removeAttribute('style');
            var type1 = document.getElementById('typeR');
            type1.removeAttribute('style');
        }
        </script>
    </body>

</html>