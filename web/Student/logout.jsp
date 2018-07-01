<%-- 
    Document   : logout
    Created on : Mar 28, 2016, 1:50:19 AM
    Author     : SAI CHAITANYA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate();
    String url=request.getRequestURL().toString();
    url=url.replace("Student/logout.jsp", "index.jsp");
    response.sendRedirect(url);
%>
