
import DAOs.DaoUsers;
import POJOs.PojoUsers;
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

@WebServlet(urlPatterns = {"/UserSignup"})
public class UserSignup extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String atype = request.getParameter("atype");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            if (request.getParameter("update") != null) {
                // for update
                int cstmid = Integer.parseInt(request.getParameter("cstmid"));
                String cname = request.getParameter("cname");
                String cemail = request.getParameter("cemail");
                String ccpwd = request.getParameter("ccpwd");
                String ccontact = request.getParameter("ccontact");
                String cadd = request.getParameter("cadd");
                String cnpwd = request.getParameter("cnpwd");
                System.out.println(cstmid + " " + cname + " " + cemail + " " + ccontact + " " + cadd + " " + ccpwd + " " + cnpwd);
                if (DaoUsers.getUser(cemail, ccpwd) != null && cname == null) {
                    if (cnpwd != null) {
                        ccpwd = cnpwd;
                    }
                    DaoUsers.updatePwd(cstmid, ccpwd);
                    session.setAttribute("cinfo", "Password Changed Successfully");
                    session.setAttribute("userpojo", DaoUsers.getUserById(cstmid));
                    response.sendRedirect("login-register.jsp");
                } else {
                    if (cname != null) {
                        System.out.println("Hii");
                        DaoUsers.updateUser(new PojoUsers(cstmid, cname, cemail, ccontact, cadd, ccpwd));
                        session.removeAttribute("cinfo");
                    session.setAttribute("userpojo", DaoUsers.getUserById(cstmid));
                    response.sendRedirect("my-account.jsp");
                    } else if(DaoUsers.getUser(cemail, ccpwd) == null){
                        System.out.println("its a null");
                        out.println("<h1 class='text-danger'>Password is incorrect <a href='my-account.jsp'>back</a></h1>");
                    }
                }

            } else {
                // for new registration
                String cname = request.getParameter("cname").toLowerCase();
                String cemail = request.getParameter("cemail").toLowerCase();
                String ccpwd = request.getParameter("ccpwd").toLowerCase();
                String ccontact = request.getParameter("ccontact").toLowerCase();
                String cadd = request.getParameter("cadd").toLowerCase();
                //out.println(cname+" "+cemail+" "+ccontact+" "+cadd+" "+ccpwd);
                PojoUsers pojo = DaoUsers.userEsits(cname, cemail);
                if (pojo == null) {
                    session.setAttribute("cinfo", cname+" registered");
                    session.removeAttribute("userpojo");
                    DaoUsers.insertUser(new PojoUsers(cname, cemail, ccontact, cadd, ccpwd));
                } else {
                    session.setAttribute("cinfo", cname+" already registered");
                }
                session.setAttribute("email", cemail);
                System.out.println("atype"+atype);
                if(atype!=null && atype.equals("admin")){
                    response.sendRedirect("Admin/customer.jsp");
                }else{
                    response.sendRedirect("login-register.jsp");
                }
            }
            
            if(request.getParameter("usertype")!=null){
                String usertype = request.getParameter("usertype");
                out.println("Hello"+usertype);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserSignup.class.getName()).log(Level.SEVERE, null, ex);
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
