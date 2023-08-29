<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.Partner"%>
<%@page import="com.smartvalue.apigee.configuration.Customer"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>

<%@page import ="com.smartvalue.apigee.rest.schema.environment.Environment"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>
<%@page import ="com.smartvalue.apigee.rest.schema.product.ProductsServices"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.Proxy"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.MPServer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.Postgres"%>

<%@page import ="com.smartvalue.apigee.rest.schema.TargetServer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.virtualHost.VirtualHost"%>
<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>


<%@page import ="java.util.*"%>
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
	ApigeeConfig ac = new ApigeeConfig("E:\\MasterWorks\\Eclipse-WS\\ResourceManagerWeb\\WebContent\\config.json" ) ; 

		out.print(request.getParameter("partnerSelect")) ; 
		int partnerSelect = Integer.parseInt(request.getParameter("partnerSelect")) ; 
		int customerSelect = Integer.parseInt( request.getParameter("customerSelect"))  ;
		int infraSelect = Integer.parseInt(request.getParameter("infraSelect")) ;
		
		Partner partnr =  (Partner) ac.getPartners().get(partnerSelect) ; 
		Customer customer = partnr.getCustomers().get(customerSelect) ; 
		Infra infra = customer.getInfras().get(infraSelect) ; //.getInfra("MasterWorks" , "MOJ" , infraName) ;
		 
			
		ManagementServer ms = new ManagementServer(infra) ; 
		
		HashMap<String , Organization > orgs = ms.getOrgs() ;
		
		%> <br>Apigee Infrastructure (<%=infra.getName() %>) <br> <br> <br> <%
		for ( String orgName : orgs.keySet())
		{ 
			out.print ("<br>Developers for Organization " + orgName ) ; 
			try {
			Organization org = orgs.get(orgName) ;  
			List<String> envs = org.getEnvironments(); 
			ArrayList<String> developers = org.getDeveloperNames() ; 
			out.print(Renderer.arrayListToHtmlTable(developers)) ;
			}
			catch ( Exception e) 
			{
				out.print ( "<br>Unable to Display Organization developers due to : " + e.getMessage() ) ; 
			}
		}
		%> 
		</body>
</html>