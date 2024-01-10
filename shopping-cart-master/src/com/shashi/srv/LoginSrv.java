package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shashi.beans.UserBean;
import com.shashi.service.impl.UserServiceImpl;

/**
 * Servlet implementation class LoginSrv
 */
@WebServlet("/LoginSrv")
public class LoginSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginSrv() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    String userName = request.getParameter("username");
	    String password = request.getParameter("password");
	    String userType = request.getParameter("usertype");
	    response.setContentType("text/html");

	    String status = "Login Denied! Invalid Username or password.";

	    if ("admin".equals(userType)) { // Login as Admin

	        if ("admin@gmail.com".equals(userName) && "admin".equals(password)) {
	            // valid

	            HttpSession session = request.getSession();

	            session.setAttribute("username", userName);
	            session.setAttribute("password", password);
	            session.setAttribute("usertype", userType);
	            response.sendRedirect(request.getContextPath() + "/ProductServlet");

	        } else {
	            // Invalid;
	            RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);
	            rd.forward(request, response);
	        }
	    
	

		} else { // Login as customer

			UserServiceImpl udao = new UserServiceImpl();

			status = udao.isValidCredential(userName, password);

			if (status.equalsIgnoreCase("valid")) {
				// valid user

				UserBean user = udao.getUserDetails(userName, password);

				HttpSession session = request.getSession();

				session.setAttribute("userdata", user);

				session.setAttribute("username", userName);
				session.setAttribute("password", password);
				session.setAttribute("usertype", userType);

				RequestDispatcher rd = request.getRequestDispatcher("userHome.jsp");

				rd.forward(request, response);

			} else {
				// invalid user;

				RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);

				rd.forward(request, response);

			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
