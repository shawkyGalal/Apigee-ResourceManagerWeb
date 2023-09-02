
<%@page import ="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h2>Select Apigee Infrastructure to Display Applications registered within All Organizations </h2> 
<br> 

    
<jsp:include page="../../InfraSelector.jsp" >
  <jsp:param name="targetPage" value="appsResult.jsp" />
</jsp:include>
 
</body>
</html>