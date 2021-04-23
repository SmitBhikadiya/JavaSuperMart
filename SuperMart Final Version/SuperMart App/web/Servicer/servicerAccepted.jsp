
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="POJOs.PojoServicerHistory"%>
<%@page import="DAOs.DaoServicerHistory"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="POJOs.PojoOrdersStatus"%>
<%@page import="DAOs.DaoOrdersStatus"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="POJOs.PojoOrders"%>
<%@page import="DAOs.DaoOrders"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="java.util.List"%>
<%@page import="POJOs.PojoServicerAccept"%>
<%@page import="DAOs.DaoServicerAccept"%>
<%@page import="DAOs.DaoServicer"%>
<%@page import="DAOs.DaoOrderRequest"%>
<%@page import="POJOs.PojoAdminUser"%>
<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("suser");
    String email = "";
    String name = "";
    String contact = "";
    int adid = 0;
    int sid = 0;
    if (user != null) {
        adid = user.getAdid();
        name = user.getAdname();
        email = user.getAdemail();
        contact = user.getAdcontact();
        sid = DaoServicer.getServicerById(adid).getServicerid();
        if (!user.getAdtype().equals("servicer")) {
            response.sendRedirect("../admin-login-register.jsp");
        }
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
%>

<%!
    private String generateRandomPin() {
        String pin = "";
        String alphasmall = "abcdefghijklmnopqrstvwxyz";
        char pin1 = alphasmall.charAt((int) (Math.random() * alphasmall.length()));
        String alphabig = "ABCDEFGHIJKLMNOPQRSTVWXYZ";
        char pin2 = alphabig.charAt((int) (Math.random() * alphabig.length()));
        String number = "1234567890";
        char pin3 = number.charAt((int) (Math.random() * number.length()));
        pin = pin + String.valueOf(pin2) + String.valueOf(pin3) + String.valueOf(pin1);
        return pin;
    }
%>

<%
    String odid = request.getParameter("ordid");
    int count = 0;
    String aproxtime = request.getParameter("aproxtime");
    if (odid != null && aproxtime != null) {
        if (sid != 0) {
            int ordid = Integer.parseInt(odid);
            count = DaoServicerAccept.countAccepted(sid);
            System.out.println(count);
            if (count < 3) {
                System.out.println("You accepted total" + count + " order ");
                PojoServicerAccept pojo = DaoServicerAccept.checkOrderIsInserted(ordid);
                if (pojo == null) {

                    PojoOrdersStatus ordsts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                    System.out.println("order status found");

                    if (ordsts.getOrdstatus() == 0) {
                        session.setAttribute("resmsg", "Order has been cancel by the customer or shopkeeper");
                        response.sendRedirect("servicerDashboard.jsp");
                    } else {

                        DaoServicerAccept.insertOrderById(sid, ordid);
                        System.out.println("Order Accepted Successfully");

                        String pin = generateRandomPin();
                        System.out.println("Pin : " + pin);

                        LocalDateTime datetime1 = LocalDateTime.now();
                        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        String accepttime = datetime1.format(format);

                        DaoOrdersStatus.setPin(pin, ordid);
                        System.out.println("Pin set successfully");
                        DaoOrdersStatus.updateOrderStatus(new PojoOrdersStatus(ordid, ordsts.getOrdstatus(), ordsts.getOrdarrivalat(), accepttime, aproxtime, "2", name, contact, pin));
                        System.out.println("Order status update succesfully");
                    }
                } else {
                    System.out.println("Already Accepted");
                }
            } else {
                out.println("<script>alert('You can accept 3 order maximum\');</script>");
                System.out.println("You can not accept more then 3 orders");
            }
        }
    }
    count = DaoServicerAccept.countAccepted(sid);
    System.out.println(odid + " " + aproxtime + " " + sid);
    System.out.println("User is logging");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="../static/bootstrap/bootstrap.min.css">
        <script src="../static/bootstrap/jquery.min.js"></script>


        <!-- External CSS -->
        <link rel="stylesheet" href="../static/css/sDashboard.css">
        <title>Servicer-Accepted</title>
    </head>

    <body>
        <div class="text-center toptitle" style="margin-bottom:5px">
            <h3>Remaining Orders</h3>
            <h1><%=count%></h1>
            <a href="servicerDashboard.jsp">Back To Dashboard</a>
        </div>
        <div class="container">
            <div class="row">
                <div class="sidebar col-md-3">
                    <div class="sidebar-title">Pending Orders</div>
                    <%
                        System.out.println("Servicer id is " + sid);
                        List<PojoServicerAccept> li = DaoServicerAccept.getAllAcceptedByServicer(sid);
                        int i = 1;
                        String display = "none";
                        for (PojoServicerAccept pojo : li) {
                            display = "block";
                            System.out.println(pojo.getOrdid());
                            PojoOrders ord = DaoOrders.getOrdersByOrdid(pojo.getOrdid());
                            System.out.println(ord.getStrid());
                            PojoStore str = DaoStore.getStoreById(ord.getStrid());
                            System.out.println(str.getStrname());
                            //String strname = str.getStrname();
                            out.println(""
                                    + "<div onclick='openMe(this)' class='sidebar-div g'>"
                                    + "<input type='hidden' class='odid' value='" + pojo.getOrdid() + "'>"
                                    + "Order" + i++ + ": from " + str.getStrname()
                                    + "</div>"
                                    + "");
                        }
                    %>
                </div>
                <div class="col-md-6">
                    <div class="track-box">
                        <%
                            if (display == "block") {
                        %>
                        <div class="row">
                            <div class="col-md-12 header">
                                <p>Order: <a href="#" class="strname"></a></p>
                            </div>
                        </div>
                        <div class="row">
                             <div class="col-md-12 header">
                                 <p>Customer can cancel the order upto <span id="time_for_cancel"></span></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="title col-md-8">
                                Stages
                            </div>
                            <div class="title col-md-4 text-center">
                                Update Progress
                            </div>
                        </div>
                        <div class="row">
                            <div class="stage col-md-8">
                                <div class="que">Are you pick-up the order from the shop?</div>
                                <div class="strname"></div>
                                <div >Address: <span id="straddress"></span></div>
                                <div>Contact: <span id="strcontact"></span></div>
                            </div>
                            <div class="action col-md-4">
                                <div>
                                    <input type="checkbox" id="check1" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="stage col-md-8">
                                <div class="que">Are you reach the customer with order?</div>
                                <div id="username"></div>
                                <div>Address: <span id="useraddress"></span></div>
                                <div>Contact: <span id="usercontact"></span></div>
                            </div>
                            <div class="action col-md-4">

                                <form action="../Servicer_Order_Manage" method="POST">
                                    <div class="form-group">
                                        <input type="hidden" name="sid" value="<%=sid%>">
                                        <input type="hidden" id="odid" name='odid'>
                                        <input class="form-control" name="pin" type="text" placeholder="Enter a pin">
                                    </div>
                                    <div class=" form-group">
                                        <button class="btn btn-success" id="delivered" disabled="true">Delivered</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="row">
                            <div class="col-md-12 header">
                                <p>You are not accepted any order</p>
                            </div>
                        </div>       
                        <%
                            }
                        %>

                    </div>

                </div>
                <div class="sidebar col-md-3">
                    <div class="sidebar-title">Completed Orders</div>
                    <%
                        List<PojoServicerHistory> lis = DaoServicerHistory.getHistoryByServicerId(sid);
                        i = 1;
                        for (PojoServicerHistory pojo : lis) {
                            PojoOrderHistory his = DaoOrderHistory.getOrderHistoryById(pojo.getOrdhistoryid());
                            String strname = DaoStore.getStoreById(his.getStrid()).getStrname();
                            int hisid = his.getOrdhistoryid();
                    %>
                    <div class="sidebar-div" onclick="window.location.href = 'order-history.jsp?id=<%=hisid%>'">Order<%=i++%>: from <%=strname%><br>time:- <%=his.getDeliveredtime()%></div>
                        <% }%>
                </div>
            </div>
        </div>

        <script>

            var check1 = document.getElementById("check1");
            check1.addEventListener("change", function () {
                var sts = 0;
                if (this.checked === false) {
                    $("#delivered").attr("disabled", "true");
                    sts = 2;
                } else {
                    sts = 3;
                    $("#delivered").removeAttr("disabled");
                }
                var odid = $("#odid").val();
                //alert(odid);
                $.ajax({
                    url: "../Servicer_Order_Manage",
                    data: {odid: odid, sts: sts},
                    success: function (res) {
                        if((res==0 || res=="0") && res!=""){
                            console.log("...>>>>..."+res);
                            alert("Order is cancelled By the customer");
                            $.get("../Servicer_Order_Manage", {reaccid : odid}, function(){
                               window.location.reload(); 
                            });
                        }
                    }
                });
            });

            function getOrder(odid) {
                $.ajax({
                    url: "../Servicer_Order_Manage",
                    data: {odid: odid},
                    success: function (res) {
                        var arr = res.split("@");
                        console.table(arr);
                        var sts = arr[6];
                        //alert(sts);
                        if (sts == 2) {
                            //alert(">>"+sts);
                            $(check1).attr("checked", false);
                            $("#delivered").attr("disabled", "true");
                        } else if (sts == 3) {
                            //alert(">"+sts);
                            $(check1).attr("checked", true);
                            $("#delivered").removeAttr("disabled");
                        }
                        $(".strname").text(arr[0]);
                        $("#straddress").text(arr[1]);
                        $("#strcontact").text(arr[2]);
                        $("#username").text(arr[3]);
                        $("#useraddress").text(arr[4]);
                        $("#usercontact").text(arr[5]);
                        
                        var date = new Date(arr[7]);
                        var curr = new Date();
                        date.setMinutes(date.getMinutes()+5);
                        if(curr.getTime() < date.getTime()){
                            $("#time_for_cancel").parent().show();
                            $("#time_for_cancel").text(date);
                        }else{
                            $("#time_for_cancel").parent().hide();
                            $("#time_for_cancel").text("");
                        }
                        $("#odid").val(odid);
                    }
                });
            }

            var ordid = document.getElementsByClassName("odid");
            getOrder($(ordid).val());

            function openMe(me) {
                var odid = $(me).children(".odid").val();
                //alert(odid);
                getOrder(odid);
            }


        </script>
    </body>