<%@page import ="com.smartvalue.apigee.rest.schema.proxy.*"%>
<%@page import ="com.smartvalue.moj.clients.environments.JsonParser"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.Infra"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import ="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.google.auto.GoogleProxiesList"%>


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

//----- ETL Starting Loading ----
Infra destInfra = ac.getInfra("MasterWorks" , "MOJ" , "Gcloud(shawky.foda@gmail.com)") ;
String destOrgName = "apigee-moj-stage" ; 
String transformedFolder = "C:\\temp\\transformed\\proxies" ; 

ManagementServer destMs = destInfra.getManagementServer(destInfra.getRegions().get(0).getName()) ;
ProxyServices proxiesServices = destMs.getProxyServices(destOrgName); 
GoogleProxiesList proxiesList= proxiesServices.getAllProxiesList(GoogleProxiesList.class); 
proxiesServices.deleteAllProxies(proxiesList) ;
ProxyFilter pf = new AllpassProxyFilter(); 
proxiesServices.setProxyFilter(pf);
proxiesServices.importAllProxies(transformedFolder, false ) ;



%>
</body>
</html>