
<%@page import="DAOs.DaoFeedback"%>
<%@page import="POJOs.PojoFeedback"%>
<%@page import="DAOs.DaoServicerHistory"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="DAOs.DaoVarifyStore"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="DAOs.DaoProductsReview"%>
<%@page import="POJOs.PojoShopkeeper"%>
<%@page import="DAOs.DaoShopkeeper"%>
<%@page import="DAOs.DaoCategory"%>
<%@page import="POJOs.PojoCategory"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="DAOs.DaoAdminUser"%>
<%@page import="POJOs.PojoAdminUser"%>
<%@page import="java.util.List"%>

<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("admin");
    int adid = 0;
    String data = "";
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
            data = "Admin " + name + " is logging";
        }
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
    System.out.println(":");
%>

<!--delete-->
<%
    String rmstid = request.getParameter("rmstid");
    String skid = request.getParameter("skid");
    if (rmstid != null && skid != null) {
        DaoStore.deleteShopById(Integer.parseInt(rmstid));
        DaoProducts.deleteProductByStoreId(Integer.parseInt(rmstid));
        DaoShopkeeper.updateStrid(0, Integer.parseInt(skid));
        session.setAttribute("sdata", "Product Remove Successfully");
    }

    String rmskid = request.getParameter("rmskid");
    if (rmskid != null) {
        PojoAdminUser ad = DaoAdminUser.getAdminById(Integer.parseInt(rmskid));
        if (ad != null) {
            DaoAdminUser.deleteAdminById(Integer.parseInt(rmskid));
            PojoShopkeeper keeper = DaoShopkeeper.getShopkeeperById(Integer.parseInt(rmskid));
            DaoShopkeeper.deleteShopkeeperByAdId(Integer.parseInt(rmskid));
            session.setAttribute("sdata", "Shopkeeper removed Successfully");
            if (keeper.getStrid() != 0) {
                DaoStore.deleteShopById(keeper.getStrid());
                List<PojoProducts> prds = DaoProducts.getProductByStrid(keeper.getStrid());
                for (PojoProducts prd : prds) {
                    DaoProducts.deleteProductById(prd.getPrdid());
                }
            }
        } else {
            session.setAttribute("sdata", "Shopkeeper Already Delete");
        }
    }

    String rmprdid = request.getParameter("rmprdid");
    if (rmprdid != null) {
        PojoProducts prd = DaoProducts.getProductsById(Integer.parseInt(rmprdid));
        if (prd != null) {
            DaoProducts.deleteProductById(Integer.parseInt(rmprdid));
            session.setAttribute("sdata", "Product remove successfully");
        } else {
            session.setAttribute("sdata", "Product already removed");
        }
    }

    String rmcatid = request.getParameter("rmcatid");
    if (rmcatid != null) {
        PojoCategory cat = DaoCategory.getCatByCatid(Integer.parseInt(rmcatid));
        if (cat != null) {
            DaoCategory.deleteCatById(Integer.parseInt(rmcatid));
            session.setAttribute("sdata", "Category remove successfully");
        } else {
            session.setAttribute("sdata", "Category already removed");
        }
    }
    System.out.println(":");
%>

<!--edit--> 
<%    String catid = request.getParameter("catid");
    if (catid != null) {
        String category = request.getParameter("edcat");
        DaoCategory.updateCategory(Integer.parseInt(catid), category);
        session.setAttribute("sdata", "category update successfully");
    }
    System.out.println(":");
%>
<%
    if (request.getParameter("Adid") != null) {
        adid = Integer.parseInt(request.getParameter("Adid"));
        String adname = request.getParameter("Adname");
        String ademail = request.getParameter("Ademail");
        String adcon = request.getParameter("Adcon");
        String adAdd = request.getParameter("Adad");
        String adpa = request.getParameter("Adpa");
        DaoAdminUser.updateAdminBy(new PojoAdminUser(adid, adname, ademail, adcon, adAdd, adpa));
        session.setAttribute("sdata", "admin update successfully");
    }
    System.out.println(":");
%>

<%
    if (request.getParameter("category") != null) {
        String category = request.getParameter("category");
        PojoCategory pojo = DaoCategory.getCatByName(category);
        if (pojo == null) {
            int result = DaoCategory.insertCat(category.toLowerCase());
            session.setAttribute("sdata", "category inserted successfully");
        } else {
            session.setAttribute("sdata", "category already exists!!");
        }
    } else {
    }
    System.out.println(":");
%>

