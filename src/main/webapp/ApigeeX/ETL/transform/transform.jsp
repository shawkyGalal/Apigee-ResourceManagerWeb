<%@page import="com.smartvalue.apigee.rest.schema.ApigeeService"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.*"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.transformers.*"%>
<%@page import ="com.smartvalue.moj.clients.environments.JsonParser"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.Infra"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import ="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.google.auto.GoogleProxiesList"%>
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
<%
	ServletContext serveletContext = request.getServletContext();
InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");

JsonParser apigeeConfigParser = new JsonParser( ) ;
ApigeeConfig ac = apigeeConfigParser.getObject(inputStream , ApigeeConfig.class) ;

//----- ETL Starting Transforming ----
Infra sourceInfra = ac.getInfra("MasterWorks" , "MOJ" , "Stage") ;
String sourceOrgName = "stg" ; 
String transformedFolder = "C:\\temp\\transformed\\proxies" ; 

ManagementServer sourceMs = sourceInfra.getManagementServer(sourceInfra.getRegions().get(0).getName()) ;
ApigeeService sourceProxiesServices = sourceMs.getProxyServices(sourceOrgName);

//sourceProxiesServices.transformAllProxies(exportFolder, transformedFolder);
%>
</body>
</html>