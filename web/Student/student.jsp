<%-- 
    Document   : student
    Created on : Apr 10, 2016, 7:57:50 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet" integrity="sha384-XYCjB+hFAjSbgf9yKUgbysEjaVLOXhCgATTEBpCqT1R3jvG5LGRAK5ZIyRbH5vpX" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    <script>
        function confirm()
        {
        <% //System.out.println(request.getParameter("old"));
                if(request.getParameter("old")!=null&&request.getParameter("new")!=null)
                {
                    
                    String oldp=request.getParameter("old");
                    String newp=request.getParameter("new");
                    String sql="update project.users set password='"+newp+"' where password='"+oldp+"'";
                    stmt.executeUpdate(sql);
                }
            %>
        }
    </script>
    <body>
        <div class="navbar navbar-default navbar-fixed-top">
            
          <div class="container">
            <div class="navbar-header">
                
                <h1 style="color:whitesmoke; margin-left: 100px">Automatic Assessment for Marking Student Short Answer</h1>
               <!--<h3 style="color:whitesmoke;margin-left:420px;">Using NLP and IE Techniques</h3>-->
            </div>
              <ul class="nav navbar-nav navbar-right">
            <li><a href="#myModal" data-toggle="modal">Change password</a></li>
            <li><a href="logout.jsp" target="_parent">Logout</a></li>
            </ul>
              
          </div>
          
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                    
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Change Password</h4>
                  </div>
                    <form method="post">
                  <div class="modal-body">
                      <input type="label" name="old" class="form-control" placeholder="Old password">
                      <input type="label" name="new" class="form-control" placeholder="New Password">
                  </div>
                  <div class="modal-footer">
                    <button type="reset" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" onclick="confirm();">Confirm</button>
                  </div>
                    </form>
                </div>
              </div>
            </div>
        <iframe name="f2" src="test.jsp" style="background: #FFFFFF; margin-top: 150px;" frameborder='0' width="100%" height="1000px" id="iframe1" marginheight="0" scrolling="yes"></iframe><!onLoad="autoResize('iframe1');">
        <br><br><br>
    </body>
</html>
