 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.rest.schema.ApigeeAccessToken"%>
 <%@page import ="com.smartvalue.apigee.resourceManager.*"%>
 <%@page import ="com.mashape.unirest.http.*"%>
 <%@page import ="com.auth0.jwt.exceptions.TokenExpiredException"%>
 
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@include file="intialize.jsp" %>
<br> 

Welcome <%=(mojEnv.getAccessToken()!= null)?  mojEnv.getAccessToken().getEnglishFirstName() : "Not Logged"%>
<br><a href="userProfile.jsp" target="Your Profile"> Your Profile</a>

<%
		
		String serviceBasePath ; 
		String serviceSuffix ;
		String serviceUrl ; 
		HttpResponse<String> serviceResponse = null ;
		String loginPage = "/ResourceManagerWeb/NajizLikeSampleApp/index.jsp" ;  

		%><h1>Proxy : Appointment </h1><%
		%><h2>Flow Name : GetPersonFutureAppointmentsCount </h2><%
		try { serviceResponse = mojEnv.getAppointmentService().GetMyFutureAppointmentsCount() ; }
		catch ( AccessTokenNotFound | TokenExpiredException t) {response.sendRedirect(loginPage) ; return ;  }
		out.print(Renderer.objectToHtmlTable(serviceResponse));
		%><h3><a href="Appointments/List.jsp" target="Your Appointments"> Manage Your Appointments</a></h3><%
		
		%><h1>Proxy : Exec-IntegrationServices </h1><%
		%><h2>Flow Name : PartyRequests </h2><%
		serviceBasePath = "/v1/exec-integrationapis/self-services" ; 
		serviceSuffix = "/api/Integration/PartyRequests/1/1/1006411456/1/1" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(Renderer.objectToHtmlTable(serviceResponse));
		

		%><h2>Flow Name : GetRequests </h2><%
		serviceBasePath = "/v1/exec-integrationapis" ; 
		//serviceSuffix = "/api/Integration/Request/CfDJ8GyQMJD4wvpOv8eHR-GWJd3ym6rINKdy1MTJVOGS9zVxg2ioDl-uhE9DFfqUR6KetSZCGi2VF6-5wH08fdN_58JE3cGY8Dmnc1XHbqXBNWOrBeT606DoDVOOqFnMa-MGiA" ; 
		serviceSuffix = "/api/Integration/Request/xxxxxxxxx" ;
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(Renderer.objectToHtmlTable(serviceResponse));
	
	
		%><h1>Proxy : Apigee-SC-Approval-Documents-API </h1><%
		%><h2>Flow Name : GetAllCompletedRequestsForExternal (IAM Protected) </h2><%
	
		serviceBasePath = "/v1/self-services/sc-approval-documents-api" ; 
		serviceSuffix = "/api/v1/Requests/GetAllCompletedRequestsForExternal" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(Renderer.objectToHtmlTable(serviceResponse));


		%><h1>Proxy : Taqadhi_ICMS_IAM </h1><%
		%><h2>Flow Name : api_my-sessions-range  </h2><%
	
		serviceBasePath = "/v1/taqadhi_icms_iam" ; 
		serviceSuffix = "/icms/api/my-sessions-range?DateFrom=2023-09-11&DateTo=2023-09-11" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(Renderer.objectToHtmlTable(serviceResponse));		
		
		%><h1>Proxy : NajizACLAttorney </h1><%
		%><h2>Flow Name : get-all-individual-attorneys </h2><%
	
		serviceBasePath = "/attorney-acl" ; 
		serviceSuffix = "/api/v1/individual-attorneys?PageSize=200&PageIndex=0&PartyTypeId=1" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(Renderer.objectToHtmlTable(serviceResponse)); 
		

%>



</body>
</html>