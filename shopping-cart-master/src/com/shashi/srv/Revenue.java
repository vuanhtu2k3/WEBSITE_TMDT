package com.shashi.srv;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shashi.utility.DBUtil;
@WebServlet("/Revenue")
public class Revenue extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	int  totalRevenue = getTotalRevenue();
            request.setAttribute("totalRevenue", totalRevenue);

        } catch (SQLException e) {
          
            throw new ServletException("Error processing request", e);
        }

        request.getRequestDispatcher("/revenue.jsp").forward(request, response);
    }

    private int getTotalRevenue() throws SQLException {
        int totalRevenue = 0;

        try (Connection conn = DBUtil.provideConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(amount) AS totalRevenue FROM orders;");
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
            	
            	totalRevenue = rs.getInt("totalRevenue");

            }
        }

        return totalRevenue;
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
    
}
