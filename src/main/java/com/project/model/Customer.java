package com.project.model;

public class Customer {

	private String account_number;
	private String name;
	private String address;
	private String telephone_number;
	private String email;
	
	
	public Customer() {
		
	}
	
	public Customer(String account_number, String name, String address, String telephone_number, String email) {
		super();
		this.account_number = account_number;
		this.name = name;
		this.address = address;
		this.telephone_number = telephone_number;
		this.email = email;
	}


	public String getAccount_number() {
		return account_number;
	}


	public void setAccount_number(String account_number) {
		this.account_number = account_number;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getTelephone_number() {
		return telephone_number;
	}


	public void setTelephone_number(String telephone_number) {
		this.telephone_number = telephone_number;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}
	
}
