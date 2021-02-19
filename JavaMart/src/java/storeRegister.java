/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import DAOs.SuperDao;
import POJOs.PojoImg;
import Utils.Util;
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
import javax.servlet.http.Part;

/**
 *
 * @author Smit Bhikadiya
 */
@WebServlet(urlPatterns = {"/storeRegister"})
@MultipartConfig
public class storeRegister extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String sName = request.getParameter("strname");
            String sAdd = request.getParameter("straddress");
            String sContact = request.getParameter("strcontact");
            String sType = request.getParameter("strtype");
            String havingServiser = request.getParameter("havingserviser");
            String openat = request.getParameter("openat");
            String closeat = request.getParameter("closeat");

            /* recieve image and store into the relative path */
            Part part = request.getPart("strimg");
            /* images information */
            int imgsize = (int) part.getSize();
            String imgtype = part.getContentType();
            String imgname = (sName+sContact+".png").toUpperCase();
            String loc = Util.profileFold;
            out.println(uploadImg(part, sName+sContact, loc));
            
            
            /* upload img to the database */
            PojoImg pojo = new PojoImg(imgname,imgsize,imgtype);
            if(!SuperDao.alreadyUploaded(imgname)){
                int i = SuperDao.insertImg(pojo);
            }
            else{
                out.println("Image are uploaded already");
            }
            
            // show upload img image
            //out.println("<img src='./static/img/"+loc.replaceAll("//","")+"/"+sName+".png'></img>");//+loc.replaceAll("\\", "")+"'></img>");
            //out.println("<img src='"+Util.ImgPath+"/top.png'>");
            
            // add all data to the database
            
            
        } catch (SQLException ex) {
            Logger.getLogger(storeRegister.class.getName()).log(Level.SEVERE, null, ex);
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
        String imgrelpath = this.getServletContext().getRealPath("") + File.separator + "static\\img\\" + relpath;
        if (!(new File(imgrelpath).exists())) {
            return "Path Not Found!";
        }
        imgrelpath = imgrelpath.replace("\\build", "") + filename;

        // upload file into given path
        OutputStream ou = new FileOutputStream(imgrelpath);//imgrelpath+"DB1.png");
        byte[] buf = new byte[5024];
        int len;
        while ((len = in.read(buf)) > 0) {
            ou.write(buf, 0, len);
        }
        in.close();
        ou.close();
        return imgrelpath;
    }

}
