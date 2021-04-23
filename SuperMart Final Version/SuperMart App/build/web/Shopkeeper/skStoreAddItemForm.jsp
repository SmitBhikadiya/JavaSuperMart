
<%@page import="DAOs.DaoProducts"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoCategory"%>
<%@page import="POJOs.PojoCategory"%>
<%@page import="java.util.List"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="POJOs.PojoAdminUser"%>
<%@page import="DAOs.DaoShopkeeper"%>
<%@page import="POJOs.PojoShopkeeper"%>
<%@page import="POJOs.PojoShopkeeper"%>

<%
    String data = "";
    if (session.getAttribute("data") != null) {
        data = session.getAttribute("data").toString().toLowerCase();
    }
%>

<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("skuser");
    String name = "";
    int adid = 0;
    int strid = 0;
    System.out.println("h");
    if (user != null) {
        System.out.println("h");
        adid = user.getAdid();
        name = user.getAdname();
        PojoShopkeeper sk = DaoShopkeeper.getShopkeeperById(adid);
        if ((!user.getAdtype().equals("shopkeeper")) || sk == null) {
            response.sendRedirect("../admin-login-register.jsp");
        }
        strid = sk.getStrid();
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
%>

<%
    String rmid = request.getParameter("rmid");
    if (rmid != null) {
        DaoProducts.deleteProductById(Integer.parseInt(rmid));
        session.setAttribute("data", "Product Remove Successfully");
    }
%>

<%
    int prdid = 0;
    String prdname = "";
    String imgpath = "";
    int prdtotalqty = 0;
    int prdprize = 0;
    int prddiscount = 0;
    String prdunit = "";
    String prdcategory = "";
    String prddescription = "";
    String btn = "Add Product";
    if (strid != 0) {
        PojoStore store = DaoStore.getStoreById(strid);
        if (request.getParameter("prdid") != null) {
            prdid = Integer.parseInt(request.getParameter("prdid"));

            PojoProducts prd = DaoProducts.getProductsById(prdid);
            if (prd != null) {
                btn = "Update Product";
                prdname = prd.getPrdname();
                imgpath = prd.getImgpath();
                prdtotalqty = prd.getPrdtotalqty();
                prdprize = prd.getPrdprize();
                prddiscount = prd.getPrddiscount();
                prdunit = prd.getPrdunit();
                prdcategory = prd.getPrdcategory();
                prddescription = prd.getPrddescription();
            }

        }
    }
%>

<%
    if (request.getParameter("category") != null) {
        String category = request.getParameter("category");
        PojoCategory pojo = DaoCategory.getCatByName(category);
        if(pojo == null){
            int result = DaoCategory.insertCat(category.toLowerCase());
        }  
    }
    else{
    }
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
        <link rel="stylesheet" href="../static/css/skDashboard.css">
        <title>Shopkeeper-Add-Item</title>

        <style>
            .jumboLink:hover{
                text-decoration: none;
            }
        </style>
    </head>

    <body>

        <div class="jumbotron text-center" style="margin-bottom:0; padding: 20px !important;">
            <h2>Store Customization Form</h2>
            <p>Owner:- <%=name%></p>
            <a class="jumboLink" href="shopkeeperDashboard.jsp">Back To Dashboard </a>|
            <a class="jumboLink" href="skStoreRegistration.jsp">Edit Your Shop</a>
        </div>
        <%
            if (data != "") {
        %>
        <div class="container">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <strong><h4 class="text-center">
                        <%
                            out.println(data);
                            session.removeAttribute("data");
                        %>
                    </h4></strong>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <%}%>
        <div class="row m-2">
            <div class="col-lg-5">
                <div class="card" onclick="">
                    <div class="card-header text-center">
                        <h4><%=btn%></h4>
                    </div>
                    <div class="card-body">
                        <form action="../SK_Store_Product_Register" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="strid" value="<%=strid%>">
                            <input type="hidden" name="imgpath" value="<%=imgpath%>">
                            <input type="hidden" name="prdid" value="<%=prdid%>">
                            <input type="hidden" name="atype" value="shopkeeper">
                            <div class="d-flex">
                                <input type="text" placeholder="Item Name" name="prdname" value="<%=prdname%>" class="form-control mb-3">
                            </div>
                            <div class="d-flex">
                                <div>
                                    <img id="strimgview" name="imgpath" style="border:1px solid #007bff; padding: 5px;" width="130px" height="130px" src="../<%=imgpath%>" class="mr-3 mb-3">
                                </div>

                                <input type="file" onchange="readURL(this);" name="prdimgpath" class="form-control mb-3" >
                            </div>


                            <div class="d-flex">
                                <input type="number" name="prdtotalqty" <% if (prdtotalqty > 0) {
                                        out.println("value=" + prdtotalqty);
                                    }%> placeholder="Total Quantity of Item" min=0 step="1" class="form-control mb-3">
                                <input type="hidden" id="unit" value="<%=prdunit%>">
                                <select name="prdunit" id="prdunit" class="form-control" style="width: 200px;">
                                    <option value="kg">in kg</option>
                                    <option value="gram">in gram</option>
                                    <option value="piese">in piece</option>
                                    <option value="pair">in pair</option>
                                    <option value="l">in liter</option>
                                    <option value="ml">in mililiter</option>
                                </select>
                            </div>

                            <div class="d-flex">
                                <input type="text" placeholder="Prize per Item with Discount" <% if (prdprize > 0) {
                                        out.println("value=" + prdprize);
                                    } %> name="prdprize" class="form-control mr-3">
                                <input type="number" max="100" min="0" step="1" <% if (prddiscount >= 0) {
                                        out.println("value=" + prddiscount);
                                    }%> name="prddiscount" placeholder="Enter Item Discount (recommand: 50%)"
                                       class="form-control mb-3">
                            </div>
                                       
                            <div class="d-flex">
                                <input type="hidden" value="<%=prdcategory%>" id="cat">
                                <select name="prdcat" id="prdcat" class="form-control mr-3">
                                    <% 
                                        List<PojoCategory> list = DaoCategory.getAllCat();
                                        out.println("<option>--Select Product Category--</option>");
                                        for (PojoCategory cat : list) {
                                            out.println("<option value='" + cat.getCatname() + "'>" + cat.getCatname() + "</option>");
                                        }
                                    %>
                                </select>
                                <textarea name="prddisc" id="" cols="30" rows="1" class="form-control"
                                          placeholder="Describe your product.."
                                          title="Example for shooes:- Staint and water resitance leather"><%=prddescription%></textarea>
                            </div>

                            <div style="margin-top: 20px;">
                                <input type="submit" class="btn btn-primary" value="<%=btn%>">
                                <a href="skStoreAddItemForm.jsp" class="btn btn-secondary">Reset Form</a>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card mt-3" onclick="">
                    <div class="card-header text-center">
                        <h4>Add Category</h4>
                    </div>
                    <div class="card-body">
                        <form action="skStoreAddItemForm.jsp" method="post" >
                            <div class="d-flex">
                                <input type="text" placeholder="Category Name" name="category" class="form-control mb-3" required="true">
                            </div>

                            <div style="margin-top: 20px;">
                                <input type="submit" class="btn btn-primary" value="Add Category">
                                <a href="skStoreAddItemForm.jsp" class="btn btn-secondary">Reset Form</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <div class="col-lg-7">
                <div class="card">
                    <div class="card-header text-center">
                        <h4>Product List</h4>
                    </div>
                    <div class="card-body text-center">
                        <table id="table-responsive" class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Prize</th>
                                    <th scope="col">Stock</th>
                                    <th scope="col">Discount</th>
                                    <th scope="col">Category</th>
                                    <th scope="col">Description</th>
                                    <th scope="col">Purchased</th>
                                    <th scope="col">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<PojoProducts> prdlist = DaoProducts.getProductByStrid(strid);
                                    int i = 1;
                                    for (PojoProducts prd : prdlist) {
                                        //System.out.println(prd.getPrdname());

                                %>
                                <tr>
                            <input type="hidden" name="strid" value="<%=prd.getPrdid()%>">
                            <th scope="row"><%=i++%></th>
                            <td><img src="../<%=prd.getImgpath()%>" width="50px" height="50" alt=""></td>
                            <td><%=prd.getPrdname()%></td>
                            <td><%=prd.getPrdprize()%>/<%=prd.getPrdunit()%></td>
                            <td><%=prd.getPrdtotalqty()%> <%=prd.getPrdunit()%></td>
                            <td><%=prd.getPrddiscount()%></td>
                            <td><%=prd.getPrdcategory()%></td>
                            <td><p style="height:40px; overflow-y: scroll; "><%=prd.getPrddescription()%></p></td>
                            <td><%=prd.getPrdpurchasedbycstm()%></td>
                            <td><a href="skStoreAddItemForm.jsp?prdid=<%=prd.getPrdid()%>" >Edit</a> | <a href="skStoreAddItemForm.jsp?rmid=<%=prd.getPrdid()%>">Remove</a></td>

                            </tr>
                            <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                var unit = $("#unit").val();
                var cat = $("#cat").val();

                $("#prdunit").children("option").each(function () {
                    if ($(this).val() == unit) {
                        $(this).attr("selected", "true");
                    }
                })
                $("#prdcat").children("option").each(function () {
                    if ($(this).val().toLowerCase() == cat) {
                        $(this).attr("selected", "true");
                    }
                });
            });
        </script>
        <script src="../static/bootstrap/javascript.min.js"></script>
        <script src="../static/js/skDashboard.js"></script>


        <script>
            
            window.addEventListener('resize', function () {
                if ($(window).width() < 550) {
                    $("#table-responsive").addClass('table-responsive');
                } else {
                    $("#table-responsive").removeClass('table-responsive');
                }
            });

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#strimgview')
                                .attr('src', e.target.result)
                                .width(130)
                                .height(130);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }

        </script>
    </body>

</html>