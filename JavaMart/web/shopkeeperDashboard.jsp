
<%@page import="DAOs.SuperDao"%>
<%@page import="POJOs.PojoRegistration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    PojoRegistration pojo = null;
    // check user are logged in 
    if (session.getAttribute("username") == null) {
        response.sendRedirect("userSignIn.jsp");
    } else {
        // get user information if login
        String id = session.getAttribute("userid").toString();
        pojo = SuperDao.getUserById(Integer.parseInt(id));
    }
%>  
<!DOCTYPE html>
<html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="static/bootstrap/bootstrap.min.css">
        <!-- External CSS -->
        <link rel="stylesheet" href="static/css/skDashboard.css">
        <link rel="stylesheet" href="static/css/skcard.css">
        <title>Document</title>

        <style>
            *{
                scroll-behavior: smooth;
            }
            .jumboLink:hover {
                text-decoration: none;
            }

            /* back to top btn */
            #myBtn {
                display: none;
                position: fixed;
                bottom: 20px;
                right: 30px;
                z-index: 99;
                font-size: 18px;
                border: none;
                outline: none;
                color: white;
                cursor: pointer;
                border-radius: 4px;
            }

            #myBtn:hover {
                background-color: #555;
            }
        </style>
    </head>

    <body>
        
        <div class="jumbotron text-center" style="margin-bottom:0">
            <h1>Welcome, <%=pojo.getUserName()%></h1>
            <p><%=pojo.getUserEmail()%></p>
        </div>

        <div class="nav p-1">
            <div class="">
                <a href="skStoreRegistration.jsp" class="text-light">Your Store</a>
            </div>
            <div class="">
                <a href="#page2" class="text-light">Pending Order: <span class="nuberoforder">3</span></a>
            </div>
            <div class="">
                <a href="#page3" class="text-light">Orders History: <span class="nuberoforder">1</span></a>
            </div>
            <div class="">
                <a href="userSignIn.html" class="text-light">Edit Me</a>
            </div>
            <div class="">
                <a href="#" class="text-light">Logout</a>
            </div>
        </div>

        <!--All remaining Orders-->
        <section id="page2" class="page mt-3">

            <div class="card">
                <div class="card-header text-center">
                    <h4>Pending Orders</h4>
                </div>
                <div class="card-body">
                    <div class="skcard">
                        <div class="skcard-header row">
                            <div class="skcard-header-number col-sm-1">1</div>
                            <div class="skcard-header-cinfo col-sm-11">
                                <div>Customer Information:-
                                    <a href="#" class="" data-toggle="modal" data-target="#quick_view">
                                        Smit Dhaneshbhai Bhikadiya</a>
                                </div>
                                <div>Address: Shantinagar, GadhadaRoad, Botad</div>
                            </div>
                        </div>
                        <div class="skcard-body row" style="overflow:scroll;">
                            <div class="skcard-itemsection col-sm-12">
                                <div class="card-table">
                                    <table class="table" id="table-responsive">
                                        <thead class="thead text-center">
                                            <tr>
                                                <th scope="col">Iimg</th>
                                                <th scope="col">Iname</th>
                                                <th scope="col">Iprize(per unit)</th>
                                                <th scope="col">Iqty</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Mark as Available</th>
                                            </tr>
                                        </thead>
                                        <tbody class="tbody text-center">
                                            <tr>
                                                <td><img class="oimg" src="static/img/apple.png" alt="apple"></td>
                                                <td>
                                                    <a href="#" class="" data-toggle="modal" data-target="#product_view">
                                                        Apple</a>
                                                </td>
                                                <td>50/kg</td>
                                                <td>4</td>

                                                <td>50X4= 200/-</td>
                                                <td><input type="checkbox" checked></td>
                                            </tr>
                                            <tr>
                                                <td> <img class="oimg" src="static/img/banana.png" alt=""> </td>
                                                <td><a href="#" class="" data-toggle="modal" data-target="#product_view">
                                                        Banana</a>
                                                </td>
                                                <td>65/dozen</td>
                                                <td>2</td>

                                                <td>65X2= 130/-</td>
                                                <td><input type="checkbox" checked></td>
                                            </tr>
                                            <tr>
                                                <td> <img class="oimg" src="static/img/grapes.png" alt=""> </td>
                                                <td><a href="#" class="" data-toggle="modal" data-target="#product_view">
                                                        Graps</a>
                                                </td>
                                                <td>70/kg</td>
                                                <td>1</td>

                                                <td>70X1= 70/-</td>
                                                <td><input type="checkbox" checked></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">Total Item : 3</td>
                                                <td class="bill">Total = <span>400/-</span></td>
                                                <td>All Available</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="skcard-actions row  d-flex justify-content-center align-item-center">

                            <select name="aprox time" id="" class="form-control mb-2" required>
                                <option value="0">Time for Delivering</option>
                                <option value="00:15">00:15 hour</option>
                                <option value="00:30">00:30 hour</option>
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
                            <a href="#" class="skcard-accept">Accept</a>
                            <a href="#" class="skcard-cancel">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section id="page3">
            <div class="card mt-2">
                <div class="card-header text-center">
                    <h4>Orders History</h4>
                </div>
                <div style="height:50vh;overflow:scroll;">
                    <div class="card-body text-center">
                        <table class="table " id="table-responsive">
                            <thead class="thead-dark text-center">
                                <tr>
                                    <th scope="col">Items Id</th>
                                    <th scope="col">Items Name</th>
                                    <th scope="col">Items Image</th>
                                    <th scope="col">Items Qty</th>
                                    <th scope="col">Total Amount</th>
                                    <th scope="col">Customer Name</th>
                                    <th scope="col">Servicer</th>
                                    <th scope="col">View Bill</th>
                                </tr>
                            </thead>
                            <tbody class="text-center">
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Banana</td>
                                    <td><img src="static/img/banana.png" width="50px" height="50" alt=""></td>
                                    <td>4 dozen</td>
                                    <td><kbd>45/-</kbd></td>
                                    <td>Ankit Chauhan</td>
                                    <td>Ajay Devgon</td>
                                    <td><a href="#">Invoice</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        
        <img src="static/img/top.png" onclick="topFunction()" id="myBtn" title="Go to top" width="50px" alt="">

        <!-- Shop keeper modal start -->
        <div class="modal" id="quick_view">
            <div class="modal-dialog modal-sm modal-md modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <!-- product details inner end -->
                        <div class="product-details-inner pl-4">

                            <hr style="background-color:black;opacity: 0.5;" width="90%">
                            <div class="row px-5 ">
                                <div class="col-lg-5 col-md-6 mb-4">
                                    <img src="static/img/profile.jpeg" width="90%" alt="">
                                </div>
                                <div class="col-lg-7 col-md-6 "
                                     style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">
                                    <h4>Name :</h4>
                                    <h5>Smit Dhaneshbhai Bhikadiya</h5>
                                    <h4>Address :</h4>
                                    <h5>Shantinagar, GadhadaRoad, Botad</h5>
                                    <h4>Phone :</h4>
                                    <h5>+91 846 911 6765</h5>
                                </div>
                            </div>
                        </div>
                        <!-- product details inner end -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Shop keeper modal end -->

        <!-- Product view modal start -->
        <div class="modal" id="product_view">
            <div class="modal-dialog modal-sm modal-md modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <!-- product details inner end -->
                        <div class="product-details-inner pl-4">
                            <hr style="background-color:black;opacity: 0.5;" width="90%">
                            <div class="row px-5 ">
                                <div class="col-lg-5 col-md-6 mb-4">
                                    <img src="static/img/apple.png" width="95%" alt="">
                                </div>
                                <div class="col-lg-7 col-md-6 py-2"
                                     style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">
                                    <h3>Item Name :</h3>
                                    <h5>Apple</h5>
                                    <h3>Price :</h3>
                                    <h5>$45</h5>
                                    <h3>Total Quantity :</h3>
                                    <h5>30 Item</h5>
                                </div>
                            </div>
                        </div>
                        <!-- product details inner end -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Product view modal end -->

        <script>

            window.addEventListener('resize', function () {
                if ($(window).width() < 550) {
                    $("#table-responsive").addClass('table-responsive');
                }
                else {
                    $("#table-responsive").removeClass('table-responsive');
                }
            });


            //Get the button
            var mybutton = document.getElementById("myBtn");

            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction()
            };

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    mybutton.style.display = "block";
                } else {
                    mybutton.style.display = "none";
                }
            }

            // When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }

        </script>


        <!-- External JS -->
        <script src="static/js/skDashboard.js"></script>
        <script src="static/js/vendor.js"></script>

    </body>

</html>