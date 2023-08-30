<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.Partner"%>
<%@page import="com.smartvalue.apigee.configuration.Customer"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>

<%@page import ="com.smartvalue.apigee.rest.schema.application.Application"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>
<%@page import ="com.smartvalue.apigee.rest.schema.product.ProductsServices"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.Proxy"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.MPServer"%>
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
<%
		ServletContext serveletContext = request.getServletContext();
		InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");
		ApigeeConfig ac = new ApigeeConfig(inputStream);
		int partnerSelect = Integer.parseInt(request.getParameter("partnerSelect")) ; 
		int customerSelect = Integer.parseInt( request.getParameter("customerSelect"))  ;
		int infraSelect = Integer.parseInt(request.getParameter("infraSelect")) ;
		Partner partnr =  (Partner) ac.getPartners().get(partnerSelect) ; 
		Customer customer = partnr.getCustomers().get(customerSelect) ; 
		Infra infra = customer.getInfras().get(infraSelect) ; //.getInfra("MasterWorks" , "MOJ" , infraName) ;
		ManagementServer ms = new ManagementServer(infra) ; 
		HashMap<String , Organization > orgs = ms.getOrgs() ;
%>
</body>
</html>