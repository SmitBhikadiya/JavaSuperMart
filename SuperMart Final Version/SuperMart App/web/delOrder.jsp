
<%@page import="POJOs.PojoOrdersList"%>
<%@page import="DAOs.DaoOrdersList"%>
<%@page import="POJOs.PojoUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    } else {
        session.setAttribute("info", "Please login first");
        response.sendRedirect("login-register.jsp");
    }
%>

<% 
    int olid = 0;
    if(request.getParameter("olid")!=null){
        olid = Integer.parseInt(request.getParameter("olid"));
    }
    PojoOrdersList pojo = DaoOrdersList.getOrdLsByListId(olid);
    if(pojo!=null){
        DaoOrdersList.deleteOrderById(olid);
        response.sendRedirect("cart.jsp");
    }
%>
