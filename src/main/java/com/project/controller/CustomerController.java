package com.project.controller;

import java.io.IOException;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.model.Customer;
import com.project.service.CustomerService;



/**
 * Servlet implementation class CustomerController
 */

public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private CustomerService customerService;

	public void init() throws ServletException {
		customerService = CustomerService.getInstance();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if (action == null || action.equals("list")) {
			viewCustomer(request, response);
		} else if (action.equals("addCustomer")) {
			request.getRequestDispatcher("WEB-INF/View/AddCustomer.jsp").forward(request, response);
		} else if (action.equals("editCustomer")) {
			showEditForm(request, response);
		} else if (action.equals("deleteCustomer")) {
			deleteCustomer(request, response);
		} else {
			response.sendRedirect("CustomerController?action=list");
		}	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("addCustomer")) {
			addCustomer(request, response);
		} else if (action.equals("updateCustomer")) {
			updateCustomer(request, response);
		}
	}
	
	private void addCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String account_no = request.getParameter("account_no");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String telephone = request.getParameter("telephone");
		String email = request.getParameter("email");
	
		Customer customer = new Customer();
		customer.setAccount_number(account_no);
		customer.setName(name);
		customer.setAddress(address);
		customer.setTelephone_number(telephone); 
		customer.setEmail(email); 
		
		customerService.addCustomer(customer);
		response.sendRedirect("CustomerController?action=list"); 
	}
	
	private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Customer> AccountList = new ArrayList<Customer>();
		try {
			AccountList = customerService.viewCustomer();
			request.setAttribute("account_list", AccountList);
		} catch (SQLException e) {
			e.printStackTrace(); 
		}
		request.getRequestDispatcher("WEB-INF/View/ViewCustomer.jsp").forward(request, response);
	}
	
	private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String account_no = request.getParameter("account_no");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String telephone = request.getParameter("telephone");
		String email = request.getParameter("email");

		Customer customer = new Customer();
		customer.setAccount_number(account_no);
		customer.setName(name);
		customer.setAddress(address);
		customer.setTelephone_number(telephone);
		customer.setEmail(email);

		customerService.updateCustomer(customer);
		response.sendRedirect("CustomerController?action=list");
	}
	
	private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accountNumber = request.getParameter("id");
		customerService.deleteCustomer(accountNumber);
		response.sendRedirect("CustomerController?action=list");
	}
	
	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accountNumber = request.getParameter("id");
		try {
			Customer customer = customerService.getCustomerByAccountNumber(accountNumber);
			request.setAttribute("customer", customer);
			request.getRequestDispatcher("WEB-INF/View/EditCustomer.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("CustomerController?action=list");
		}
	}

}
