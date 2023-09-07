<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.rest.schema.ApigeeAccessToken"%>
 <%@page import ="com.smartvalue.apigee.resourceManager.*"%>
 <%@page import ="com.mashape.unirest.http.*"%>
 
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@include file="intialize.jsp" %>
<%
	Renderer.objectToHtmlTable(mojEnv);
	
	//--1- Execution Services Proxy : "Exec-IntegrationServices" 
		//-- FlowName = "PartyRequests"---
		String serviceBasePath = "/v1/exec-integrationapis/self-services" ; 
		String serviceSuffix = "/api/Integration/PartyRequests/1/1/1006411456/1/1" ; 
		String serviceUrl = mojEnv.getUrl() + serviceBasePath + serviceSuffix ; 
		HttpResponse<String> serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(serviceResponse.getBody()) ;
		
		// --FlowName = "GetRequests"---
		serviceBasePath = "/v1/exec-integrationapis" ; 
		serviceSuffix = "/api/Integration/Request/CfDJ8GyQMJD4wvpOv8eHR-GWJd3ym6rINKdy1MTJVOGS9zVxg2ioDl-uhE9DFfqUR6KetSZCGi2VF6-5wH08fdN_58JE3cGY8Dmnc1XHbqXBNWOrBeT606DoDVOOqFnMa-MGiA" ; 
		serviceUrl = mojEnv.getUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(serviceResponse.getBody()) ;
	
	//--2- Execution Services Proxy : "Apigee-SC-Approval-Documents-API" 
		//-- FlowName = "GetAllCompletedRequestsForExternal (IAM Protected)"---
		serviceBasePath = "/v1/self-services/sc-approval-documents-api" ; 
		serviceSuffix = "/api/v1/Requests/GetAllCompletedRequestsForExternal" ; 
		serviceUrl = mojEnv.getUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(serviceResponse.getBody()) ;
	

%>
</body>
</html>