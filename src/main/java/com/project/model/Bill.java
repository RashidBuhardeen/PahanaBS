package com.project.model;

import java.util.Date;
import java.util.List;

public class Bill {

    private String bill_number;          // Unique bill number
    private String customer_account_no;  // Foreign key to Customer.account_number
    private Date bill_date;
    private double total_amount;
    private List<BillItem> bill_items;

    public Bill() {
    }

    public Bill(String bill_number, String customer_account_no, Date bill_date, double total_amount,
                List<BillItem> bill_items) {
        this.bill_number = bill_number;
        this.customer_account_no = customer_account_no;
        this.bill_date = bill_date;
        this.total_amount = total_amount;
        this.bill_items = bill_items;
    }

    public String getBill_number() {
        return bill_number;
    }

    public void setBill_number(String bill_number) {
        this.bill_number = bill_number;
    }

    public String getCustomer_account_no() {
        return customer_account_no;
    }

    public void setCustomer_account_no(String customer_account_no) {
        this.customer_account_no = customer_account_no;
    }

    public Date getBill_date() {
        return bill_date;
    }

    public void setBill_date(Date bill_date) {
        this.bill_date = bill_date;
    }

    public double getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(double total_amount) {
        this.total_amount = total_amount;
    }

    public List<BillItem> getBill_items() {
        return bill_items;
    }

    public void setBill_items(List<BillItem> bill_items) {
        this.bill_items = bill_items;
    }
}
