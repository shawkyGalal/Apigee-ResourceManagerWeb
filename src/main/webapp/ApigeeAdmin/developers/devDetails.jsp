<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<%@page import ="com.smartvalue.apigee.rest.schema.developer.Developer"%>
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Developer Details</title>
</head>
<body>
<%
		ManagementServer ms = (ManagementServer)session.getAttribute("ms"); 
		String org = request.getParameter("org") ; 		
		String developerId = request.getParameter("developerId") ;
		
		%> <br>Apigee Developer  <%=org %>/ <%=developerId %> Details <br> <br> <br> <%
			
		try {
				Developer developer  = ms.getOrgByName(org).getDeveloper(developerId) ;
				out.print(Renderer.objectToHtmlTable(developer)) ; 
			}
			catch ( Exception e) 
			{
				out.print ( "<br>Unable to Display Developer  "+developerId+" due to : " + e.getMessage() ) ; 
			}
		%> 
</body>
</html>