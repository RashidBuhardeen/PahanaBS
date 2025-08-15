package com.project.model;

public class BillItem {

    private String bill_item_id;   // Unique ID for bill item
    private String bill_number;    // Foreign key to Bill.bill_number
    private String item_code;      // Foreign key to Item.item_code
    private int quantity;
    private double price;          // Price at time of billing

    public BillItem() {
    }

    public BillItem(String bill_item_id, String bill_number, String item_code, int quantity, double price) {
        super();
        this.bill_item_id = bill_item_id;
        this.bill_number = bill_number;
        this.item_code = item_code;
        this.quantity = quantity;
        this.price = price;
    }

    public String getBill_item_id() {
        return bill_item_id;
    }

    public void setBill_item_id(String bill_item_id) {
        this.bill_item_id = bill_item_id;
    }

    public String getBill_number() {
        return bill_number;
    }

    public void setBill_number(String bill_number) {
        this.bill_number = bill_number;
    }

    public String getItem_code() {
        return item_code;
    }

    public void setItem_code(String itemId) {
        this.item_code = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

	
}
