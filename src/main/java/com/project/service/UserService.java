package com.project.service;

import com.project.dao.UserDAO;
import com.project.model.User;

public class UserService {

    private static UserService instance;
    private UserDAO userDAO;

    // Private constructor for singleton
    private UserService() {
        this.userDAO = new UserDAO();
    }

    // Singleton instance
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

    // Validate login credentials
    public User authenticate(String username, String password) {
        User user = userDAO.getUserByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            // In production, use hashed passwords and secure verification
            return user;
        }
        return null;
    }

    // Register new user
    public boolean registerUser(User user) {
        return userDAO.addUser(user);
    }
}
