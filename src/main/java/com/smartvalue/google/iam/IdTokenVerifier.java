package com.smartvalue.google.iam;

import com.google.api.client.json.jackson2.JacksonFactory; 
import com.google.api.client.http.javanet.NetHttpTransport ; 


import com.google.api.client.http.HttpTransport ; 
import com.google.api.client.json.gson.GsonFactory ; 
import java.util.Collections ;

import javax.servlet.http.HttpServletRequest;

import java.io.InputStreamReader ;
import java.security.GeneralSecurityException;
import java.io.InputStream ; 
import java.io.BufferedReader ;
import java.io.IOException;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken ; 
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload ; 
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier ; 

public class IdTokenVerifier {
	
	public static GoogleIdToken verifyFromRequest(String m_client_id , HttpServletRequest request  ) throws IOException, GeneralSecurityException
	{
		// String client_id= "743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com" ;  
		com.google.api.client.json.JsonFactory jsonFactory = new GsonFactory(); 
		HttpTransport httpTransport = new NetHttpTransport() ;
	
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, new JacksonFactory())
				// Specify the CLIENT_ID of the app that accesses the backend:
				.setAudience(Collections.singletonList(m_client_id))
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
	    int equalIndex = idTokenString.indexOf("=");  
	    idTokenString = idTokenString.substring(equalIndex+1); 
	    String idTokenStringOnly= idTokenString.split("&g_csrf_token")[0]; 
	    String gCsrfToken = idTokenString.split("&g_csrf_token")[1]; 
	    
	    
		GoogleIdToken idToken = verifier.verify(idTokenStringOnly);
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
		return idToken ; 
	}
	public static boolean verifyTimingOnly(GoogleIdToken googleIdToken )
	{
		boolean result = true; 
		com.google.api.client.json.JsonFactory jsonFactory = new GsonFactory(); 
		HttpTransport httpTransport = new NetHttpTransport() ;
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, new JacksonFactory())
				// Specify the CLIENT_ID of the app that accesses the backend:
				//.setAudience(Collections.singletonList(m_client_id))
				// Or, if multiple clients access the backend:
				//.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
				.build();
		
		com.google.api.client.auth.openidconnect.IdTokenVerifier basicVerifier =  (com.google.api.client.auth.openidconnect.IdTokenVerifier) verifier ;
		
		result = basicVerifier.verify(googleIdToken) ;
		 
		return result ; 
		
	}
}
