<%-- 
    Document   : admin
    Created on : Apr 10, 2016, 2:52:00 PM
    Author     : SAI CHAITANYA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <!link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <!script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
    </head>
    <body onload="set();">
        <div class="navbar navbar-default navbar-fixed-top">
            <ul class="nav navbar-nav navbar-right" style="margin-right: 20px;">
            <li><a href="logout.jsp" target="_parent">Logout</a></li>
            </ul>
          <div class="container">
            <div class="navbar-header">
                <h1 style="color:whitesmoke; margin-left: 100px">Automatic Assessment for Marking Student Short Answer</h1>
               <!--<h3 style="color:whitesmoke;margin-left:420px;">Using NLP and IE Techniques</h3>-->
               <br><br>
            </div>
              
          </div>
            
          <ul class="nav nav-tabs" style="margin-left: 200px">
              
              <li id="link1"><a href='javascript:;' onclick='link1();' data-toggle="tab">Tests</a></li>
             
            <li id="link2"><a href='javascript:;' onclick='link2();' data-toggle="tab">Reports</a></li>
            
            <li id="link3"><a href='javascript:;' onclick='link3();' data-toggle="tab">Users</a></li>
          </ul>
            
        </div>
        <br>
        <iframe name="f2" id="myFrame" src="tests.jsp" style="background: #FFFFFF; margin-top: 150px;" frameborder='0' width="100%" height="1000px" marginheight="0" scrolling="yes"></iframe><!onLoad="autoResize('iframe1');">
    </body>
    <script>
        function link1()
        {
            var loc = "tests.jsp";
            document.getElementById('myFrame').setAttribute('src', loc);
            var ac="active";
            document.getElementById('link1').setAttribute('class',ac);
            var ac="";
            document.getElementById('link2').setAttribute('class',ac);
            var ac="";
            document.getElementById('link3').setAttribute('class',ac);
        }
        function link2()
        {
            var loc = "report.jsp";
            document.getElementById('myFrame').setAttribute('src', loc);
            var ac="";
            document.getElementById('link1').setAttribute('class',ac);
            var ac="active";
            document.getElementById('link2').setAttribute('class',ac);
            var ac="";
            document.getElementById('link3').setAttribute('class',ac);
        }
        function link3()
        {
            var loc = "users.jsp";
            document.getElementById('myFrame').setAttribute('src', loc);
            var ac="";
            document.getElementById('link1').setAttribute('class',ac);
            var ac="active";
            document.getElementById('link3').setAttribute('class',ac);
            var ac="";
            document.getElementById('link2').setAttribute('class',ac);
        }
        function set()
        {
            var ac="active";
            document.getElementById('link1').setAttribute('class',ac);
        }
        </script>
</html>
