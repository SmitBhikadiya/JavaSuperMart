
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoFeedback"%>
<%@page import="DAOs.DaoFeedback"%>
<%@page import="POJOs.PojoUsers"%>

<%
    if (request.getParameter("viewid") != null) {
        int feedid = Integer.parseInt(request.getParameter("viewid"));
        if (feedid != 0) {
            PojoFeedback pojo = DaoFeedback.getFeedbackByFeedid(feedid);
            PojoOrderHistory hist = DaoOrderHistory.getOrderHistoryByordid(pojo.getOrdid());
            out.println("<h1>reviewer name : "+hist.getBillingname()+"</h1>");
            out.println("<h3 style='margin-bottom:20px;'>Deliverd time : "+hist.getDeliveredtime()+"</h3><hr>");
            out.println("Overall rating : <h2>" + pojo.getOverall_rat() + "/5</h2>");
            out.println("Products rating : <h2>" + pojo.getProducts_rat() + "/5</h2>");
            out.println("Delivery Service : <h2>" + pojo.getDelivery_service() + "</h2>");
            out.println("Review message : <h2>" + pojo.getReview_msg() + "</h2>");
        } else {
            out.println("No review found!!");
        }
%>

<%} else {
%>

<%
    PojoUsers user = null;
    int cstmid = 0;
    if (session.getAttribute("userpojo") != null) {
        user = (PojoUsers) session.getAttribute("userpojo");
        cstmid = user.getCstmid();
    } else {
        session.setAttribute("info", "You are not login!!!");
        response.sendRedirect("login-register.jsp");
    }
%>

<%
    String odid = request.getParameter("odid");
    if (odid == null && request.getParameter("feedid") == null) {
        response.sendRedirect("track-order.jsp");
    }
%>

<%
    String btn = "Submit Review";
    int overall_rat = 5;
    int product_rev = 5;
    String delivery_serv = "Good";
    String review = "";
    int feedid = 0;
    if (request.getParameter("feedid") != null) {
        feedid = Integer.parseInt(request.getParameter("feedid"));
        System.out.println(feedid);
        if (feedid != 0) {
            PojoFeedback feed = DaoFeedback.getFeedbackByFeedid(feedid);
            btn = "Update Review";
            overall_rat = feed.getOverall_rat();
            product_rev = feed.getProducts_rat();
            delivery_serv = feed.getDelivery_service();
            review = feed.getReview_msg();
            odid = String.valueOf(feed.getOrdid());
        }else{
            odid = request.getParameter("ordid");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <title>SuperMart-Feedback</title>
        <link rel="stylesheet" href="assets/css/feedback.css">
    </head>
    <body>

        <header class="ScriptHeader">
            <div class="rt-container">
                <div class="col-rt-12">
                    <div class="rt-heading">
                        <h1>Feedback Form</h1>
                        <p>share your valuable feedback</p>
                    </div>
                </div>
            </div>
        </header>

        <section>
            <div class="rt-container">
                <div class="col-rt-12">
                    <div class="Scriptcontent">


                        <div class="feedback">
                            <p>Dear Customer,<br>
                                Thank you for getting your order at our store. We would like to know how we performed. Please spare some moments to give us your valuable feedback as it will help us in improving our service and quality.</p>

                            <h4>Please rate your service experience for the following parameters</h4>

                            <form action="feedback" method="POST">
                                <input type="hidden" name="ordid" value="<%=odid%>" >
                                <input type="hidden" name="feedid" value="<%=feedid%>" >
                                <label>1. Your overall experience with us ?</label><br>

                                <span class="">
                                    <%
                                        for (int i = 1; i <= 5; i++) {
                                            String sts = "";
                                            if (i == overall_rat) {
                                                sts = "checked";
                                            }
                                    %>
                                    <input type="radio" name="rat1" value="<%=i%>" <%=sts%>>
                                    <%
                                        }
                                    %>


                                </span>

                                <div class="clear"></div> 
                                <hr class="survey-hr">
                                <label>2. Give us overall rating for our products</label><br>
                                <span class="">
                                    <%
                                        for (int i = 1; i <= 5; i++) {
                                            String sts = "";
                                            if (i == product_rev) {
                                                sts = "checked";
                                            }
                                    %>
                                    <input type="radio" name="rat2" value="<%=i%>" <%=sts%>>
                                    <%
                                        }
                                    %>
                                </span>

                                <div class="clear"></div> 
                                <hr class="survey-hr">
                                <div class="row">
                                    <div class="col-sm-12 form-group">
                                        <label>3. How was our dilivery service?</label>
                                        <p>
                                            <%
                                                String[] exp = {"Bad", "Average", "Good", "Excellent"};
                                                for (int i = 0; i < exp.length; i++) {
                                                    String sts = "";
                                                    if (exp[i].equals(delivery_serv)) {
                                                        sts = "checked";
                                                    }
                                            %>
                                            <label class="radio-inline">
                                                <input type="radio" name="exp" id="radio_experience" value="<%=exp[i]%>" <%=sts%>>
                                                <%=exp[i]%>
                                            </label>
                                            <%
                                                }
                                            %>

                                        </p>
                                    </div>
                                </div>


                                <hr class="survey-hr"> 
                                <label for="">4. Any Other suggestions:</label><br/><br/>
                                <textarea name="commentText" rows="5" style="width:100%;"><%=review%></textarea><br>
                                <br>
                                <div class="clear"></div> 
                                <input style="background:#43a7d5;color:#fff;padding:12px;border:0" type="submit" value="<%=btn%>">&nbsp;
                                <a href="track-order.jsp">skip</a>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </section>



        <!-- Analytics -->

    </body>
</html>

<% }%>