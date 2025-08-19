package com.project.dao;

import com.project.model.Bill;
import com.project.model.BillItem;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

	// CREATE BILL + ITEMS (fixed to use INT item_id and decrement stock)
	public boolean createBill(Bill bill) {
	    final String insertBillSQL =
	        "INSERT INTO bills (customer_id, bill_date, total_amount) VALUES (?, ?, ?)";
	    final String insertBillItemSQL =
	        "INSERT INTO bill_items (bill_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";
	    final String decStockSQL =
	        "UPDATE items SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";

	    try (Connection conn = DBConnectionFactory.getConnection()) {
	        conn.setAutoCommit(false);

	        try (PreparedStatement psBill =
	                 conn.prepareStatement(insertBillSQL, Statement.RETURN_GENERATED_KEYS)) {

	            psBill.setString(1, bill.getCustomer_account_no());
	            // bills.bill_date is DATE; using Timestamp is fine (time part will be truncated by MySQL)
	            psBill.setTimestamp(2, new Timestamp(bill.getBill_date().getTime()));
	            psBill.setBigDecimal(3, BigDecimal.valueOf(bill.getTotal_amount()));

	            int affectedRows = psBill.executeUpdate();
	            if (affectedRows == 0) throw new SQLException("Creating bill failed, no rows affected.");

	            int billId;
	            try (ResultSet keys = psBill.getGeneratedKeys()) {
	                if (!keys.next()) throw new SQLException("Creating bill failed, no generated key obtained.");
	                billId = keys.getInt(1);
	                bill.setBill_number(String.valueOf(billId));
	            }

	            try (PreparedStatement psItem = conn.prepareStatement(insertBillItemSQL);
	                 PreparedStatement psDec = conn.prepareStatement(decStockSQL)) {

	                for (BillItem item : bill.getBill_items()) {
	                    // 1) Decrement stock (guarded)
	                    psDec.setInt(1, item.getQuantity());
	                    psDec.setInt(2, item.getItemId());
	                    psDec.setInt(3, item.getQuantity());
	                    int dec = psDec.executeUpdate();
	                    if (dec == 0) {
	                        throw new SQLException("Insufficient stock for item_id=" + item.getItemId());
	                    }

	                    // 2) Insert bill item
	                    psItem.setInt(1, billId);
	                    psItem.setInt(2, item.getItemId());
	                    psItem.setInt(3, item.getQuantity());
	                    psItem.setBigDecimal(4, BigDecimal.valueOf(item.getPrice()));
	                    psItem.addBatch();
	                }
	                psItem.executeBatch();
	            }

	            conn.commit();
	            return true;

	        } catch (SQLException ex) {
	            conn.rollback();
	            ex.printStackTrace();
	            return false;
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

    // READ BILL BY ID
	// com.project.dao.BillDAO
	public Bill getBillById(int billId) {
	    Bill bill = null;

	    String billSQL =
	        "SELECT b.id, b.customer_id, b.bill_date, b.total_amount, " +
	        "       c.name AS customer_name " +
	        "FROM bills b " +
	        "JOIN customer c ON c.account_no = b.customer_id " +
	        "WHERE b.id = ?";

	    String billItemsSQL =
	        "SELECT bi.id, bi.bill_id, bi.item_id, bi.quantity, bi.price, " +
	        "       i.item_code, i.item_name " +
	        "FROM bill_items bi " +
	        "JOIN items i ON i.id = bi.item_id " +
	        "WHERE bi.bill_id = ?";

	    try (Connection conn = DBConnectionFactory.getConnection()) {

	        // Load bill + customer name
	        try (PreparedStatement psBill = conn.prepareStatement(billSQL)) {
	            psBill.setInt(1, billId);
	            try (ResultSet rs = psBill.executeQuery()) {
	                if (rs.next()) {
	                    bill = new Bill();
	                    bill.setBill_number(String.valueOf(rs.getInt("id")));
	                    bill.setCustomer_account_no(rs.getString("customer_id"));
	                    bill.setCustomer_name(rs.getString("customer_name")); // <-- here
	                    bill.setBill_date(rs.getTimestamp("bill_date"));
	                    bill.setTotal_amount(rs.getDouble("total_amount"));
	                }
	            }
	        }

	        if (bill == null) return null;

	        // Load items + book name/code
	        try (PreparedStatement psItems = conn.prepareStatement(billItemsSQL)) {
	            psItems.setInt(1, billId);
	            try (ResultSet rs = psItems.executeQuery()) {
	                List<BillItem> items = new ArrayList<>();
	                while (rs.next()) {
	                    BillItem it = new BillItem();
	                    it.setBill_item_id(String.valueOf(rs.getInt("id")));
	                    it.setBill_number(String.valueOf(rs.getInt("bill_id")));
	                    it.setItemId(rs.getInt("item_id"));

	                    it.setItem_code(rs.getString("item_code")); // Book Code
	                    it.setBook_name(rs.getString("item_name")); // Book Name

	                    it.setQuantity(rs.getInt("quantity"));
	                    it.setPrice(rs.getDouble("price")); // historical price
	                    items.add(it);
	                }
	                bill.setBill_items(items);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return bill;
	}

    // READ ALL BILLS
    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills ORDER BY bill_date DESC";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBill_number(String.valueOf(rs.getInt("id")));
                bill.setCustomer_account_no(rs.getString("customer_id"));
                bill.setBill_date(rs.getTimestamp("bill_date"));
                bill.setTotal_amount(rs.getDouble("total_amount"));
                bills.add(bill);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error fetching all bills: " + e.getMessage());
            e.printStackTrace();
        }

        return bills;
    }

    // UPDATE BILL (basic fields only)
    public boolean updateBill(Bill bill) {
        String sql = "UPDATE bills SET customer_id=?, bill_date=?, total_amount=? WHERE id=?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bill.getCustomer_account_no());
            ps.setTimestamp(2, new java.sql.Timestamp(bill.getBill_date().getTime()));
            ps.setDouble(3, bill.getTotal_amount());
            ps.setInt(4, Integer.parseInt(bill.getBill_number()));

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error updating bill: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // DELETE BILL (and its items)
    public boolean deleteBill(int billId) {
        String deleteItems = "DELETE FROM bill_items WHERE bill_id=?";
        String deleteBill = "DELETE FROM bills WHERE id=?";

        try (Connection conn = DBConnectionFactory.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psItems = conn.prepareStatement(deleteItems)) {
                psItems.setInt(1, billId);
                psItems.executeUpdate();
            }

            try (PreparedStatement psBill = conn.prepareStatement(deleteBill)) {
                psBill.setInt(1, billId);
                psBill.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            System.out.println("❌ Error deleting bill: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
