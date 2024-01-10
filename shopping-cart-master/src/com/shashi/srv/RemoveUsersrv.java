package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shashi.service.impl.UserServiceImpl;

@WebServlet("/RemoveUsersrv")
public class RemoveUsersrv extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("usertype");
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userType == null || !userType.equals("admin")) {
            response.sendRedirect("login.jsp?message=Truy cập bị từ chối. Đăng nhập với tư cách quản trị viên!!");
            return;
        } else if (userName == null || password == null) {
            response.sendRedirect("login.jsp?message=Phiên đã hết hạn. Hãy đăng nhập lại!!");
            return;
        }

        try {
            String email = request.getParameter("email");
            UserServiceImpl user = new UserServiceImpl();
            String status = user.removeUser(email);
            RequestDispatcher rd = request.getRequestDispatcher("removeUser.jsp?message=" + status);
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            // Handle invalid pincode (not a number)
            response.sendRedirect("removeUser.jsp?message=Email không hợp lệ");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
