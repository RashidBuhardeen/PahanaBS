package com.project.dao;

import com.project.model.Bill;
import com.project.model.BillItem;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public boolean createBill(Bill bill) {
        String insertBillSQL = "INSERT INTO bills (customer_id, bill_date, total_amount) VALUES (?, ?, ?)";
        String insertBillItemSQL = "INSERT INTO bill_items (bill_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";
        boolean success = false;

        try (Connection conn = DBConnectionFactory.getConnection()) {
            conn.setAutoCommit(false);

            // Insert into bills table
            try (PreparedStatement psBill = conn.prepareStatement(insertBillSQL, Statement.RETURN_GENERATED_KEYS)) {
                psBill.setString(1, bill.getCustomer_account_no());
                psBill.setTimestamp(2, new java.sql.Timestamp(bill.getBill_date().getTime()));
                psBill.setDouble(3, bill.getTotal_amount());
                int affectedRows = psBill.executeUpdate();

                if (affectedRows == 0) {
                    throw new SQLException("❌ Creating bill failed, no rows affected.");
                }

                try (ResultSet generatedKeys = psBill.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int billId = generatedKeys.getInt(1);
                        bill.setBill_number(insertBillItemSQL);

                        // Insert bill items
                        try (PreparedStatement psBillItem = conn.prepareStatement(insertBillItemSQL)) {
                            for (BillItem item : bill.getBill_items()) {
                                psBillItem.setInt(1, billId);
                                psBillItem.setString(2, item.getBill_item_id());
                                psBillItem.setInt(3, item.getQuantity());
                                psBillItem.setDouble(4, item.getPrice());
                                psBillItem.addBatch();
                            }
                            psBillItem.executeBatch();
                        }
                    } else {
                        throw new SQLException("❌ Creating bill failed, no ID obtained.");
                    }
                }
            }

            conn.commit();
            success = true;

        } catch (SQLException e) {
            System.out.println("❌ Error creating bill: " + e.getMessage());
            e.printStackTrace();
        }

        return success;
    }

    public Bill getBillById(int billId) {
        Bill bill = null;
        String billSQL = "SELECT * FROM bills WHERE id = ?";
        String billItemsSQL = "SELECT * FROM bill_items WHERE bill_id = ?";

        try (Connection conn = DBConnectionFactory.getConnection()) {

            try (PreparedStatement psBill = conn.prepareStatement(billSQL)) {
                psBill.setInt(1, billId);
                try (ResultSet rsBill = psBill.executeQuery()) {

                    if (rsBill.next()) {
                        bill = new Bill();
                        bill.setBill_number("id");
                        bill.setCustomer_account_no(rsBill.getString("customer_id"));
                        bill.setBill_date(rsBill.getDate("bill_date"));
                        bill.setTotal_amount(rsBill.getDouble("total_amount"));

                        // Get bill items
                        try (PreparedStatement psItems = conn.prepareStatement(billItemsSQL)) {
                            psItems.setInt(1, billId);
                            try (ResultSet rsItems = psItems.executeQuery()) {
                                List<BillItem> items = new ArrayList<>();
                                while (rsItems.next()) {
                                    BillItem item = new BillItem();
                                    item.setBill_item_id("id");
                                    item.setBill_number("id");
                                    item.setItem_code("item_code");
                                    item.setQuantity(rsItems.getInt("quantity"));
                                    item.setPrice(rsItems.getDouble("price"));
                                    items.add(item);
                                }
                                bill.setBill_items(items);
                            }
                        }
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("❌ Error fetching bill: " + e.getMessage());
            e.printStackTrace();
        }

        return bill;
    }

    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills ORDER BY bill_date DESC";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBill_number("id");
                bill.setCustomer_account_no("");
                bill.setBill_date(rs.getDate("bill_date"));
                bill.setTotal_amount(rs.getDouble("total_amount"));
                bills.add(bill);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error fetching all bills: " + e.getMessage());
            e.printStackTrace();
        }

        return bills;
    }
}