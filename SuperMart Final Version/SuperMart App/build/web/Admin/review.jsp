
<%@page import="DAOs.DaoStore"%>
<%@page import="DAOs.DaoProductsReview"%>
<%@page import="POJOs.PojoProductsReview"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="DAOs.DaoFeedback"%>
<%@page import="POJOs.PojoFeedback"%>
<%@page import="DAOs.DaoServicer"%>
<%@page import="DAOs.DaoServicerHistory"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoAdminUser"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DaoAdminUser"%>
<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("admin");
    int adid = 0;
    String name = "";
    String type = "";
    if (user != null) {
        adid = user.getAdid();
        if (!user.getAdtype().equals("admin")) {
            System.out.println("adid" + adid);
            response.sendRedirect("../admin-login-register.jsp");
        } else {
            type = user.getAdtype();
            name = user.getAdname();
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
        <title>Admin-Review</title>
        <style>
            @media only screen and (min-width: 1200px) {
                .table1{
                    width: 1142px !important ;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="admin-header.jsp"></jsp:include>
            <section>
                <div class="text-center mt-2 bg-gray p-2">
                    <h2 class="">Order-Reviews</h2>
                </div><hr style="border: 1px solid gray;">

                <div class="container">
                    <table class="table table1 table-hover table-bordered table-responsive" style="height: 59vh;">
                        <thead class="thead-dark text-center">
                            <tr>
                                <th scope="col" class="sticky-top">Feedback Id</th>
                                <th scope="col" class="sticky-top">Order Id</th>
                                <th scope="col" class="sticky-top">Reviewer Name</th>
                                <th scope="col" class="sticky-top">Overall Ratting</th>
                                <th scope="col" class="sticky-top">Products Rating</th>
                                <th scope="col" class="sticky-top">Delivery Service</th>
                                <th scope="col" class="sticky-top">Feedback</th>
                                <th scope="col" class="sticky-top">timestamp</th>
                                <th scope="col" class="sticky-top">Set as Testimonial</th>
                                <th scope="col" class="sticky-top">Action</th>

                            </tr>
                        </thead>
                        <tbody class="text-center">
                        <%
                            List<PojoFeedback> feedbacks = DaoFeedback.getAllFeedback();
                            for (PojoFeedback feed : feedbacks) {
                                PojoOrderHistory hist = DaoOrderHistory.getOrderHistoryByordid(feed.getOrdid());

                        %>
                        <tr>
                            <td class="id"><%=feed.getOrdratid()%></td>
                            <td><%=feed.getOrdid()%></td>
                            <td><%=hist.getBillingname()%></td>
                            <td><%=feed.getOverall_rat()%>/5</td>
                            <td><%=feed.getProducts_rat()%>/5</td>
                            <td><%=feed.getDelivery_service()%></td>
                            <td><%=feed.getReview_msg()%></td>
                            <td><%=feed.getTimestamp()%></td>
                            <td>
                                <input type="checkbox" class="form-control" onchange="setTest(this)" <% if (feed.getIsTestimonial() == 1) { %> checked="true" <% } %> >
                            </td>
                            <td class="bg-danger">
                                <a onclick="deleteMe(this)"><i class="text-white fa fa-trash-o"></i></a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </section>

        <section>
            <div class="text-center mt-2 bg-gray p-2">
                <h2 class="">Product-Reviews</h2>
            </div><hr style="border: 1px solid gray;">

            <div class="container">
                <table class="table table1 table-hover table-bordered table-responsive" style="height: 59vh;">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th scope="col" class="sticky-top">Prdid Id</th>
                            <th scope="col" class="sticky-top">Cstmid Id</th>
                            <th scope="col" class="sticky-top">Review Id</th>
                            <th scope="col" class="sticky-top">Reviewer Name</th>
                            <th scope="col" class="sticky-top">Reviewer Email</th>
                            <th scope="col" class="sticky-top">Products Rating</th>

                            <th scope="col" class="sticky-top">Review</th>
                            <th scope="col" class="sticky-top">Timestamp</th>
                            <th scope="col" class="sticky-top">Action</th>

                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                            List<PojoProducts> prds = DaoProducts.getProducts();
                            for (PojoProducts prd : prds) {
                                String strname = DaoStore.getStoreById(prd.getStrid()).getStrname();
                                List<PojoProductsReview> feeds = DaoProductsReview.getReviewByPrdid(prd.getPrdid());
                                if (feeds.size() > 0) {
                        %>
                        <tr>
                            <td colspan="9"><div class="d-flex justify-content-center"><h4><%=prd.getPrdname()%></h4><small class="ml-2">(<%=strname%>)</small></div></td>
                        </tr>
                        <%

                            for (PojoProductsReview feed : feeds) {

                        %>
                        <tr>
                            <td class="id"><%=feed.getPrdid()%></td>
                            <td><%=feed.getCstmid()%></td>
                            <td class="rid"><%=feed.getReviewid() %></td>
                            <td><%=feed.getRname()%></td>
                            <td><%=feed.getRemail()%></td>
                            <td><%=feed.getRrating()%>/5</td>
                            <td><%=feed.getRmsg()%></td>
                            <td><%=feed.getTimestamp()%></td>
                            <td class="bg-danger">
                                <a onclick="deletePrdMe(this)"><i class="text-white fa fa-trash-o"></i></a>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            }
                        %>

                    </tbody>
                </table>
            </div>
        </section>
    </body>
    <script>
        function setTest(me) {
            var out = $(me).attr("checked");
            var id = $(me).parent().parent().find(".id").text();
            var sts = 0;
            if (out == "checked") {
                sts = 1;
            }

            $.get('../feedback', {sts: sts, id: id}, function () {
                //alert();
            });

        }

        function deleteMe(me) {
            var id = $(me).parent().parent().find(".rid").text();
            //alert(id);

            $.get('../feedback', {rid: id}, function () {
                $(me).parent().parent().fadeOut(1000);
            });

        }
        
        function deletePrdMe(me) {
            var id = $(me).parent().parent().find(".rid").text();
            //alert(id);

            $.get('../feedback', {rpid: id}, function () {
                $(me).parent().parent().fadeOut(1000);
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
</html>