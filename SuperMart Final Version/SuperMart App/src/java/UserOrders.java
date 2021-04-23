
import DAOs.DaoOrders;
import DAOs.DaoOrdersList;
import DAOs.DaoOrdersStatus;
import DAOs.DaoProducts;
import DAOs.DaoProductsReview;
import DAOs.DaoStore;
import POJOs.PojoOrders;
import POJOs.PojoOrdersList;
import POJOs.PojoOrdersStatus;
import POJOs.PojoProducts;
import POJOs.PojoProductsReview;
import POJOs.PojoStore;
import Utils.TimeF;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UserOrders", urlPatterns = {"/UserOrders"})
public class UserOrders extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int prdid = Integer.parseInt(request.getParameter("prdid"));
            int cstmid = Integer.parseInt(request.getParameter("cstmid"));
            int ordid = 0;

            // check shop of product is opened or not
            PojoProducts pojoprd = DaoProducts.getProductsById(prdid);
            int strid = pojoprd.getStrid();

            PojoStore store = DaoStore.getStoreById(strid);
            if ("Closed".equals(TimeF.isOpen(store.getStropentime(), store.getStrclosetime()))) {
                System.out.println("Store is Closed");
                out.println(4);
            } else {
                System.out.println("Store is Open");
                // process of genrate order or update order
                if (cstmid == 0) {
                    out.println(0);
                } else {

                    /* step-2 check any row having strid and cstmid both */
                    PojoOrders pojoord = DaoOrders.getOrdersBy(strid, cstmid);

                    /* step-3 (step-2 : yes) : check any row having ordid and prdid both */
                    if (pojoord != null) {

                        ordid = pojoord.getOrdid();
                        int status = DaoOrdersStatus.getOrderStatusByOrdId(ordid).getOrdstatus();
                        if (status == 1) {
                            out.println(3);
                        } else {
                            PojoOrdersList pojoordls = DaoOrdersList.getOrdLsByIds(ordid, prdid);
                            System.out.println(">>> Already Order Exsits in orders");
                            if (pojoordls != null) {
                                System.out.println(">>> Already Order Exsits in orderslist");
                                out.println(2);
                            } else {
                                System.out.println(">>> Order are not found in orderlist");
                                DaoOrdersList.insertOrderList(new PojoOrdersList(ordid, prdid, 1, pojoprd.getPrdprize()));
                                System.out.println(">>> Order added into the orderlist");
                                out.println(1);
                            }
                        }
                    } else {
                        System.out.println(">>> Order are not exists in orders");
                        // insert new order in orders table 
                        DaoOrders.insertOrder(new PojoOrders(strid, cstmid, "COD", pojoprd.getPrdprize()));
                        System.out.println(">>> Order added into the orders");

                        // insert new orderlist in orderlist table
                        ordid = DaoOrders.getLastInsertedData();
                        System.out.println(">>> last ordid " + ordid);

                        DaoOrdersList.insertOrderList(new PojoOrdersList(ordid, prdid, 1, pojoprd.getPrdprize()));
                        System.out.println(">>> Order added into the ordrelist");
                    }

                    if (ordid != 0) {
                        PojoOrdersStatus pojostatus = DaoOrdersStatus.getOrderStatusByOrdId(ordid);
                        if (pojostatus != null) {
                            System.out.println(">>> Already Order Exists in orderstatus");
                        } else {
                            int ordstatus = 0;
                            String ordarrivalat = null;
                            String deliverytime = null;
                            String acceptstatus = null;
                            String acceptedname = null;
                            String acceptedcontact = null;
                            if (request.getParameter("ordarrivalat") != null) {
                                ordstatus = Integer.parseInt(request.getParameter("ordstatus"));
                                ordarrivalat = request.getParameter("ordarrivalat");
                                deliverytime = request.getParameter("deliverytime");
                                acceptstatus = request.getParameter("acceptstatus");
                                acceptedname = request.getParameter("acceptedname");
                                acceptedcontact = request.getParameter("acceptedcontact");
                            }
                            System.out.println(">>> Order added into the orderstatus");
                            DaoOrdersStatus.setOrderStatus(new PojoOrdersStatus(ordid, ordstatus, ordarrivalat, deliverytime, acceptstatus, acceptedname, acceptedcontact));
                        }
                        out.println(2);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
