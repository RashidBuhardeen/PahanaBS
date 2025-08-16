package com.project.controller;

import com.project.model.User;
import com.project.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles login requests (GET → show login page, POST → authenticate user).
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        // Initialize UserService (Singleton)
        userService = UserService.getInstance();
    }

    /**
     * Handles GET requests → Show login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    /**
     * Handles POST requests → Authenticate user.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (isNullOrEmpty(username) || isNullOrEmpty(password)) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = userService.authenticate(username, password);

        if (user != null) {
            // Valid credentials → create session
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            // Redirect based on role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            // Invalid credentials → show error
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    /**
     * Utility method to check for null or empty strings.
     */
    private boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
