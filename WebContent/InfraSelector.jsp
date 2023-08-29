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
	ServletContext context = request.getServletContext();
	
	// Get the input stream of the JSON resource
	InputStream inputStream = context.getResourceAsStream("/WEB-INF/classes/config.json");
	
	ApigeeConfig ac = new ApigeeConfig(inputStream);
	
	String jsonData = ac.getFileContent();
	%>
	<script>
		function populateCustomer (jsonData , partnerIndex)
		{
			const partner = jsonData.Partners[partnerIndex];
			customerSelect.innerHTML = "";
	        for (const index in partner.Customers) {
	            const option = document.createElement("option");
	            option.value = index;
	            option.textContent = partner.Customers[index].Name;
	            customerSelect.appendChild(option);
	        }
		}
		
		function populateInfra(jsonData , selectedPartner , selectedCustomer )
		{
			const customer = jsonData.Partners[selectedPartner].Customers[selectedCustomer];
	        infraSelect.innerHTML = "";
	        for (const index in customer.Infras) {
	            const option = document.createElement("option");
	            option.value = index;
	            option.textContent = customer.Infras[index].Name;
	            infraSelect.appendChild(option);
	        }
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
	        option.value = index;
	        option.textContent = jsonData.Partners[index].Name;
	        partnerSelect.appendChild(option);
	    }
	    populateCustomer (jsonData , 0); 
	    populateInfra(jsonData , 0 , 0 )
	    
	 
	    // Populate customer options based on the selected partner
	    partnerSelect.addEventListener("change", function() {
	        const selectedPartner = partnerSelect.value;
	        populateCustomer(jsonData , selectedPartner) ;
	        populateInfra(jsonData , selectedPartner , 0 )
	    });
	    
	    // Populate infrastructure options based on the selected customer
	    customerSelect.addEventListener("change", function() {
	        const selectedPartner = partnerSelect.value;
	        const selectedCustomer = customerSelect.value;
	        populateInfra(jsonData , selectedPartner , selectedCustomer ) ; 
	        
	    });
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
	    <button type="submit">Submit</button>
	</form>
    
</html>