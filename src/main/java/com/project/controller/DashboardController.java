package com.project.controller;

import utils.SessionUtil;
import com.project.dao.DBConnectionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        try {
            conn = DBConnectionFactory.getConnection();

            // Get counts for DBoard
            int totalUsers = getCount(conn, "SELECT COUNT(*) FROM users");
            int totalItems = getCount(conn, "SELECT COUNT(*) FROM items");
            int totalBills = getCount(conn, "SELECT COUNT(*) FROM bills");

            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("totalBills", totalBills);

            // Forward to DBoard view
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard");
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    private int getCount(Connection conn, String sql) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
