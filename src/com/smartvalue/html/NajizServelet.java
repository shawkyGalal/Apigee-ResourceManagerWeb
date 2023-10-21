package com.smartvalue.html;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auth0.jwt.exceptions.TokenExpiredException;
import com.smartvalue.moj.clients.environments.AccessTokenNotFound;
			 

@WebServlet("/NajizLikeSampleAppxxx/*")
public class NajizServelet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)    throws ServletException, IOException {
			try {
	    	super.doGet(request, response);
			}
			catch ( TokenExpiredException t) {response.sendRedirect("/ResourceManagerWeb/NajizLikeSampleApp/index.jsp") ; return ;  }
		
	    }
	
	

	}
