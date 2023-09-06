<%@page import="com.smartvalue.apigee.configuration.ApigeeConfigFactory"%>
<%@ page language="java" contentType="application/json; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.Partner"%>
<%@page import="com.smartvalue.apigee.configuration.Customer"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>
<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<%@page import ="java.io.InputStream"%>
<%@page import ="com.google.gson.Gson"%>
<% 	ServletContext serveletContext = request.getServletContext();
	InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");
	ApigeeConfig ac = ApigeeConfigFactory.create(inputStream) ;
	String partner = (String) request.getAttribute("partner");
	String customer = (String) request.getAttribute("customer");
	String infra = (String) request.getAttribute("infra");
	String org = (String) request.getAttribute("org");
	String env = (String) request.getAttribute("env");
	
	Partner partnerObj =  ac.getPartnerByName(partner) ; 
	Customer customerObj = partnerObj.getCustomerByName(customer) ; 
	Infra infraObj = customerObj.getInfraByName(infra) ; //.getInfra("MasterWorks" , "MOJ" , infraName) ;
	ManagementServer ms = new ManagementServer(infraObj) ;
	if (org== null && env == null )
	{	
		String[] orgs = ms.getAllOrgNames() ;
		Gson gson = new Gson() ;
		out.print(gson.toJson(orgs).trim()) ;
	}
	
	if (org != null &&  env == null )
	{
		// -- Display Org Details 
	}
	
	if (org != null &&  env != null )
	{
		// -- Display environments list for the given org 
	}
%>
