package com.smartvalue.html;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.smartvalue.apigee.configuration.ApigeeConfig;
import com.smartvalue.moj.clients.environments.JsonParser;

@WebListener
public class ApplicationContextListener implements ServletContextListener {

	
	public void contextInitialized(ServletContextEvent sce)
	{
		System.out.println("Web application is starting...");
		ServletContext sc = sce.getServletContext(); 
		java.io.InputStream inputStream = sc.getResourceAsStream("/WEB-INF/classes/config-web.json");
		JsonParser apigeeConfigParser = new JsonParser( ) ; 
		ApigeeConfig ac = null ; 
		try {
			ac = (ApigeeConfig) apigeeConfigParser.getObject(inputStream , ApigeeConfig.class) ;
			ac.setFileContent(apigeeConfigParser.getFileContent()) ; 
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ac.setInternetProxy(); 
		sc.setAttribute("appConfig", ac) ; 
	}
	
	public void contextDestroyed(ServletContextEvent sce) {
        // Code to be executed when the web application is about to be destroyed
		//super.contextDestroyed(sce);
		System.out.println("Web application is stopping...");
    }
	
}
