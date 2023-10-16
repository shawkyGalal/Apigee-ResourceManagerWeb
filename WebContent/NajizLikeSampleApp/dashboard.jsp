 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.rest.schema.ApigeeAccessToken"%>
 <%@page import ="com.smartvalue.apigee.resourceManager.*"%>
 <%@page import ="com.mashape.unirest.http.*"%>
 
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@include file="intialize.jsp" %>
<br> 
<a href="Appointments.jsp" target="Your Appointments"> Manage Your Appointments</a>
<%
		
		out.print(Renderer.objectToHtmlTable(mojEnv.getAccessToken()));
	
	
		%><h1>Proxy : Exec-IntegrationServices </h1><%
		%><h2>Flow Name : PartyRequests </h2><%
		String serviceBasePath = "/v1/exec-integrationapis/self-services" ; 
		String serviceSuffix = "/api/Integration/PartyRequests/1/1/1006411456/1/1" ; 
		String serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		HttpResponse<String> serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
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

		
		%><h1>Proxy : Taqadhi_ICMS </h1><%
		%><h2>Flow Name : empty : ( Cases List ) </h2><%
	
		serviceBasePath = "/self-services/taqadhi_icms" ; 
		serviceSuffix = "/icms/api/my-cases?pageSize=10&pageIndex=0" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		HashMap<String , String> headers =new HashMap<String , String> () ; 
		//headers.put("")
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		out.print(Renderer.objectToHtmlTable(serviceResponse));
		

		%><h1>Proxy : Taqadhi_ICMS</h1><%
		%><h2>Flow Name : empty (Case Details) </h2><%
	
		serviceBasePath = "/self-services/taqadhi_icms" ; 
		serviceSuffix = "/icms/icms/api/cases/1a18ef54-16fc-4438-b4bb-b8edb318358b" ; 
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