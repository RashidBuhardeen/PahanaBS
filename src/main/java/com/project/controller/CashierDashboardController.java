package com.project.controller;

import utils.SessionUtil;
import com.project.dao.DBConnectionFactory;
import com.project.model.Bill;
import com.project.dao.BillDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cashier")
public class CashierDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // If you already manage DAOs via DI, adjust accordingly.
    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Require login
        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }
        // Require cashier role
        if (!SessionUtil.hasRole(request, "cashier")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        switch (action) {
            case "addCustomer":
                request.getRequestDispatcher("/WEB-INF/View/cashier/cashier-addcus.jsp")
                       .forward(request, response);
                return;

            case "printBill":
                printBill(request, response);
                return;

            default:
                request.getRequestDispatcher("/WEB-INF/View/cashier/cashier-db.jsp")
                       .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Require login + role on POST too
        if (!SessionUtil.isLoggedIn(req) || !SessionUtil.hasRole(req, "cashier")) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action");
            return;
        }

        try {
            switch (action) {
                case "saveCustomer":
                    saveCustomer(req, resp);
                    break;
                case "submitBill":
                    submitBill(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("error", ex.getMessage());
            // On error, return to the respective page if possible
            if ("saveCustomer".equals(action) || "updateCustomer".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/View/cashier/cashier-addcus.jsp").forward(req, resp);
            } else if ("submitBill".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/View/cashier/cashier-bill.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
            }
        }
    }

    private void saveCustomer(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String accountNo = req.getParameter("account_no");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String telephone = req.getParameter("telephone");
        String email = req.getParameter("email");

        if (accountNo == null || accountNo.isEmpty() || name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Account number and name are required.");
        }

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO customer (account_no, name, address, telephone_number, email) VALUES (?,?,?,?,?)")) {
            ps.setString(1, accountNo);
            ps.setString(2, name);
            ps.setString(3, address);
            ps.setString(4, telephone);
            ps.setString(5, email);
            ps.executeUpdate();
        }

        req.getRequestDispatcher("/WEB-INF/View/cashier/cashier-db.jsp").forward(req, resp);
    }


    private void submitBill(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String customerAccount = req.getParameter("account_no");
        String[] selectedItemIds = req.getParameterValues("item_ids");

        if (customerAccount == null || customerAccount.isEmpty()) {
            req.setAttribute("error", "Select a customer.");
            req.getRequestDispatcher("/WEB-INF/View/cashier/cashier-bill.jsp").forward(req, resp);
            return;
        }

        class Line {
            int itemId;
            int qty;
            BigDecimal price;
        }
        List<Line> lines = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        if (selectedItemIds != null) {
            for (String idStr : selectedItemIds) {
                int itemId = Integer.parseInt(idStr);
                String qtyParam = req.getParameter("qty_" + itemId);
                String priceParam = req.getParameter("price_" + itemId);

                int qty = (qtyParam == null || qtyParam.isEmpty()) ? 0 : Integer.parseInt(qtyParam);
                BigDecimal price = (priceParam == null || priceParam.isEmpty())
                        ? BigDecimal.ZERO : new BigDecimal(priceParam);

                if (qty > 0) {
                    Line l = new Line();
                    l.itemId = itemId;
                    l.qty = qty;
                    l.price = price;
                    lines.add(l);
                    total = total.add(price.multiply(new BigDecimal(qty)));
                }
            }
        }

        if (lines.isEmpty()) {
            req.setAttribute("error", "Select at least one item with quantity > 0.");
            req.getRequestDispatcher("/WEB-INF/View/cashier/cashier-bill.jsp").forward(req, resp);
            return;
        }

        int billId;
        try (Connection conn = DBConnectionFactory.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Insert bill
                try (PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO bills (customer_id, bill_date, total_amount) VALUES (?, NOW(), ?)",
                        Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, customerAccount);
                    ps.setBigDecimal(2, total);
                    ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) throw new SQLException("No bill id generated");
                        billId = keys.getInt(1);
                    }
                }

                // Insert bill items + reduce stock with check
                try (PreparedStatement psItem = conn.prepareStatement(
                             "INSERT INTO bill_items (bill_id, item_id, quantity, price) VALUES (?,?,?,?)");
                     PreparedStatement psStock = conn.prepareStatement(
                             "UPDATE items SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?")) {

                    for (Line l : lines) {
                        // stock check/update
                        psStock.setInt(1, l.qty);
                        psStock.setInt(2, l.itemId);
                        psStock.setInt(3, l.qty);
                        int updated = psStock.executeUpdate();
                        if (updated == 0) {
                            conn.rollback();
                            throw new SQLException("Insufficient stock for item id " + l.itemId);
                        }

                        psItem.setInt(1, billId);
                        psItem.setInt(2, l.itemId);
                        psItem.setInt(3, l.qty);
                        psItem.setBigDecimal(4, l.price);
                        psItem.addBatch();
                    }
                    psItem.executeBatch();
                }

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }

        String printUrl   = resp.encodeURL(req.getContextPath() + "/cashier?action=printBill&id=" + billId);
        String refreshUrl = resp.encodeURL(req.getContextPath() + "/cashier"); // dashboard

        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Printing…</title></head><body>");
            out.println("<script>");
            // Navigate the *already opened* named tab (no popup creation → no block)
            out.println("try { window.open('" + printUrl + "', 'billPrintTab'); } catch(e) {}");
            out.println("window.location.replace('" + refreshUrl + "');"); // refresh current tab
            out.println("</script>");
            out.println("<noscript>");
            out.println("<p>Open print tab: <a href='" + printUrl + "' target='billPrintTab' rel='noopener'>Print Bill</a></p>");
            out.println("<p>Back to dashboard: <a href='" + refreshUrl + "'>Dashboard</a></p>");
            out.println("</noscript>");
            out.println("</body></html>");
        }
        return;
    }

    // Print bill view
    private void printBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing bill id");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(idParam);
        } catch (NumberFormatException nfe) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid bill id");
            return;
        }

        Bill bill = billDAO.getBillById(billId); // expects a valid DAO implementation
        if (bill != null) {
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("/WEB-INF/View/bill/print-bill.jsp")
                   .forward(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().println("Bill not found!");
        }
    }
}
