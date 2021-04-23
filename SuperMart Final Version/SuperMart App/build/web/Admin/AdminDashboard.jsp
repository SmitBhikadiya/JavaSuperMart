
<%@page import="DAOs.DaoAdminUser"%>
<%@page import="POJOs.PojoAdminUser"%>
<%@page import="java.util.List"%>

<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("admin");
    int adid = 0;
    String name = "";
    String type = "";
    if (user != null) {
        adid = user.getAdid();
        if (!user.getAdtype().equals("admin")) {
            System.out.println("adid"+adid);
            response.sendRedirect("../admin-login-register.jsp");
        } else{
            type = user.getAdtype();
            name = user.getAdname();
        }
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
%>

<%
    String rmadid = request.getParameter("rmadid");
    if (rmadid != null) {
        DaoAdminUser.deleteAdminById(Integer.parseInt(rmadid));
        session.setAttribute("data", "Product Remove Successfully");
    }
%>
<%
    if(request.getParameter("Adid") != null){
        adid = Integer.parseInt(request.getParameter("Adid"));
        String adname = request.getParameter("Adname");
        String ademail = request.getParameter("Ademail");
        String adcon = request.getParameter("Adcon");
        String adAdd = request.getParameter("Adad");
        String adpa = request.getParameter("Adpa");
        DaoAdminUser.updateAdminBy(new PojoAdminUser(adid,adname,ademail,adcon,adAdd,adpa));
        session.setAttribute("data", "Product Remove Successfully");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="../static/bootstrap/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/4ae0bb5b6f.js" crossorigin="anonymous"></script>

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
        <title>Admin-Dashboard</title>
    </head>

    <body>
        
        <jsp:include page="admin-header.jsp"></jsp:include>

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
                                        <h4>ADD ADMIN</h4>
                                    </div>
                                    <hr style="border: 1px solid gray;">
                                    <div class="col-lg-12">
                                        <div class="login-reg-form-wrap mt-md-60 mt-sm-60">
                                            <!--<h2>Singup Form</h2>-->
                                            <form action="../Admin_SignUp" method="post">
                                                <input type="hidden" name="admintype" value="admin">
                                                <input type="hidden" name="atype" value="admin">
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
                                                    <button class="btn btn_bg btn_sqr" id="register">ADD</button>
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
        
        <section>
            <div class="text-center mt-2 bg-gray p-2 d-flex justify-content-center">
                <h2 class="mr-3">Admin Data</h2>
                <button onclick="" class="pro-track" data-toggle="modal"
                        data-target="#quick_view">
                    <span data-toggle="tooltip" title="Add Admin">Add Admin</span>
                </button>
            </div><hr style="border: 1px solid gray;">

            <div class="container-fluid">
                <table class="table table1 table-hover" style="height: 59vh;">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th scope="col" class="sticky-top">Id</th>
                            <th scope="col" class="sticky-top">Name</th>
                            <th scope="col" class="sticky-top">Mail</th>
                            <th scope="col" class="sticky-top">Contact</th>
                            <th scope="col" class="sticky-top">Address</th>
                            <th scope="col" class="sticky-top">Password</th>
                            <th scope="col" class="sticky-top">Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                            List<PojoAdminUser> admins = DaoAdminUser.getadUser("admin");
                            for (PojoAdminUser admin : admins) {
                        %>
                        <tr>
                            <th scope="row" id="adid"><%=admin.getAdid()%></th>
                            <td >
                                <input class="text-center" id="adname" style="border: none;" type="text" value="<%=admin.getAdname()%>">
                            </td>
                            <td>
                                <input class="text-center" id="ademail" style="border: none;" type="text" value="<%=admin.getAdemail()%>">
                            </td>
                            <td>
                                <input class="text-center" id="adcon" style="border: none;" type="text" value="<%=admin.getAdcontact()%>">
                            </td>
                            <td>
                                <input class="text-center" id="adpa" style="border: none;" type="text" value="<%=admin.getAdpassword()%>">
                            </td>
                            <td>
                                <input class="text-center" id="adAdd" style="border: none;" type="text" value="<%=admin.getAdaddress()%>">
                            </td>
                            
                            <td style="cursor: pointer;" >
                                <a onclick="Admin(this)" style="font-size: 18px;color: blue;" ><i class="fas fa-user-edit"></i></a>
                                <a href="AdminDashboard.jsp?rmadid=<%=admin.getAdid()%>" style="font-size: 18px;color: red;"><i class="fas fa-trash-alt"></i></a>
                            </td>
                        </tr>
                        <%
                            }%>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- External JS -->
        <script>
            function Admin(e) {
                var adid = $(e).parent().parent().find('#adid').text();
                var adname = $(e).parent().parent().find('#adname').val();
                var ademail = $(e).parent().parent().find('#ademail').val();
                var adcon = $(e).parent().parent().find('#adcon').val();
                var adAdd = $(e).parent().parent().find('#adAdd').val();
                var adpa = $(e).parent().parent().find('#adpa').val();
//                alert(adpa);
                $.ajax({
                    url: "AdminDashboard.jsp",
                    type: "POST",
                    data: {Adid: adid, Adname : adname, Ademail : ademail, Adcon : adcon, Adad : adAdd, Adpa : adpa},
                    success: function () {
                    }
                });
            }
            
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
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