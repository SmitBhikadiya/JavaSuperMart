
<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="POJOs.PojoShopkeeper"%>
<%@page import="DAOs.DaoShopkeeper"%>
<%@page import="POJOs.PojoAdminUser"%>

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
    int skid = 0;
    String btn = "Register";
    String strimgpath = "";
    String strname = "";
    String strcontact = "";
    String straddress = "";
    String stropentime = "";
    String strclosetime = "";
    int strhavingservicer = 0;
    int strid = Integer.parseInt(request.getParameter("strid"));
    if (strid != 0) {
        btn = "Update";
        PojoStore store = DaoStore.getStoreById(strid);
        skid = store.getSkid();
        strimgpath = store.getImgpath();
        strname = store.getStrname();
        strcontact = store.getStrcontact();
        straddress = store.getStraddress();
        stropentime = store.getStropentime();
        strclosetime = store.getStrclosetime();
        strhavingservicer = store.getStrhavingserviser();
    }
    
    if (strid == 0 && request.getParameter("skid") != null) {
        btn = "Update";
        skid = Integer.parseInt(request.getParameter("skid"));
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
        <title>Admin-Store-Registration</title>
    </head>

    <body>

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
                                    <input type="hidden" name="imgpath" value="<%=strimgpath%>">
                                    <input type="hidden" name="atype" value="admin">
                                           <!--<input type="hidden" name="imgpath" value="" id="imgpath">-->
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
                } else {
                    check1.checked = false;
                }
            }
        </script>
    </body>

</html>