

<%@page import ="com.smartvalue.apigee.rest.schema.application.Application"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>
<%@page import ="com.smartvalue.apigee.rest.schema.product.ProductsServices"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.Proxy"%>
<%@page import ="com.smartvalue.apigee.rest.schema.developer.Developer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.Postgres"%>

<%@page import ="com.smartvalue.apigee.rest.schema.TargetServer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.virtualHost.VirtualHost"%>
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
<body>
<%@include file="../../intialize.jsp" %>

		<br>Apigee Infrastructure (<%=infra.getName() %>) <br> <br> <br> 
		<%
			String deployedRevisionOnly = request.getParameter("deployedRevisionOnly") ; 
			String targetServer = request.getParameter("targetServer") ;
			String org = request.getParameter("org") ;
			Organization orgObj = (Organization) ms.getOrgByName(org) ;  
			HashMap<String, Object> proxies = orgObj.getAllProxiesUsesTargetServer(targetServer , deployedRevisionOnly.equals("true")); 
			
		%> 
		</body>
</html>