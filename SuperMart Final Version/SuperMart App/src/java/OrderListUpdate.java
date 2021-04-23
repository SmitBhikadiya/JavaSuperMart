
import DAOs.DaoAdminUser;
import DAOs.DaoOrders;
import DAOs.DaoOrdersList;
import DAOs.DaoOrdersStatus;
import DAOs.DaoProducts;
import DAOs.DaoProductsReview;
import DAOs.DaoShopkeeper;
import DAOs.DaoStore;
import DAOs.DaoUsers;
import POJOs.PojoAdminUser;
import POJOs.PojoOrders;
import POJOs.PojoOrdersList;
import POJOs.PojoOrdersStatus;
import POJOs.PojoProducts;
import POJOs.PojoProductsReview;
import POJOs.PojoShopkeeper;
import POJOs.PojoStore;
import POJOs.PojoUsers;
import Utils.SendEmail;
import Utils.TimeF;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/OrderListUpdate"})
public class OrderListUpdate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            LocalDateTime datetime1 = LocalDateTime.now();
            DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            String myJsonData = request.getParameter("data");
            if (myJsonData != null && myJsonData.length() > 0) {
                String[] arr = myJsonData.substring(1, myJsonData.length() - 1).split(",");
                for (int i = 0; i < arr.length; i = i + 3) {
                    int id = Integer.parseInt(arr[i]);
                    int qty = Integer.parseInt(arr[i + 1]);
                    int total = Integer.parseInt(arr[i + 2]);
                    System.out.println(id + " " + qty + " " + total);
                    DaoOrdersList.updateTotal(id, qty, total);
                }
            }

            String odid = request.getParameter("ordid");
            if (odid != null) {
                PojoOrdersStatus pojo = DaoOrdersStatus.getOrderStatusByOrdId(Integer.parseInt(odid));

                if (pojo != null) {
                    if (pojo.getAcceptstatus() == null) {
                        out.println("null");
                    } else {
                        out.println(pojo.getAcceptstatus() + "@" + pojo.getAccepttime());
                    }
                } else {
                    System.out.println("null");
                }
            }

            String ordhidsrr = request.getParameter("ordhidsrr");
            if (ordhidsrr != null && ordhidsrr.length() > 0) {

                int ordid = Integer.parseInt(ordhidsrr);

                DaoOrdersStatus.updateR(new PojoOrdersStatus(ordid, 0, "NA"));
                response.sendRedirect("Shopkeeper/shopkeeperDashboard.jsp");
            }

            String checkdata = request.getParameter("checkdata");
            if (checkdata != null && checkdata.length() > 0) {
                String[] arr = checkdata.substring(1, checkdata.length() - 1).split(",");
                System.out.println(arr[0] + " " + arr[1]);
                int ordid = Integer.parseInt(arr[1]);
                int totalbill = Integer.parseInt(arr[0]);

                PojoOrders ord = DaoOrders.getOrdersByOrdid(ordid);
                if (ord != null) {

                    String ordcharge = request.getParameter("ship");
                    
                    PojoStore store = DaoStore.getStoreById(ord.getStrid());
                    String status = TimeF.isOpen(store.getStropentime(), store.getStrclosetime());

                    if (status == "Closed") {
                        System.out.println("Store is closed");
                        out.println(0);
                    } else {
                        out.println(1);
                        String ordarrivalat = datetime1.format(format);
                        System.out.println("Checkout Time : " + ordarrivalat);
                        DaoOrdersStatus.updateOrderStatus(1, 0, ordarrivalat, ordid);

                        //***** send msg to store *****// 
                        PojoShopkeeper sk = DaoShopkeeper.getShopkeeperBySkid(store.getSkid());
                        PojoAdminUser ad = DaoAdminUser.getAdminById(sk.getAdid());

                        ServletContext context = getServletConfig().getServletContext();
                        String host = context.getInitParameter("host");
                        String port = context.getInitParameter("port");
                        String user = context.getInitParameter("user");
                        String pass = context.getInitParameter("pass");

                        String email = ad.getAdemail();
                        String content = getOrder(ordid, Integer.parseInt(ordcharge));
                        String subject = "New Order Arrive";

                        try {
                            SendEmail.sendEmail(host, port, user, pass, email, subject, content);

                        } catch (Exception ex) {
                            ex.printStackTrace();

                        } finally {
                            response.sendRedirect("cart.jsp");
                        }

                        //***** end *****// 
                        System.out.println("Order Status change successfully");
                        List<PojoOrdersList> li = DaoOrdersList.getOrdByOrdid(ordid);
                        for (PojoOrdersList p : li) {
                            if (p != null) {
                                DaoProducts.updateStock(p.getPrdid(), p.getPrdqty(), "des");
                            }
                        }
                    }
                }
            }

            String canid = request.getParameter("canid");
            if (canid != null) {
                int ordid = Integer.parseInt(canid);
                PojoOrders pojo = DaoOrders.getOrdersByOrdid(ordid);
                if (pojo == null) {
                    out.println("Order is not Exists");
                } else {
                    PojoOrdersStatus sts = DaoOrdersStatus.getOrderStatusByOrdId(ordid);

                    List<PojoOrdersList> li = DaoOrdersList.getOrdByOrdid(ordid);
                    for (PojoOrdersList p : li) {
                        if (p != null) {
                            DaoProducts.updateStock(p.getPrdid(), p.getPrdqty(), "inc");
                        }
                    }

                    DaoOrdersStatus.updateOrderStatus(new PojoOrdersStatus(ordid, 1, sts.getOrdarrivalat(), sts.getAccepttime(), sts.getDeliverytime(), "5", sts.getAcceptedname(), sts.getAcceptedcontact(), "NA"));

                    out.println("Order is canceled successfully");
                }
            }

            // for products review
            String rating = request.getParameter("rating");
            String revid = request.getParameter("revid");
            System.out.println("Review id is : " + revid);
            int rat;
            String name;
            String email;
            String msg;
            if (rating != null && (revid == null || revid.equals("0"))) {
                String cid = request.getParameter("cstmid");
                int cstmid = Integer.parseInt(cid);
                if (cstmid != 0) {
                    int prdid = Integer.parseInt(request.getParameter("prdid"));
                    String prdname = request.getParameter("prdname");

                    PojoProductsReview rev = DaoProductsReview.getReviewByIds(cstmid, prdid);
                    if (rev == null) {
                        name = request.getParameter("name");
                        email = request.getParameter("email");
                        msg = request.getParameter("message");
                        rat = Integer.parseInt(rating);
                        DaoProductsReview.insertReview(new PojoProductsReview(cstmid, prdid, name, email, msg, rat));
                        System.out.println("Review Inserted Successfully");
                        System.out.println(cstmid + " " + prdid + " " + name + " " + email + " " + msg + " " + rat);
                    } else {
                        System.out.println("Review Already Exists");
                    }
                    response.sendRedirect("single-product.jsp?prdid=" + prdid + "&prdname=" + prdname);
                } else {
                    response.sendRedirect("login-register.jsp");
                }
            } else {
                if (revid != null) {
                    int reviewid = Integer.parseInt(revid);
                    int prdid = Integer.parseInt(request.getParameter("prdid"));
                    String prdname = request.getParameter("prdname");
                    name = request.getParameter("name");
                    email = request.getParameter("email");
                    msg = request.getParameter("message");
                    rat = Integer.parseInt(rating);
                    DaoProductsReview.updateProduct(reviewid, name, email, msg, rat);
                    System.out.println("Review Updated Successfully");
                    response.sendRedirect("single-product.jsp?prdid=" + prdid + "&prdname=" + prdname);
                }
            }

            String trkord = request.getParameter("trkdata");
            if (trkord != null && trkord.length() > 0) {
                PojoOrdersStatus pojo = DaoOrdersStatus.getOrderStatusByOrdId(Integer.parseInt(trkord));
                String text = "null";

                if (pojo != null) {
                    if (pojo.getOrdstatus() == 0) {
                        text = "cancel";
                    } else {
                        String accpetedname = pojo.getAcceptedname();
                        String accpetedstatus = pojo.getAcceptstatus();
                        String diliverytime = pojo.getDeliverytime();
                        String acceptedcontact = pojo.getAcceptedcontact();
                        String orderarrivalat = pojo.getOrdarrivalat();
                        String accepttime = pojo.getAccepttime();
                        String pin = pojo.getPin();
                        text = accpetedname + "@" + accpetedstatus + "@" + diliverytime + "@" + acceptedcontact + "@" + orderarrivalat + "@" + pin + "@" + accepttime;
                    }
                }
                System.out.println(text);
                response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
                response.getWriter().write(text);
            }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(OrderListUpdate.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(OrderListUpdate.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    private String getOrder(int ordid, int ordcharge) throws SQLException {
        
        PojoOrders order = DaoOrders.getOrdersByOrdid(ordid);
        PojoUsers cstm = DaoUsers.getUserById(order.getCstmid());
        List<PojoOrdersList> ordls = DaoOrdersList.getOrdByOrdid(ordid);
        
        String tr = "";
        int total_bill = 0;
        for(PojoOrdersList ls: ordls){
            PojoProducts prd = DaoProducts.getProductsById(ls.getPrdid());
            tr = tr + "<tr>\n"
                + "                <td>"+prd.getPrdname()+"</td>\n"
                + "                <td>"+prd.getPrdprize()+"/"+prd.getPrdunit()+"</td>\n"
                + "                <td>"+ls.getPrdqty()+"</td>\n"
                + "                <td>"+(ls.getPrdqty()*prd.getPrdprize())+"</td>\n"
                + "            </tr>\n";
            total_bill = total_bill + (ls.getPrdqty()*prd.getPrdprize());
        }
        System.out.println(total_bill);
        DaoOrders.updateTotalAndCharge(ordid, total_bill, ordcharge);
                        
 
        String content = "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                + "<meta charset=utf-8\">"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "    <title></title>\n"
                + "    <style rel=\"stylesheet\">\n"
                + "        .table {\n"
                + "            margin: 0;\n"
                + "            display: flex;\n"
                + "            justify-content: center;\n"
                + "            align-items: center;\n"
                + "        }\n"
                + "\n"
                + "        table {\n"
                + "            box-shadow: 0px 2px 16px rgb(0, 0, 0);\n"
                + "            padding: 10px;\n"
                + "        }\n"
                + "\n"
                + "        .header {\n"
                + "            background-color: rgb(218, 31, 31);\n"
                + "            color: white;\n"
                + "            font-size: 14px;\n"
                + "        }\n"
                + "\n"
                + "        .header td {\n"
                + "            padding: 10px;\n"
                + "        }\n"
                + "\n"
                + "        .sub-header {\n"
                + "            background-color: black;\n"
                + "            color: aliceblue;\n"
                + "        }\n"
                + "\n"
                + "        .logo {\n"
                + "            display: flex;\n"
                + "            justify-content: center;\n"
                + "            align-items: center;\n"
                + "            margin-bottom: 20px;\n"
                + "            border-bottom: 2px solid red;\n"
                + "            font-size: 30px;\n"
                + "        }\n"
                + "\n"
                + "        .logo span {\n"
                + "            font-family: Verdana, Geneva, Tahoma, sans-serif;\n"
                + "            color: crimson;\n"
                + "            font-size: 35px;\n"
                + "        }\n"
                + "\n"
                + "        .kbd {\n"
                + "            background-color: black;\n"
                + "            color: aliceblue;\n"
                + "            border-radius: 4px;\n"
                + "            padding: 4px;\n"
                + "        }\n"
                + "\n"
                
                + "    </style>\n"
                + "</head>\n"
                + "\n"
                + "<body>\n"
                + "    <div class=\"logo\">\n"
                + "        <span>S</span>uper <span>M</span>art\n"
                + "    </div>\n"
                + "    <div class=\"table\">\n"
                + "        <table>\n"
                + "            <tr class=\"header\">\n"
                + "                <td colspan=\"4\">Cstm: "+cstm.getCstmname()+"<br>Add: "+cstm.getCstmaddress()+"<br>Payment: "+order.getPaymentmethod()+"<br>Order No: "+order.getOrdid()+"</td>\n"
                + "            </tr>\n"
                + "            <tr class=\"sub-header\">\n"
                + "                <th scope=\"col\">Prdname</th>\n"
                + "                <th scope=\"col\">Prize/Unit</th>\n"
                + "                <th scope=\"col\">Quntity</th>\n"
                + "                <th scope=\"col\">Sub-total</th>\n"
                + "            </tr>\n"
                +               tr + "<tr><td colspan='4'></td></tr>"
               
                + "            <tr>\n"
                + "                <td colspan=\"2\"></td>\n"
                + "                <td colspan=\"2\">Delivery Charge:- <kbd class=\"kbd\">"+ordcharge+"</kbd></td>\n"
                + "            </tr>\n"
                + "            <tr>\n"
                + "                <td colspan=\"2\"></td>\n"
                + "                <td colspan=\"2\">Bill:- <kbd class=\"kbd\">"+total_bill+ordcharge+"</kbd></td>\n"
                + "            </tr>\n"
                + "        </table>\n"
                + "    </div>\n"
                + "</body>\n"
                + "\n"
                + "</html>";
        System.out.println(tr);
        System.out.println(content);
        return content;
    }

}
