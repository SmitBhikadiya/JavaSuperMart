<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="static/bootstrap/bootstrap.min.css">
    <script src="static/bootstrap/jquery.min.js"></script>


    <!-- External CSS -->
    <link rel="stylesheet" href="static/css/skDashboard.css">
    <title>Store Registration</title>

    <style>
        .jumboLink:hover{
            text-decoration: none;
        }
    </style>
</head>

<body>

    <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Store Customization Form</h1>
        <p>Owner:- Smit D. Bhikadiya</p>
        <a class="jumboLink" href="shopkeeperDashboard.jsp">Back To Dashboard </a>|
        <a class="jumboLink" href="skStoreRegistration.html">Edit Your Shop</a>
    </div>

    <div class="nav p-1">
        <div class="">
            <a href="skStoreRegistration.html" class="text-light">Your Store</a>
        </div>
        <div class="">
            <a href="#page2" class="text-light">Remaining Order: <span class="nuberoforder">3</span></a>
        </div>
        <div class="">
            <a href="#page3" class="text-light">Orders History: <span class="nuberoforder">1</span></a>
        </div>
        <div class="">
            <a href="skRegistrationForm.html" class="text-light">Edit Me</a>
        </div>
        <div class="">
            <a href="#" class="text-light">Logout</a>
        </div>
    </div>
    <div class="card flex-fill ml-2" onclick="">
        <div class="card-header text-center">
            <h3>Step-2 : Added Items</h3>
        </div>
        <div class="card-body">
            <form action="">
                <div class="d-flex">
                    <input type="text" placeholder="Item Name" class="form-control mr-3 mb-3">
                    <input type="file" class="form-control ">
                </div>

                <div class="d-flex">
                    <input type="number" placeholder="Total Quantity of Item" min=0 step="1" class="form-control mb-3">
                    <select name="" id="" class="form-control" style="width: 200px;">
                        <option value="kg">in kg</option>
                        <option value="gram">in gram</option>
                        <option value="piese">in piece</option>
                        <option value="pair">in pair</option>
                        <option value="L">in liter</option>
                        <option value="ml">in milileter</option>
                    </select>
                </div>

                <div class="d-flex">
                    <input type="text" placeholder="Prize per Item with Discount" class="form-control mr-3">
                    <input type="number" max="100" min="0" step="1" placeholder="Enter Item Discount (recommand: 50%)"
                        class="form-control mb-3">
                </div>

                <div class="d-flex">
                    <textarea name="" id="" cols="30" rows="1" class="form-control"
                        placeholder="Describe your product.."
                        title="Example of shooes:- Staint and water resitance leather"></textarea>
                </div>

                <div style="margin-top: 20px;">
                    <input type="submit" class="form-control btn btn-primary" value="Add To List">
                </div>
            </form>
            <div class="card mt-3">
                <div class="card-header text-center">
                    <h4>Added Items</h4>
                </div>
                <div class="card-body text-center">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Image</th>
                                <th scope="col">Items</th>
                                <th scope="col">Total Qty</th>
                                <th scope="col">Prize</th>
                                <th scope="col">Discount</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td><img src="static/img/apple.png" width="50px" height="50" alt=""></td>
                                <td>Apple</td>
                                <td>10 kg</td>
                                <td>45</td>
                                <td>10%</td>
                                <td><a href="#">Edit</a> | <a href="#">Remove</a></td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td><img src="static/img/banana.png" width="50px" height="50" alt=""></td>
                                <td>Banana</td>
                                <td>24 dozen</td>
                                <td>45</td>
                                <td>0%</td>
                                <td><a href="#">Edit</a> | <a href="#">Remove</a></td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td><img src="static/img/grapes.png" width="50px" height="50" alt=""></td>
                                <td>Graps</td>
                                <td>30 kg</td>
                                <td>60</td>
                                <td>25%</td>
                                <td><a href="#">Edit</a> | <a href="#">Remove</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </div>

    <script src="static/bootstrap/javascript.min.js"></script>
    <script src="static/js/skDashboard.js"></script>
</body>

</html>