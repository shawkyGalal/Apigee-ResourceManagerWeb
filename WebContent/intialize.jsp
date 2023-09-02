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
		Infra infra ; 
		HashMap<String , Organization > orgs ; 
		ManagementServer ms = (ManagementServer) session.getAttribute("ms") ;
		String xx = request.getParameter("refreshSessionInfo") ; 
		boolean refreshSessionInfo = xx != null && xx.equalsIgnoreCase("true") ; 
 		if (ms == null || refreshSessionInfo )
 		{
			ServletContext serveletContext = request.getServletContext();
			InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");
			ApigeeConfig ac = new ApigeeConfig(inputStream);
			String partnerSelect = request.getParameter("partnerSelect") ; 
			String customerSelect = request.getParameter("customerSelect")  ;
			String infraSelect = request.getParameter("infraSelect") ;
			Partner partnr =  (Partner) ac.getPartnerByName(partnerSelect) ; 
			Customer customer = partnr.getCustomerByName(customerSelect) ; 
			infra = customer.getInfraByName(infraSelect) ; //.getInfra("MasterWorks" , "MOJ" , infraName) ;
			ms = new ManagementServer(infra) ;
			orgs = ms.getOrgs() ;
			//HashMap<String , Object > userSessionVars = new HashMap() ; 
			//userSessionVars.put("ms" , ms) ; 
			session.setAttribute("ms", ms) ;
			session.setAttribute("infra", infra) ;
			session.setAttribute("orgs", orgs) ;
 		}
 		else 
 		{
 			infra = (Infra) session.getAttribute("infra") ;
 			orgs = (HashMap<String , Organization>) session.getAttribute("orgs") ;
 		}
		
%>
</body>
</html>