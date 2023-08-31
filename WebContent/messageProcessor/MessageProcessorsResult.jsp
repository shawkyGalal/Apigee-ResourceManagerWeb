<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.Partner"%>
<%@page import="com.smartvalue.apigee.configuration.Customer"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>

<%@page import ="com.smartvalue.apigee.rest.schema.environment.Environment"%>
<%@page import ="com.smartvalue.apigee.rest.schema.organization.Organization"%>
<%@page import ="com.smartvalue.apigee.rest.schema.product.ProductsServices"%>
<%@page import ="com.smartvalue.apigee.rest.schema.proxy.Proxy"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.MPServer"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.Postgres"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.Router"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.Server"%>
<%@page import ="com.smartvalue.apigee.rest.schema.server.ServerServices"%>
<%@page import ="com.smartvalue.apigee.rest.schema.sharedFlow.SharedFlow"%>
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
<%@include file="../intialize.jsp" %>
<body>
<%
	
				
		ArrayList<String> regions = ms.getRegions() ;
		%> <br>Apigee Infrastructure (<%=infra.getName() %>) <br> <br> <br> <%
		for ( String orgName : orgs.keySet())
		{ 
			Organization org = orgs.get(orgName) ;  
			List<String> envs = org.getEnvironments(); 
			%>
			  
			<br>Active Message Processors For Environments of Organization ( <%=org.getName() %> ) 
			<Table border = 1>
				<tr><td rowspan = 2 >Environments</td><td colspan = <%=regions.size()%> >Regions</td></tr>
				<tr>
				<% 
					for (String  region : regions)
					{
						out.print ("<td>" + region + "</td>" ) ;  
					}
				%>
				
				</tr>
				<% for (String env : envs) { %>
					<tr>
						<td><%=env%></td>
						<%  Environment envObj = org.getEnvByName(env) ; 
							for (String  region : regions)
							{	%> <td><table border = 1 name = "Region Message Processors "> 
									<tr> <td>MP IP </td> <td>Heath Check </td> </tr>
								<% 
									try { List<MPServer> mpServers = envObj.getMessageProcesors(region) ;
									for ( MPServer mpServer : mpServers )
									{
										String mpIP = mpServer.getInternalIP() ;
										%><tr><td><%=mpIP%></td> <td>mpServer.healthCheck()</td></tr><% 
									}
									} catch (Exception e )
									{
										%><tr><td>Failed to get MPs for Environment <%=envObj.getName() %>  or region <%=region %> Due to : <%=e.getMessage() %></td></tr><%
									}
									%> </table></td> <%
							}
							
						%>
					</tr>
				<%}%>
			</Table>
	<%} %>
</body>
</html>