 <%@page import="com.google.gson.Gson"%>
 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.rest.schema.ApigeeAccessToken"%>
 <%@page import ="com.smartvalue.apigee.resourceManager.*"%>
 <%@page import ="com.mashape.unirest.http.*"%>
 <%@page import ="com.google.gson.internal.LinkedTreeMap"%>
 <%@page import ="com.auth0.jwt.exceptions.TokenExpiredException"%>
 
 
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>
<%@include file="../intialize.jsp" %>

<%
		Gson gson = new Gson();
		String serviceBasePath ; 
		String serviceSuffix ;
		String serviceUrl ; 
		String protectedId = request.getParameter("protectedId") ; 
		HttpResponse<String> serviceResponse = null ; 
		
		%><h1>Proxy : Appointment </h1><%
		%><h2>Flow Name : Delete Appointment POST </h2><%
		serviceBasePath = "/v1/self-services/appointment-mobile" ;
		serviceSuffix = "/api/people/xxxx/appointments/"+protectedId ; //  service will automatically replace xxxx with the logged in user id from the accesstoken  
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		try { serviceResponse = mojEnv.executeRequest( serviceUrl , null, "POST", "") ; } 
		catch ( AccessTokenNotFound | TokenExpiredException t) {response.sendRedirect("/ResourceManagerWeb/NajizLikeSampleApp/index.jsp") ; return ;  }
		out.print(Renderer.objectToHtmlTable(serviceResponse));
		%>
		
		

</body>
</html>