<%
    if (session.getAttribute("sdata") != null) {
        data = session.getAttribute("sdata").toString();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="meta description">
        <title>Admin-Shopkeeper</title>
        <!--=== All Plugins CSS ===-->
        <link href="../assets/css/plugins.css" rel="stylesheet">
        <!--=== All Vendor CSS ===-->
        <link href="../assets/css/vendor.css" rel="stylesheet">
        <!--=== Main Style CSS ===-->
        <link href="../assets/css/style.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/4ae0bb5b6f.js" crossorigin="anonymous"></script>

        <!-- Modernizer JS -->
        <script src="../assets/js/modernizr-2.8.3.min.js"></script>
        <style>
            table{
                height: 500px;
            }
            .table2{
                z-index: 0;
            }
            .table3{
                z-index: 0;
            }
        </style>
    </head>
    <body>
        <jsp:include page="admin-header.jsp"></jsp:include>     

        <% if (data != "") {
        %>
        <div class="container">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <strong><h5 class="text-center" id="msgbox"><%
                    out.println(data);
                    session.removeAttribute("sdata");
                        %></h5></strong>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <%}%>
        <div class="modal" id="Add_Shopkeeper">
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
                                        <h4>ADD SHOPKEEPER</h4>
                                    </div>
                                    <hr style="border: 1px solid gray;">
                                    <div class="col-lg-12">
                                        <div class="login-reg-form-wrap mt-md-60 mt-sm-60">
                                            <!--<h2>Singup Form</h2>-->
                                            <form action="../Admin_SignUp" method="post">
                                                <input type="hidden" name="admintype" value="shopkeeper">
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
                <h2 class="mr-3">Shopkeeper Data</h2>
                <button onclick="" class="pro-track" data-toggle="modal"
                        data-target="#Add_Shopkeeper">
                    <span data-toggle="tooltip" title="Add Shopkeeper">Add Shopkeeper</span>
                </button>
            </div><hr style="border: 1px solid gray;">

            <div class="container-fluid d-flex flex-wrap justify-content-around">
                <table class="table table1 table-hover">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th scope="col" class="sticky-top">Id</th>
                            <th scope="col" class="sticky-top">Name</th>
                            <th scope="col" class="sticky-top">Mail</th>
                            <th scope="col" class="sticky-top">Contact</th>
                            <th scope="col" class="sticky-top">Owner of</th>
                            <th scope="col" class="sticky-top">Address</th>
                            <th scope="col" class="sticky-top">Password</th>
                            <th scope="col" class="sticky-top">Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                            System.out.println(":--");
                            List<PojoAdminUser> shopkeepers = DaoAdminUser.getadUser("shopkeeper");
                            for (PojoAdminUser shopkeeper : shopkeepers) {
                                int strid = DaoShopkeeper.getShopkeeperById(shopkeeper.getAdid()).getStrid();
                                String shopname = "";
                                if (strid == 0) {
                                    shopname = "not";
                                } else {
                                    shopname = DaoStore.getStoreById(strid).getStrname();
                                }

                                System.out.println(":");
                        %>
                        <tr>
                            <th scope="row" id="adid"><%=shopkeeper.getAdid()%></th>
                            <td>
                                <input class="text-center" id="adname" style="border: none;" type="text" value="<%=shopkeeper.getAdname()%>">
                            </td>
                            <td>
                                <input class="text-center" id="ademail" style="border: none;" type="text" value="<%=shopkeeper.getAdemail()%>">
                            </td>
                            <td>
                                <input class="text-center" id="adcon" style="border: none;" type="text" value="<%=shopkeeper.getAdcontact()%>">
                            </td>
                            <td>
                                <p class="text-center" style="border: none; width: 150px;"><%=shopname%></p>
                            </td>
                            <td>
                                <input class="text-center" id="adpa" style="border: none;" type="text" value="<%=shopkeeper.getAdpassword()%>">
                            </td>
                            <td>
                                <input class="text-center" id="adAdd" style="border: none;" type="text" value="<%=shopkeeper.getAdaddress()%>">
                            </td>

                            <td style="cursor: pointer;" >
                                <a onclick="shopkeeper(this)" style="font-size: 18px;color: blue;" ><i class="fas fa-user-edit"></i></a>
                                <a href="shopkeeper.jsp?rmskid=<%=shopkeeper.getAdid()%>" style="font-size: 18px;color: red;"><i class="fas fa-trash-alt"></i></a>
                            </td>

                        </tr>

                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </section>


        <section class="mt-5">
            <div class="text-center mt-2 bg-gray p-2">
                <h2 class="">All Stores</h2>
            </div><hr style="border: 1px solid gray;">

            <div class="container-fluid d-flex flex-wrap justify-content-around">

                <div style="margin-bottom:10px;">
                    <form action="editStore.jsp" method="get">
                        <input type="hidden" name="strid" value="0">
                        <select class="mr-3 text-center" name="skid" style="width:200px;"> 
                            <%
                                System.out.println("--:");
                                PojoAdminUser pojo2 = null;
                                int dbtn = 0;
                                List<PojoShopkeeper> list = DaoShopkeeper.getShopkeeperStrid();
                                for (PojoShopkeeper pojo1 : list) {
                                    dbtn += 1;
                                    System.out.println("::" + pojo1.getAdid());
                                    pojo2 = DaoAdminUser.getAdminById(pojo1.getAdid());
                                    if (pojo2 == null) {
                                        continue;
                                    }
                            %>

                            <option value="<%=pojo1.getSkid()%>"><%=pojo2.getAdname()%></option> 
                            <% } %>
                        </select>

                        <button class="pro-track" <%if (dbtn == 0) {%>onclick="return false"<%}%>>
                            <span data-toggle="tooltip" title="Add Store">Add Store</span>
                        </button>
                    </form>
                </div>

                <table class="table table2 table-hover">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th scope="col" class="sticky-top">Store Id</th>
                            <th scope="col" class="sticky-top">Image</th>
                            <th scope="col" class="sticky-top">Store</th>
                            <th scope="col" class="sticky-top">Shopkeeper</th>
                            <th scope="col" class="sticky-top">Total Product</th>
                            <th scope="col" class="sticky-top">Orders Completed</th>
                            <th scope="col" class="sticky-top">Contact</th>
                            <th scope="col" class="sticky-top">Address</th>
                            <th scope="col" class="sticky-top">Open</th>
                            <th scope="col" class="sticky-top">Close</th>
                            <th scope="col" class="sticky-top">Servicer</th>
                            <th scope="col" class="sticky-top">Verify</th>
                            <th scope="col" class="sticky-top">Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                            List<PojoStore> stores = DaoStore.getStores();
                            for (PojoStore store : stores) {
                                PojoShopkeeper keeper = DaoShopkeeper.getShopkeeperBySkid(store.getSkid());
                                PojoAdminUser admin = DaoAdminUser.getAdminById(keeper.getAdid());
                        %>
                        <tr>
                            <th scope="row" class="storeid"><%=store.getStrid()%></th>
                            <td><img src="../<%=store.getImgpath()%>" width="50px" height="50" alt=""></td>
                            <td><%=store.getStrname()%></td>
                            <td><%=admin.getAdname()%></td>
                            <td>
                                <%
                                    int total = DaoProducts.getTotalProductBystrid(store.getStrid());
                                    out.println(total);
                                %>
                            </td>
                            <td>
                                <%
                                    total = DaoOrderHistory.getCntHistoryByStrid(store.getStrid());
                                    out.println(total);
                                %>
                            </td>
                            <td><%=store.getStrcontact()%></td>
                            <td><%=store.getStraddress()%></td>
                            <td><%=store.getStropentime()%></td>
                            <td><%=store.getStrclosetime()%></td>
                            <td><%
                                if (store.getStrhavingserviser() == 1) { %>
                                Yes
                                <% } else {%>
                                No
                                <% }
                                %>
                            </td>
                            <td><input type="checkbox" onchange="setVarify(this)" class="form-control" <% if (DaoVarifyStore.getVerified(store.getStrid()) == 1) { %> checked="true" <% }%>></td>
                            <td style="cursor: pointer;" >
                                <a href="editStore.jsp?strid=<%=store.getStrid()%>" style="font-size: 18px;color: blue;" ><i class="fas fa-user-edit"></i></a>
                                <a href="shopkeeper.jsp?rmstid=<%=store.getStrid()%>&skid=<%=store.getSkid()%>" style="font-size: 18px;color: red;"><i class="fas fa-trash-alt"></i></a>
                            </td>

                        </tr>
                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="mt-5">
            <div class="text-center mt-2 bg-gray p-2">
                <h2 class="">All Products</h2>
            </div><hr style="border: 1px solid gray;">

            <div class="container-fluid d-flex flex-wrap justify-content-around">

                <div style="margin-bottom:10px;">
                    <form action="EditProduct.jsp" method="get">
                        <select class="mr-3 text-center" name="strid" style="width:200px;"> 
                            <%
                                List<PojoStore> storesName = DaoStore.getStores();
                                for (PojoStore pojo : storesName) {%>
                            <option value="<%=pojo.getStrid()%>"><%=pojo.getStrname()%></option> 
                            <%}%>
                        </select>

                        <button class="pro-track" >
                            <span data-toggle="tooltip" title="Add Product">Add Product</span>
                        </button>
                    </form>
                </div>

                <table class="table table3 table-hover" >
                    <thead class="thead-dark text-center">
                        <tr>
                            <th scope="col" class="sticky-top">Product Id</th>
                            <th scope="col" class="sticky-top">Name</th>
                            <th scope="col" class="sticky-top">Store</th>
                            <th scope="col" class="sticky-top">Image</th>
                            <th scope="col" class="sticky-top">Rating</th>
                            <th scope="col" class="sticky-top">Prize</th>
                            <th scope="col" class="sticky-top">Unit</th>
                            <th scope="col" class="sticky-top">Discount</th>
                            <th scope="col" class="sticky-top">Qty</th>
                            <th scope="col" class="sticky-top">Category</th>
                            <th scope="col" class="sticky-top">Description</th>
                            <th scope="col" class="sticky-top">Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                            List<PojoProducts> products = DaoProducts.getProducts();
                            for (PojoProducts product : products) {
                        %>
                        <tr>
                            <th scope="row"><%=product.getPrdid()%></th>
                            <td><%=product.getPrdname()%></td>
                            <td>
                                <%
                                    out.println(DaoStore.getStoreById(product.getStrid()).getStrname());
                                %>
                            </td>
                            <td><img src="../<%=product.getImgpath()%>" width="50px" height="50" alt=""></td>
                            <td>
                                <div class="ratings">
                                    <%
                                        int rat = Math.round(DaoProductsReview.getOverallReviewBYprdid(product.getPrdid()));
                                        if (rat != 0) {
                                            for (int i = 1; i <= 5; i++) {
                                                if (i > rat) {
                                                    break;
                                                }
                                                out.println("<span><i class=\"ion-android-star\"></i></span>");
                                            }
                                        } else {
                                            out.println("Not rated");
                                        }
                                    %>
                                </div>
                            </td>
                            <td><%=product.getPrdprize()%></td>
                            <td><%=product.getPrdunit()%></td>
                            <td><%=product.getPrddiscount()%></td>
                            <td><%=product.getPrdtotalqty()%></td>
                            <td><%=product.getPrdcategory()%></td>
                            <td><p style="height:40px; overflow-y: scroll; "><%=product.getPrddescription()%></p></td>

                            <td style="cursor: pointer;" >
                                <a href="EditProduct.jsp?prdid=<%=product.getPrdid()%>&strid=<%=product.getStrid()%>" style="font-size: 18px;color: blue;" ><i class="fas fa-user-edit"></i></a>
                                <a href="shopkeeper.jsp?rmprdid=<%=product.getPrdid()%>" style="font-size: 18px;color: red;"><i class="fas fa-trash-alt"></i></a>
                            </td>
                        </tr>
                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </section>

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
                                        <h4>ADD CATEGORY</h4>
                                    </div>
                                    <hr style="border: 1px solid gray;">
                                    <div class="card mt-3" onclick="">

                                        <div class="card-body">
                                            <form action="shopkeeper.jsp" method="post" >
                                                <div class="d-flex">
                                                    <input type="text" placeholder="Category Name" name="category" class="form-control mb-3" required="true">
                                                </div>

                                                <div style="margin-top: 20px;" class="d-flex justify-content-center ">
                                                    <input type="submit" class="btn btn-primary text-white" value="Add Category">
                                                    <a href="skStoreAddItemForm.jsp" class="btn btn-secondary text-white">Reset Form</a>
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

        <section class="mt-5" >
            <div class="text-center mt-2 bg-gray p-2 d-flex justify-content-center">
                <h2 class="mr-3">Category Data</h2>
                <button onclick="" class="pro-track" data-toggle="modal"
                        data-target="#quick_view">
                    <span data-toggle="tooltip" title="Add Category">Add Category</span>
                </button>
            </div><hr style="border: 1px solid gray;">

            <div class="container-fluid d-flex flex-wrap justify-content-around">
                <table class="table table4 table-hover">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th scope="col" class="sticky-top">Product Id</th>
                            <th scope="col" class="sticky-top">Category</th>
                            <th scope="col" class="sticky-top">Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                            List<PojoCategory> Categorys = DaoCategory.getAllCat();
                            for (PojoCategory category : Categorys) {
                        %>
                        <tr>
                            <th scope="row" id="ctid"><%=category.getCatid()%></th>
                            <th>
                                <input id="cate" class="text-center" style="border: none;" type="text" value="<%=category.getCatname()%>">
                            </th>

                            <td style="cursor: pointer;" >
                                <a onclick="Category(this)" style="font-size: 18px;color: blue;" ><i class="fas fa-user-edit"></i></a>
                                <a href="shopkeeper.jsp?rmcatid=<%=category.getCatid()%>" style="font-size: 18px;color: red;"><i class="fas fa-trash-alt"></i></a>
                            </td>

                        </tr>
                        <%
                            }%>
                    </tbody>
                </table>
            </div>
        </section>

        <div class="card mt-5" id="order-history">
            <div class="card-header text-center">
                <h4>Orders History</h4>
            </div>
            <div class="container mt-3">
                <table class="table table-bordered">

                    <tbody>
                        <%
                            shopkeepers.clear();
                            int strid = 0;
                            shopkeepers = DaoAdminUser.getadUser("shopkeeper");
                            for (PojoAdminUser servicer : shopkeepers) {
                                PojoShopkeeper sk = DaoShopkeeper.getShopkeeperById(servicer.getAdid());
                                List<PojoOrderHistory> history = DaoOrderHistory.getOrderHistoryByStrid(sk.getStrid());
                                int i = 1;
                                strid = sk.getStrid();
                                String strname = DaoStore.getStoreById(sk.getStrid()).getStrname();

                        %>

                        <tr class="text-center pro-track" style="border-bottom:3px solid blue;"> 
                            <th colspan="2">Strid <%=sk.getStrid()%></th>
                            <th colspan="2">Store: <%=strname%></th>
                            <th colspan="3">Email: <%=servicer.getAdemail()%></th>
                        </tr>

                        <tr>
                            <th>Order</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Address</th>
                            <th>Feedback</th>
                            <th>Charge</th>
                            <th>Action</th>
                        </tr>

                        <%
                            if (history.size() <= 0) {
                                out.println("<tr><td colspan='7' class='text-center'><kbd>history not found</kbd></td></tr>");
                                continue;
                            }
                        %><%
                            list.clear();
                            List<PojoOrderHistory> li = DaoOrderHistory.getOrderHistoryByStrid(strid);
                            i = 1;
                            for (PojoOrderHistory pojo : li) {
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

                            <% System.out.println(pojo.getAcceptedtype());
                                if (pojo.getAcceptedtype().equals("Servicer")) {%>
                            <td><%=pojo.getDeliveredby()%> (servicer)</td>
                            <% } else {%>
                            <td><%=pojo.getDeliveredby()%> (shopkeeper)</td>
                            <% }%>
                            <td><a href="../feedback.jsp?viewid=<%=feedid%>">feedback</a></td>
                            <td><a href="order-history.jsp?id=<%=pojo.getOrdhistoryid()%>"
                                   class="btn btn-dark text-white">View</a></td>
                        </tr>
                        <% }
                            }%>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
    <script>

        function setVarify(me) {
            var out = $(me).attr("checked");
            var strid = $(me).parent().parent().find(".storeid").text();
            //alert(strid);
            var varify = 0;
            if (out == "checked") {
                varify = 1;
            }
            $.ajax({
                url: "../Sk_Store_Varify",
                type: "POST",
                data: {varify: varify, strid: strid},
                success: function (res) {
                    //alert(res);
                }
            });
        }

        function shopkeeper(e) {
            var adid = $(e).parent().parent().find('#adid').text();
            var adname = $(e).parent().parent().find('#adname').val();
            var ademail = $(e).parent().parent().find('#ademail').val();
            var adcon = $(e).parent().parent().find('#adcon').val();
            var adAdd = $(e).parent().parent().find('#adAdd').val();
            var adpa = $(e).parent().parent().find('#adpa').val();
//            alert(adpa);
            $.ajax({
                url: "shopkeeper.jsp",
                type: "POST",
                data: {Adid: adid, Adname: adname, Ademail: ademail, Adcon: adcon, Adad: adAdd, Adpa: adpa},
                success: function () {
                    $("#msgbox").text("Shopkeeper ( id="+adid+" ) update successfully");
                }
            });
        }

        function Category(e) {
            var cate = $(e).parent().parent().find('#cate').val();
            var catid = $(e).parent().parent().find('#ctid').text();

            $.ajax({
                url: "shopkeeper.jsp",
                type: "GET",
                data: {catid: catid, edcat: cate},
                success: function () {
                    $("#msgbox").text("Category ( "+cate+" ) update successfully");
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
</html>
