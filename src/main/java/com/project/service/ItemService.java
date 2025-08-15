package com.project.service;

import com.project.dao.ItemDAO;
import com.project.model.Item;

import java.sql.SQLException;
import java.util.List;

public class ItemService {

    private static ItemService instance;
    private ItemDAO itemDAO;

    // Private constructor to enforce Singleton
    private ItemService() {
        this.itemDAO = new ItemDAO();
    }

    // Thread-safe Singleton getter
    public static ItemService getInstance() {
        if (instance == null) {
            synchronized (ItemService.class) {
                if (instance == null) {
                    instance = new ItemService();
                }
            }
        }
        return instance;
    }

    public void addItem(Item item) {
        itemDAO.addItem(item);
        
    }

    public void updateItem(Item item) {
        itemDAO.updateItem(item);
    }

    public void deleteItem(int id) {
       itemDAO.deleteItem(id);
    }

    public Item getItemById(int id) {
        return itemDAO.getItemById(id);
    }

    public List<Item> getAllItems() throws SQLException {
        System.out.println("=== ItemService.getAllItems() called ===");
        return itemDAO.getAllItems();
    }
}
