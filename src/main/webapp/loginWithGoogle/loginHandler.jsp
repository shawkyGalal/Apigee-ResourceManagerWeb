<%@page import = "com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import = "com.google.api.client.googleapis.auth.oauth2.GoogleIdToken" %>
<%@page import = "com.smartvalue.google.iam.IdTokenVerifier" %>
<%@page import ="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.googleWebAppCredential.GoogleWebAppCredential"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Google Login Handler </title>
<head>

</head>
<body>
<%

	ApigeeConfig ac = (ApigeeConfig) application.getAttribute("appConfig") ;
	GoogleWebAppCredential googleWebAppCredential = ac.getGoogleWebAppCredential();
	String client_id= googleWebAppCredential.getClient_id(); //(String) application.getAttribute("client_id") ; 
		
	GoogleIdToken googleIdToken = IdTokenVerifier.verifyFromRequest(client_id, (javax.servlet.http.HttpServletRequest)request) ; 
	
	if (googleIdToken != null )
	{
		out.print( googleIdToken.getPayload().getEmail()) ; 
		session.setAttribute("GoogleIdToken", googleIdToken); 
		response.sendRedirect("userInfo.jsp"); 
	}

%>

</body>
</html>