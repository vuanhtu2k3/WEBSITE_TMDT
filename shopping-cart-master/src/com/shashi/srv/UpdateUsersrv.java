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

@WebServlet("/UpdateUsersrv")
public class UpdateUsersrv extends HttpServlet {
	public UpdateUsersrv() {
		super();

	}

	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String userType = (String) session.getAttribute("usertype");
		String userName = (String) session.getAttribute("username");
		

		if (userType == null || !userType.equals("admin")) {

			response.sendRedirect("login.jsp?message=Access Denied, Login As Admin!!");
			return;

		} else if (userName == null ) {

			response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
			return;
		}
		
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		Integer pinCode  = Integer.parseInt(request.getParameter("pincode"));
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		
		
		UserBean listUser = new UserBean();
		listUser.setEmail(email);
		listUser.setName(name);
		listUser.setMobile(mobile);
		listUser.setAddress(address);
		listUser.setPinCode(pinCode);
		listUser.setPassword(password);
		
		UserServiceImpl dao = new UserServiceImpl();
		
		String status = dao.updateUser(email, listUser);

		RequestDispatcher rd = request
				.getRequestDispatcher("UpdateUser.jsp?email=" + email + "&message=" + status);
		rd.forward(request, response);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}
