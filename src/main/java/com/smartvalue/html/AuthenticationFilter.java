package com.smartvalue.html;

import java.io.IOException;
import java.util.ArrayList;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns ="/*")
public class AuthenticationFilter implements Filter 
{
	private static String INDEX_PATH = "/index.jsp" ; 
	
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)     throws IOException, ServletException {

    	 HttpServletRequest request = (HttpServletRequest) req;
         HttpServletResponse response = (HttpServletResponse) res;
         HttpSession session = request.getSession(false);

         String loginURI = request.getContextPath() + INDEX_PATH;
         boolean authNotRequired = isAuthRequired(request ); 
         if (authNotRequired)
         {
        	 chain.doFilter(request, response);
         }
         else
         {
	         if (session != null)
	         {
	        	GoogleIdToken googleIdToken = (GoogleIdToken)session.getAttribute(AppContext.GOOGLE_ID_TOKEN_VAR_NAME); 
	        	
		        if (googleIdToken == null)
		     	{
		     		response.sendRedirect(loginURI +"?state=InvalidIdToken"); 
		     	}
		     	else 
		     	{ 
		     		long currentTimeMillis = new java.util.Date().getTime() ;
		     		if  (! googleIdToken.verifyExpirationTime(currentTimeMillis, 3))
		     		{
		     			response.sendRedirect(loginURI+"?state=IdToken_Expired");
		     		}
		     		else 
		     		{
		     			 chain.doFilter(request, response);
		     		}
		     	}
	         }
	         else 
	         {
	        	 response.sendRedirect(loginURI+"?state=WebSession_Expired");
	         }
         }
    }
    
    private static boolean isAuthRequired(HttpServletRequest request)
    {
    	return getNonAuthPaths().contains(request.getRequestURI().substring(request.getContextPath().length())) ;
    }
    
    private static ArrayList<String> getNonAuthPaths()
    {
    	String loginURI 	=  INDEX_PATH ;
    	String loginHandler = "/loginWithGoogle/loginHandler.jsp";
    	String loginIndex 	= "/loginWithGoogle/index.jsp";
    	String authenticate = "/loginWithGoogle/authenticate.jsp";
    	String authorize 	= "/loginWithGoogle/authorize.jsp";
    	
    	ArrayList<String> nonAuthPaths = new ArrayList<String>(); 
    	nonAuthPaths.add(loginURI); 
    	nonAuthPaths.add(loginHandler);
    	nonAuthPaths.add(loginIndex);
    	nonAuthPaths.add(authenticate);
    	nonAuthPaths.add(authorize);
    	
    	return nonAuthPaths ; 
    	
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    public void destroy() {
        // Cleanup code, if needed
    }

	
}

