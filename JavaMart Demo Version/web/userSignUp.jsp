<%-- 
    Document   : userSignUp
    Created on : 16 Feb, 2021, 9:50:34 PM
    Author     : Smit Bhikadiya
--%>

<%@page import="DAOs.SuperDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--Bootstrap CDN-->
    <link rel="stylesheet" href="static/bootstrap/bootstrap.min.css">
    <script src="static/bootstrap/jquery.min.js"></script>

    <!--CSS-->
    <link rel="stylesheet" href="static/css/form.css">
    <title>Document</title>
</head>

<body>
     <div class="form-registration">
        <form action="signUp" method="POST">
            <div class="form-group brand text-center">
                <img src="static/img/profile.jpeg" alt="" width="100px" height="120px">
                <p><span>S</span>uper<span>M</span>art</p>
                <marquee loop = "5"><span>S</span>hopkeeper <span>R</span>egistration <span>F</span>orm</marquee>
            </div>
            <div class="form-group">
                <label for="fullname">Username </label>
                <input type="text" class="form-control" name="username">
            </div>
            <div class="form-group">
                <label for="userType">are you?</label>
                <select name="usertype" class="form-control">
                    <option value="ShopKeeper">ShopKeeper</option>
                    <option value="Servicer">Servicer</option>
                </select>
            </div>
            <div class="form-group">
                <label for="email">Email: </label>
                <input type="email" class="form-control" name="useremail">
            </div>
            <div class="form-group">
                <label for="mobile">Mobile No.: </label>
                <input type="text" class="form-control" name="usermobile">
            </div>
            <div class="form-group">
                <label for="password">Password: </label>
                <input type="password" class="form-control" name="userpassword">
            </div>
            <div class="form-group">
                <label for="address">Address: </label>
                <textarea class="form-control" name="useraddress"></textarea>
            </div>
            <div class="form-group">
                <button>Register</button>
                <input type="reset" value="Reset">
            </div>
            <div class="form-group">
                <a href="userSignIn.jsp">Login Form</a> |
                <a href="">Forgot Password</a>
            </div>
        </form>
    </div>
    
</body>

</html>
