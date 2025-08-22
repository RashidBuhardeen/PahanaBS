package com.project.controller;

import com.project.model.User;
import com.project.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() {
        userService = UserService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "addUser":
                req.getRequestDispatcher("/WEB-INF/View/user/add-user.jsp").forward(req, resp);
                break;
            case "editUser":
                showEditForm(req, resp);
                break;
            case "deleteUser":
                deleteUser(req, resp);
                break;
            default:
                viewUsers(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("addUser".equals(action)) {
            saveUser(req, resp, false);
        } else if ("updateUser".equals(action)) {
            saveUser(req, resp, true);
        }
    }

    private void saveUser(HttpServletRequest req, HttpServletResponse resp, boolean update)
            throws IOException {
        User user = new User();
        user.setId(req.getParameter("id") != null ? Integer.parseInt(req.getParameter("id")) : 0);
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password")); // should be hashed before saving
        user.setRole(req.getParameter("role"));

        if (update) {
            userService.updateUser(user);
        } else {
            userService.addUser(user);
        }
        resp.sendRedirect("navigate?action=users");
    }

    private void viewUsers(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<User> list = userService.viewUsers();
            req.setAttribute("user_list", list);
            req.getRequestDispatcher("/WEB-INF/View/user/view-user.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Error fetching users", e);
        }
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        userService.deleteUser(Integer.parseInt(req.getParameter("id")));
        resp.sendRedirect("navigate?action=users");
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = userService.getUserById(id);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/View/user/edit-user.jsp").forward(req, resp);
        } catch (SQLException e) {
            resp.sendRedirect("navigate?action=users");
        }
    }
}
