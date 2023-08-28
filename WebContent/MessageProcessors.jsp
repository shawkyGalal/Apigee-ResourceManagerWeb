<%@page import="com.smartvalue.apigee.resourceManager.Renderer"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfig"%>
<%@page import="com.smartvalue.apigee.configuration.infra.*"%>
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
	ApigeeConfig ac = new ApigeeConfig("E:\\MasterWorks\\Eclipse-WS\\ResourceManagerWeb\\WebContent\\config.json" ) ; 
		String infraName = request.getParameter("infraName") ; //"Emergency" ; 
		Infra infra = ac.getInfra("MasterWorks" , "MOJ" , infraName) ;
		String orgName = request.getParameter("orgName") ; //"moj-prod" ; 
		
		
		ManagementServer ms = new ManagementServer(infra) ; 
		
		HashMap<String, Infra> customer = ac.getCustomer("MasterWorks", "MOJ") ;  // getPartnersMap().get("MasterWorks").get("MOJ")
%> 
		<form >
			<select  id="infra">
				<% for (String custInfra : customer.keySet())
					{ %><option><%=custInfra%></option> <% } %> 
			
			</select>
		</form>
<%
		
		ArrayList<String> regions = ms.getRegions() ; 
		Organization org = ms.getOrgByName(orgName) ; 
		List<String> envs = org.getEnvironments(); 
%>
	<br>Apigee Infrastructure (<%=infraName %>)  
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
				<% 
					for (String  region : regions)
					{	%> <td><table border = 1 name = "Region Message Processors "> 
							<tr> <td>MP IP </td> <td>Heath Check </td> </tr>
						<% 
							List<MPServer> mpServers = org.getEnvByName(env).getMessageProcesors(region) ; 
							for ( MPServer mpServer : mpServers )
							{	
								%><tr><td><%=mpServer.getInternalIP()%></td> <td>mpServer.healthCheck()</td></tr><% 
							}
							%> </table></td> <%
					}
					
				%>
			</tr>
		<%}%>
	</Table>
</body>
</html>