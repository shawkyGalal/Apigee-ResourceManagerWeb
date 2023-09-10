<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<a href = "InfraSelector.jsp">Select Apigee Infrastructure </a>
	<% ManagementServer ms = (ManagementServer) session.getAttribute("ms") ;  
		if (ms != null) out.print ("Current Infra Name : " + ms.getInfraName() ) ;  
	%>
	<h1> Apigee Operational Tasks </h1>
	<table border = 1>
		<tr><td><a href = "products/products.jsp" target = "products" >Products </a></td></tr>
		<tr><td><a href = "developers/developers.jsp" target = "developers">Developers  </a></td></tr>
		<tr><td><a href = "apps/apps.jsp" target = "applications">Applications  </a></td></tr>
		<tr><td><a href = "kvms/kvms.jsp" target = "kvms">Key value Maps  </a></td></tr>
	
	</table>
	
	<h1> Special Queries </h1>
	<table border = 1>
		<tr><td><a href = "specialQueries/proxiesUsingTargetServer/InfraSelector.jsp" target = "listProxiesUsingTargetServer" >listProxiesUsingTargetServer </a></td></tr>
		<tr><td><a href = "specialQueries/listProxiesNotDeployed/InfraSelector.jsp" target = "listProxiesNotDeployed">listProxiesNotDeployed  </a></td></tr>
		<tr><td><a href = "specialQueries/productsWithoutProxies/InfraSelector.jsp" target = "productsWithoutProxies">productsWithoutProxies  </a></td></tr>
		<tr><td><a href = "specialQueries/ProxiesWithoutPolices/InfraSelector.jsp" target = "ProxiesWithoutPolices">ProxiesWithoutPolices  </a></td></tr>
		<tr><td><a href = "specialQueries/ProxiesWithoutPolices/InfraSelector.jsp" target = "ProxiesWithoutPolices">ProxiesWithoutPolices  </a></td></tr>
	
	</table>
	
	
	<h1> Apigee Administration Tasks </h1>
	<table border = 1>
		<tr><td><a href = "messageProcessor/MessageProcessors.jsp"  target = "messageProcessors">message Processors  </a></td></tr>
		<tr><td><a href = "routers/routers.jsp"  target = "routers">Routers </a></td></tr>
	</table>
	
	<h1> REST Services </h1>
	<table border = 1>
		<tr><td><a href = "rest/v1/o/smart-value/apis"  target = "Rest Services ">REST Services  </a></td></tr>
	</table>
	
	<h1> Najiz Like Sample Application  </h1>
	
	<%@include file="NajizLikeSampleApp/intialize.jsp" %>
	<%
		String authURL = mojEnv.getUrlBuilder()
									.withForthAuth(false)
									.withResponseType("code")
									.withScope("openid")
									.buildAuthorizationURL();
		
	%>
	<a href = <%=authURL%> Target = "NajizLikeApp" >Login Using Nafath Mowahad </a>
	
</body>
</html>