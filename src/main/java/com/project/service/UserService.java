
package com.project.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.project.dao.DBConnectionFactory;
import com.project.dao.UserDAO;
import com.project.model.User;

public class UserService {

    private static UserService instance;
    private UserDAO userDAO;

    private UserService() {
        this.userDAO = new UserDAO();
    }

    public static UserService getInstance() {
        if (instance == null) {
            synchronized (UserService.class) {
                if (instance == null) {
                    instance = new UserService();
                }
            }
        }
        return instance;
    }

    public void addUser(User user) {
        userDAO.addUser(user);
    }

    public List<User> viewUsers() throws SQLException {
        System.out.println("=== UserService.viewUsers() called ===");
        return userDAO.viewUsers();
    }

    public User getUserById(int id) throws SQLException {
        return userDAO.getUserById(id);
    }

    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }

    public User authenticate(String username, String password) {
        return userDAO.authenticate(username, password);
    }
    
    
    
}
        
