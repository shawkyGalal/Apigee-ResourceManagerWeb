<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<%@include file="../intialize.jsp" %>
<% 	
	String input = (String) request.getAttribute("pathInfo");
	com.mashape.unirest.http.HttpResponse<String> userResponse = ms.getGetHttpResponse(input) ;
	out.print(userResponse.getBody().trim()) ; 
%>
