package com.smartvalue.html;

import java.io.IOException;

import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/xxxxApigeeAdmin/messageProcessor/*")
public class GoogleIdProtectedServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		//ServletContext application = getServletContext();
		//HttpSession session = request.getSession() ;
		//GoogleIdToken googleIdToken= (GoogleIdToken) session.getAttribute("GoogleIdToken") ;
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/loginWithGoogle/verifyGoogelIdToken.jsp");
        dispatcher.include(request, response);
        
        
        //super.doGet(request, response);
        //dispatcher = request.getRequestDispatcher("/footer.jsp");
        //dispatcher.include(request, response);
		
		super.doGet(request, response);
	    }

}
