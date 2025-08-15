package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.project.model.Customer;

public class CustomerDAO {

    public void addCustomer(Customer customer) {
        String query = "INSERT INTO customer (account_no, name, address, telephone_number, email) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, customer.getAccount_number());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getAddress());
            pstmt.setString(4, customer.getTelephone_number());
            pstmt.setString(5, customer.getEmail());
            pstmt.executeUpdate();
            
            System.out.println("✅ Customer added to database successfully");
            
        } catch (SQLException e) {
            System.out.println("❌ Error adding customer: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // FIXED: Column names must match your database table
    public List<Customer> viewCustomer() throws SQLException {
        System.out.println("=== CustomerDAO.viewCustomer() START ===");
        
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customer";
        
        try (Connection connection = DBConnectionFactory.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet resultSet = stmt.executeQuery(query)) {
            
            System.out.println("✅ Database query executed: " + query);
            int count = 0;
            
            while (resultSet.next()) {
                count++;
                // FIXED: Use correct column names that match your database
                String account_no = resultSet.getString("account_no");           // Not "account_number"
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telephone = resultSet.getString("telephone_number");      // Not "telephone"
                String email = resultSet.getString("email");
                
                System.out.println("Loading customer " + count + ": " + name + " (" + account_no + ")");
                
                // Create customer using constructor
                Customer customer = new Customer(account_no, name, address, telephone, email);
                customers.add(customer);
            }
            
            System.out.println("✅ Total customers loaded: " + count);
            
        } catch (SQLException e) {
            System.out.println("❌ Database error in viewCustomer(): " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        
        System.out.println("=== CustomerDAO.viewCustomer() END ===");
        return customers;
    }
    
    public void updateCustomer(Customer customer) {
        // FIXED: Column names to match database
        String query = "UPDATE customer SET name = ?, address = ?, telephone_number = ?, email = ? WHERE account_no = ?";
        
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, customer.getName());
            pstmt.setString(2, customer.getAddress());
            pstmt.setString(3, customer.getTelephone_number());
            pstmt.setString(4, customer.getEmail());
            pstmt.setString(5, customer.getAccount_number());
            pstmt.executeUpdate();
            
            System.out.println("✅ Customer updated successfully");
            
        } catch (SQLException e) {
            System.out.println("❌ Error updating customer: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public void deleteCustomer(String accountNumber) {
        // FIXED: Use correct column name
        String query = "DELETE FROM customer WHERE account_no = ?";
        
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, accountNumber);
            int rowsAffected = pstmt.executeUpdate();
            
            System.out.println("✅ Delete operation affected " + rowsAffected + " rows");
            
        } catch (SQLException e) {
            System.out.println("❌ Error deleting customer: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException {
        System.out.println("=== Getting customer by account number: " + accountNumber + " ===");
        
        Customer customer = null;
        String query = "SELECT * FROM customer WHERE account_no = ?";
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBConnectionFactory.getConnection();
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, accountNumber);
            resultSet = pstmt.executeQuery();
            
            if (resultSet.next()) {
                // FIXED: Use consistent column names
                String account_no = resultSet.getString("account_no");
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telephone = resultSet.getString("telephone_number");      // FIXED
                String email = resultSet.getString("email");
                
                customer = new Customer(account_no, name, address, telephone, email);
                System.out.println("✅ Found customer: " + name);
            } else {
                System.out.println("❌ No customer found with account number: " + accountNumber);
            }
            
        } catch (SQLException e) {
            System.out.println("❌ Error getting customer: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return customer;
    }
}