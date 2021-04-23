
import DAOs.DaoAdminUser;
import DAOs.DaoServicer;
import DAOs.DaoShopkeeper;
import POJOs.PojoAdminUser;
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
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/Admin_SignUp"})
public class Admin_SignUp extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String aid = request.getParameter("adid");
            String upd = request.getParameter("upd");
            //System.out.println(aid+"++++"+upd);
            if (aid != null && upd != null) {
                PojoAdminUser us = DaoAdminUser.getAdminById(Integer.parseInt(aid));
                String text = us.getAdid() + "$" + us.getAdname() + "$" + us.getAdemail() + "$" + us.getAdcontact() + "$" + us.getAdpassword() + "$" + us.getAdaddress();
                out.println(text);
            } else {
                String atype = request.getParameter("atype");
                String name = request.getParameter("adminname");
                String email = request.getParameter("adminemail");
                String contact = request.getParameter("admincontact");
                String password = request.getParameter("adminpwd");
                String usertype = request.getParameter("admintype");
                String address = request.getParameter("adminaddress");

                PojoAdminUser pojo = DaoAdminUser.getAdminBy(usertype, email);
                HttpSession session = request.getSession();
                out.println(pojo);
                if (pojo != null) {
                    int adid = pojo.getAdid();
                    if (usertype.equals("shopkeeper") && DaoShopkeeper.getShopkeeperById(adid) == null) {
                        DaoShopkeeper.insertAdminId(adid);
                        System.out.println("add shopkeeper");
                    } else if (usertype.equals("servicer") && DaoServicer.getServicerById(adid) == null) {
                        DaoServicer.inserteAdminId(adid);
                        System.out.println("add servicer");
                    } else {
                        System.out.println("No data");
                    }
                    session.setAttribute("info", "Admin Already Exists..do login..");
                    session.setAttribute("email", pojo.getAdemail());
                } else {

                    DaoAdminUser.insertAdmin(new PojoAdminUser(name, email, contact, usertype, password, address));
                    out.println("User Inserted Successfully");
                    int adid = DaoAdminUser.getLastInsertedData();
                    if (usertype.equals("shopkeeper")) {
                        DaoShopkeeper.insertAdminId(adid);
                        System.out.println("Shopkeeper Inserted");
                    } else if (usertype.equals("servicer")) {
                        DaoServicer.inserteAdminId(adid);
                        System.out.println("Inserted serviser");
                    } else {
                        System.out.println("Invalid Admin Type");
                    }
                    session.setAttribute("info", "Admin Register successfully");
                    session.setAttribute("email", email);
                }
                session.setAttribute("admintype", usertype);
                if (atype.equals("admin") && usertype.equals("admin")) {
                    response.sendRedirect("Admin/AdminDashboard.jsp");
                } else if (atype.equals("admin") && usertype.equals("servicer")) {
                    response.sendRedirect("Admin/servicer.jsp");
                } else if (atype.equals("admin") && usertype.equals("shopkeeper")) {
                    response.sendRedirect("Admin/shopkeeper.jsp");
                } else {
                    response.sendRedirect("admin-login-register.jsp");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Admin_SignUp.class.getName()).log(Level.SEVERE, null, ex);
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
