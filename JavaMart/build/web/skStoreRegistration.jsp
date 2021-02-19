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
</head>

<body>

    <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Register Your Shop Hear</h1>
        <p>Owner:- Smit D. Bhikadiya</p>
        <a href="shopkeeperDashboard.jsp">Back To Dashboard </a>|
        <a href="skStoreAddItemForm.html">Add Item</a>
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
                            <form action="storeRegister" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="skid" value="">
                                <input type="hidden" name="imgpath" value="" id="imgpath">
                                <div class="form-group">
                                    <label for="storeName">Register Storename</label>
                                    <input type="text" class="form-control" name="strname" required>
                                </div>
                                <div class="form-group">
                                    <label for="storeimg">Store Image</label>
                                    <input type="file" id="img" onchange="onimgchange(event)" accept=".jpeg,jpg,.png" name="strimg" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="storeadd">Store Address</label>
                                    <textarea  id="" cols="30" rows="2" name="straddress" class="form-control" required></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="storeContact">Store Contact Number</label>
                                    <input type="number" class="form-control" name="strcontact" max="9999999999">
                                </div>
                                <div class="form-group">
                                    <label for="storeType">Store Type</label>
                                    <select name="strtype" id="" class="form-control">
                                        <option value="Grocery">Grocery Store</option>
                                        <option value="Fruits" disabled>Fruits Store</option>
                                        <option value="Vegetables" disabled>Vegetables Store</option>
                                        <option value="Farsan" disabled>Farsan Store</option>
                                        <option value="Frozen Foods" disabled>Frozen Foods Store</option>
                                        <option value="Statinory" disabled>Statinory Store</option>
                                        <option value="Others" disabled>Others</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="havingServiser" onclick="checkme()" style="cursor: pointer;">Are you having serviser?</label>
                                    <input type="checkbox" id="havingSrvs" name="havingserviser">
                                </div>
                                <div class="form-group">
                                    <label for="storeName">Store Opening Time</label>
                                    <input type="time" class="form-control" name="openat" required>
                                    <label for="storeName">Store Closing Time</label>
                                    <input type="time" class="form-control" name="closeat" required>
                                </div>
                                <div style="margin-top: 20px;">
                                    <input type="submit" class="form-control btn btn-primary" onclick="return myFunc()"
                                        value="Register">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="static/bootstrap/javascript.min.js"></script>
    <script src="static/js/skDashboard.js"></script>

    <script>
        function checkme(){
            var check1 = document.getElementById("havingSrvs");
            if(check1.checked==false){
                check1.checked = true;
            }
            else{
                check1.checked = false;
            }
        }
        function onimgchange(event){
          
        }
    </script>
</body>

</html>