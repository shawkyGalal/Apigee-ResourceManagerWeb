<%@page import ="com.smartvalue.apigee.rest.schema.proxy.ProxyServices"%>

<%@page import ="com.smartvalue.apigee.rest.schema.proxy.transformers.BundleUploadTransformer"%>
<%@page import ="com.smartvalue.moj.clients.environments.JsonParser"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.Infra"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import ="com.smartvalue.apigee.configuration.ApigeeConfig"%>

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

JsonParser apigeeConfigParser = new JsonParser( ) ;
ApigeeConfig ac = apigeeConfigParser.getObject("config.json" , ApigeeConfig.class) ; 

//----- ETL Starting Extraction ----  
Infra sourceInfra = ac.getInfra("MasterWorks" , "MOJ" , "Stage") ;
String sourceOrgName = "stg" ; 
ManagementServer sourceMs = sourceInfra.getManagementServer(sourceInfra.getRegions().get(0).getName()) ;
ProxyServices sourceProxiesServices = sourceMs.getProxyServices(sourceOrgName);
String exportFolder = "C:\\temp\\proxies" ;
sourceProxiesServices.exportAllProxies(exportFolder) ;




%>
</body>
</html>