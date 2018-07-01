<%-- 
    Document   : users
    Created on : Apr 30, 2016, 2:28:56 PM
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
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet" integrity="sha384-XYCjB+hFAjSbgf9yKUgbysEjaVLOXhCgATTEBpCqT1R3jvG5LGRAK5ZIyRbH5vpX" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div id="container0">
            <br><br><br>
            <form method="post">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Role</th>
                    </tr>
                </thead>
                <tbody>
                <%
                String sql="select *from users";
                rs=stmt.executeQuery(sql);
                while(rs.next()){
                %>
                    <tr>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("password")%></td>
                        <td><%=rs.getString("role")%></td>
                    </tr>
                    <%}%>
                    <tr>
                        
                        <td><input type="text" class="form-control" name="newuser" id="newuser"></td>
                        <td><input type="text" class="form-control" name="newpass" id="newpass"></td>
                        <input type="hidden" name="hide">
                        <td>
                            <div class="form-group">
                          <div class="col-lg-10">
                            <select class="form-control" name="role">
                              <option>Admin</option>
                              <option>Student</option>
                            </select>
                          </div>
                        </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button type="submit" class="btn btn-primary" onclick="new();">Add New User</button>
            </form>
        </div>
                    
    </body>
    <script>
        function new()
        {
            <%
                if(request.getParameter("hide")!=null)
                {
                    String username=request.getParameter("newuser");
                    String password=request.getParameter("newpass");
                    String role=request.getParameter("role");
                    sql="insert into project.users values('"+username+"','"+password+"','"+role+"',NULL)";
                    stmt.executeUpdate(sql);
                    String url = request.getRequestURL().toString();
                    response.sendRedirect(url);
                }
            %>
                   
        }
    </script>
</html>
