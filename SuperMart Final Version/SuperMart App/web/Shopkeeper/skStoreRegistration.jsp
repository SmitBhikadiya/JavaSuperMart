
<%@page import="DAOs.DaoVarifyStore"%>
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="POJOs.PojoShopkeeper"%>
<%@page import="DAOs.DaoShopkeeper"%>
<%@page import="POJOs.PojoAdminUser"%>

<%
    PojoAdminUser user = (PojoAdminUser) session.getAttribute("skuser");
    String name = "";
    int adid = 0;
    int strid = 0;
    int skid = 0;
    System.out.println("h");
    if (user != null) {
        System.out.println("h");
        adid = user.getAdid();
        name = user.getAdname();

        PojoShopkeeper sk = DaoShopkeeper.getShopkeeperById(adid);
        if ((!user.getAdtype().equals("shopkeeper")) || sk == null) {
            response.sendRedirect("../admin-login-register.jsp");
        }
        skid = sk.getSkid();
        strid = sk.getStrid();
    } else {
        response.sendRedirect("../admin-login-register.jsp");
    }
%>

<%
    String btn = "Register";
    String strimgpath = "";
    String strname = "";
    String strcontact = "";
    String straddress = "";
    String stropentime = "";
    String strclosetime = "";
    int strhavingservicer = 0;
    if (strid != 0) {
        btn = "Update";
        PojoStore store = DaoStore.getStoreById(strid);
        strimgpath = store.getImgpath();
        strname = store.getStrname();
        strcontact = store.getStrcontact();
        straddress = store.getStraddress();
        stropentime = store.getStropentime();
        strclosetime = store.getStrclosetime();
        strhavingservicer = store.getStrhavingserviser();
    }

    System.out.println(strimgpath);
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

        <style>
            #strimgview{
                border:1px solid black;
                padding: 5px;
                margin: 5px 0px 10px 10px;
                box-shadow: 1px 1px 5px black;
            }
            #strimgview:hover{
                transform: scale(1.1);
            }
        </style>
        <title>Shopkeeper-Store-Registration</title>
    </head>

    <body>

        <div class="jumbotron text-center" style="margin-bottom:0; padding: 20px !important;">
            <h2>Register Your Shop Hear</h2>
            <p>Owner:- <%=name%></p>
            <a href="shopkeeperDashboard.jsp">Back To Dashboard </a>|
            <a href="skStoreAddItemForm.jsp">Add Item</a>
        </div>

        <div class="width7center">

            <div class="m-3 d-flex flex-wrap justify-content-around">
                <div class="card flex-fill">
                    <div class="card-header text-center">
                        <h3>Registration Form</h3>
                    </div>
                    <div class="">
                        <div class="row no-gutters">
                            <div class="card-body">
                                <form action="../SK_Store_Register" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" name="skid" value="<%=skid%>" >
                                    <input type="hidden" name="strid" value="<%=strid%>" >
                                    <input type="hidden" name="imgpath" value="<%=strimgpath%>" >
                                    <input type="hidden" name="atype" value="shopkeeper" >
                                    <!--<input type="hidden" name="imgpath" value="" id="imgpath">-->
                                    <div>
                                        <% 
                                            if(strid!=0){
                                                int varified = DaoVarifyStore.getVerified(strid);
                                                if(varified==1){
                                                    %>
                                                    <p class="bg-success text-white p-2" title="your store available for customer">Store is verified</p>
                                        <%
                                                }else{
                                                     %>
                                                     <p class="bg-warning text-white p-2" title="once admin will verified your store it will be available for customer">Store is not verified</p>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="form-group">
                                        <label for="storeName">Register Storename</label>
                                        <input type="text" class="form-control" value="<%=strname%>" name="strname" required>
                                    </div>
                                    <div>
                                        <img src="../<%=strimgpath%>" id="strimgview" alt="Select Image" width="150px" height="150px" />
                                    </div>
                                    <div class="form-group">
                                        <label for="storeimg">Store Image</label>
                                        <input type="file" onchange="readURL(this);" id="img" accept=".jpeg,jpg,.png" name="strimg" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="storeadd">Store Address</label>
                                        <input name="straddress" value="<%=straddress%>" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="storeContact">Store Contact Number</label>
                                        <input type="number" class="form-control" value="<%=strcontact%>" name="strcontact" max="9999999999">
                                    </div>

                                    <div class="form-group">
                                        <label for="havingServiser" onclick="checkme()" style="cursor: pointer;">Are you having servicer?</label>
                                               <input type="checkbox" id="havingSrvs" name="havingserviser" <% if (strhavingservicer != 0) {
                                                       out.println("checked");
                                                   }%>>
                                    </div>
                                    <div class="form-group">
                                        <label for="storeName">Store Opening Time</label>
                                        <input type="time" value="<%=stropentime%>" class="form-control" name="openat" required>
                                        <label for="storeName">Store Closing Time</label>
                                        <input type="time" value="<%=strclosetime%>" class="form-control" name="closeat" required>
                                    </div>
                                    <div style="margin-top: 20px;">
                                        <input type="submit" class="form-control btn btn-primary" name="input"
                                               value="<%=btn%>">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="../static/bootstrap/javascript.min.js"></script>
        <script src="../static/js/skDashboard.js"></script>

        <script>

                                            function readURL(input) {
                                                if (input.files && input.files[0]) {
                                                    var reader = new FileReader();

                                                    reader.onload = function (e) {
                                                        $('#strimgview')
                                                                .attr('src', e.target.result)
                                                                .width(150)
                                                                .height(150);
                                                    };

                                                    reader.readAsDataURL(input.files[0]);
                                                }
                                            }
                                            function checkme() {
                                                var check1 = document.getElementById("havingSrvs");
                                                if (check1.checked == false) {
                                                    check1.checked = true;
                                                }
                                                else {
                                                    check1.checked = false;
                                                }
                                            }

        </script>
    </body>

</html>