 <%@page import="com.google.gson.Gson"%>
 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.rest.schema.ApigeeAccessToken"%>
 <%@page import ="com.smartvalue.apigee.resourceManager.*"%>
 <%@page import ="com.mashape.unirest.http.*"%>
 <%@page import ="com.google.gson.internal.LinkedTreeMap"%>
 <%@page import ="com.auth0.jwt.exceptions.TokenExpiredException"%>
 <%@page import ="com.smartvalue.moj.najiz.services.appointments.auto.*"%>
 
 
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>
<%@include file="../intialize.jsp" %>
<form action="">

<%
		Gson gson = new Gson();
		String serviceBasePath ; 
		String serviceSuffix ;
		String serviceUrl ; 
		HttpResponse<String> serviceResponse = null ; 
		
		%><h1>Proxy : Appointment </h1><%
		%><h2>Flow Name : GetPersonFutureAppointmentsCount </h2><%
		serviceBasePath = "/v1/self-services/appointment-mobile" ;
		serviceSuffix = "/api/people/xxxxx/appointments-count" ; //  service will automatically replace xxxx with the logged in user id from the accesstoken  
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		try { serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; } 
		catch ( AccessTokenNotFound | TokenExpiredException t) {response.sendRedirect("/ResourceManagerWeb/NajizLikeSampleApp/index.jsp") ; return ;  }
		out.print(Renderer.objectToHtmlTable(serviceResponse));
		%>
		
		<h1> List My Appointments <h1>
		<h2>Flow Name : GetPersonFutureAppointments </h2>
	<%
		serviceBasePath = "/v1/self-services/appointment-mobile" ;  
		serviceSuffix = "/api/people/$userId/appointments?includeRequests=True" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		Appointments appointments = gson.fromJson(serviceResponse.getBody() , Appointments.class) ;
		%><li>Your Appointments Requests</li><%
		for (Request reqx : appointments.getRequests() )
		{
			out.print(Renderer.objectToHtmlTable(reqx));
			out.print("<a href = 'Delete.jsp?protectedId="+reqx.getProtectedId()+"' >Delete </a>") ; 
		}
		// out.print(Renderer.arrayListToHtmlTable(appointments.getRequests()));
		%><li>Your Appointments</li><%
		out.print(Renderer.arrayListToHtmlTable(appointments.getAppointments()));
		
	 %>
	 <br>
	 <a href="Create.jsp">New Appointment Request</a>

</body>
</html>