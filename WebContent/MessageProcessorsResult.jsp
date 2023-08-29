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
<body>
<%
	//Get the ServletContext
	ServletContext serveletContext = request.getServletContext();
	
	// Get the input stream of the JSON resource
	InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");
	
	ApigeeConfig ac = new ApigeeConfig(inputStream);

		out.print(request.getParameter("partnerSelect")) ; 
		int partnerSelect = Integer.parseInt(request.getParameter("partnerSelect")) ; 
		int customerSelect = Integer.parseInt( request.getParameter("customerSelect"))  ;
		int infraSelect = Integer.parseInt(request.getParameter("infraSelect")) ;
		
		Partner partnr =  (Partner) ac.getPartners().get(partnerSelect) ; 
		Customer customer = partnr.getCustomers().get(customerSelect) ; 
		Infra infra = customer.getInfras().get(infraSelect) ; //.getInfra("MasterWorks" , "MOJ" , infraName) ;
		 
			
		ManagementServer ms = new ManagementServer(infra) ; 

		ArrayList<String> regions = ms.getRegions() ;
		HashMap<String , Organization > orgs = ms.getOrgs() ;
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
	<%} %>
</body>
</html>