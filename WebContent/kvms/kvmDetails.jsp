<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import ="com.smartvalue.apigee.rest.schema.keyValueMap.KeyValueMap"%>
<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

		<%
		ManagementServer ms = (ManagementServer)session.getAttribute("ms"); 
		String org = request.getParameter("org") ; 		
		String env = request.getParameter("env") ;
		String kvm = request.getParameter("kvm") ;
		
		%> <br>Apigee KVM  (<%=org %>)/ <%=env %>/<%=kvm %> Details <br> <br> <br> <%
			
		try {
				KeyValueMap kvmObj  = ms.getKeyValueMapServices(org, env).getKvmDetails(kvm) ;
				out.print(Renderer.objectToHtmlTable(kvmObj)) ; 
			}
			catch ( Exception e) 
			{
				out.print ( "<br>Unable to Display KVM "+kvm+" due to : " + e.getMessage() ) ; 
			}
		%> 
</body>