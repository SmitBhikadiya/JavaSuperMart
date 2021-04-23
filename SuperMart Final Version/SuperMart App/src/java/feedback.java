
import DAOs.DaoFeedback;
import DAOs.DaoOrderHistory;
import DAOs.DaoProductsReview;
import POJOs.PojoFeedback;
import POJOs.PojoOrderHistory;
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

@WebServlet(urlPatterns = {"/feedback"})
public class feedback extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int oid = 0;
            int overall_rat = 0;
            int prodcuts_rat = 0;
            String delivery_service = "";
            String review_msg = "";
            System.out.println("hii");
            
            String sts = request.getParameter("sts");
            String id = request.getParameter("id");
            System.out.println(sts+" "+id);
            if(id!=null && sts!=null){
                DaoFeedback.updateTestimonial(Integer.parseInt(id), Integer.parseInt(sts));
                System.out.println(">> Testimonial is changed successfully");
            }
            
            String rid = request.getParameter("rid");
            if(rid!=null){
                System.out.println(rid);
                DaoFeedback.deleteFeedback(Integer.parseInt(rid));
                System.out.println(">> Testimonial is deleted successfully");
            }
            
            String rpid = request.getParameter("rpid");
            if(rpid!=null){
                System.out.println("Product review id : "+rpid);
                DaoProductsReview.deleteProductById(Integer.parseInt(rpid));
            }
            
            if (request.getParameter("ordid") != null) {
                System.out.println(request.getParameter("ordid"));
                oid = Integer.parseInt(request.getParameter("ordid").toString());
                overall_rat = Integer.parseInt(request.getParameter("rat1"));
                prodcuts_rat = Integer.parseInt(request.getParameter("rat2"));
                delivery_service = request.getParameter("exp");
                review_msg = request.getParameter("commentText");

                System.out.println("ordid" + oid + " overallrat" + overall_rat + " productrat" + prodcuts_rat + " delivery_service" + delivery_service + " review_msg" + review_msg);
                PojoOrderHistory history = DaoOrderHistory.getOrderHistoryByordid(oid);
                if (history != null && DaoFeedback.getFeedbackByordid(oid) == null) {
                    DaoFeedback.insertFeedback(new PojoFeedback(oid, overall_rat, prodcuts_rat, delivery_service, review_msg));
                    System.out.println("Feedback inserted successfully");
                    //session.setAttribute("feedback", "Your feedback is submitted successfully");
                } else {
                    System.out.println("Feedback is already given!!");
                    if (request.getParameter("feedid") != null) {
                        int feedid = Integer.parseInt(request.getParameter("feedid"));
                        System.out.println(feedid);
                        if (feedid != 0) {
                            overall_rat = Integer.parseInt(request.getParameter("rat1"));
                            prodcuts_rat = Integer.parseInt(request.getParameter("rat2"));
                            delivery_service = request.getParameter("exp");
                            review_msg = request.getParameter("commentText");
                            DaoFeedback.updateFeedback(new PojoFeedback(feedid, oid, overall_rat, prodcuts_rat, delivery_service, review_msg));
                            System.out.println("Feedback is updated successfully");
                        }
                    }
                    //response.sendRedirect("my-account.jsp");
                }
            }
            response.sendRedirect("track-order.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(feedback.class.getName()).log(Level.SEVERE, null, ex);
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
