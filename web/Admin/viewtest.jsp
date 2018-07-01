<%-- 
    Document   : viewtest
    Created on : Apr 18, 2016, 12:52:17 PM
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
        <div class="container">
            <br><br><br>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        
                        <th>Username</th>
                        <th>Question</th>
                        <th>Testname</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                String testname=request.getParameter("select");
                String test=testname.toLowerCase();
                String sql="select test.username,test.question,test.testname,"+test+".status from test,"+test+" where test.testname='"+testname+"' AND test.username="+test+".username";
                rs=stmt.executeQuery(sql);
                while(rs.next()){
                %>
                    <tr>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("question")%></td>
                        <td><%=rs.getString("testname")%></td>
                        <td><%=rs.getString("status")%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>

        </div>
    </body>
</html>
