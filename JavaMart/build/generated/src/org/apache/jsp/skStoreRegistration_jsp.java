package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class skStoreRegistration_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <!-- Bootstrap CDN -->\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"static/bootstrap/bootstrap.min.css\">\r\n");
      out.write("    <script src=\"static/bootstrap/jquery.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <!-- External CSS -->\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"static/css/skDashboard.css\">\r\n");
      out.write("    <title>Store Registration</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"jumbotron text-center\" style=\"margin-bottom:0\">\r\n");
      out.write("        <h1>Register Your Shop Hear</h1>\r\n");
      out.write("        <p>Owner:- Smit D. Bhikadiya</p>\r\n");
      out.write("        <a href=\"shopkeeperDashboard.jsp\">Back To Dashboard </a>|\r\n");
      out.write("        <a href=\"skStoreAddItemForm.html\">Add Item</a>\r\n");
      out.write("    </div>\r\n");
      out.write("    <div class=\"width7center\">\r\n");
      out.write("\r\n");
      out.write("        <div class=\"m-3 d-flex flex-wrap justify-content-around\">\r\n");
      out.write("            <div class=\"card flex-fill\">\r\n");
      out.write("                <div class=\"card-header text-center\">\r\n");
      out.write("                    <h3>Registration Form</h3>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"\">\r\n");
      out.write("                    <div class=\"row no-gutters\">\r\n");
      out.write("                        <div class=\"card-body\">\r\n");
      out.write("                            <form action=\"storeRegister\" method=\"POST\" enctype=\"multipart/form-data\">\r\n");
      out.write("                                <input type=\"hidden\" name=\"skid\" value=\"\">\r\n");
      out.write("                                <input type=\"hidden\" name=\"imgpath\" value=\"\" id=\"imgpath\">\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"storeName\">Register Storename</label>\r\n");
      out.write("                                    <input type=\"text\" class=\"form-control\" name=\"strname\" required>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"storeimg\">Store Image</label>\r\n");
      out.write("                                    <input type=\"file\" id=\"img\" onchange=\"onimgchange(event)\" accept=\".jpeg,jpg,.png\" name=\"strimg\" class=\"form-control\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"storeadd\">Store Address</label>\r\n");
      out.write("                                    <textarea  id=\"\" cols=\"30\" rows=\"2\" name=\"straddress\" class=\"form-control\" required></textarea>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"storeContact\">Store Contact Number</label>\r\n");
      out.write("                                    <input type=\"number\" class=\"form-control\" name=\"strcontact\" max=\"9999999999\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"storeType\">Store Type</label>\r\n");
      out.write("                                    <select name=\"strtype\" id=\"\" class=\"form-control\">\r\n");
      out.write("                                        <option value=\"Grocery\">Grocery Store</option>\r\n");
      out.write("                                        <option value=\"Fruits\" disabled>Fruits Store</option>\r\n");
      out.write("                                        <option value=\"Vegetables\" disabled>Vegetables Store</option>\r\n");
      out.write("                                        <option value=\"Farsan\" disabled>Farsan Store</option>\r\n");
      out.write("                                        <option value=\"Frozen Foods\" disabled>Frozen Foods Store</option>\r\n");
      out.write("                                        <option value=\"Statinory\" disabled>Statinory Store</option>\r\n");
      out.write("                                        <option value=\"Others\" disabled>Others</option>\r\n");
      out.write("                                    </select>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"havingServiser\" onclick=\"checkme()\" style=\"cursor: pointer;\">Are you having serviser?</label>\r\n");
      out.write("                                    <input type=\"checkbox\" id=\"havingSrvs\" name=\"havingserviser\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"form-group\">\r\n");
      out.write("                                    <label for=\"storeName\">Store Opening Time</label>\r\n");
      out.write("                                    <input type=\"time\" class=\"form-control\" name=\"openat\" required>\r\n");
      out.write("                                    <label for=\"storeName\">Store Closing Time</label>\r\n");
      out.write("                                    <input type=\"time\" class=\"form-control\" name=\"closeat\" required>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div style=\"margin-top: 20px;\">\r\n");
      out.write("                                    <input type=\"submit\" class=\"form-control btn btn-primary\" onclick=\"return myFunc()\"\r\n");
      out.write("                                        value=\"Register\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </form>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <script src=\"static/bootstrap/javascript.min.js\"></script>\r\n");
      out.write("    <script src=\"static/js/skDashboard.js\"></script>\r\n");
      out.write("\r\n");
      out.write("    <script>\r\n");
      out.write("        function checkme(){\r\n");
      out.write("            var check1 = document.getElementById(\"havingSrvs\");\r\n");
      out.write("            if(check1.checked==false){\r\n");
      out.write("                check1.checked = true;\r\n");
      out.write("            }\r\n");
      out.write("            else{\r\n");
      out.write("                check1.checked = false;\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("        function onimgchange(event){\r\n");
      out.write("          \r\n");
      out.write("        }\r\n");
      out.write("    </script>\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
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
