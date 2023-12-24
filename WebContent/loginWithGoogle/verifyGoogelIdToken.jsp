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
	GoogleIdToken googleIdToken= (GoogleIdToken) session.getAttribute("GoogleIdToken") ; 

		boolean isTimeValid = IdTokenVerifier.verifyTimingOnly(googleIdToken) ;
		if ( ! isTimeValid )
		{
			out.print( "Your session is Expired, You need to relogin to Google") ;
			response.sendRedirect("/loginWithGoogle/login.jsp");
		}

%>

</body>
</html>