 <%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
<%@page import="com.google.gson.Gson"%>
 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
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
<form action="">

	<%
	Gson gson = new Gson();
	HttpResponse<String> serviceResponse = null ; 
	%>
		 
	<h1> Add a New Appointment </h1>
	== Not Yet Completed ==  
	
	<h2>Flow Name : GetRegions </h2>
	<%
	try {
	serviceResponse = mojEnv.getAppointmentService().getRegions();
	ArrayList<Object>  responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
	%>
	<select id="region" name = "region">
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
	<h2>Flow Name : GetSites  </h2>
	<%
		serviceResponse = mojEnv.getAppointmentService().getSites(12);
		responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
	%>
	<select id="site" name = "site">
	<% 
	for (Object site:  responseBody )
		{
			LinkedTreeMap<String , Object> sitesMap = (LinkedTreeMap<String , Object>)site ;  
			String siteName = (String)sitesMap.get("name") ;
			Double siteId = (Double)sitesMap.get("id") ;
			out.print("<option id = "+siteId+">" + siteName + "</option>" ) ; 
		}
	%>
	</select>
		
	<h2>Flow Name : Departments  </h2><%
		 
	serviceResponse = mojEnv.getAppointmentService().getDepartments(245);
	responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
	%>
	<select id="department" name = "department" >
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
		serviceResponse = mojEnv.getAppointmentService().getServices(349);
		responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
	%>
	<select id = "service" name = "service">
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
		
	
	<h2>Flow Name : Get Available Appointments Times </h2>
	<%
		serviceResponse = mojEnv.getAppointmentService().getAvailableAppointments(322, 36);
		responseBody = gson.fromJson(serviceResponse.getBody(), ArrayList.class); 
		out.print( Renderer.generateArrayHtmlTable(responseBody)) ; 
	
	} catch ( AccessTokenNotFound | TokenExpiredException t) {response.sendRedirect("/ResourceManagerWeb/NajizLikeSampleApp/index.jsp") ; return ;  }
	%>
	
	<br> <br>
		<input type="submit"  name="حجز موعد" id="submit" />
	</form>

</body>
</html>