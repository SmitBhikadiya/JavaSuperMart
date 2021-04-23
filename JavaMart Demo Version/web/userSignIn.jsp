<%-- 
    Document   : userSignIn
    Created on : 16 Feb, 2021, 9:49:40 PM
    Author     : Smit Bhikadiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    if(session.getAttribute("username")!=null){
        response.sendRedirect("shopkeeperDashboard.jsp");
    }
    String email = request.getParameter("email");
    if(email==null){
        email = "";
    }
%>
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
    <div class="boxborder center">
        <form action="signIn" method="POST">
            <div class="form-group brand text-center">
                <img src="static/img/profile.jpeg" alt="" width="100px" height="120px">
                <p><span>S</span>uper<span>M</span>art</p>
                <marquee loop="5" scrollamount="5"><span>S</span>hopkeeper <span>L</span>ogin <span>F</span>orm
                </marquee>
            </div>
            <div class="form-group">
                <label for="uore">Email</label>
                <input type="email" class="form-control" name="useremail" value="<%=email%>" required>
            </div>
            <div class="form-group">
                <label for="Password">Password</label>
                <input type="password" class="form-control" name="userpassword" required>
            </div>
            <div class="form-group">
                <button class="btn btn-success form-control">Login</button>
            </div>
            <div class="form-group">
                <a href="userSignUp.jsp">New Registration</a> |
                <a href="">Forgot Password</a>
            </div>
        </form>
    </div>
</body>

</html>