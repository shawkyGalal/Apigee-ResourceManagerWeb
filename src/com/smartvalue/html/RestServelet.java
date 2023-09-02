package com.smartvalue.html;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
			 

@WebServlet("/rest/*")
public class RestServelet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public void doGetxx(HttpServletRequest request ,  HttpServletResponse response ) throws ServletException, IOException
	{
		String pathInfo = request.getPathInfo(); // Get the path after the servlet mapping
		String targetPage = null ; 
		if (pathInfo != null) {
	        String[] parts = pathInfo.split("/"); // Split the path into parts
	        if (parts.length >= 5) {
	            String partnerId = parts[1]; // Extract the partner ID from the path
	            String customerId = parts[3];
	            String infraId = parts[5];
	            if (parts.length >= 7 && parts[6] == "org")
	            {
	            	String org = parts[7] ; 
	            	request.setAttribute("org", org);
	            }
	            
	            if (parts.length >= 8 && parts[7] == "env")
	            {
	            	String env = parts[8] ; 
	            	request.setAttribute("env", env);
	            }
	            
	            targetPage = parts[parts.length - 1 ];
	            // You can use the partnerId to fetch the corresponding data and set it in the request
	            request.setAttribute("partner", partnerId);
	            request.setAttribute("customer", customerId);
	            request.setAttribute("infra", infraId);
	        }
	    }
		 request.getRequestDispatcher("/rest/"+ targetPage + ".jsp").forward(request, response);
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)            throws ServletException, IOException {

	        // Get the requested URL
	        String requestURI = request.getPathInfo();

	        // Split the URL into segments
	        String[] segments = requestURI.split("/");

	        // Check if there are enough segments
	        if (segments.length < 3) {
	            response.getWriter().println("Invalid URL format.");
	            return;
	        }

	        // Determine the number of segments
	        //int numSegments = segments.length - 2; // Exclude the empty segment at the beginning
	        int numSegments = segments.length - 1; 
	        boolean evenSegments = numSegments % 2 ==0 ;
	        int segmentsPairs  = (evenSegments)? numSegments/2 : ( numSegments+1 )/2 ;
	        // Extract the values from the segments
	        
	        String[] segmentNames = new String[segmentsPairs];
	        String[] segmentValues = new String[segmentsPairs];
	        HashMap <String , String > atts = new HashMap() ; 
	        for (int i = 0; i < segmentsPairs; i++) {
	            segmentNames[i] = segments[i * 2 + 1];
	            if ( evenSegments || i < (segmentsPairs -1)  ) segmentValues[i] = segments[i * 2 + 2];
	            atts.put(segmentNames[i], segmentValues[i]) ; 
	        }
            request.setAttribute("atts" , atts);	        

	        // Determine which JSP to forward to based on the parsed values
	        String jspPage = "/root/root.jsp" ; determineJspPage(segmentNames, segmentValues);


	        // Forward the request to the selected JSP
	        request.getRequestDispatcher(jspPage).forward(request, response);
	    }

	    private String determineJspPage(String[] segmentNames, String[] segmentValues) {
	    	StringBuilder jspPageBuilder = new StringBuilder();
	        for (int i = 2; i < segmentNames.length; i++) {
	            jspPageBuilder.append(segmentNames[i]);
	            jspPageBuilder.append((segmentValues.length >= i ) ? "Details" : "sList"); 
	        }
	        return jspPageBuilder.toString();
	    }
	}
