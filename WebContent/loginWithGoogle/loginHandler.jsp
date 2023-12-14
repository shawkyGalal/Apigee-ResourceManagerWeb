<%@page import="org.apache.tomcat.util.descriptor.web.LoginConfig"%>
<%@page import="com.smartvalue.google.IdTokenVerifier"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<%@page import = "com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import = "com.google.api.client.googleapis.auth.oauth2.GoogleIdToken" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Google Login Handler </title>
<head>

</head>
<body>
<% 
	String client_id= (String) application.getAttribute("client_id") ; 
	if (client_id == null )
	{
		application.setAttribute("client_id" , "743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ) ; 
		//response.sendRedirect("Login.jsp"); //   ;
	}
	GoogleIdToken googleIdToken = IdTokenVerifier.verifyFromRequest(client_id, request) ;
	if (googleIdToken != null )
	{
		out.print( googleIdToken.getPayload().getEmail()) ; 
		session.setAttribute("GoogleIdToken", googleIdToken); 
	}
	//IdTokenVerifier.verifyTimingOnly(googleIdToken) ;
%>

</body>
</html>