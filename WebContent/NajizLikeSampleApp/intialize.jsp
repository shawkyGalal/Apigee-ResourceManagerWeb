
<%@page import ="java.util.*"%>
<%@page import ="java.io.InputStream"%>
<%@page import ="java.io.InputStream"%>
<%@page import ="com.smartvalue.moj.clients.environments.*"%>
<%@page import ="com.smartvalue.moj.clients.environments.Environment"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

Environment mojEnv = (Environment) session.getAttribute("mojEnv");
if (mojEnv == null)
{
	ServletContext serveletContext = request.getServletContext();
	InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/moj-environments.json");
	Environments mojEnvs = ClientEnvironmentsFactory.create(inputStream) ;
	mojEnv  =mojEnvs.getEnvByName("prod") ;
	session.setAttribute("mojEnv" , mojEnv );
}
		
%>
</body>
</html>