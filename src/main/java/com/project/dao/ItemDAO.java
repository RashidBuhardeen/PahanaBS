package com.project.dao;

import com.project.model.Item;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public ItemDAO() {
        // No need to store a single connection; always fetch when needed.
        // This avoids stale or closed connection issues.
    }

    // Add new item
    public void addItem(Item item) {
        String sql = "INSERT INTO items (item_code, item_name, price, stock_quantity) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnectionFactory.getConnection();
        	 PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getStockQuantity());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update item
    public void updateItem(Item item) {
        String sql = "UPDATE items SET item_code=?, item_name=?, price=?, stock_quantity=? WHERE id=?";
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getStockQuantity());
            ps.setInt(5, item.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete item
    public void deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id=?";
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get item by ID
    public Item getItemById(int id) {
        String sql = "SELECT * FROM items WHERE id=?";
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Item(
                        rs.getInt("id"),
                        rs.getString("item_code"),
                        rs.getString("item_name"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all items
    public List<Item> getAllItems() {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT * FROM items";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Item(
                        rs.getInt("id"),
                        rs.getString("item_code"),
                        rs.getString("item_name"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
