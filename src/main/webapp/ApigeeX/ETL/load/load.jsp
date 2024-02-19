<%@page import="com.smartvalue.html.AppContext"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.*"%>
<%@page import ="com.smartvalue.moj.clients.environments.JsonParser"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.Infra"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import ="com.smartvalue.apigee.configuration.AppConfig"%>
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
AppConfig ac = AppContext.getAppConfig(application);

//----- ETL Starting Loading ----
Infra destInfra = ac.getInfra("MasterWorks" , "MOJ" , "Gcloud(shawky.foda@gmail.com)") ;
String destOrgName = "moj-prod-apigee" ; 
String transformedFolder = "C:\\temp\\transformed\\proxies" ; 

ManagementServer destMs = destInfra.getManagementServer(destInfra.getRegions().get(0).getName()) ;
ProxyServices proxiesServices = (ProxyServices)destMs.getProxyServices(destOrgName); 
GoogleProxiesList proxiesList= proxiesServices.getAllProxiesList(GoogleProxiesList.class); 
proxiesServices.deleteAll(proxiesList) ;

proxiesServices.setDeployUponUpload(false); 
proxiesServices.importAll(transformedFolder) ;
%>
</body>
</html>