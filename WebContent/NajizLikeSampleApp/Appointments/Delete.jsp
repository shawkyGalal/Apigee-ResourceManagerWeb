 <%@page import ="com.smartvalue.moj.clients.environments.*"%>
 <%@page import ="com.smartvalue.moj.clients.environments.Environment"%>
 <%@page import ="com.smartvalue.apigee.resourceManager.*"%>
 <%@page import ="com.mashape.unirest.http.*"%>
 <%@page import ="com.auth0.jwt.exceptions.TokenExpiredException"%>
 
 
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>
<%@include file="../intialize.jsp" %>

<%		
	HttpResponse<String> serviceResponse = null ; 
	String protectedId = request.getParameter("protectedId") ; 
	try { serviceResponse = mojEnv.getAppointmentService().deleteRequest(protectedId); }
	catch ( AccessTokenNotFound | TokenExpiredException t) {response.sendRedirect("/ResourceManagerWeb/NajizLikeSampleApp/index.jsp") ; return ;  }
	out.print(Renderer.objectToHtmlTable(serviceResponse));
%>

</body>
</html>