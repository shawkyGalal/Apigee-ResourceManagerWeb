package com.smartvalue.html;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.mashape.unirest.http.exceptions.UnirestException;
import com.smartvalue.apigee.resourceManager.ManagementServer;
import com.smartvalue.apigee.rest.schema.environment.Environment;

public class AppContext {
	
	public static HashMap<String , HashMap<String , Environment>> getStoredEnvs(ServletContext  application , ManagementServer ms ) throws UnirestException, IOException
	{
		
		HashMap<String , HashMap<String , Environment>> storedEnvs = ( HashMap<String , HashMap<String , Environment>> ) application.getAttribute("storedEnvs") ; 
		if (storedEnvs == null  )
		{
			storedEnvs= new HashMap<String , HashMap<String , Environment>> () ;
			for ( String orgName : ms.getAllOrgNames())
			{
				storedEnvs.put(orgName , ms.getOrgByName(orgName).getEnvs() ) ; 
			}
			application.setAttribute("storedEnvs", storedEnvs);
		}
		
		return storedEnvs ; 
	}
}
