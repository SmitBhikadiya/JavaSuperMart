package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import DAOs.SuperDao;
import POJOs.PojoRegistration;

public final class shopkeeperDashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

    PojoRegistration pojo = null;
    // check user are logged in 
    if (session.getAttribute("username") == null) {
        response.sendRedirect("userSignIn.jsp");
    } else {
        // get user information if login
        String id = session.getAttribute("userid").toString();
        pojo = SuperDao.getById(Integer.parseInt(id));
    }

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("\r\n");
      out.write("    <head>\r\n");
      out.write("        <meta charset=\"UTF-8\">\r\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("        <!-- Bootstrap CDN -->\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"static/bootstrap/bootstrap.min.css\">\r\n");
      out.write("\r\n");
      out.write("        <!-- External CSS -->\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"static/css/skDashboard.css\">\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"static/css/skcard.css\">\r\n");
      out.write("        <title>Document</title>\r\n");
      out.write("\r\n");
      out.write("        <style>\r\n");
      out.write("            .jumboLink:hover {\r\n");
      out.write("                text-decoration: none;\r\n");
      out.write("            }\r\n");
      out.write("            html{\r\n");
      out.write("                scroll-behavior: smooth;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            /* back to top btn */\r\n");
      out.write("            #myBtn {\r\n");
      out.write("                display: none;\r\n");
      out.write("                position: fixed;\r\n");
      out.write("                bottom: 20px;\r\n");
      out.write("                right: 30px;\r\n");
      out.write("                z-index: 99;\r\n");
      out.write("                font-size: 18px;\r\n");
      out.write("                border: none;\r\n");
      out.write("                outline: none;\r\n");
      out.write("                color: white;\r\n");
      out.write("                cursor: pointer;\r\n");
      out.write("                border-radius: 4px;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            #myBtn:hover {\r\n");
      out.write("                background-color: #555;\r\n");
      out.write("            }\r\n");
      out.write("        </style>\r\n");
      out.write("    </head>\r\n");
      out.write("\r\n");
      out.write("    <body>\r\n");
      out.write("\r\n");
      out.write("        <img src=\"static/img/top.png\" onclick=\"topFunction()\" id=\"myBtn\" title=\"Go to top\" width=\"50px\" alt=\"\">\r\n");
      out.write("\r\n");
      out.write("        <!-- Shop keeper modal start -->\r\n");
      out.write("        <div class=\"modal\" id=\"quick_view\">\r\n");
      out.write("            <div class=\"modal-dialog modal-sm modal-md modal-lg modal-dialog-centered\">\r\n");
      out.write("                <div class=\"modal-content\">\r\n");
      out.write("                    <div class=\"modal-header\">\r\n");
      out.write("                        <h3 class=\"text-center\">\r\n");
      out.write("                                About Shop Keeper</h3>\r\n");
      out.write("                        <button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"modal-body\">\r\n");
      out.write("                        <!-- product details inner end -->\r\n");
      out.write("                        <div class=\"product-details-inner pl-4\">\r\n");
      out.write("                            \r\n");
      out.write("                            <hr style=\"background-color:black;opacity: 0.5;\" width=\"90%\">\r\n");
      out.write("                            <div class=\"row px-5 \">\r\n");
      out.write("                                <div class=\"col-lg-5 col-md-6\">\r\n");
      out.write("                                    <img src=\"static/img/profile.jpeg\" width=\"200px\" height=\"200px\" alt=\"\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-lg-7 col-md-6 \"\r\n");
      out.write("                                     style=\"font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;\">\r\n");
      out.write("                                    <h4>Name :</h4>\r\n");
      out.write("                                    <h5>Smit Dhaneshbhai Bhikadiya</h5>\r\n");
      out.write("                                    <h4>Address :</h4>\r\n");
      out.write("                                    <h5>Shantinagar, GadhadaRoad, Botad</h5>\r\n");
      out.write("                                    <h4>Phone :</h4>\r\n");
      out.write("                                    <h5>+91 846 911 6765</h5>\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <!-- product details inner end -->\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- Shop keeper modal end -->\r\n");
      out.write("\r\n");
      out.write("        <!-- Product view modal start -->\r\n");
      out.write("        <div class=\"modal\" id=\"product_view\">\r\n");
      out.write("            <div class=\"modal-dialog modal-sm modal-md modal-lg modal-dialog-centered\">\r\n");
      out.write("                <div class=\"modal-content\">\r\n");
      out.write("                    <div class=\"modal-header\">\r\n");
      out.write("                        <button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"modal-body\">\r\n");
      out.write("                        <!-- product details inner end -->\r\n");
      out.write("                        <div class=\"product-details-inner pl-4\">\r\n");
      out.write("                            <h1 class=\"text-center mb-3\"\r\n");
      out.write("                                style=\"font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif\">\r\n");
      out.write("                                About Item</h1>\r\n");
      out.write("                            <hr style=\"background-color:black;opacity: 0.5;\" width=\"90%\">\r\n");
      out.write("                            <div class=\"row px-5 \">\r\n");
      out.write("                                <div class=\"col-lg-5 col-md-6\">\r\n");
      out.write("                                    <img src=\"static/img/apple.png\" width=\"95%\" alt=\"\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-lg-7 col-md-6 py-2\"\r\n");
      out.write("                                     style=\"font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;\">\r\n");
      out.write("                                    <h3>Item Name :</h3>\r\n");
      out.write("                                    <h5>Apple</h5>\r\n");
      out.write("                                    <h3>Price :</h3>\r\n");
      out.write("                                    <h5>$45</h5>\r\n");
      out.write("                                    <h3>Total Quantity :</h3>\r\n");
      out.write("                                    <h5>30 Item</h5>\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <!-- product details inner end -->\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- Product view modal end -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <div class=\"jumbotron text-center\" style=\"margin-bottom:0\">\r\n");
      out.write("            <h1>Welcome, Smit Bhikadiya</h1>\r\n");
      out.write("            <p>sbhikadiya892@gmail.com</p>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <div class=\"nav p-1\">\r\n");
      out.write("            <div class=\"\">\r\n");
      out.write("                <a href=\"skStoreRegistration.html\" class=\"text-light\">Your Store</a>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"\">\r\n");
      out.write("                <a href=\"#page2\" class=\"text-light\">Pending Order: <span class=\"nuberoforder\">3</span></a>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"\">\r\n");
      out.write("                <a href=\"#page3\" class=\"text-light\">Orders History: <span class=\"nuberoforder\">1</span></a>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"\">\r\n");
      out.write("                <a href=\"userSignIn.html\" class=\"text-light\">Edit Me</a>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"\">\r\n");
      out.write("                <a href=\"#\" class=\"text-light\">Logout</a>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!--All remaining Orders-->\r\n");
      out.write("        <section id=\"page2\" class=\"page mt-3\">\r\n");
      out.write("\r\n");
      out.write("            <div class=\"card\">\r\n");
      out.write("                <div class=\"card-header text-center\">\r\n");
      out.write("                    <h4>Pending Orders</h4>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"card-body\">\r\n");
      out.write("                    <div class=\"skcard\">\r\n");
      out.write("                        <div class=\"skcard-header row\">\r\n");
      out.write("                            <div class=\"skcard-header-number col-sm-1\">1</div>\r\n");
      out.write("                            <div class=\"skcard-header-cinfo col-sm-11\">\r\n");
      out.write("                                <div>Customer Information:-\r\n");
      out.write("                                    <a href=\"#\" class=\"\" data-toggle=\"modal\" data-target=\"#quick_view\">\r\n");
      out.write("                                        Smit Dhaneshbhai Bhikadiya</a>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div>Address: Shantinagar, GadhadaRoad, Botad</div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"skcard-body row\" style=\"overflow:scroll;\">\r\n");
      out.write("                            <div class=\"skcard-itemsection col-sm-12\">\r\n");
      out.write("                                <div class=\"card-table\">\r\n");
      out.write("                                    <table class=\"table\" id=\"table-responsive\">\r\n");
      out.write("                                        <thead class=\"thead text-center\">\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <th scope=\"col\">Iimg</th>\r\n");
      out.write("                                                <th scope=\"col\">Iname</th>\r\n");
      out.write("                                                <th scope=\"col\">Iprize(per unit)</th>\r\n");
      out.write("                                                <th scope=\"col\">Iqty</th>\r\n");
      out.write("                                                <th scope=\"col\">Total</th>\r\n");
      out.write("                                                <th scope=\"col\">Mark as Available</th>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                        </thead>\r\n");
      out.write("                                        <tbody class=\"tbody text-center\">\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td><img class=\"oimg\" src=\"static/img/apple.png\" alt=\"apple\"></td>\r\n");
      out.write("                                                <td>\r\n");
      out.write("                                                    <a href=\"#\" class=\"\" data-toggle=\"modal\" data-target=\"#product_view\">\r\n");
      out.write("                                                        Apple</a>\r\n");
      out.write("                                                </td>\r\n");
      out.write("                                                <td>50/kg</td>\r\n");
      out.write("                                                <td>4</td>\r\n");
      out.write("\r\n");
      out.write("                                                <td>50X4= 200/-</td>\r\n");
      out.write("                                                <td><input type=\"checkbox\" checked></td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td> <img class=\"oimg\" src=\"static/img/banana.png\" alt=\"\"> </td>\r\n");
      out.write("                                                <td> <a href=\"#\">Banana</a>\r\n");
      out.write("                                                    <a href=\"#\" class=\"\" data-toggle=\"modal\" data-target=\"#product_view\">\r\n");
      out.write("                                                        Banana</a>\r\n");
      out.write("                                                </td>\r\n");
      out.write("                                                <td>65/dozen</td>\r\n");
      out.write("                                                <td>2</td>\r\n");
      out.write("\r\n");
      out.write("                                                <td>65X2= 130/-</td>\r\n");
      out.write("                                                <td><input type=\"checkbox\" checked></td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td> <img class=\"oimg\" src=\"static/img/grapes.png\" alt=\"\"> </td>\r\n");
      out.write("                                                <td> <a href=\"#\">Graps </a>\r\n");
      out.write("                                                    <a href=\"#\" class=\"\" data-toggle=\"modal\" data-target=\"#product_view\">\r\n");
      out.write("                                                        Graps</a>\r\n");
      out.write("                                                </td>\r\n");
      out.write("                                                <td>70/kg</td>\r\n");
      out.write("                                                <td>1</td>\r\n");
      out.write("\r\n");
      out.write("                                                <td>70X1= 70/-</td>\r\n");
      out.write("                                                <td><input type=\"checkbox\" checked></td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td colspan=\"3\">Total Item : 3</td>\r\n");
      out.write("                                                <td class=\"bill\">Total = <span>400/-</span></td>\r\n");
      out.write("                                                <td>All Available</td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                        </tbody>\r\n");
      out.write("                                    </table>\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"skcard-actions row  d-flex justify-content-center align-item-center\">\r\n");
      out.write("\r\n");
      out.write("                            <select name=\"aprox time\" id=\"\" class=\"form-control mb-2\" required>\r\n");
      out.write("                                <option value=\"0\">Time for Delivering</option>\r\n");
      out.write("                                <option value=\"00:15\">00:15 hour</option>\r\n");
      out.write("                                <option value=\"00:30\">00:30 hour</option>\r\n");
      out.write("                                <option value=\"00:45\">00:45 hour</option>\r\n");
      out.write("                                <option value=\"01:00\">01:00 hour</option>\r\n");
      out.write("                                <option value=\"01:30\">01:30 hour</option>\r\n");
      out.write("                                <option value=\"02:00\">02:00 hour</option>\r\n");
      out.write("                                <option value=\"02:30\">02:30 hour</option>\r\n");
      out.write("                                <option value=\"03:00\">03:00 hour</option>\r\n");
      out.write("                                <option value=\"03:30\">03:30 hour</option>\r\n");
      out.write("                                <option value=\"04:00\">04:00 hour</option>\r\n");
      out.write("                                <option value=\"05:00\">05:00 hour</option>\r\n");
      out.write("                                <option value=\"06:00\">06:00 hour</option>\r\n");
      out.write("                            </select>\r\n");
      out.write("                            <a href=\"#\" class=\"skcard-accept\">Accept</a>\r\n");
      out.write("                            <a href=\"#\" class=\"skcard-cancel\">Cancel</a>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"skcard\">\r\n");
      out.write("                        <div class=\"skcard-header row\">\r\n");
      out.write("                            <div class=\"skcard-header-number col-sm-1\">1</div>\r\n");
      out.write("                            <div class=\"skcard-header-cinfo col-sm-11\">\r\n");
      out.write("                                <div>Customer Information:-<a href=\"#\">Smit Dhaneshbhai Bhikadiya</a></div>\r\n");
      out.write("                                <div>Address: Shantinagar, GadhadaRoad, Botad</div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"skcard-body row\" style=\"overflow:scroll;\">\r\n");
      out.write("                            <div class=\"skcard-itemsection col-sm-12\">\r\n");
      out.write("                                <div class=\"card-table\">\r\n");
      out.write("                                    <table class=\"table \" id=\"table-responsive\">\r\n");
      out.write("                                        <thead class=\"thead text-center\">\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <th scope=\"col\">Iimg</th>\r\n");
      out.write("                                                <th scope=\"col\">Iname</th>\r\n");
      out.write("                                                <th scope=\"col\">Iprize(per unit)</th>\r\n");
      out.write("                                                <th scope=\"col\">Iqty</th>\r\n");
      out.write("                                                <th scope=\"col\">Total</th>\r\n");
      out.write("                                                <th scope=\"col\">Mark as Available</th>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                        </thead>\r\n");
      out.write("                                        <tbody class=\"tbody text-center\">\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td><img class=\"oimg\" src=\"static/img/apple.png\" alt=\"apple\"></td>\r\n");
      out.write("                                                <td> <a href=\"#\">Apple</a></td>\r\n");
      out.write("                                                <td>50/kg</td>\r\n");
      out.write("                                                <td>4</td>\r\n");
      out.write("\r\n");
      out.write("                                                <td>50X4= 200/-</td>\r\n");
      out.write("                                                <td><input type=\"checkbox\" checked></td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td> <img class=\"oimg\" src=\"static/img/banana.png\" alt=\"\"> </td>\r\n");
      out.write("                                                <td> <a href=\"#\">Banana</a> </td>\r\n");
      out.write("                                                <td>65/dozen</td>\r\n");
      out.write("                                                <td>2</td>\r\n");
      out.write("\r\n");
      out.write("                                                <td>65X2= 130/-</td>\r\n");
      out.write("                                                <td><input type=\"checkbox\" checked></td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td> <img class=\"oimg\" src=\"static/img/grapes.png\" alt=\"\"> </td>\r\n");
      out.write("                                                <td> <a href=\"#\">Graps </a> </td>\r\n");
      out.write("                                                <td>70/kg</td>\r\n");
      out.write("                                                <td>1</td>\r\n");
      out.write("\r\n");
      out.write("                                                <td>70X1= 70/-</td>\r\n");
      out.write("                                                <td><input type=\"checkbox\" checked></td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td colspan=\"3\">Total Item : 3</td>\r\n");
      out.write("                                                <td class=\"bill\">Total = <span>400/-</span></td>\r\n");
      out.write("                                                <td>All Available</td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                        </tbody>\r\n");
      out.write("                                    </table>\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"skcard-actions row  d-flex justify-content-center align-item-center\">\r\n");
      out.write("                            <select name=\"aprox time\" id=\"\" class=\"form-control mb-2\" required>\r\n");
      out.write("                                <option value=\"0\">Time for Delivering</option>\r\n");
      out.write("                                <option value=\"00:15\">00:15 hour</option>\r\n");
      out.write("                                <option value=\"00:30\">00:30 hour</option>\r\n");
      out.write("                                <option value=\"00:45\">00:45 hour</option>\r\n");
      out.write("                                <option value=\"01:00\">01:00 hour</option>\r\n");
      out.write("                                <option value=\"01:30\">01:30 hour</option>\r\n");
      out.write("                                <option value=\"02:00\">02:00 hour</option>\r\n");
      out.write("                                <option value=\"02:30\">02:30 hour</option>\r\n");
      out.write("                                <option value=\"03:00\">03:00 hour</option>\r\n");
      out.write("                                <option value=\"03:30\">03:30 hour</option>\r\n");
      out.write("                                <option value=\"04:00\">04:00 hour</option>\r\n");
      out.write("                                <option value=\"05:00\">05:00 hour</option>\r\n");
      out.write("                                <option value=\"06:00\">06:00 hour</option>\r\n");
      out.write("                            </select>\r\n");
      out.write("                            <a href=\"#\" class=\"skcard-accept\">Accept</a>\r\n");
      out.write("                            <a href=\"#\" class=\"skcard-cancel\">Cancel</a>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </section>\r\n");
      out.write("        <section id=\"page3\">\r\n");
      out.write("            <div class=\"card mt-2\">\r\n");
      out.write("                <div class=\"card-header text-center\">\r\n");
      out.write("                    <h4>Orders History</h4>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div style=\"height:50vh;overflow:scroll;\">\r\n");
      out.write("                    <div class=\"card-body text-center\">\r\n");
      out.write("                        <table class=\"table \" id=\"table-responsive\">\r\n");
      out.write("                            <thead class=\"thead-dark text-center\">\r\n");
      out.write("                                <tr>\r\n");
      out.write("                                    <th scope=\"col\">Items Id</th>\r\n");
      out.write("                                    <th scope=\"col\">Items Name</th>\r\n");
      out.write("                                    <th scope=\"col\">Items Image</th>\r\n");
      out.write("                                    <th scope=\"col\">Items Qty</th>\r\n");
      out.write("                                    <th scope=\"col\">Total Amount</th>\r\n");
      out.write("                                    <th scope=\"col\">Customer Name</th>\r\n");
      out.write("                                    <th scope=\"col\">Servicer</th>\r\n");
      out.write("                                    <th scope=\"col\">View Bill</th>\r\n");
      out.write("                                </tr>\r\n");
      out.write("                            </thead>\r\n");
      out.write("                            <tbody class=\"text-center\">\r\n");
      out.write("                                <tr>\r\n");
      out.write("                                    <th scope=\"row\">1</th>\r\n");
      out.write("                                    <td>Banana</td>\r\n");
      out.write("                                    <td><img src=\"static/img/banana.png\" width=\"50px\" height=\"50\" alt=\"\"></td>\r\n");
      out.write("                                    <td>4 dozen</td>\r\n");
      out.write("                                    <td><kbd>45/-</kbd></td>\r\n");
      out.write("                                    <td>Ankit Chauhan</td>\r\n");
      out.write("                                    <td>Ajay Devgon</td>\r\n");
      out.write("                                    <td><a href=\"#\">Invoice</a></td>\r\n");
      out.write("                                </tr>\r\n");
      out.write("                            </tbody>\r\n");
      out.write("                        </table>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </section>\r\n");
      out.write("\r\n");
      out.write("        <script>\r\n");
      out.write("\r\n");
      out.write("            window.addEventListener('resize', function () {\r\n");
      out.write("                if ($(window).width() < 550) {\r\n");
      out.write("                    $(\"#table-responsive\").addClass('table-responsive');\r\n");
      out.write("                }\r\n");
      out.write("                else {\r\n");
      out.write("                    $(\"#table-responsive\").removeClass('table-responsive');\r\n");
      out.write("                }\r\n");
      out.write("            });\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("            //Get the button\r\n");
      out.write("            var mybutton = document.getElementById(\"myBtn\");\r\n");
      out.write("\r\n");
      out.write("            // When the user scrolls down 20px from the top of the document, show the button\r\n");
      out.write("            window.onscroll = function () {\r\n");
      out.write("                scrollFunction()\r\n");
      out.write("            };\r\n");
      out.write("\r\n");
      out.write("            function scrollFunction() {\r\n");
      out.write("                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {\r\n");
      out.write("                    mybutton.style.display = \"block\";\r\n");
      out.write("                } else {\r\n");
      out.write("                    mybutton.style.display = \"none\";\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            // When the user clicks on the button, scroll to the top of the document\r\n");
      out.write("            function topFunction() {\r\n");
      out.write("                document.body.scrollTop = 0;\r\n");
      out.write("                document.documentElement.scrollTop = 0;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("        </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <!-- External JS -->\r\n");
      out.write("    <script src=\"static/js/skDashboard.js\"></script>\r\n");
      out.write("    <script src=\"static/js/vendor.js\"></script>\r\n");
      out.write("\r\n");
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
