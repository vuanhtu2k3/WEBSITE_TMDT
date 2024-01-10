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
@WebServlet("/ProductServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	int  totalUsers = getTotalUserCount();
        	int totalOrders = getTotalOrderCount();
            int totalProducts = getTotalProductCount();
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalProducts", totalProducts);

        } catch (SQLException e) {
          
            throw new ServletException("Error processing request", e);
        }

        request.getRequestDispatcher("/adminViewProduct.jsp").forward(request, response);
    }

    private int getTotalProductCount() throws SQLException {
        int totalCount = 0;

        try (Connection conn = DBUtil.provideConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM product");
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalCount = rs.getInt("total");
            }
        }

        return totalCount;
    }
    private int getTotalUserCount() throws SQLException {
        int totalCount = 0;

        try (Connection conn = DBUtil.provideConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM user");
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalCount = rs.getInt("total");
            }
        }

        return totalCount;
    }
    private int getTotalOrderCount() throws SQLException {
        int totalCount = 0;

        try (Connection conn = DBUtil.provideConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM orders");
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalCount = rs.getInt("total");
            }
        }

        return totalCount;
    }
}
