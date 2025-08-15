package com.project.dao;

import com.project.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

 
    /**
     * Get user by username (for login validation)
     */
    public User getUserByUsername(String username) {
        
    	String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection connection = DBConnectionFactory.getConnection();	
        	 PreparedStatement ps = connection.prepareStatement(sql);	
        	) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by username: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Add new user (registration)
     */
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        try (Connection connection = DBConnectionFactory.getConnection();
        	 PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // Consider hashing before storing
            ps.setString(3, user.getRole());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding new user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
