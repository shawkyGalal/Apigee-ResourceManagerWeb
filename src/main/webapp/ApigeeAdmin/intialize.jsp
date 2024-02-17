
<%@page import ="com.smartvalue.apigee.configuration.infra.ManagementServer"%>
<%@page import ="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
		ManagementServer ms = (ManagementServer) session.getAttribute("ms") ;
		String xx = request.getParameter("refreshSessionInfo") ; 
		boolean refreshSessionInfo = xx != null && xx.equalsIgnoreCase("true") ; 
 		if (ms == null || refreshSessionInfo )
 		{
 			response.sendRedirect("/infraSelector.jsp") ; 
 			
 		}
		
%>