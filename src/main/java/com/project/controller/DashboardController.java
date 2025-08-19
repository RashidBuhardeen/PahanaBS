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

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Simple DTO for the stock table
    public static class ItemStock {
        private final int id;
        private final String itemCode;
        private final String itemName;
        private final BigDecimal price;
        private final int stockQuantity;

        public ItemStock(int id, String itemCode, String itemName, BigDecimal price, int stockQuantity) {
            this.id = id;
            this.itemCode = itemCode;
            this.itemName = itemName;
            this.price = price;
            this.stockQuantity = stockQuantity;
        }
        public int getId() { return id; }
        public String getItemCode() { return itemCode; }
        public String getItemName() { return itemName; }
        public BigDecimal getPrice() { return price; }
        public int getStockQuantity() { return stockQuantity; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnectionFactory.getConnection()) {

            // Top cards
            int totalUsers  = getCount(conn, "SELECT COUNT(*) FROM users");
            int totalItems  = getCount(conn, "SELECT COUNT(*) FROM items");
            int totalBills  = getCount(conn, "SELECT COUNT(*) FROM bills");

            int totalBooksInStock = getIntAggregate(conn, "SELECT COALESCE(SUM(stock_quantity), 0) FROM items");
            BigDecimal totalRevenue = getDecimalAggregate(conn, "SELECT COALESCE(SUM(total_amount), 0) FROM bills");

            // Stock table (all books)
            List<ItemStock> itemStocks = getItemStocks(conn);

            // Attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("totalBooksInStock", totalBooksInStock);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("itemStocks", itemStocks);

            // Forward to dashboard view
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard");
        }
    }

    private int getCount(Connection conn, String sql) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private int getIntAggregate(Connection conn, String sql) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private BigDecimal getDecimalAggregate(Connection conn, String sql) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                BigDecimal v = rs.getBigDecimal(1);
                return v != null ? v : BigDecimal.ZERO;
            }
            return BigDecimal.ZERO;
        }
    }

    private List<ItemStock> getItemStocks(Connection conn) throws Exception {
        String sql = "SELECT id, item_code, item_name, price, stock_quantity " +
                     "FROM items ORDER BY item_name ASC";
        List<ItemStock> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ItemStock(
                        rs.getInt("id"),
                        rs.getString("item_code"),
                        rs.getString("item_name"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity")
                ));
            }
        }
        return list;
    }
}
