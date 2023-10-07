package com.smartvalue.html;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.mashape.unirest.http.exceptions.UnirestException;
import com.smartvalue.apigee.resourceManager.ManagementServer;
import com.smartvalue.apigee.rest.schema.environment.Environment;

public class AppContext {
	
	public static HashMap<String , HashMap<String , Environment>> getStoredEnvs(HttpServletRequest request , ServletContext  application , ManagementServer ms ) throws UnirestException, IOException
	{
		
		String envName = request.getParameter("envName") ; 
		String orgName = request.getParameter("orgName") ;
		
		Environment env ;
		HashMap<String , HashMap<String , Environment>> storedEnvs = ( HashMap<String , HashMap<String , Environment>> ) application.getAttribute("storedEnvs") ; 
		if (storedEnvs == null)
		{
			storedEnvs= new HashMap<String , HashMap<String , Environment>> () ; 
			storedEnvs.put(orgName , new HashMap<String , Environment> () ) ; 
		}
		
		if (storedEnvs.get(orgName) == null)
		{
			storedEnvs.put(orgName , new HashMap<String , Environment>()) ; 
		}
			
		env = storedEnvs.get(orgName).get(envName) ; 
		if (env == null)
		{
			env = ms.getOrgByName(orgName).getEnvByName(envName) ;
			storedEnvs.get(orgName).put(envName , env) ; 
			application.setAttribute("storedEnvs" , storedEnvs) ;  
		}
		return storedEnvs ; 
	}
}
