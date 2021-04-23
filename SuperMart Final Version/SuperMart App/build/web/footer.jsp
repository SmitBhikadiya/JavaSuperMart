<%@page import="DAOs.DaoFeedback"%>
<%@page import="DAOs.DaoOrderHistory"%>
<%@page import="POJOs.PojoOrderHistory"%>
<%@page import="POJOs.PojoFeedback"%>
<%@page import="POJOs.PojoCategory"%>
<%@page import="DAOs.DaoCategory"%>
<%@page import="DAOs.DaoProductsReview"%>
<%@page import="POJOs.PojoProductsReview"%>
<%@page import="POJOs.PojoProducts"%>
<%@page import="DAOs.DaoProducts"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>


<!-- best sellers area start -->
<section class="category-features-area pt-60 pt-sm-30">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-md-30 mb-sm-30">
                <div class="section-title section-title__2">
                    <h2>Best Seller</h2>
                </div>
                <div class="best-sellers-content">
                    <div class="row product-carousel-active-3" data-row="3">

                        <%
                            List<PojoProducts> pop = DaoProducts.getHighestSelling(3);
                            for (PojoProducts po : pop) {
                                PojoCategory catid = DaoCategory.getCatByName(po.getPrdcategory());

                        %>
                        <div class="col">
                            <div class="single-item mb-30">
                                <div class="product-thumb">
                                    <a>
                                        <img src="<%=po.getImgpath()%>" alt="">
                                    </a>
                                </div>
                                <div class="product-description">
                                    <div class="tag-cate">
                                        <a href="single-product.jsp?ctid=<%=catid.getCatid()%>&category=<%=po.getPrdcategory()%>"><%=po.getPrdcategory()%></a>
                                    </div>
                                    <div class="product-name">
                                        <h4 class="h5">
                                            <a href="single-product.jsp?prdid=<%=po.getPrdid()%>&prdname=<%=po.getPrdname()%>"><%=po.getPrdname()%></a>
                                        </h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><%=po.getPrdprize()%>₹</span>
                                        <% 
                                                            if(po.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((po.getPrdprize() * po.getPrddiscount()) / 100) + po.getPrdprize()); %></del>₹</span>
                                                            <% } %> </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-md-30 mb-sm-30">
                <div class="section-title section-title__2">
                    <h2>new arrivals</h2>
                </div>
                <div class="best-sellers-content">
                    <div class="row product-carousel-active-3" data-row="3">

                        <%
                            List<PojoProducts> pojo = DaoProducts.getNewProducts(3);
                            for (PojoProducts po : pojo) {
                                PojoCategory catid = DaoCategory.getCatByName(po.getPrdcategory());

                        %>
                        <div class="col">
                            <div class="single-item mb-30">
                                <div class="product-thumb">
                                    <a>
                                        <img src="<%=po.getImgpath()%>" alt="">
                                    </a>
                                </div>
                                <div class="product-description">
                                    <div class="tag-cate">
                                        <a href="single-product.jsp?ctid=<%=catid.getCatid()%>&category=<%=po.getPrdcategory()%>"><%=po.getPrdcategory()%></a>
                                    </div>
                                    <div class="product-name">
                                        <h4 class="h5">
                                            <a href="single-product.jsp?prdid=<%=po.getPrdid()%>&prdname=<%=po.getPrdname()%>"><%=po.getPrdname()%></a>
                                        </h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><%=po.getPrdprize()%>₹</span>
                                       <% 
                                                            if(po.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((po.getPrdprize() * po.getPrddiscount()) / 100) + po.getPrdprize()); %></del>₹</span>
                                                            <% } %> </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-md-30 mb-sm-30">
                <div class="section-title section-title__2">
                    <h2>top rated</h2>
                </div>
                <div class="best-sellers-content">
                    <div class="row product-carousel-active-3" data-row="3">
                        <%
                            List<PojoProductsReview> poj = DaoProductsReview.getToprated(3);
                            for (PojoProductsReview p : poj) {
                                PojoProducts po = DaoProducts.getProductsById(p.getPrdid());
                                PojoCategory catid = DaoCategory.getCatByName(po.getPrdcategory());
                        %>
                        <div class="col">
                            <div class="single-item mb-30">
                                <div class="product-thumb">
                                    <a>
                                        <img src="<%=po.getImgpath()%>" alt="">
                                    </a>
                                </div>
                                <div class="product-description">
                                    <div class="tag-cate">
                                        <a href="single-product.jsp?ctid=<%=catid.getCatid()%>&category=<%=po.getPrdcategory()%>"><%=po.getPrdcategory()%></a>
                                    </div>
                                    <div class="product-name">
                                        <h4 class="h5">
                                            <a href="single-product.jsp?prdid=<%=po.getPrdid()%>&prdname=<%=po.getPrdname()%>"><%=po.getPrdname()%></a>
                                        </h4>
                                    </div>
                                    <div class="price-box">
                                        <span class="regular-price"><%=po.getPrdprize()%>₹</span>
                                       <% 
                                                            if(po.getPrddiscount()!=0){ 
                                                            %>
                                                            <span class="old-price"><del><% out.println(((po.getPrdprize() * po.getPrddiscount()) / 100) + po.getPrdprize()); %></del>₹</span>
                                                            <% } %>  </div>
                                </div>
                            </div>
                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- best sellers area end -->

<!-- testimonial area start -->
<%
    List<PojoFeedback> feeds = DaoFeedback.getAllFeedbackBytest();
    if (feeds.size() > 0) {
%>
<div class="testimonial-area pt-60 pb-88">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section-title text-center">
                    <h2 class="text-white">testimonial</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="testimonial-carousel-active slick-dot-style">
                    <%
                        for (PojoFeedback feed : feeds) {
                            PojoOrderHistory hist = DaoOrderHistory.getOrderHistoryByordid(feed.getOrdid());
                    %>
                    <div class="testimonial-item text-center">
                        <div class="testimonial-thumb">
                            <img src="assets/img/testimonial/team-member-1.jpg" alt="">
                        </div>
                        <div class="testimonial-content">
                            <p><%=feed.getReview_msg()%></p>
                            <p>Overall Experience: <%=feed.getOverall_rat()%>/5</p>
                            <h3><a href="#"><%=hist.getBillingname()%></a></h3>
                        </div>
                    </div>
                    <% }%>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- testimonial area end -->
<% }%>


<!-- choosing area start -->
<div class="choosing-area pt-60 pb-56 pb-md-24 pb-sm-24">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section-title text-center">
                    <h2>why choose us</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <div class="single-choose-item text-center mb-md-30 mb-sm-30">
                    <i class="fa fa-globe"></i>
                    <h4>free shipping</h4>
                    <p>It's always better when it's natural. I farm, You eat. Don't panic, it's organic. Know Your Farmer, Know Your Food
                    </p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="single-choose-item text-center mb-md-30 mb-sm-30">
                    <i class="fa fa-plane"></i>
                    <h4>fast delivery</h4>
                    <p>we use top-ranking quality, reasonable price, endurable packing and fast delivery time to serve for the most of customers. And free delivery on ?500 or more purchase.</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="single-choose-item text-center mb-md-30 mb-sm-30">
                    <i class="fa fa-comments"></i>
                    <h4>customers support</h4>
                    <p>Building a good customer experience does not happen by accident. It happens by design.</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- choosing area end -->

<!--== Start Footer Area Wrapper ==-->
<footer class="footer-wrapper">

    <!-- footer bottom area start -->
    <div class="footer-bootom bg-gray pt-20 pb-20">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="copyright-text text-center text-md-left">
                        <p>Â© 2021 <b>Selena</b> Made with <i class="fa fa-heart text-danger"></i> by <a
                                href="https://hasthemes.com/">HasThemes</a></p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="payment-method text-md-right text-center">
                        <img src="assets/img/payment.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer bottom area end -->

</footer>
<!--== End Footer Area Wrapper ==-->