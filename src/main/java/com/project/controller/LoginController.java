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
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/login.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
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
            request.getRequestDispatcher("/WEB-INF/View/login.jsp").forward(request, response);
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
                // Forward internally to admin dashboard JSP (under WEB-INF)
                request.getRequestDispatcher("/WEB-INF/View/dashboard.jsp").forward(request, response);

            } else if ("cashier".equalsIgnoreCase(user.getRole())) {
                // Redirect to the CashierDashboardController (which forwards to /WEB-INF/View/cashier/cashier-db.jsp)
//                response.sendRedirect("/WEB-INF/View/cashier/cashier-db.jsp");
                request.getRequestDispatcher("/WEB-INF/View/cashier/cashier-db.jsp").forward(request, response);

            } else {
                // Fallback for other roles, if any
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } else {
            // Invalid credentials → show error
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/View/login.jsp").forward(request, response);
        }
    }

    /**
     * Utility method to check for null or empty strings.
     */
    private boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
