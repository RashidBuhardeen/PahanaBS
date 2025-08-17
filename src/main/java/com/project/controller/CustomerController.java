package com.project.controller;

import com.project.model.Customer;
import com.project.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer")
public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService;

    @Override
    public void init() { 
        customerService = CustomerService.getInstance(); 
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "addCustomer":
                req.getRequestDispatcher("/WEB-INF/View/customer/add-customer.jsp").forward(req, resp);
                break;
            case "editCustomer":
                showEditForm(req, resp);
                break;
            case "deleteCustomer":
                deleteCustomer(req, resp);
                break;
            default:
                viewCustomer(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("addCustomer".equals(action)) {
            saveCustomer(req, resp, false);
        } else if ("updateCustomer".equals(action)) {
            saveCustomer(req, resp, true);
        }
    }

    private void saveCustomer(HttpServletRequest req, HttpServletResponse resp, boolean update) 
            throws IOException {
        Customer customer = new Customer();
        customer.setAccount_number(req.getParameter("account_no"));
        customer.setName(req.getParameter("name"));
        customer.setAddress(req.getParameter("address"));
        customer.setTelephone_number(req.getParameter("telephone"));
        customer.setEmail(req.getParameter("email"));

        if (update) {
            customerService.updateCustomer(customer);
        } else {
            customerService.addCustomer(customer);
        }
        resp.sendRedirect("navigate?action=customers");
    }

    private void viewCustomer(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            List<Customer> list = customerService.viewCustomer();
            req.setAttribute("account_list", list);
            req.getRequestDispatcher("/WEB-INF/View/customer/view-customer.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Error fetching customers", e);
        }
    }

    private void deleteCustomer(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        customerService.deleteCustomer(req.getParameter("id"));
        resp.sendRedirect("navigate?action=customers");
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            Customer customer = customerService.getCustomerByAccountNumber(req.getParameter("id"));
            req.setAttribute("customer", customer);
            req.getRequestDispatcher("/WEB-INF/View/customer/edit-customer.jsp").forward(req, resp);
        } catch (SQLException e) {
            resp.sendRedirect("navigate?action=customers");
        }
    }
}
