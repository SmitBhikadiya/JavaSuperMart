
import DAOs.DaoATC;
import DAOs.DaoAdminUser;
import DAOs.DaoOrderHistory;
import DAOs.DaoOrderHistoryList;
import DAOs.DaoOrderRequest;
import DAOs.DaoOrders;
import DAOs.DaoOrdersList;
import DAOs.DaoOrdersStatus;
import DAOs.DaoProducts;
import DAOs.DaoUsers;
import POJOs.PojoATC;
import POJOs.PojoAdminUser;
import POJOs.PojoOrderHistory;
import POJOs.PojoOrderHistoryList;
import POJOs.PojoOrderRequest;
import POJOs.PojoOrdersList;
import POJOs.PojoOrdersStatus;
import POJOs.PojoProducts;
import POJOs.PojoUsers;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/SK_Store_Order_Manage"})
public class SK_Store_Order_Manage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String orderid = request.getParameter("odid");
            String atime = request.getParameter("atime");
            String adid = request.getParameter("adid");
            String upin = request.getParameter("pin");
            String type = "Shopkeeper";

            LocalDateTime datetime1 = LocalDateTime.now();
            DateTimeFormatter format;

            if (upin != null && orderid != null) {
                int ordid = Integer.parseInt(orderid);
                PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(Integer.parseInt(orderid));
                if (sts.getOrdstatus()!=0) {
                    String dpin = sts.getPin();
                    int strid = DaoOrders.getOrdersByOrdid(Integer.parseInt(orderid)).getStrid();
                    if (upin.equals(dpin)) {
                        DaoOrdersStatus.updateOrderStatus(1, 4, sts.getOrdarrivalat(), ordid);
                        System.out.println("Order updated Successfully");
                        List<PojoATC> atc = DaoATC.getATCByAcsSts(strid, ordid, 4);
                        out.println(ordid + " " + strid);
                        int historyid = 0;
                        for (int i = 0; i < atc.size(); i++) {
                            PojoATC pojo = atc.get(i);
                            int ordlisid = pojo.getOrdlistid();
                            int cstmid = pojo.getCstmid();
                            PojoUsers cstmpojo = DaoUsers.getUserById(cstmid);
                            String cstmaddress = cstmpojo.getCstmaddress();
                            String cstmname = cstmpojo.getCstmname();
                            int prdid = pojo.getPrdid();
                            String prdname = pojo.getPrdname();
                            int prdprize = pojo.getPrdprize();
                            int prdqty = pojo.getPrdqty();
                            int prdtotal = pojo.getPrdtotalamount();
                            String prdimgpath = pojo.getImgpath();
                            int ordcharge = pojo.getOrdcharge();
                            String deliveredby = sts.getAcceptedname();
                            String deliveredcontact = sts.getAcceptedcontact();
                            String orderedtime = sts.getOrdarrivalat();
                            format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                            
                            // *** hear added ***
                            DaoProducts.updatePurchased(prdid);
                            System.out.println("Products is purchased successfully where prdid is "+prdid);
                            
                            String deliveredtime = datetime1.format(format);
                            if (i == 0) {
                                DaoOrderHistory.insertOrderHistory(new PojoOrderHistory(ordid, cstmid, strid, ordcharge, deliveredby, type, deliveredcontact, orderedtime, deliveredtime, cstmname, cstmaddress));
                                System.out.println("added new history record for order :" + ordid);
                                // *** hear changed ***
                                historyid = DaoOrderHistory.getOrderHistoryByordid(ordid).getOrdhistoryid();
                                System.out.println("Last History id : " + historyid);
                            }
                            if (historyid != 0) {
                                DaoOrderHistoryList.insertOrderHistoryList(new PojoOrderHistoryList(historyid, prdid, prdname, prdprize, prdqty, prdtotal, prdimgpath));
                                System.out.println("added to orderlist" + historyid);
                                DaoOrdersList.deleteOrderById(ordlisid);
                                System.out.println("Delete order list : " + ordlisid);
                            }
                            if (i == atc.size() - 1) {
                                DaoOrders.deleteOrderById(ordid);
                                System.out.println("Successfully delete orders :" + ordid);
                                DaoOrdersStatus.deleteOrderById(ordid);
                                System.out.println("Successfully delete order status : " + ordid);
                            }
                        }
                    } else {
                        System.out.println("Wrong Pin" + dpin);
                    }
                } else{
                    System.out.println("Order is cancelled by the customer");
                }
                response.sendRedirect("Shopkeeper/shopkeeperDashboard.jsp");
            }

            String ord_ = request.getParameter("ordrmid");
            System.out.println(ord_);
            if (ord_ != null && adid != null) {

                int ordid = Integer.parseInt(ord_);
                System.out.println("Order is being cancelled");

                PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                PojoAdminUser user = DaoAdminUser.getAdminById(ordid);

                List<PojoOrdersList> li = DaoOrdersList.getOrdByOrdid(ordid);
                for (PojoOrdersList p : li) {
                    if (p != null) {
                        DaoProducts.updateStock(p.getPrdid(), p.getPrdqty(), "inc");
                    }
                }

                DaoOrdersStatus.updateOrderStatus(new PojoOrdersStatus(ordid, 1, sts.getOrdarrivalat(), sts.getDeliverytime(), "5", user.getAdname(), user.getAdcontact(), "NA"));
                response.sendRedirect("Shopkeeper/shopkeeperDashboard.jsp");
            }

            if (orderid != null && atime != null && adid != null) {
                System.out.println(orderid + atime);

                PojoOrdersStatus pojo = DaoOrdersStatus.getOrderStatusByOrdId(Integer.parseInt(orderid));
                System.out.println("Order status : "+pojo.getOrdstatus());
                if (pojo != null && pojo.getOrdstatus()!=0) {

                    // generate 4 digit pin and store into the orderstatus table
                    String pin = generateRandomPin();
                    DaoOrdersStatus.setPin(pin, Integer.parseInt(orderid));
                    System.out.println("Pin has been generated successfully and store to the database" + pin);

                    PojoAdminUser user = DaoAdminUser.getAdminById(Integer.parseInt(adid));
                    System.out.println("User is found");

                    format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String accepttime = datetime1.format(format);
                    System.out.println(accepttime);

                    // change orderstatus table field like acceptstatus, acceptname, aproxtime, acceptcontact
                    DaoOrdersStatus.updateOrderStatus(new PojoOrdersStatus(Integer.parseInt(orderid), 1, pojo.getOrdarrivalat(), accepttime, atime, "1", user.getAdname(), user.getAdcontact(), pin));
                    System.out.println("Order status Updated successfully");

                    // create card view for those data which is excepted and still pending
                    out.println(getPending(Integer.parseInt(orderid)));
                } else {
                    out.println(0);
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(SK_Store_Order_Manage.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String generateRandomPin() {
        String pin = "";
        String alphasmall = "abcdefghijklmnopqrstvwxyz";
        char pin1 = alphasmall.charAt((int) (Math.random() * alphasmall.length()));
        String alphabig = "ABCDEFGHIJKLMNOPQRSTVWXYZ";
        char pin2 = alphabig.charAt((int) (Math.random() * alphabig.length()));
        String number = "1234567890";
        char pin3 = number.charAt((int) (Math.random() * number.length()));
        pin = pin + String.valueOf(pin2) + String.valueOf(pin3) + String.valueOf(pin1);
        return pin;
    }

    private String getPending(int ordid) throws SQLException {
        String html = "";
        List<PojoOrderRequest> allpending = DaoOrderRequest.getOrderDataByStrid(DaoOrders.getOrdersByOrdid(ordid).getStrid(), 1, 1, 1);
        PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
        for (PojoOrderRequest pending : allpending) {
            System.out.println("Order accepted name :" + pending.getCstmname());
            String subhtml = "";
            List<PojoOrdersList> ls = DaoOrdersList.getOrdByOrdid(ordid);
            for (PojoOrdersList po : ls) {
                PojoProducts prd = DaoProducts.getProductsById(po.getPrdid());
                subhtml = subhtml + "<tr>\n"
                        + " <td><a href=\"single-product.jsp?prdid=" + prd.getPrdid() + "\">" + prd.getPrdname() + "</a></td>\n"
                        + " <td>$" + prd.getPrdprize() + " * " + po.getPrdqty() + " </td>\n"
                        + " <td>$" + po.getPrdtotalamount() + "</td>\n"
                        + " </tr>\n";
            }
            html = html + "<div class=\"main1\">\n"
                    + "                    <div class=\"container1\">\n"
                    + "                        <div class=\"p-3\">\n"
                    + "                            <div><h5>>> Customer name</h5>" + pending.getCstmname() + "</div>\n"
                    + "                            <div><h5>>> Address</h5>" + pending.getCstmaddress() + "</div>\n"
                    + "                            <div><h5>>> Contact</h5>" + pending.getCstmcontact() + "</div>\n"
                    + "                            <div><h5>>> Aprox Time</h5>" + sts.getDeliverytime() + "</div>\n"
                    + "                            <div><h5>>> Payment Method</h5>" + pending.getPaymethod() + "</div>\n"
                    + "                            <div><h5>>> Total Bill</h5>$" + pending.getOrdtotalbill() + "</div>\n"
                    + "                            <div class=\"mt-3\">"
                    + "                                 <form action=\"../SK_Store_Order_Manage\" method=\"POST\">"
                    + "                                       <input type=\"hidden\" name=\'odid\' value=\"" + pending.getOrdid() + "\">"
                    + "                                       <input type=\"text\" name=\"pin\" class=\"form-control\" placeholder=\"Enter Pin\">"
                    + "                                       <button class=\"mt-2 form-control btn btn-success text-white\">Delivered</button>"
                    + "                                </form>"
                    + "                            </div>"
                    + "                            <div class=\"mt-3\">\n"
                    + "                                <input type=\"text\" class=\"form-control\" placeholder=\"Enter Pin\">\n"
                    + "                                <button class=\"mt-2 form-control btn btn-success text-white\">Delivered</button>\n"
                    + "                            </div>\n"
                    + "                            \n"
                    + "                        </div>\n"
                    + "                        <div class=\"p-3\">\n"
                    + "                            <table class=\"table\">\n"
                    + "                                <tr>\n"
                    + "                                    <th>Product</th>\n"
                    + "                                    <th>Prize * Qty</th>\n"
                    + "                                    <th>Total</th>\n"
                    + "                                </tr>\n" + subhtml
                    + "                            </table>\n"
                    + "                        </div>\n"
                    + "                    </div>\n"
                    + "                </div>";
        }
        return html;
    }
}
