<%-- 
    Document   : index
    Created on : Apr 10, 2016, 10:45:43 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
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
        
%>
<html>
    <head>
        <title>HOME</title>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet" integrity="sha384-XYCjB+hFAjSbgf9yKUgbysEjaVLOXhCgATTEBpCqT1R3jvG5LGRAK5ZIyRbH5vpX" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body background="background.jpg">
        <div class="modal show" align="center" style="margin-top: 100px;">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h2 class="modal-title"><span class="glyphicon glyphicon-user fa-fw" aria-hidden="true"> </span>LOGIN</h2>
              </div>
                <br>
                <div style="width: 300px;">
                    <form method="post">
                <input type="text" class="form-control" name="user" id="inputEmail" placeholder="Email">
                <br>
                <input type="password" class="form-control" name="pass" id="inputPassword" placeholder="Password">
                <br>
                <button type="reset" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" onclick="fun();">Submit</button>
                    </form>
                <br><br>
                </div>
          </div>
        </div>
        </div>
    </body>
    <script type="text/javascript">
                function fun()
                {
                    <%
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
                   
                  %>  
                      }
                </script>
</html>
