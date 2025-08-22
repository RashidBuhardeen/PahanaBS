package com.project.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/navigate")
public class NavController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "dashboard";
        }

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (username == null && !"login".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("login".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/login.jsp").forward(request, response);
        } else if ("dashboard".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/dashboard.jsp").forward(request, response);
        } else if ("customers".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/customer/view-customers.jsp").forward(request, response);
        } else if ("items".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/user/view-user.jsp").forward(request, response);
        } else if ("user".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/user/view-user.jsp").forward(request, response);
        } else if ("bills".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/View/bill/view-bills.jsp").forward(request, response);
        } else if ("logout".equals(action)) {
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            request.getRequestDispatcher("/WEB-INF/View/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}