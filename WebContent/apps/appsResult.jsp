

<%@page import ="com.smartvalue.apigee.rest.schema.application.Application"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>
<%@page import ="com.smartvalue.apigee.rest.schema.product.ProductsServices"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.Proxy"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.MPServer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.Postgres"%>

<%@page import ="com.smartvalue.apigee.rest.schema.TargetServer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.virtualHost.VirtualHost"%>
<%@page import ="com.smartvalue.apigee.resourceManager.ManagementServer"%>
<%@page import ="java.util.*"%>
<%@page import ="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@include file="../intialize.jsp" %>

		<br>Apigee Infrastructure (<%=infra.getName() %>) <br> <br> <br> <%
		for ( String orgName : orgs.keySet())
		{ 
			out.print ("<br>Developers for Organization " + orgName ) ; 
			try {
			Organization org = orgs.get(orgName) ;  
			ArrayList<Application> apps = org.getAllApps() ;
			int counter = 0 ; 
			%>
			<table border = 1 > 
			<tr><td> <%=counter%><td>App Name </td> <td>DeveloperId</td></tr>
			<%
			
			for (Application app  : apps)
			{
				counter++ ; 
				%> <tr>
						<td><%=counter%></td>
						<td><%=app.getName()%> </td> 
						<td><%=app.getDeveloperId()%></td>
						<td><a href = "appDetails.jsp?org=<%=orgName%>&appId=<%=app.getAppId()%>" > Details</a></td>
				</tr> 
				<%
			}
			%>
			</table>
			<%
			//out.print(Renderer.arrayListToHtmlTable(applications)) ;
			}
			catch ( Exception e) 
			{
				out.print ( "<br>Unable to Display Organization developers due to : " + e.getMessage() ) ; 
			}
		}
		%> 
		</body>
</html>