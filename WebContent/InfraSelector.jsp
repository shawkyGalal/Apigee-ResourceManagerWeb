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

<%
	//Get the ServletContext
	ServletContext serveletContext = request.getServletContext();
	
	// Get the input stream of the JSON resource
	InputStream inputStream = serveletContext.getResourceAsStream("/WEB-INF/classes/config.json");
	boolean includeOrgSelect = request.getParameter("includeOrgSelect")!= null  ; 
	boolean includeEnvSelect = request.getParameter("includeEnvSelect")!= null  ;
	
	ApigeeConfig ac = new ApigeeConfig(inputStream);
	
	String jsonData = ac.getFileContent();
	%>
	<script>
		function populateCustomer (jsonData , partnerName)
		{
			const partner = jsonData.Partners.find(obj => obj.Name === partnerName); 
			customerSelect.innerHTML = "";
	        for (const index in partner.Customers) {
	            const option = document.createElement("option");
	            option.value = partner.Customers[index].Name;
	            option.textContent = partner.Customers[index].Name;
	            customerSelect.appendChild(option);
	        }
		}
		
		function populateInfra(jsonData , selectedPartner , selectedCustomer )
		{
			const partner = jsonData.Partners.find(obj => obj.Name === selectedPartner);
			const customer = partner.Customers.find(obj => obj.Name === selectedCustomer); ; //jsonData.Partners[selectedPartner].Customers[selectedCustomer];
	        infraSelect.innerHTML = "";
	        for (const index in customer.Infras) {
	            const option = document.createElement("option");
	            option.value = customer.Infras[index].Name;
	            option.textContent = customer.Infras[index].Name;
	            infraSelect.appendChild(option);
	        }
		}
		function populateEnvs() {
			 var partner = document.getElementById("partnerSelect").value;
			 var customer = document.getElementById("customerSelect").value;
			 var infra = document.getElementById("infraSelect").value;
			 var org = document.getElementById("orgSelect").value;
			 var url = "/ResourceManagerWeb/rest/partner/"+partner+"/customer/" + customer + "/infra/" + infra+"/org/" + org + "/env";  
			 populateSelectItem(url , "orgSelect") ; 
		}
		
		function populateOrgs() {
			 var partner = document.getElementById("partnerSelect").value;
			 var customer = document.getElementById("customerSelect").value;
			 var infra = document.getElementById("infraSelect").value;
			 var url = "/ResourceManagerWeb/rest/partner/"+partner+"/customer/" + customer + "/infra/" + infra+"/org" ;  
			 populateSelectItem(url , "orgSelect") ; 
		}
		function populateSelectItem(url , selectItemId) {
		  var orgSelect = document.getElementById( selectItemId );
	      orgSelect.innerHTML = ""; // Clear existing options
		  // Perform an AJAX request
		  var xhr = new XMLHttpRequest();
		  xhr.open("GET", url , true);
		  xhr.onreadystatechange = function () {
		    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
		      var itemData = JSON.parse(xhr.responseText.trim());
		      for (var i = 0; i < itemData.length; i++) {
		        var option = document.createElement("option");
		        option.value = itemData[i];
		        option.textContent = itemData[i];
		        orgSelect.appendChild(option);
		      }
		    }
		  };
		  xhr.send();
		}
		
		const selectedPartner = 0 ;
		const selectedCustomer = 0 ; 
		document.addEventListener("DOMContentLoaded", function() {
	    const partnerSelect = document.getElementById("partnerSelect");
	    const customerSelect = document.getElementById("customerSelect");
	    const infraSelect = document.getElementById("infraSelect");

	    const jsonData = <%=jsonData%> ;
	 
	    // Populate partner options
	    for (const index in jsonData.Partners) {
	        const option = document.createElement("option");
	        option.value = jsonData.Partners[index].Name;
	        option.textContent = jsonData.Partners[index].Name;
	        partnerSelect.appendChild(option);
	    }
	    var intialPartner = jsonData.Partners[0].Name ; 
	    var intialCustomer = jsonData.Partners[0].Customers[0].Name  ; 
	    var intialInfra = jsonData.Partners[0].Customers[0].Infras[0].Name ; 
	    populateCustomer (jsonData , intialPartner); 
	    populateInfra(jsonData , intialPartner , intialCustomer ) ; 
	    
	    <% if ( includeOrgSelect) { %>
	    populateOrgs(jsonData , intialPartner , intialCustomer , intialInfra) ; 
	    <%}%>
	    
	 
	    // Populate customer options based on the selected partner
	    partnerSelect.addEventListener("change", function() {
	        const selectedPartner = partnerSelect.value;
	        populateCustomer(jsonData , selectedPartner) ;
	        var partner = jsonData.Partners.find(obj => obj.Name === selectedPartner);
	        populateCustomer (jsonData , partner.Name);
	        populateInfra(jsonData , selectedPartner , partner.Customers[0].Name ); 
	        <% if ( includeOrgSelect) { %>
	        populateOrgs(jsonData , selectedPartner , partner.Customers[0].Name , partner.Customers[0].Infras[0].Name) ; 
	        <%}%>
	    });
	    
	    // Populate infrastructure options based on the selected customer
	    customerSelect.addEventListener("change", function() {
	        const selectedPartner = partnerSelect.value;
	        const selectedCustomer = customerSelect.value;
	        var partner = jsonData.Partners.find(obj => obj.Name === selectedPartner);
	        var customer = partner.Customers.find(obj => obj.Name === selectedCustomer);
	        populateInfra(jsonData , selectedPartner , selectedCustomer ) ;
	        <% if ( includeOrgSelect) { %>
	        populateOrgs(jsonData , selectedPartner , selectedCustomer , customer.Infras[0].Name)
	        <%}%>
	    });
	    <% if ( includeOrgSelect) { %>
		// Populate Orgs options based on the selected infra
		    infraSelect.addEventListener("change", function() {
		        const selectedPartner = partnerSelect.value;
		        const selectedCustomer = customerSelect.value;
		        const selectedInfra = infraSelect.value ; 
		        populateOrgs(jsonData , selectedPartner , selectedCustomer , selectedInfra)
		    });
	 	<% } %>
	});
	</script>
	<form action="<%= request.getParameter("targetPage") %>" method="post" >
		<label for="partnerSelect">Select Partner:</label>
		<select id="partnerSelect" name = "partnerSelect">
	        <!-- Add more partners here -->
	    </select>
	    
	    <br><br>
	    
	    <label for="customerSelect"  >Select Customer:</label>
	    <select id="customerSelect"  name = "customerSelect"  >
	        <!-- Options will be populated based on the selected partner -->
	    </select>
	    
	    <br><br>
	    
	    <label for="infraSelect">Select Infrastructure:</label>
	    <select id="infraSelect" name = "infraSelect" >
	        <!-- Options will be populated based on the selected customer -->
	    </select>
	    
	    <br><br>
	    
	    <% if ( includeOrgSelect) { %>
	     <label for="orgSelect">Select Organization:</label>
	    <select id="orgSelect" name = "orgSelect" >
	        <!-- Options will be populated based on the selected Infa -->
	    </select>
	    <% } %>
	    
	    <br><br>
	    
	    <% if ( includeEnvSelect) { %>
	     <label for="envSelect">Select Environment:</label>
	    <select id="envSelect" name = "envSelect" >
	        <!-- Options will be populated based on the selected organization -->
	    </select>
	    <% } %>
	    
	    <br><br>
	    <input type="hidden" id="refreshSessionInfo" name="refreshSessionInfo" value="true">
	    
	    <button type="submit">Submit</button>
	</form>
    
</html>