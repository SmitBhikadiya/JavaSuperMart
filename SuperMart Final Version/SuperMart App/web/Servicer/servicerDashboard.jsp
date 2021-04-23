<%@page import="DAOs.DaoAdminUser"%>
<%@page import="DAOs.DaoFeedback"%>
<%@page import="POJOs.PojoFeedback"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="DAOs.DaoServicer"%>
<%@page import="POJOs.PojoServicerHistory"%>
<%@page import="DAOs.DaoServicerHistory"%>
<%@page import="POJOs.PojoAdminUser"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="POJOs.PojoUsers"%>
<%@page import="DAOs.DaoUsers"%>
<%@page import="POJOs.PojoOrders"%>
<%@page import="DAOs.DaoOrders"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="DAOs.DaoOrderRequest"%>
<%@page import="POJOs.PojoOrderRequest"%>
<%@page import="java.util.List"%>

<%
    String aid = request.getParameter("adid");
    int sid = 0;
    int adid = 0;
    String name = "";
    String type = "";
    if(aid!=null){
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
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("suser");
    if (user != null) {
        adid = user.getAdid();
        if (!user.getAdtype().equals("servicer")) {
            System.out.println("adid" + adid);
            response.sendRedirect("../admin-login-register.jsp");
        } else {
            PojoAdminUser a = DaoAdminUser.getAdminById(user.getAdid());
            type = a.getAdtype();
            name = a.getAdname();
            sid = DaoServicer.getServicerById(adid).getServicerid();
        }
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="../static/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- External CSS -->
        <link rel="stylesheet" href="../static/css/skDashboard.css">
        <link rel="stylesheet" href="../static/css/sDashboard.css">
        <!--=== All Plugins CSS ===-->
        <link href="../assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="../assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="../assets/css/style.css" rel="stylesheet">
        <!--=== my own css ===-->
        <link href="../assets/css/mycss.css" rel="stylesheet">
        <title>Servicer-Dashboard</title>
    </head>

    <body>

        <div class="modal" id="quick_view">
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
                                        <h4>Update Servicer</h4>
                                    </div>
                                    <hr style="border: 1px solid gray;">
                                    <div class="col-lg-12">
                                        <div class="login-reg-form-wrap mt-md-60 mt-sm-60">
                                            <!--<h2>Singup Form</h2>-->
                                            <form action="servicerDashboard.jsp" method="post">
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
                                    <div></div>
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
                                            <a href="">Account</a>
                                        </li>

                                        <li><a href="#">Order <i class="fa fa-angle-down"></i></a>
                                            <ul class="dropdown">
                                                <li><a href="#request">All Request </a></li>                                               
                                                <li><a href="servicerAccepted.jsp">Current Accepted</a></li>
                                                <li><a href="#history">Completed </a></li>                                               
                                            </ul>
                                        </li>
                                        <li>
                                            <input type="hidden" id="adid" value="<%=adid%>">
                                            <a onclick="updateMe(this)" data-toggle="modal"
                                               data-target="#quick_view">
                                                <span data-toggle="tooltip" title="Add Servicer">Account</span></a>
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



        <section id="request" style="margin-top: 10px;">

            <div class="section-heading text-center mb-5 p-1">All Request</div>

            <%
                List<PojoOrderRequest> li = DaoOrderRequest.getOrderDataByHaving(1, 0, 0);
                if (li.size() > 0) {
                    int i = 0;
                    for (PojoOrderRequest pojo : li) {
                        PojoOrders ord = DaoOrders.getOrdersByOrdid(pojo.getOrdid());
                        PojoStore str = DaoStore.getStoreById(ord.getStrid());
                        PojoUsers cstm = DaoUsers.getUserById(ord.getCstmid());
            %>
            <div class="mycard">
                <div class="d-flex flex-wrap form-group">
                    <div class="card-section col-md-1 text-center" style="margin-right: 0; width: 100%;">
                        <p>Sr.No</p>
                        <h5><%=++i%></h5>
                    </div>
                    <div class="card-section col-md-1 text-center">
                        <p>Time</p>
                        <h5><%=pojo.getOrdarrivalat()%></h5>
                    </div>
                    <div class="card-section col-md-5" style="margin-right: 0;">
                        <div>
                            <h5 title="place to pick order"><img src="../static/img/meterialIcon/store.png" alt="store"><%=str.getStrname()%></h5>
                        </div>
                        <div><i class="mr-1 fa fa-phone" aria-hidden="true"></i><%=str.getStrcontact()%></div>
                        <div>Add: <%=str.getStraddress()%> </div>
                    </div>
                    <div class="card-section col-md-4">
                        <div>
                            <h5 title="place to drop order"><img src="../static/img/meterialIcon/home.png" alt="home"><%=cstm.getCstmname()%></h5>
                        </div>
                        <div><i class="mr-1 fa fa-phone" aria-hidden="true"></i><%=cstm.getCstmcontact()%></div>
                        <div>Add: <%=cstm.getCstmaddress()%></div>
                    </div>
                    <div class="card-section col-md-1">
                        <p class="text-center">Action</p>
                        <div class="card-action-links">
                            <form style="display: inline-grid;" action="servicerAccepted.jsp" method="POST">
                                <input type="hidden" value="<%=ord.getOrdid()%>" name="ordid">
                                <select name="aproxtime" class="aprox_time" required>
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
                                <button class="btn btn-dark text-white mb-2">Accept</button>
                            </form>
                            <a href="#" onclick="">decline</a>
                        </div>
                    </div>
                </div>
            </div>

            <%
                    }
                } else {
                    out.println("<h4 class='text-center'>Order request Not found</h4><br><h5 class='text-center'><a href='servicerAccepted.jsp'>Go to Your Accepted</a></h5>");
                }
            %>
        </section>

        <section style="height: 100vh;" id="history">
            <div class="card" id="order-history">
                <div class="card-header text-center">
                    <h4>Orders History</h4>
                </div>
                <div class="container mt-3">
                    <table id="table-responsive" class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Order</th>
                                <th>Date</th>
                                <th>Customer</th>
                                <th>Address</th>
                                <th>Feedback</th>
                                <th>paid/order</th>

                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                System.out.println(">>" + sid);
                                List<PojoServicerHistory> history = DaoServicerHistory.getHistoryByServicerId(sid);
                                int i = 1;
                                int total = 0;
                                for (PojoServicerHistory po : history) {
                                    PojoOrderHistory pojo = DaoOrderHistory.getOrderHistoryById(po.getOrdhistoryid());
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
                                <td><a href="../feedback.jsp?viewid=<%=feedid%>">feedback</a></td>
                                <td>
                                    <%
                                        int payment = DaoServicerHistory.getHistoryPayment(sid);
                                        total = total + payment;
                                        out.println(payment + "/-");
                                    %>
                                </td>
                                <td><a href="order-history.jsp?id=<%=pojo.getOrdhistoryid()%>"
                                       class="btn btn-dark text-white">View</a></td>
                            </tr>
                            <% }%>
                            <tr>
                                <td colspan="5"></td>
                                <td colspan="2">Total Paid: <%=total%></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>


        <!-- External JS -->
        <script>
            const status = document.getElementById("status").innerText;
            if (status === "Available") {
                document.getElementById("status").setAttribute("style", "color:green;font-weight:650");
            }
            else {
                document.getElementById("status").setAttribute("style", "color:red;font-weight:650");
                document.getElementsByClassName("card-action-links")[0].setAttribute("onclick", "retutn false;");
            }
        </script>

        <script>
            window.addEventListener('resize', function () {
                if ($(window).width() < 550) {
                    $("#table-responsive").addClass('table-responsive');
                } else {
                    $("#table-responsive").removeClass('table-responsive');
                }
            });
        </script>

        <script>
            function updateMe(me) {
                var adid = $(me).parent().find("#adid").val();
                // alert(adid);
                var upd = "upd";
                $.ajax({
                    url: "../Admin_SignUp",
                    type: "POST",
                    data: {adid: adid,upd: upd},
                    success: function (res) {
                       // alert(res);
                       var arr = res.split("$");
                       if(arr.length > 0){
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