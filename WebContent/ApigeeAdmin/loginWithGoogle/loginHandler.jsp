<%@page import="com.google.api.client.http.apache.v2.ApacheHttpTransport"%>
<%@page import="com.google.api.client.http.HttpTransport"%>
<%@page import="com.google.api.client.json.gson.GsonFactory"%>
<%@page import="java.util.Collections"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<%@page import = "com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import = "com.google.api.client.googleapis.auth.oauth2.GoogleIdToken" %>
<%@page import = "com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload" %>
<%@page import = "com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Google Login Handler </title>
<head>

</head>
<body>
<% 
	String client_id= "743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ;  
	com.google.api.client.json.JsonFactory jsonFactory = new GsonFactory(); 
	HttpTransport httpTransport = new ApacheHttpTransport() ; 
	
	GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, jsonFactory)
			// Specify the CLIENT_ID of the app that accesses the backend:
			.setAudience(Collections.singletonList(client_id))
			// Or, if multiple clients access the backend:
			//.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
			.build();
	
	//(Receive idTokenString by HTTPS POST)
 	String idTokenString = null;
    StringBuilder stringBuilder = new StringBuilder();
    BufferedReader bufferedReader = null;
    
    InputStream inputStream = request.getInputStream();
    bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
    char[] charBuffer = new char[128];
    int bytesRead = -1;
    while ((bytesRead = bufferedReader.read(charBuffer)) > 0) 
    {
         stringBuilder.append(charBuffer, 0, bytesRead);
    }
    idTokenString = stringBuilder.toString();
    
    
	GoogleIdToken idToken = verifier.verify(idTokenString);
	if (idToken != null) {
	Payload payload = idToken.getPayload();
	
	// Print user identifier
	String userId = payload.getSubject();
	System.out.println("User ID: " + userId);
	
	// Get profile information from payload
	String email = payload.getEmail();
	boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
	String name = (String) payload.get("name");
	String pictureUrl = (String) payload.get("picture");
	String locale = (String) payload.get("locale");
	String familyName = (String) payload.get("family_name");
	String givenName = (String) payload.get("given_name");
	}
%>

</body>
</html>