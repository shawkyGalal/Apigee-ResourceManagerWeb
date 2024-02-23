<%@page import="com.smartvalue.apigee.configuration.infra.googleAccessToken.auto.GoogleAccessToken"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>

<%@page import="org.springframework.security.crypto.codec.Base64"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="com.mashape.unirest.http.HttpResponse"%>
<%@page import="com.mashape.unirest.http.Unirest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	ManagementServer ms = (ManagementServer)session.getAttribute("ms"); 
	String authCode = request.getParameter("code") ;
	String contextPath = request.getContextPath(); 
	String redirectUri = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/loginWithGoogle/authCodeHandler.jsp" ; 
	ms.webLogin(authCode, redirectUri) ; 
	GoogleAccessToken googleAccessToken = (GoogleAccessToken) ms.getAccessToken() ;
	//googleAccessToken.getJwtClaims() ;
	
	response.sendRedirect("../ApigeeAdmin/index.jsp"); 
	
%>
</body>
</html>