<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<head> 	<script src="https://accounts.google.com/gsi/client" async></script> </head>

<body>
	<% 
	String client_id= "743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ;   
	application.setAttribute("client_id", client_id) ; 
	%>
	<!--  Google Sign in  -->
	<div id="g_id_onload"
	     data-client_id="<%=client_id %>"
	     data-context="signin"
	     data-ux_mode="popup"
	     data-login_uri="https://apigeeadmin.moj.gov.sa:8443/ResourceManagerWeb/loginWithGoogle/loginHandler.jsp"
	     data-auto_prompt="false">
	</div>


	<div class="g_id_signin"
	     data-type="standard"
	     data-shape="rectangular"
	     data-theme="filled_blue"
	     data-text="signin_with"
	     data-size="large"
	     data-logo_alignment="left">
	</div>

</body>
</html>