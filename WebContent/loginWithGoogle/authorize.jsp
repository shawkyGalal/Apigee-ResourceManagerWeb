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
	String client_id= "455673897131-f610c9tau1i582tpk8nq2q5794qdb1oi.apps.googleusercontent.com" ; //"743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ;   
	application.setAttribute("client_id", client_id) ; 
	String callbackUrl = "https://apigeeadmin.moj.gov.sa:8443/ResourceManagerWeb/loginWithGoogle/authCodeHandler.jsp" ; 
	%>
	
	<script>
	function requestCode()
	{
		const client = google.accounts.oauth2.initCodeClient({
			  client_id: '<%=client_id %>',
			  scope: 'https://www.googleapis.com/auth/calendar.readonly',
			  ux_mode: 'redirect',
			  redirect_uri: "<%=callbackUrl%>",
			  state: "YOUR_BINDING_VALUE"
				});
		client.requestCode(); 
	
	}
	</script>

	<button onclick="requestCode();  ">Authorize with Google</button>
	
	
</body>
</html>