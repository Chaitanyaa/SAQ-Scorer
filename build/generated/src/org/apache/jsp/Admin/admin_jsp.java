package org.apache.jsp.Admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class admin_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
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
      out.write("        <!link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css\">\n");
      out.write("        <!script src=\"https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    <body onload=\"set();\">\n");
      out.write("        <div class=\"navbar navbar-default navbar-fixed-top\">\n");
      out.write("            <ul class=\"nav navbar-nav navbar-right\" style=\"margin-right: 20px;\">\n");
      out.write("            <li><a href=\"logout.jsp\" target=\"_parent\">Logout</a></li>\n");
      out.write("            </ul>\n");
      out.write("          <div class=\"container\">\n");
      out.write("            <div class=\"navbar-header\">\n");
      out.write("                <h1 style=\"color:whitesmoke; margin-left: 100px\">Automatic Assessment for Marking Student Short Answer</h1>\n");
      out.write("               <!--<h3 style=\"color:whitesmoke;margin-left:420px;\">Using NLP and IE Techniques</h3>-->\n");
      out.write("               <br><br>\n");
      out.write("            </div>\n");
      out.write("              \n");
      out.write("          </div>\n");
      out.write("            \n");
      out.write("          <ul class=\"nav nav-tabs\" style=\"margin-left: 200px\">\n");
      out.write("              \n");
      out.write("              <li id=\"link1\"><a href='javascript:;' onclick='link1();' data-toggle=\"tab\">Tests</a></li>\n");
      out.write("             \n");
      out.write("            <li id=\"link2\"><a href='javascript:;' onclick='link2();' data-toggle=\"tab\">Reports</a></li>\n");
      out.write("            \n");
      out.write("            <li id=\"link3\"><a href='javascript:;' onclick='link3();' data-toggle=\"tab\">Users</a></li>\n");
      out.write("          </ul>\n");
      out.write("            \n");
      out.write("        </div>\n");
      out.write("        <br>\n");
      out.write("        <iframe name=\"f2\" id=\"myFrame\" src=\"tests.jsp\" style=\"background: #FFFFFF; margin-top: 150px;\" frameborder='0' width=\"100%\" height=\"1000px\" marginheight=\"0\" scrolling=\"yes\"></iframe><!onLoad=\"autoResize('iframe1');\">\n");
      out.write("    </body>\n");
      out.write("    <script>\n");
      out.write("        function link1()\n");
      out.write("        {\n");
      out.write("            var loc = \"tests.jsp\";\n");
      out.write("            document.getElementById('myFrame').setAttribute('src', loc);\n");
      out.write("            var ac=\"active\";\n");
      out.write("            document.getElementById('link1').setAttribute('class',ac);\n");
      out.write("            var ac=\"\";\n");
      out.write("            document.getElementById('link2').setAttribute('class',ac);\n");
      out.write("            var ac=\"\";\n");
      out.write("            document.getElementById('link3').setAttribute('class',ac);\n");
      out.write("        }\n");
      out.write("        function link2()\n");
      out.write("        {\n");
      out.write("            var loc = \"report.jsp\";\n");
      out.write("            document.getElementById('myFrame').setAttribute('src', loc);\n");
      out.write("            var ac=\"\";\n");
      out.write("            document.getElementById('link1').setAttribute('class',ac);\n");
      out.write("            var ac=\"active\";\n");
      out.write("            document.getElementById('link2').setAttribute('class',ac);\n");
      out.write("            var ac=\"\";\n");
      out.write("            document.getElementById('link3').setAttribute('class',ac);\n");
      out.write("        }\n");
      out.write("        function link3()\n");
      out.write("        {\n");
      out.write("            var loc = \"users.jsp\";\n");
      out.write("            document.getElementById('myFrame').setAttribute('src', loc);\n");
      out.write("            var ac=\"\";\n");
      out.write("            document.getElementById('link1').setAttribute('class',ac);\n");
      out.write("            var ac=\"active\";\n");
      out.write("            document.getElementById('link3').setAttribute('class',ac);\n");
      out.write("            var ac=\"\";\n");
      out.write("            document.getElementById('link2').setAttribute('class',ac);\n");
      out.write("        }\n");
      out.write("        function set()\n");
      out.write("        {\n");
      out.write("            var ac=\"active\";\n");
      out.write("            document.getElementById('link1').setAttribute('class',ac);\n");
      out.write("        }\n");
      out.write("        </script>\n");
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
