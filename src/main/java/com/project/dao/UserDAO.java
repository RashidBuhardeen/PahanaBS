package com.project.dao;

import com.project.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public void addUser(User user) {
        String query = "INSERT INTO user (username, password, role) VALUES (?, ?, ?)";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // ⚠️ Should be hashed in service layer
            pstmt.setString(3, user.getRole());
            pstmt.executeUpdate();

            System.out.println("✅ User added to database successfully");

        } catch (SQLException e) {
            System.out.println("❌ Error adding user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<User> viewUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user";

        try (Connection connection = DBConnectionFactory.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            int count = 0;
            while (rs.next()) {
                count++;
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role");

                User user = new User(id, username, password, role);
                users.add(user);

                System.out.println("Loading user " + count + ": " + username);
            }
            System.out.println("✅ Total users loaded: " + count);

        } catch (SQLException e) {
            System.out.println("❌ Error fetching users: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return users;
    }

    public void updateUser(User user) {
        String query = "UPDATE user SET username = ?, password = ?, role = ? WHERE id = ?";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // ⚠️ Hash in service layer
            pstmt.setString(3, user.getRole());
            pstmt.setInt(4, user.getId());

            pstmt.executeUpdate();
            System.out.println("✅ User updated successfully");

        } catch (SQLException e) {
            System.out.println("❌ Error updating user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deleteUser(int id) {
        String query = "DELETE FROM user WHERE id = ?";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("✅ Delete operation affected " + rowsAffected + " rows");

        } catch (SQLException e) {
            System.out.println("❌ Error deleting user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public User getUserById(int id) throws SQLException {
        User user = null;
        String query = "SELECT * FROM user WHERE id = ?";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                    System.out.println("✅ Found user: " + user.getUsername());
                } else {
                    System.out.println("❌ No user found with ID: " + id);
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error fetching user by ID: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return user;
    }
}
