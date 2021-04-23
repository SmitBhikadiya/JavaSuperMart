
import DAOs.DaoATC;
import DAOs.DaoOrderHistory;
import DAOs.DaoOrderHistoryList;
import DAOs.DaoOrders;
import DAOs.DaoOrdersList;
import DAOs.DaoOrdersStatus;
import DAOs.DaoProducts;
import DAOs.DaoServicerAccept;
import DAOs.DaoServicerHistory;
import DAOs.DaoStore;
import DAOs.DaoUsers;
import POJOs.PojoATC;
import POJOs.PojoOrderHistory;
import POJOs.PojoOrderHistoryList;
import POJOs.PojoOrders;
import POJOs.PojoOrdersStatus;
import POJOs.PojoServicerAccept;
import POJOs.PojoStore;
import POJOs.PojoUsers;
import Utils.MasterSetting;
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
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/Servicer_Order_Manage"})
public class Servicer_Order_Manage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String odid = request.getParameter("odid");
            String pin = request.getParameter("pin");
            String srid = request.getParameter("sid");
            String status = request.getParameter("sts");
            String type = "Servicer";

            HttpSession session = request.getSession();
            
            String reaccid = request.getParameter("reaccid");
            if(reaccid!=null){
                int ordid = Integer.parseInt(reaccid);
                PojoServicerAccept p = DaoServicerAccept.checkOrderIsInserted(ordid);
                if(p!=null){
                    DaoServicerAccept.deleteOrder(ordid);
                }
            }

            if (odid != null && pin == null && status == null) {
                int ordid = Integer.parseInt(odid);
                System.out.println(ordid);

                String text = "";
                PojoOrders pojo = DaoOrders.getOrdersByOrdid(ordid);
                PojoStore str = DaoStore.getStoreById(pojo.getStrid());
                PojoUsers cstm = DaoUsers.getUserById(pojo.getCstmid());
                PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(pojo.getOrdid());

                text = str.getStrname() + "@" + str.getStraddress() + "@" + str.getStrcontact() + "@" + cstm.getCstmname() + "@" + cstm.getCstmaddress() + "@" + cstm.getCstmcontact() + "@" + sts.getAcceptstatus() + "@" + sts.getAccepttime();
                out.println(text);
            }

            if (odid != null && pin != null && srid != null) {
                System.out.println(odid + ">>" + pin);
                int ordid = Integer.parseInt(odid);
                String p = DaoOrdersStatus.getePin(ordid);
                PojoOrders ord = DaoOrders.getOrdersByOrdid(ordid);
                PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                if (sts.getOrdstatus() == 0) {
                    session.setAttribute("resmsg", "Order has been cancel by the shopkeeper or customer");
                } else {
                    if (p.equals(pin)) {
                        DaoOrdersStatus.updateOrderStatus(1, 4, sts.getOrdarrivalat(), ordid);
                        System.out.println("Order updated Successfully");
                        List<PojoATC> atc = DaoATC.getATCByAcsSts(ord.getStrid(), ordid, 4);
                        out.println(ordid + " " + ord.getStrid());
                        int historyid = 0;
                        int sid = Integer.parseInt(srid);
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
                            LocalDateTime datetime1 = LocalDateTime.now();
                            DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

                            // *** hear added ***
                            DaoProducts.updatePurchased(prdid);
                            System.out.println("Products is purchased successfully where prdid is "+prdid);
                            
                            String deliveredtime = datetime1.format(format);
                            if (i == 0) {
                                DaoOrderHistory.insertOrderHistory(new PojoOrderHistory(ordid, cstmid, ord.getStrid(), ordcharge, deliveredby, type, deliveredcontact, orderedtime, deliveredtime, cstmname, cstmaddress));
                                System.out.println("added new history record for order :" + ordid);
                                
                                historyid = DaoOrderHistory.getOrderHistoryByordid(ordid).getOrdhistoryid();
                                
                                // *** hear changed ***
                                System.out.println("Last History id : " + historyid);
                                DaoServicerHistory.insertOrder(sid, historyid, ord.getStrid(), MasterSetting.SER_PAY_PER_ORDER);
                                
                            }
                            if (historyid != 0) {
                                DaoOrderHistoryList.insertOrderHistoryList(new PojoOrderHistoryList(historyid, prdid, prdname, prdprize, prdqty, prdtotal, prdimgpath));
                                System.out.println("added to orderlist" + historyid);
                                DaoOrdersList.deleteOrderById(ordlisid);
                                System.out.println("Delete order list : " + ordlisid);
                                DaoServicerAccept.deleteOrder(ordid);
                            }
                            if (i == atc.size() - 1) {
                                DaoOrders.deleteOrderById(ordid);
                                System.out.println("Successfully delete orders :" + ordid);
                                DaoOrdersStatus.deleteOrderById(ordid);
                                System.out.println("Successfully delete order status : " + ordid);
                            }
                        }
                    } else {
                        System.out.println("Wrong Pin" + pin);
                    }
                }
                response.sendRedirect("Servicer/servicerAccepted.jsp");
            }

            if (odid != null && status != null) {
                System.out.println(odid + ">>" + status);
                int ordid = Integer.parseInt(odid);
                PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                if (sts.getOrdstatus() == 0) {
                    System.out.println("Order status is "+sts.getOrdstatus());
                    out.println(0);
                }else{
                    DaoOrdersStatus.updateOrderStatus(sts.getOrdstatus(), Integer.parseInt(status), sts.getOrdarrivalat(), Integer.parseInt(odid));
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Servicer_Order_Manage.class.getName()).log(Level.SEVERE, null, ex);
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

}
