package com.project.controller;

import com.project.dao.BillDAO;
import com.project.model.Bill;
import com.project.model.BillItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/bill")
public class BillController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BillDAO billDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {
        case "create":
            request.getRequestDispatcher("/WEB-INF/View/bill/create-bill.jsp").forward(request, response);
            break;
        case "edit":
            editBill(request, response);
            break;
        case "delete":
            deleteBill(request, response);
            break;
        case "view":
            viewBill(request, response);
            break;
        case "print":
            printBill(request, response);
            break;
        default:
            listBills(request, response);
            break;
    }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createBill(request, response);
        } else if ("update".equals(action)) {
            updateBill(request, response);
        } else {
            response.sendRedirect("bill?action=list");
        }
    }

    // List all bills
    private void listBills(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Bill> bills = billDAO.getAllBills();
        request.setAttribute("bills", bills);
        request.getRequestDispatcher("views/bill/list-bills.jsp").forward(request, response);
    }

    // View single bill
    private void viewBill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        Bill bill = billDAO.getBillById(billId);
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("views/bill/view-bill.jsp").forward(request, response);
    }

    // Create new bill
    private void createBill(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String customerAccount = request.getParameter("account_no");
            String[] selectedItems = request.getParameterValues("item");
            List<BillItem> billItems = new ArrayList<>();
            double totalAmount = 0.0;

            if (selectedItems != null) {
                for (String itemName : selectedItems) {
                    int quantity = Integer.parseInt(request.getParameter("qty_" + itemName.replaceAll(" ","_")));
                    double price = Double.parseDouble(request.getParameter("price_" + itemName.replaceAll(" ","_")));
                    totalAmount += price * quantity;

                    BillItem billItem = new BillItem();
                    billItem.setItem_code(itemName); // storing item_name as item_code
                    billItem.setQuantity(quantity);
                    billItem.setPrice(price);
                    billItems.add(billItem);
                }
            }

            Bill bill = new Bill();
            bill.setCustomer_account_no(customerAccount);
            bill.setBill_date(new Date());
            bill.setTotal_amount(totalAmount);
            bill.setBill_items(billItems);

            boolean success = billDAO.createBill(bill);
            if (success) {
                response.sendRedirect("navigate?action=bills");
            } else {
                request.setAttribute("error", "Failed to create bill!");
                request.getRequestDispatcher("views/bill/create-bill.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("views/bill/create-bill.jsp").forward(request, response);
        }
    }

    // Edit bill (load for update)
    private void editBill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        Bill bill = billDAO.getBillById(billId);
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("views/bill/edit-bill.jsp").forward(request, response);
    }

    // Update bill
    private void updateBill(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int billId = Integer.parseInt(request.getParameter("bill_id"));
            String customerAccount = request.getParameter("account_no");
            double totalAmount = Double.parseDouble(request.getParameter("total_amount"));

            Bill bill = new Bill();
            bill.setBill_number(String.valueOf(billId));
            bill.setCustomer_account_no(customerAccount);
            bill.setBill_date(new Date());
            bill.setTotal_amount(totalAmount);

            boolean success = billDAO.updateBill(bill);
            if (success) {
                response.sendRedirect("bill?action=list");
            } else {
                request.setAttribute("error", "Failed to update bill!");
                editBill(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            editBill(request, response);
        }
    }

    // Delete bill
    private void deleteBill(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        billDAO.deleteBill(billId);
        response.sendRedirect("bill?action=list");
    }
    
    
    // Print bill
    private void printBill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        Bill bill = billDAO.getBillById(billId);
        if (bill != null) {
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("/WEB-INF/View/bill/print-bill.jsp").forward(request, response);
        } else {
            response.getWriter().println("Bill not found!");
        }
    }
}
