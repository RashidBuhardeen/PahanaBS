package com.project.service;

import java.sql.SQLException;
import java.util.List;

import com.project.dao.CustomerDAO;
import com.project.model.Customer;


public class CustomerService {

	private static CustomerService instance;
	private CustomerDAO customerDAO;
	
	private CustomerService() {
		this.customerDAO = new CustomerDAO();
	}
	
	public static CustomerService getInstance() {
		if (instance == null) {
			synchronized (CustomerService.class) {
				if(instance == null) {
					instance = new CustomerService();
				}
			}
		}
		return instance;
	}
	
	public void addCustomer (Customer customer) {
		customerDAO.addCustomer(customer);
	}
	
	public List<Customer> viewCustomer() throws SQLException {
        System.out.println("=== CustomerService.ViewAccountDetails() called ===");
        return customerDAO.viewCustomer();  // Call the DAO method
    }
	
	public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException{
		return customerDAO.getCustomerByAccountNumber(accountNumber);
	}
	
	public void updateCustomer(Customer customer) {
		customerDAO.updateCustomer(customer);
	}
	
	public void deleteCustomer(String accountNumber) {
		customerDAO.deleteCustomer(accountNumber);
	}
	
	
}
