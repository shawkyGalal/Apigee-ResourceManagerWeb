<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.Partner"%>
<%@page import="com.smartvalue.apigee.configuration.Customer"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>

<%@page import ="com.smartvalue.apigee.rest.schema.environment.Environment"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>

<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<%@page import ="java.util.*"%>
<%@page import ="java.io.InputStream"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<%@include file="../intialize.jsp" %>
<body>
<%
		String envName = request.getParameter("envName") ; 
		String orgName = request.getParameter("orgName") ;
		String operation = request.getParameter("operation") ;
		String envUniqueName =  orgName + "_"+ envName ; 
		
		Environment env ;
		HashMap<String , Environment> storedEnvs = ( HashMap<String , Environment> ) application.getAttribute("storedEnvs") ; 
		if (storedEnvs == null)
		{
			storedEnvs= new HashMap<String , Environment>() ; 
		}
			
		env = storedEnvs.get(envUniqueName); 
		if (env == null)
		{
			env = ms.getOrgByName(orgName).getEnvByName(envName) ;
			storedEnvs.put(envUniqueName, env) ;
			application.setAttribute("storedEnvs" , storedEnvs) ; 
		}
		
		if (operation.equalsIgnoreCase("start"))
		{		 
			env.startMonitoring(1) ;
		}
		else if (operation.equalsIgnoreCase("stop"))
		{
			env.stopMonitoring() ;
		}
 %>
	
</body>
</html>