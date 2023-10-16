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
<%@include file="intialize.jsp" %>
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
		//out.print(Renderer.objectToHtmlTable(serviceResponse));
		HashMap<String, Object>  appointments = gson.fromJson(serviceResponse.getBody(), HashMap.class);
		ArrayList<Object> requests = (ArrayList) appointments.get("requests") ; 
		out.print(Renderer.generateArrayHtmlTable(requests));
		
		for (Object req : requests)
		{
			out.print("<tr>"); 
			LinkedTreeMap <String , String> ReqMap = (LinkedTreeMap) req ;
			out.print(Renderer.hashMaptoHtmlTable(ReqMap));
		}
		
		 %>
		<br><br><br>
		
		======================================================
		
		 
		<h1> Add a New Appointment <h1>
		<h2>Flow Name : GetRegions </h2>
		<%
		serviceBasePath = "/v1/appointment-mobile" ;  
		serviceSuffix = "/api/lookups/regions" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		//out.print(Renderer.objectToHtmlTable(serviceResponse));
		ArrayList<Object>  responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
		%>
		<select id="Region">
		<% 
		for (Object region:  responseBody )
			{
				LinkedTreeMap<String , Object> regionMap = (LinkedTreeMap<String , Object>)region ;  
				String regionName = (String)regionMap.get("name") ;
				Double regionId = (Double)regionMap.get("id") ;
				out.print("<option id ="+regionId+">" + regionName + "</option>" ) ; 
			}
		%>
		</select>
		
		<h2>Flow Name : GetSites  </h2><%
		
		serviceSuffix = "/api/lookups/regions/12/sites" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		//out.print(Renderer.objectToHtmlTable(serviceResponse)); 
		responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
		%>
		<select id="site">
		<% 
		for (Object site:  responseBody )
			{
				LinkedTreeMap<String , Object> siteMap = (LinkedTreeMap<String , Object>)site ;  
				String siteName = (String)siteMap.get("name") ;
				Double siteId = (Double)siteMap.get("id") ;
				out.print("<option id = "+siteId+">" + siteName + "</option>" ) ; 
			}
		%>
		</select>
		
		<h2>Flow Name : Departments  </h2><%
		serviceSuffix = "/api/lookups/sites/245/departments" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		//out.print(Renderer.objectToHtmlTable(serviceResponse)); 
		responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
		%>
		<select id="department">
		<% 
		for (Object dept:  responseBody )
			{
				LinkedTreeMap<String , Object> deptMap = (LinkedTreeMap<String , Object>)dept ;  
				String deptName = (String)deptMap.get("name") ;
				Double deptId = (Double) deptMap.get("id") ;
				out.print("<option id = "+deptId+">" + deptName + "</option>" ) ;  
			}
		%>
		</select>
		

		<h2>Flow Name : GetServices  </h2><%
		serviceSuffix = "/api/lookups/departments/349/services" ; 
		serviceUrl = mojEnv.getMojServicesBaseUrl() + serviceBasePath + serviceSuffix ; 
		serviceResponse = mojEnv.executeRequest( serviceUrl , null, "GET", "") ; 
		responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
		%>
		<select>
			<% 
			for (Object service:  responseBody )
				{
					LinkedTreeMap<String , Object> serviceMap = (LinkedTreeMap<String , Object>)service ;  
					String serviceName = (String)serviceMap.get("name") ;
					Double serviceId = (Double)serviceMap.get("id") ;
					out.print("<option  id = "+serviceId+">" + serviceName + "</option>" ) ; 
				}
			%>
		</select>
	</form>

</body>
</html>