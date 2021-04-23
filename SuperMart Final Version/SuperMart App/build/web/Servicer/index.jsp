
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%  
    session.removeAttribute("adminuser");
    if(session.getAttribute("suser")!=null){
        response.sendRedirect("servicerDashboard.jsp");
    }
    else{
        session.setAttribute("type", "servicer");
        response.sendRedirect("../admin-login-register.jsp");
    }
%>
