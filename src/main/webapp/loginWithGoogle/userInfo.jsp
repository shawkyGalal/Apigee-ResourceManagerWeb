<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "com.google.api.client.googleapis.auth.oauth2.GoogleIdToken" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	GoogleIdToken googleIdToken = (GoogleIdToken) session.getAttribute("GoogleIdToken");
	%>
	<img alt="<%=googleIdToken.getPayload().get("name")%>" src="<%=googleIdToken.getPayload().get("picture")%>">
	<%	
	out.print(Renderer.objectToHtmlTable(googleIdToken.getPayload())); 
%>

</body>
</html>