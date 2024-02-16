<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
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
		ApigeeConfig ac = (ApigeeConfig)application.getAttribute("appConfig") ;
		String clientId = ac.getGoogleWebAppCredential().getClient_id() ; //"455673897131-f610c9tau1i582tpk8nq2q5794qdb1oi.apps.googleusercontent.com" ; //"743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ;
	    String contextPath = request.getContextPath(); 
		String callbackUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/loginWithGoogle/authCodeHandler.jsp" ; 
	%>
	
	Apigee Organization You Have Selected is configured as an Apigee X Google Cloud Project, You Need To Authorize Access to this Project
	<br>   
	
	<script>
	function requestCode()
	{
		const client = google.accounts.oauth2.initCodeClient({
			  client_id: '<%=clientId %>',
			  scope: 'https://www.googleapis.com/auth/cloud-platform' ,
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