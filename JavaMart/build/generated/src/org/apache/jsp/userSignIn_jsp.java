package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class userSignIn_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 
    if(session.getAttribute("username")!=null){
        response.sendRedirect("shopkeeperDashboard.jsp");
    }
    String email = request.getParameter("email");
    if(email==null){
        email = "";
    }

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("\n");
      out.write("    <!--Bootstrap CDN-->\n");
      out.write("    <link rel=\"stylesheet\" href=\"static/bootstrap/bootstrap.min.css\">\n");
      out.write("    <script src=\"static/bootstrap/jquery.min.js\"></script>\n");
      out.write("\n");
      out.write("    <!--CSS-->\n");
      out.write("    <link rel=\"stylesheet\" href=\"static/css/form.css\">\n");
      out.write("\n");
      out.write("    <title>Document</title>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("    <div class=\"boxborder center\">\n");
      out.write("        <form action=\"signIn\" method=\"POST\">\n");
      out.write("            <div class=\"form-group brand text-center\">\n");
      out.write("                <img src=\"static/img/profile.jpeg\" alt=\"\" width=\"100px\" height=\"120px\">\n");
      out.write("                <p><span>S</span>uper<span>M</span>art</p>\n");
      out.write("                <marquee loop=\"5\" scrollamount=\"5\"><span>S</span>hopkeeper <span>L</span>ogin <span>F</span>orm\n");
      out.write("                </marquee>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"uore\">Email</label>\n");
      out.write("                <input type=\"email\" class=\"form-control\" name=\"useremail\" value=\"");
      out.print(email);
      out.write("\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"Password\">Password</label>\n");
      out.write("                <input type=\"password\" class=\"form-control\" name=\"userpassword\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <button class=\"btn btn-success form-control\">Login</button>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <a href=\"userSignUp.jsp\">New Registration</a> |\n");
      out.write("                <a href=\"\">Forgot Password</a>\n");
      out.write("            </div>\n");
      out.write("        </form>\n");
      out.write("    </div>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
