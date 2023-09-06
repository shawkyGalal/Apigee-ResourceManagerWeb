<%@ page language="java" contentType="application/json; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfigFactory"%>
<%@page import="com.smartvalue.apigee.configuration.Partner"%>
<%@page import="com.smartvalue.apigee.configuration.Customer"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>
<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<%@page import ="java.io.InputStream"%>
<%@page import ="java.util.*"%>
<%@page import ="com.google.gson.Gson"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>
<%@page import ="com.smartvalue.apigee.rest.schema.environment.Environment"%>
 
<% 	ServletContext serveletContext = request.getServletContext();
	InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");
	ApigeeConfig ac = ApigeeConfigFactory.create(inputStream) ;
	
	HashMap<String , String > atts = (HashMap<String , String >) request.getAttribute("atts");
	
	String partner = atts.get("partner") ; //(String) request.getAttribute("partner");
	String customer = atts.get("customer") ; //(String) request.getAttribute("customer");
	String infra = atts.get("infra") ; //(String) request.getAttribute("infra");
	String org = atts.get("org") ;// (String) request.getAttribute("org");
	String env = atts.get("env") ; //(String) request.getAttribute("env");
	String kvm = atts.get("kvm") ; //(String) request.getAttribute("env");
	String targetServer =  atts.get("targetServer") ;
	
	Partner partnerObj =  ac.getPartnerByName(partner) ; 
	Customer customerObj = partnerObj.getCustomerByName(customer) ; 
	Infra infraObj = customerObj.getInfraByName(infra) ; //.getInfra("MasterWorks" , "MOJ" , infraName) ;
	ManagementServer ms = new ManagementServer(infraObj) ;
	Gson gson = new Gson() ;
	if (org== null && env == null )
	{	// -- Display Orgs List 
		String[] orgs = ms.getAllOrgNames() ;
		out.print(gson.toJson(orgs).trim()) ;
	}
	
	else if (org != null &&  ! atts.keySet().contains("env") )
	{
		//-- Org Details 
		Organization orgObj = ms.getOrgByName(org) ; 
		out.print(gson.toJson(orgObj).trim() ) ;
	}
	
	else if (atts.keySet().contains("kvm") && kvm == null)
	{
		//-- KVM List 
		out.print(gson.toJson ( ms.getOrgByName(org).getEnvByName(env).getAllKvmNames())) ; 
	} 
	
	else if (atts.keySet().contains("kvm") && kvm != null)
	{
		//-- KVM Details 
		out.print(gson.toJson ( ms.getOrgByName(org).getEnvByName(env).getKvm(kvm))) ; 
	} 
	else if (atts.keySet().contains("targetServer") && targetServer == null)
	{
		//-- targetServer List 
		out.print(gson.toJson ( ms.getOrgByName(org).getEnvByName(env).getTargetServers())) ; 
	} 
	
	else if (atts.keySet().contains("targetServer") && targetServer != null)
	{
		//-- targetServer Details 
		out.print(gson.toJson ( ms.getOrgByName(org).getEnvByName(env).getTargetServer(targetServer))) ; 
	} 
	
	else if (org != null &&  atts.keySet().contains("env") && env == null )
	{
		// -- Display environments list for the given org 
		List<String> envs = ms.getOrgByName(org).getEnvironments(); 
		out.print(gson.toJson(envs).trim()) ;
		 
	}
	
	else if (org != null &&  atts.keySet().contains("env") && env != null )
	{
		// -- Display Env Details  
		Environment  envObj = ms.getOrgByName(org).getEnvByName(env) ; 
		out.print(gson.toJson(envObj).trim() ) ; 
		 
	}
	
	
%>
