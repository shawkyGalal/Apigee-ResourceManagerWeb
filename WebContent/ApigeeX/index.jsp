<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://accounts.google.com/gsi/client" async></script>

<meta charset="ISO-8859-1">
<title>ApigeeX Migration Services </title>
</head>
<body>
	<% 
	String client_id= "455673897131-f610c9tau1i582tpk8nq2q5794qdb1oi.apps.googleusercontent.com" ;   
	application.setAttribute("client_id", client_id) ; 
	%>
	<!--  Google Sign in  -->
	<div id="g_id_onload"
	     data-client_id="<%=client_id%>"
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

	<h1> Build Apigee X Environments  </h1>
		<h2><a href = "Environments/create.jsp" target = "Najiz"> 01- Create Environments  </a></h2>
		<h2><a href = "Environments/create.jsp" target = "Najiz"> 02- Delete Environments  </a></h2>
	We Will Use ETL ( Extract , Transform and Load ) Model 
	<h1><a href = "ETL/extract/extract.jsp" target = "Najiz"> Extract Apigee Objects from Staging  </a></h1>
	<h1><a href = "ETL/transform/transform.jsp" target = "Najiz"> Transform Objects to Match ApigeeX requirments </a></h1>
	<h1><a href = "ETL/load/load.jsp" target = "load" >Load Apigee Objects to Apigee X Cloud </a></h1>
	
	
</body>
</html>