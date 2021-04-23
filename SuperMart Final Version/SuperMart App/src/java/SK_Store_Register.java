import DAOs.DaoShopkeeper;
import DAOs.DaoStore;
import DAOs.DaoVarifyStore;
import POJOs.PojoShopkeeper;
import POJOs.PojoStore;
import POJOs.PojoVarifyStore;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/SK_Store_Register"})
@MultipartConfig
public class SK_Store_Register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String atype = request.getParameter("atype");
            String strname = request.getParameter("strname");
            String stradd = request.getParameter("straddress");
            String strcontact = request.getParameter("strcontact");
            String having_serviser = request.getParameter("havingserviser");
            String opentime = request.getParameter("openat");
            String closetime = request.getParameter("closeat");
            int skid = Integer.parseInt(request.getParameter("skid"));
            Part part = request.getPart("strimg");
            int having = 0;
            if (having_serviser == null) {
                having = 0;
            } else {
                having = 1;
            }

            String imgpath = "";
            String imgname = skid + "skstore.png";
            String relpath = "assets\\img\\storeimg\\";
            /*  /assets/img/storeimg/1Fizzy Born.png */
            imgpath = relpath.replaceAll("\\\\", "/") + imgname;

            if (part.getSize() == 0) {
                imgpath = request.getParameter("imgpath");
            } else {
                System.out.println("Hello");
                out.println(uploadImg(part, imgname, relpath));
            }

            out.println(imgpath);

            HttpSession session = request.getSession();
            if (skid != 0) {
                PojoShopkeeper sk = DaoShopkeeper.getShopkeeperBySkid(skid);
                if (sk != null) {
                    System.out.println("Shopkeeper are logging");
                    if (sk.getStrid() == 0) {
                        DaoStore.insertStore(new PojoStore(skid, imgpath, strname, strcontact, stradd, opentime, closetime, having));
                        System.out.println("New Shop Register successfully");

                        int strid = DaoStore.getLastInsertedStrid();
                        System.out.println("Strid is " + strid);
                        
                        DaoVarifyStore.insertVarifyStore(new PojoVarifyStore(strid, 0));
                        System.out.println("Store added to varifystore table");

                        DaoShopkeeper.updateStrid(strid, skid);
                        System.out.println("Store Added to shopkeeper table");

                        session.setAttribute("data", "Congratulation, Store is created successfully");
                        session.setAttribute("store", DaoStore.getStoreById(strid));
                        
                    } else {
                        int strid = Integer.parseInt(request.getParameter("strid"));
                        DaoStore.updateStore(new PojoStore(strid, skid, imgpath, strname, strcontact, stradd, opentime, closetime, having));
                        System.out.println("Store Update Successfully");
                        session.setAttribute("store", DaoStore.getStoreById(sk.getStrid()));
                        session.setAttribute("data", "Store Updated Successfully");
                        
                    }
                    System.out.println("atype :"+atype);
                    if(atype.equals("shopkeeper")){
                        response.sendRedirect("Shopkeeper/skStoreAddItemForm.jsp");
                    }else{
                        response.sendRedirect("Admin/shopkeeper.jsp");
                    }

                } else {
                    System.out.println("Shopkeeper are not found");
                    session.setAttribute("info", "Shopkeeper are not login");
                    response.sendRedirect("admin-login-register.jsp");
                }

            } else {
                System.out.println("Shopkeeper are not logging");
                session.setAttribute("info", "Shopkeeper are not login");
                response.sendRedirect("admin-login-register.jsp");
            }

            out.println(strname + " " + stradd + " " + strcontact + " " + having + " " + opentime + " " + closetime + " " + part.getSubmittedFileName());
        } catch (SQLException ex) {
            Logger.getLogger(SK_Store_Register.class.getName()).log(Level.SEVERE, null, ex);
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

    private String uploadImg(Part part, String filename, String relpath) throws IOException {
        InputStream in = null;

        if (part != null) {
            in = part.getInputStream();
        }

        // find path of  images uploade folder
        String imgrelpath = this.getServletContext().getRealPath("") + File.separator + relpath;
        if (!(new File(imgrelpath).exists())) {
            return "Path Not Found!";
        }
        imgrelpath = imgrelpath.replace("\\build", "") + filename;
        if(new File(imgrelpath).delete()){
            System.out.println("File Deleted Successfully");
        }
        // upload file into given path
        OutputStream ou = new FileOutputStream(imgrelpath);
     
        byte[] buf = new byte[5024];
        int len;
        while ((len = in.read(buf)) > 0) {
            ou.write(buf, 0, len);
        }
        in.close();
        ou.close();
        return "Uploaded";
    }

}
