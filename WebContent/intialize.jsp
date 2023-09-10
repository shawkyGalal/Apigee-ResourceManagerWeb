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
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfigFactory"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
		Infra infra ; 
		HashMap<String , Organization > orgs ; 
		ManagementServer ms = (ManagementServer) session.getAttribute("ms") ;
		String xx = request.getParameter("refreshSessionInfo") ; 
		boolean refreshSessionInfo = xx != null && xx.equalsIgnoreCase("true") ; 
 		if (ms == null || refreshSessionInfo )
 		{
 			response.sendRedirect("infraSelector.jsp") ; 
 			
 		}
 		else 
 		{
 			infra = (Infra) session.getAttribute("infra") ;
 			orgs = (HashMap<String , Organization>) session.getAttribute("orgs") ;
 		}
		
%>