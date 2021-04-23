
import DAOs.DaoProducts;
import POJOs.PojoProducts;
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

@WebServlet(urlPatterns = {"/SK_Store_Product_Register"})
@MultipartConfig
public class SK_Store_Product_Register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String atype = request.getParameter("atype");
            String strid = request.getParameter("strid");
            String prdid = request.getParameter("prdid");
            String prdname = request.getParameter("prdname");
            String prdunit = request.getParameter("prdunit");
            String prdprize = request.getParameter("prdprize");
            String prdtotalqty = request.getParameter("prdtotalqty");
            String prddiscount = request.getParameter("prddiscount");
            String prdcat = request.getParameter("prdcat");
            String prddisc = request.getParameter("prddisc");
            String imgpath = request.getParameter("imgpath");
            Part part = request.getPart("prdimgpath");

            String imgtype = ".png";
            String relpath = "assets\\img\\product\\";

            System.out.println(strid + " " + prdid);
            System.out.println(prdname + " " + prdunit + " " + prdprize + " " + prdtotalqty + " " + prddiscount + " " + prdcat + " " + prddisc + " " + imgpath);
            System.out.println(part.getSubmittedFileName());

            HttpSession session = request.getSession();
            if (strid != null) {
                if (prdid != null) {
                    int str_id = Integer.parseInt(strid);
                    int prd_id = Integer.parseInt(prdid);
                    int prd_disc = Integer.parseInt(prddiscount);
                    int prd_prize = Integer.parseInt(prdprize);
                    int prd_stock = Integer.parseInt(prdtotalqty);
                    String imgname = prdname + "_" + str_id + imgtype;
                    imgpath = relpath.replaceAll("\\\\", "/") + imgname;
                    System.out.println(imgpath);
                    if (prd_id == 0) {
                        System.out.println("prdid is 0");
                        // step-1 check product is exists or not 
                        PojoProducts prd = DaoProducts.getProductsByName(str_id, prdname.toLowerCase());

                        if (prd != null) {
                            session.setAttribute("data", "Product is already exists");
                            System.out.println("Product is already exists");
                        } else {
                            if (part.getSize() > 0) {
                                System.out.println(uploadImg(part, imgname, relpath));
                            }
                            session.setAttribute("data", "Product inserted successfully");
                            DaoProducts.insertProduct(new PojoProducts(str_id, imgpath, prdname, prd_prize, prdunit, prd_disc, prd_stock, prdcat, prddisc));
                            System.out.println("Product inserted successfully");
                        }

                    } else {
                        System.out.println("prdid is not 0");
                        if(imgpath!=null && part.getSize() == 0){
                            PojoProducts pojo = DaoProducts.getProductsById(prd_id);
                            deleteImg(pojo.getPrdname()+"_"+pojo.getStrid()+imgtype, relpath);
                        }
                        System.out.println(uploadImg(part, imgname, relpath));
                        DaoProducts.updateProduct(new PojoProducts(prd_id, str_id,imgpath, prdname,prd_prize, prdunit, prd_disc, prd_stock , prdcat, prddisc));
                        session.setAttribute("data", "Product Update Successfully");
                    }
                    System.out.println("atype :"+atype);
                    if(atype.equals("shopkeeper")){
                        response.sendRedirect("Shopkeeper/skStoreAddItemForm.jsp");
                    }else{
                        response.sendRedirect("Admin/shopkeeper.jsp");
                    }
                } else {
                    System.out.println("prdid is null");
                }
            } else {
                response.sendRedirect("admin-login-register.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SK_Store_Product_Register.class.getName()).log(Level.SEVERE, null, ex);
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
        if (new File(imgrelpath).delete()) {
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

    private String deleteImg(String filename, String relpath) {

// find path of  images uploade folder
        String imgrelpath = this.getServletContext().getRealPath("") + File.separator + relpath;
        if (!(new File(imgrelpath).exists())) {
            return "Path Not Found!";
        }
        imgrelpath = imgrelpath.replace("\\build", "") + filename;
        if (new File(imgrelpath).delete()) {
            return "File Deleted Successfully";
        }

        return "File Not Found!";
    }
}
