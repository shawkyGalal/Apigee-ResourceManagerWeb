<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://accounts.google.com/gsi/client" async></script>

<meta charset="ISO-8859-1">
<title>MOJ Automation Services </title>
</head>
<body>
	<% 
	String client_id= "455673897131-f610c9tau1i582tpk8nq2q5794qdb1oi.apps.googleusercontent.com" ; //"743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ;   
	application.setAttribute("client_id", client_id) ; 
	%>
	<!--  Google Sign in  Using  Google button --> 
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
	
	<!--  Google Sign in  Using  Enable OneTap --> 
	
	<div id="g_id_onload"
	     data-client_id="<%=client_id %>"
	     data-context="use"
	     data-login_uri="https://apigeeadmin.moj.gov.sa:8443/ResourceManagerWeb/loginWithGoogle/loginHandler.jsp"
	     data-nonce=""
	     data-itp_support="true">
	</div>


	<h1> NajizLikeSample App </h1>
		<h2><a href = "NajizLikeSampleApp/dashboard.jsp" target = "Najiz"> Najiz Sample Like Application Using Najiz SDK </a></h2>
		<h2><a href = "SDK_Generator/InputParams.jsp" target = "SDK Generator"> SDK Generator </a></h2>
	
	<h1><a href = "ApigeeAdmin/index.jsp" target = "Najiz"> Apigee Administration </a></h1>
	<br>
	<h1><a href = "ApigeeX/index.jsp" target = "Apigee X"> Apigee X </a></h1>
	
	<h3><a href="loginWithGoogle/index.jsp" target = "Google Login" >Login with Google</a></h3>
	
</body>
</html>