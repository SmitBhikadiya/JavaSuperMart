
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
    int prdid = 0;
    int strid = 0;
    String prdname = "";
    String imgpath = "";
    int prdtotalqty = 0;
    int prdprize = 0;
    int prddiscount = 0;
    String prdunit = "";
    String prdcategory = "";
    String prddescription = "";
    String btn = "Edit Product";

    if (request.getParameter("prdid") != null) {
        prdid = Integer.parseInt(request.getParameter("prdid"));
        strid = Integer.parseInt(request.getParameter("strid"));

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
    
    if (request.getParameter("strid") != null) {
        strid = Integer.parseInt(request.getParameter("strid")); 
        btn = "Add Product";
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
        <title>Admin-Add-Product</title>

        <style>

        </style>
    </head>

    <body>
        <div class="width7center">
           <div class="m-3 d-flex flex-wrap justify-content-around">
                <div class="card flex-fill" onclick="">
                    <div class="card-header text-center">
                        <h4><%=btn%></h4>
                    </div>
                    <div class="card-body">
                        <form action="../SK_Store_Product_Register" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="strid" value="<%=strid%>">
                            <input type="hidden" name="imgpath" value="<%=imgpath%>">
                            <input type="hidden" name="prdid" value="<%=prdid%>">
                            <input type="hidden" name="atype" value="admin">
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

                                    <% List<PojoCategory> list = DaoCategory.getAllCat();
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