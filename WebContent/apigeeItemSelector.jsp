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
<%@page import ="java.lang.reflect.Type"%>
<%@page import ="com.smartvalue.moj.clients.environments.JsonParser"%>
<%@page import="com.smartvalue.apigee.configuration.ApigeeConfigFactory"%>
<%@page import="com.smartvalue.apigee.configuration.infra.Infra"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body >

	<%
	String[] neededAttributes = (request.getParameter("neededAttributes") != null) ? request.getParameter("neededAttributes").trim().split("\\s*,\\s*") :new String[] {}; 
	List<String> neededlist = Arrays.asList(neededAttributes) ; 
	boolean orgIsNeeded = neededlist.contains("org"); 
	boolean envIsNeeded = neededlist.contains("env");
	boolean resourceTypeIsNeeded = neededlist.contains("resourceType");
	String hostIp = "10.169.3.142"; 
 
	%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			populateOrgs(); 
			<% if ( envIsNeeded ) { %>
	 			const orgSelect = document.getElementById("orgSelect");
		    	orgSelect.addEventListener("change", function() 
		    	{
				    populateEnvs() ;
				    
				} )
		 	<% } %>
		})
		function populateOrgs() {
			 var url = "http://<%=hostIp%>:8080/ResourceManagerWeb/rest/v1/o" ;  
			 populateSelectItem(url , "orgSelect") ; 
			 <% if ( envIsNeeded ) { %>
			 populateEnvs() ; 
			 <% } %>
			 <% if ( resourceTypeIsNeeded ) { %>
			 populateResources() ; 
			 <% } %>
		}
		
		<% if (envIsNeeded) {%>
			function populateEnvs() {
		        const selectedOrg = orgSelect.value ; 
				var url = "http://<%=hostIp%>:8080/ResourceManagerWeb/rest/v1/o/"+ selectedOrg + "/e";  
				 populateSelectItem(url , "envSelect") ; 
				 <% if (resourceTypeIsNeeded) {%> 
				    var resourceTypeSelect = document.getElementById("resourceTypeSelect");
				    resourceTypeSelect.addEventListener("change", function() { populateResources() ; } ) ;
			 		<% } %>
			}
		<% } %> 
		
		
		<% if (resourceTypeIsNeeded) {%>
			function populateResources() {
		        const selectedOrg = orgSelect.value ; 
		        const selectedEnv = envSelect.value ; 
		        const selectedResourceType = resourceTypeSelect.value ;
		        
				var url = "http://<%=hostIp%>:8080/ResourceManagerWeb/rest/v1/o/"+selectedOrg+"/e/"+ selectedEnv +"/" + selectedResourceType ;  
				populateSelectItem(url , "resourceSelect") ; 
			}
		<%}%>
				
		function populateSelectItem(url , selectItemId) {
		  var itemSelect = document.getElementById( selectItemId );
		  itemSelect.innerHTML = ""; // Clear existing options
		  // Perform an AJAX request
		  var xhr = new XMLHttpRequest();
		  xhr.open("GET", url , false);
		  xhr.onreadystatechange = function () {
		  try{
			  	if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
		      	var itemData = JSON.parse(xhr.responseText.trim());
		      	for (var i = 0; i < itemData.length; i++) {
		        var option = document.createElement("option");
		        option.value = itemData[i];
		        option.textContent = itemData[i];
		        itemSelect.appendChild(option);
		        
		      	}	
		        
		       
		    	}
			  	else if (xhr.readyState === XMLHttpRequest.DONE && xhr.status !== 200) 
			  	{ throw new Error(" Unable to Retive list of options "+ xhr.responseText.trim() + xhr.responseURL) ; }
		    }
		    catch ( Exception ) 
		    { 
		    	var messages = document.getElementById( "messages" );
		    	messages.hidden=false ; 
		    	messages.innerText =  Exception ; 
		    }
		  };
		  xhr.send();
		}
	 	
 		
 		
		
	</script>
	<textarea rows="" cols="" id = "messages" hidden="true"></textarea>
	<form action="<%=request.getParameter("targetPage")%>" method="post" >
	    
	    <% if ( orgIsNeeded) { %>
	    <label for="orgSelect">Select Organization:</label>
	    <select id="orgSelect" name = "orgSelect"  >
	        <!-- Options will be populated based on the selected Infa -->
	    </select>
	    <br><br>
	    <% } %>
	    
	    <% if ( envIsNeeded) { %>
	     <label for="envSelect">Select Environment:</label>
	    <select id="envSelect" name = "envSelect" >
	        <!-- Options will be populated based on the selected organization -->
	    </select>
	    <br><br>
     	<% } %>
	    
	    <% if ( resourceTypeIsNeeded) { %>
	     <label for="resourceTypeSelect">Select Resource Type:</label>
	    	<select id="resourceTypeSelect" name = "resourceTypeSelect" >
		        <option>keyvaluemaps</option>
		        <option>virtualhosts</option>
		        <option>targetservers</option>
	    	</select>
	    <br><br>
	    <% } %>
	    
	    <% if ( resourceTypeIsNeeded) { %>
	     <label for="resourceSelect">Select Resource </label>
	    	<select id="resourceSelect" name = "resourceSelect" >
	    </select>
	    <br><br>
	    <% } %>
	    
	    
	    <input type="hidden" id="targetPage" name="targetPage" value="<%= request.getParameter("targetPage")%>">
	    
	    <button type="submit" name= "submit" id = "submit">Submit</button>
	</form>
   
   </body>
</html>