package com.smartvalue.html;

import java.io.IOException;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns ="/ApigeeAdmin/messageProcessorxxx/*")
public class CommonIncludeFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Include the common JSP content
    	HttpSession session = ((HttpServletRequest)request).getSession() ;
    	GoogleIdToken googleIdToken= (GoogleIdToken) session.getAttribute("GoogleIdToken") ; 
    	if (googleIdToken == null)
    	{
    		ServletOutputStream out = response.getOutputStream(); 
    		out.print("Redirecting to Google Cloud Login .....");
    		request.getRequestDispatcher("/loginWithGoogle/authorize.jsp").include(request, response);
    	}
    	else 
    	{
    		request.getRequestDispatcher("/loginWithGoogle/verifyGoogelIdToken.jsp").include(request, response);
    	}

        // Continue with the filter chain
        chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    public void destroy() {
        // Cleanup code, if needed
    }

	
}

