package com.project.model;

public class Item {

    private int id;
    private String itemCode;
    private String itemName;
    private double price;
    private int stockQuantity;

    // No-args constructor (required for frameworks and easy instantiation)
    public Item() {
    }

    // All-args constructor
    public Item(int id, String itemCode, String itemName, double price, int stockQuantity) {
        this.id = id;
        this.itemCode = itemCode;
        this.itemName = itemName;
        this.price = price;
        this.stockQuantity = stockQuantity;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getItemCode() {
        return itemCode;
    }
    public void setItemCode(String itemCode) {
        this.itemCode = itemCode != null ? itemCode.trim() : null;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName != null ? itemName.trim() : null;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        if (price >= 0) {  // Prevents negative prices
            this.price = price;
        }
    }

    public int getStockQuantity() {
        return stockQuantity;
    }
    public void setStockQuantity(int stockQuantity) {
        if (stockQuantity >= 0) { // Prevents negative stock
            this.stockQuantity = stockQuantity;
        }
    }

    // Optional: toString method for debugging/logging
    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", itemCode='" + itemCode + '\'' +
                ", itemName='" + itemName + '\'' +
                ", price=" + price +
                ", stockQuantity=" + stockQuantity +
                '}';
    }
}
