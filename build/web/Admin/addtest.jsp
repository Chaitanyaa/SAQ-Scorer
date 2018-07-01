<%-- 
    Document   : addtest
    Created on : Apr 10, 2016, 6:28:23 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Statement stmt=null;
    int i=0;
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
    <body>
        <script>
            function createtest()
            {
                <%
                if(request.getParameter("testname")!=null){
                    String testname=request.getParameter("testname");
                    String questions[]=request.getParameterValues("questions");
                    String students[]=request.getParameterValues("students");
                    stmt.executeUpdate("create table "+testname+"(username varchar(255),status varchar(10))");
                    for(int x=0;x<students.length;x++)
                    {
                        for(int y=0;y<questions.length;y++)
                        {
                        String sql="insert into project.test values('"+questions[y]+"',NULL,NULL,'"+testname+"','"+students[x]+"',NULL)";
                        stmt.executeUpdate(sql);
                        }
                    }
                    for(String student:students)
                    {
                        String sql="insert into project."+testname+" values('"+student+"','incomplete')";
                        stmt.executeUpdate(sql);
                    }
                    
                    
                }
                %>
            }
        </script>
       <form class="form-horizontal" name="tform" target="f2">
        <div class="container">
            <table width="100%" cellspacing="2">
                <tbody>
                    <tr>
                        <td>
                            <h3>Enter new test name</h3>
                            <br>
                            <div class="form-group">
                              <div class="col-lg-10">
                                  <input type="text" class="form-control" name="testname" placeholder="Test Name">
                              </div>
                            </div>
                        </td>
                        <td>
                            <h3>Select questions</h3><br>
                        <div class="col-lg-10">
                        <select multiple="" class="form-control" name="questions">
                            <%
                            ResultSet rs = stmt.executeQuery("Select *from project.qas");
                            while(rs.next()){
                            %>
                            <option><%=rs.getString("question")%></option>
                          <%}%>
                        </select>
                            <span class="help-block">Press ctrl to select two or more !</span>
                        </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                        <div class="form-group" align="center">
                          <div class="col-lg-10 col-lg-offset-2">
                            <a href="tests.jsp" class="btn btn-primary" target="f2">Back</a>
                            <button type="reset" class="btn btn-default">Cancel</button>
                            <button type="submit" onclick="createtest();" class="btn btn-primary">Save Test</button>
                          </div>
                        </div>
                        </td>
                        <td>
                            <h3>Assign students</h3><br>
                        <div class="col-lg-10">
                        <select multiple="" class="form-control" name="students">
                            <%
                            rs = stmt.executeQuery("Select *from project.users");
                            while(rs.next()){
                                if(rs.getString("role").equals("Student")){
                            %>
                          <option><%=rs.getString("username")%></option>
                          <%}}%>
                        </select>
                            <span class="help-block">Press ctrl to select two or more !</span>
                        </div>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    
                </tbody>
            </table>
        </div>
        </form>
    </body>
</html>
