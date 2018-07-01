<%-- 
    Document   : report
    Created on : Apr 18, 2016, 1:34:43 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
    Statement stmt1=null;
    ResultSet rs1=null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project?user=root");
        }
        catch (Exception e) {
        e.printStackTrace();
        }
        stmt=con.createStatement();
        stmt1=con.createStatement();
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
    <body>
        <div class="container">
            <br><br><br>
            <%
                String sql="select distinct(username) from test";
                rs=stmt.executeQuery(sql);
                while(rs.next()){
            %>
            <table class="table table-striped table-hover">
                <thead>
                    <tr class="success">
                        <th colspan="4" style='text-align:center;'><%=rs.getString("username")%></th>
                    </tr>
                </thead>
                <tbody>
                    
                    <tr>
                        <th>Testname</th>
                        <th>Question</th>
                        <th>Answer</th>
                        <th>Score</th>
                    </tr>
                <%
                String sql1="select *from test where username='"+rs.getString("username")+"'";
                rs1=stmt1.executeQuery(sql1);
                while(rs1.next()){
                %>
                    <tr>
                        <td><%=rs1.getString("testname")%></td>
                        <td><%=rs1.getString("question")%></td>
                        <td><%=rs1.getString("answer")%></td>
                        <td><%=rs1.getString("score")%></td>
                    </tr>
                   <%}%> 
                </tbody>
            </table>
            <%}%>
        </div>
    </body>
</html>
