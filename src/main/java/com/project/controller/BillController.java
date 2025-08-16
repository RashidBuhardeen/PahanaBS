package com.project.controller;

import com.project.dao.BillDAO;
import com.project.model.Bill;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/bill")
public class BillController extends HttpServlet {
	 private static final long serialVersionUID = 1L;

    private BillDAO billDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from form
        try {
        	String customerAccountNo = request.getParameter("customer_id");
            String billDateStr = request.getParameter("bill_date");
            double totalAmount = Double.parseDouble(request.getParameter("total_amount"));

            // Convert String to SQL Date
            Date billDate = Date.valueOf(billDateStr);

            // Create Bill object
            Bill bill = new Bill();
            bill.setCustomer_account_no(customerAccountNo);
            bill.setBill_date(billDate);
            bill.setTotal_amount(totalAmount);

            // Save to database
            boolean success = billDAO.createBill(bill);

            if (success) {
                request.setAttribute("message", "Bill created successfully!");
            } else {
                request.setAttribute("message", "Failed to create bill.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid number format in input.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("message", "Invalid date format. Please use YYYY-MM-DD.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred: " + e.getMessage());
        }

        // Forward back to JSP page
        request.getRequestDispatcher("bill_form.jsp").forward(request, response);
    }
}