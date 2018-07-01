package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");

    Connection con=null;
    Statement stmt=null;
    Boolean access=false;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project?user=root");
        }
        catch (Exception e) {
        e.printStackTrace();
        }
        stmt=con.createStatement();
        

      out.write("\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>HOME</title>\n");
      out.write("        <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("/css/style.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("        <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js\"></script>\n");
      out.write("        <link href=\"https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-XYCjB+hFAjSbgf9yKUgbysEjaVLOXhCgATTEBpCqT1R3jvG5LGRAK5ZIyRbH5vpX\" crossorigin=\"anonymous\">\n");
      out.write("        <link href=\"https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css\" rel=\"stylesheet\">\n");
      out.write("        <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\"></script>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    </head>\n");
      out.write("    <body background=\"background.jpg\">\n");
      out.write("        <div class=\"modal show\" align=\"center\" style=\"margin-top: 100px;\">\n");
      out.write("          <div class=\"modal-dialog\">\n");
      out.write("            <div class=\"modal-content\">\n");
      out.write("              <div class=\"modal-header\">\n");
      out.write("                <h2 class=\"modal-title\"><span class=\"glyphicon glyphicon-user fa-fw\" aria-hidden=\"true\"> </span>LOGIN</h2>\n");
      out.write("              </div>\n");
      out.write("                <br>\n");
      out.write("                <div style=\"width: 300px;\">\n");
      out.write("                    <form method=\"post\">\n");
      out.write("                <input type=\"text\" class=\"form-control\" name=\"user\" id=\"inputEmail\" placeholder=\"Email\">\n");
      out.write("                <br>\n");
      out.write("                <input type=\"password\" class=\"form-control\" name=\"pass\" id=\"inputPassword\" placeholder=\"Password\">\n");
      out.write("                <br>\n");
      out.write("                <button type=\"reset\" class=\"btn btn-default\" data-dismiss=\"modal\">Cancel</button>\n");
      out.write("                <button type=\"submit\" class=\"btn btn-primary\" onclick=\"fun();\">Submit</button>\n");
      out.write("                    </form>\n");
      out.write("                <br><br>\n");
      out.write("                </div>\n");
      out.write("          </div>\n");
      out.write("        </div>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("    <script type=\"text/javascript\">\n");
      out.write("                function fun()\n");
      out.write("                {\n");
      out.write("                    ");

                    ResultSet rs=null;
                    if(request.getParameter("pass")!=null&&request.getParameter("user")!=null)
                    {
                        stmt=con.createStatement();
                        rs=stmt.executeQuery("select *from project.users");
                        while(rs.next()){
                        if(rs.getString("password").equals(request.getParameter("pass"))&&rs.getString("username").equals(request.getParameter("user")))
                        {
                            access=true;
                            break;
                        }
                        }
                    
                    //System.out.println(request.getParameter("pass"));
                    session.setAttribute("user", rs.getString("username"));
                    if(access&&rs.getString("role").equals("Admin"))
                    {
                        
                        String url = request.getRequestURL().toString();
                        url=url.replace("index.jsp", "");
                        url=url+"Admin/admin.jsp";
                        response.sendRedirect(url);
                    }
                    else if(access&&rs.getString("role").equals("Student"))
                    {
                        String url = request.getRequestURL().toString();
                        url=url.replace("index.jsp", "");
                        url=url+"Student/student.jsp";
                        response.sendRedirect(url);
                    }
                    }
                   
                  
      out.write("  \n");
      out.write("                      }\n");
      out.write("                </script>\n");
      out.write("</html>\n");
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
