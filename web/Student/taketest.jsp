<%-- 
    Document   : taketest
    Created on : Apr 10, 2016, 8:21:37 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
    ArrayList<Integer> a=new ArrayList<Integer>();
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
            function save()
            {
            <%
                    if(request.getParameter("answer")!=null)
                    {
                        
                        a=(ArrayList<Integer>)session.getAttribute("a");
                        Iterator <Integer>i=a.iterator();
                        String ans[]=request.getParameterValues("answer");
                        //System.out.println(Arrays.toString(ans));
                        //System.out.print(Arrays.toString(a.toArray()));
                        //System.out.println(i.next());
                        for(String str:ans)
                        {
                        String sql="update project.test set answer='"+str+"' where id='"+i.next()+"'";
                        stmt.executeUpdate(sql);
                        }
                        String sql1="update project."+(String)session.getAttribute("testname")+" set status='complete' where username='"+session.getAttribute("user")+"'";
                        stmt.executeUpdate(sql1);
                        //System.out.println(Arrays.toString(request.getParameterValues("answer")));
                    }
                %>
                window.top.location.reload();
            }
        </script>
        <br><br>
        <div id="container0">
            <form class="form-horizontal" name="qform" target="f2">
                <%
                    String testname=request.getParameter("select");
                    session.setAttribute("testname", testname);
                    String username=(String)session.getAttribute("user");
                    String sql="select *from project.test where username='"+username+"' AND testname='"+testname+"'";
                    rs=stmt.executeQuery(sql);
                    
                    while(rs.next()){
                        int id=rs.getInt("id");
                        a.add(id);
                %>
                <h4><span class="help-block" id="question">
                <%=rs.getString("question")%>
                </span></h4>
            <div class="form-group">
            <label for="textArea" class="col-lg-2 control-label" name="">Answer</label>
            <div class="col-lg-10">
            <textarea class="form-control" rows="2" name="answer"></textarea>
            
            </div>
            <br><br><br><br>
            <%}session.setAttribute("a", a);
            %>
            <div class="form-group" align="center">
              <div class="col-lg-10 col-lg-offset-2">
                <a href="test.jsp" class="btn btn-primary" target="f2">Back</a>
                <button type="reset" class="btn btn-default">Cancel</button>
                <button type="submit" onclick="save();" class="btn btn-primary ">Submit Test</button>
              </div>
            </div>
            </div>
            <br><br><br><br><br>
            <span class="help-block"> --->Shorter the better !</span>
            </form>
            </div>
        
    </body>
</html>
