
import DAOs.DaoAdminUser;
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

@WebServlet(urlPatterns = {"/Admin_SignIn"})
public class Admin_SignIn extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String usertype = request.getParameter("admintype").toLowerCase();
            String email = request.getParameter("adminemail").toLowerCase();
            String password = request.getParameter("adminpwd").toLowerCase();
            PojoAdminUser pojo = DaoAdminUser.getAdminBy(usertype, email, password);
            HttpSession session = request.getSession();
            if (pojo != null) {
                System.out.println(usertype+" "+pojo.getAdemail()+ ">>"+pojo.getAdid());
                session.setAttribute("adminuser", pojo);
                if (usertype.equals("shopkeeper")) {
                    session.setAttribute("skuser", pojo);
                    System.out.println("User is shopkeeper");
                    response.sendRedirect("Shopkeeper/index.jsp");
                } else if (usertype.equals("servicer")) {
                    session.setAttribute("suser", pojo);
                    System.out.println("User is serviser");
                    response.sendRedirect("Servicer/index.jsp");
                } else if(usertype.equals("admin")){
                    session.setAttribute("admin", pojo);
                    System.out.println("User is Admin");
                    response.sendRedirect("Admin/index.jsp");
                }else {
                    System.out.println("Somthing went wrong");
                    session.removeAttribute("adminuser");
                }
            } else{
                System.out.println("Username or Password is incorrect!");
                session.setAttribute("info", "Incorrect Username or Password");
                response.sendRedirect("admin-login-register.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Admin_SignIn.class.getName()).log(Level.SEVERE, null, ex);
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
