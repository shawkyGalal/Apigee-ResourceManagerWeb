package com.smartvalue.html;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;


import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.smartvalue.apigee.configuration.AppConfig;

public class AppContext {
 public static final String APP_CONFIG_VAR_NAME = "appConfig" ; 
 public static final String GOOGLE_ID_TOKEN_VAR_NAME = "GoogleIdToken" ;
 
 public static AppConfig getAppConfig(ServletContext sc)
 {
	 return (AppConfig) sc.getAttribute(APP_CONFIG_VAR_NAME) ; 
 }
 

 public static GoogleIdToken getGoogleIdToken(HttpSession  session)
 {
	 return (GoogleIdToken) session.getAttribute(GOOGLE_ID_TOKEN_VAR_NAME) ; 
 }
 
 public static void googleIdTokenLogoff(HttpSession  session)
 {
	 session.setAttribute(GOOGLE_ID_TOKEN_VAR_NAME , null) ; 
 }

 
}
