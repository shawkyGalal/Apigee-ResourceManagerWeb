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
	HashMap<String , HashMap<String , Environment>> storedEnvs = AppContext.getStoredEnvs(request, application) ; 
		String envName = request.getParameter("envName") ; 
		String orgName = request.getParameter("orgName") ;
		Environment env = storedEnvs.get(orgName).get(envName) ;  
		
		
		
		String operation = request.getParameter("operation") ;
		if (operation.equalsIgnoreCase("start"))
		{		 
	env.startMonitoring(1) ;
	out.print("Monitoring "+envUniqueName+" Successfully Started"); 
		}
		else if (operation.equalsIgnoreCase("stop"))
		{
	env.stopMonitoring() ;
	out.print("Monitoring "+envUniqueName+" Successfully Stoped");
		}
%>
 
	
</body>
</html>