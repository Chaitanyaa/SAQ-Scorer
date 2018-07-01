<%-- 
    Document   : test
    Created on : Apr 10, 2016, 8:04:58 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Connection con1=null;
    Statement stmt=null;
    Statement stmt1=null;
    int i=0;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project?user=root");
        //con1 = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project?user=root");
        }
        catch (Exception e) {
        e.printStackTrace();
        }
        stmt=con.createStatement();
        //stmt1=con1.createStatement();
    
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
        <br>
        <div id="container2">
            <form id="fo" target="f2">
            <table width="100%" cellspacing="10">
                <tbody>
                    <tr>
                        <td>
                            <h3>Select Test</h3>
                            <div class="col-lg-10">
                            <select class="form-control" id="select" name="select">
                              <%
                                    String sql="SELECT distinct(project.test.testname),project.test.username from project.test";
                                    ResultSet rs=stmt.executeQuery(sql);
                                    while(rs.next()){
                                        //String sql1="select *from "+rs.getString("testname")+" where username='"+rs.getString("username")+"'";
                                        //ResultSet rs1=stmt1.executeQuery(sql1);rs1.next();//System.out.println("Stat:"+rs1.getString("status").equals("incomplete"));
                                        if(rs.getString("username").equals(session.getAttribute("user"))){//&&rs1.getString("status").equals("incomplete")){
                               %>   
                              <option><%=rs.getString("testname")%></option>
                              <%}}%>
                            </select>
                            </div>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <br>
                            <button type="submit" onclick="test();" class="btn btn-primary btn-sm">Take test</button>
                            <button type="submit" onclick="view();" class="btn btn-primary btn-sm">View result</button>
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                </tbody>
            </table>
            </form>
        </div>
    </body>
    <script>
        function view(){
            document.getElementById("fo").action = "result.jsp";
        }
        function test(){
            document.getElementById("fo").action = "taketest.jsp";
        }
        </script>
</html>
