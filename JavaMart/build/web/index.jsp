
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%  
    if(session.getAttribute("username")!=null){
        response.sendRedirect("shopkeeperDashboard.jsp");
    }
    else{
        response.sendRedirect("userSignIn.jsp");
    }
%>
