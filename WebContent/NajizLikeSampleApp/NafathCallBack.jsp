<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@page import ="java.io.InputStream"%>
 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.rest.schema.ApigeeAccessToken"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@include file="intialize.jsp" %>
<%
	String authorizationCode = request.getParameter("code") ;
	%>Received Authorization Code : <%=authorizationCode%><% 
	
	ApigeeAccessToken accessToken = mojEnv.getAccessToken(false); 
	if (accessToken == null)
	{
		accessToken = mojEnv.getAccessToken(authorizationCode);
		session.setAttribute("accessToken" , accessToken);
	}
	
%>
</body>
</html>