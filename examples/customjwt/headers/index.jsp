<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Enumeration"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>All Headers</title>
</head>
<body>
  <%
    for (Enumeration iter = request.getHeaderNames(); iter.hasMoreElements();) {
        String key = (String) iter.nextElement();
  %>
  <%= key %> = <%= request.getHeader(key) %>
  <br>
  <%
            }
  %>
  Tomcat Version : <%= application.getServerInfo() %><br>    
    Servlet Specification Version : 
<%= application.getMajorVersion() %>.<%= application.getMinorVersion() %> <br>    
    JSP version :
<%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %><br>
</body>
</html>
