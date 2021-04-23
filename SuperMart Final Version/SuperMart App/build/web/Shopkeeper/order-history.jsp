
<%@page import="POJOs.PojoAdminUser"%>
<%@page import="DAOs.DaoShopkeeper"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="POJOs.PojoOrderHistoryList"%>
<%@page import="POJOs.PojoOrdersList"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DaoOrderHistoryList"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="POJOs.PojoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("skuser");
    String strname = "";
    int adid = 0;
    int strid = 0;
    if (user != null) {
        adid = user.getAdid();
        strid = DaoShopkeeper.getShopkeeperById(adid).getStrid();
        strname = DaoStore.getStoreById(strid).getStrname();
        if (!user.getAdtype().equals("shopkeeper")) {
            response.sendRedirect("../admin-login-register.jsp");
        }
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
%>

<%
    String id = request.getParameter("id");
    String straddress = "";
    String strcontact = "";
    String billdate = "";
    String cstmname = "";
    String cstmaddress = "";
    String deliveredby = "";
    String acceptedtype = "";
    int ordcharge = 0;
    int ordid = 0;
    int ordhistoryid = 0;
    if(id!=null && id!=""){
        ordhistoryid = Integer.parseInt(id);
        PojoOrderHistory orderhistory = DaoOrderHistory.getOrderHistoryById(ordhistoryid);
        PojoStore store = DaoStore.getStoreById(orderhistory.getStrid());
        strname =  store.getStrname();
        billdate = orderhistory.getDeliveredtime();
        straddress = store.getStraddress();
        strcontact = store.getStrcontact();
        cstmaddress = orderhistory.getBillingaddress();
        cstmname = orderhistory.getBillingname();
        deliveredby = orderhistory.getDeliveredby();
        acceptedtype = orderhistory.getAcceptedtype();
        ordid = orderhistory.getOrdid();
        ordcharge = orderhistory.getOrdcharge();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>Order-History</title>
        <!--=== All Plugins CSS ===-->
        <link href="../assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="../assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="../assets/css/style.css" rel="stylesheet">

        <!-- Modernizer JS -->
        <script src="../assets/js/modernizr-2.8.3.min.js"></script>
    </head>
    <body>
        <div class="container">
        <div class="row mt-5">
                        <!-- Order Summary Details -->
                        <div class="col-lg-12">
                            <div class="order-summary-details mt-md-50 mt-sm-50">
                                <div class="float-left mb-3">
                                    <h2 class="" style="font-weight: 600"><%=strname%></h2>
                                    <h5 class="" style="font-weight: 500">Add:- <%=straddress%></h5>
                                    <h5 class="" style="font-weight: 100">Contact:- <%=strcontact%></h5>
                                    <h5 class="mt-3" style="font-weight: 80">Delivered By:- <%=deliveredby%> (<%=acceptedtype%>)</h5>
                                </div>
                                <div class="float-right mb-3">
                                     <h2 class="" style="font-weight: 600"><%=cstmname%></h2>
                                    <h5 class="" style="font-weight: 500">Add:- <%=cstmaddress%></h5>
                                    <h5 class="" style="font-weight: 100">Bill Date- <%=billdate%></h5>
                                    <h5 class="mt-3" style="font-weight: 80">Order No:- <%=ordid%></h5>
                                </div>
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
                                                    int total = 0;
                                                    List<PojoOrderHistoryList> list = DaoOrderHistoryList.getHistoryListByOrdhid(ordhistoryid);
                                                    for (PojoOrderHistoryList atc : list) {
                                                        int subtotal = atc.getPrdprize() * atc.getPrdqty();
                                                        total = total + subtotal;
                                                %>
                                                <tr>
                                                    <td class="pro-thumbnail"><a href="#"><img class="img-fluid" src="../<%=atc.getPrdimgpath()%>"
                                                                                               alt="Product" width="60px"/></a></td>

                                                    <td><a href="../single-product.jsp?prdid=<%=atc.getPrdid()%>"><%=atc.getPrdname()%></a></td>
                                                    <td><%=atc.getPrdqty()%> x $<%=atc.getPrdprize()%></td>
                                                    <td>$<%=atc.getPrdqty() * atc.getPrdprize()%></td>
                                                </tr>

                                                <% }%>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <td>Sub Total</td>
                                           
                                            <td class="order-total"><strong>$<%=total%></strong></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"></td>
                                                <td>Delivery Charge</td>
                                                <td class="d-flex justify-content-center">
                                                    <ul class="shipping-type">
                                                        <li>
                                                            <div class="custom-control custom-radio">
                                                                <%=ordcharge%>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"></td>
                                                <td>Total Amount</td>
                                                <td class="order-sub-total"><h2>$<%=total+ordcharge%></h2></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td colspan="2"><button onclick="window.print()" class="btn btn-dark text-white">Print</button></td>
                                                <td></td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                          </div>                  
    </body>
</html>
