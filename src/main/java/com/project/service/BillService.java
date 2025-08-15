package com.project.service;

import com.project.dao.BillDAO;
import com.project.model.Bill;

import java.util.List;

public class BillService {
    private BillDAO billDAO;
    public static BillService instance;

    public static BillService getInstance() {
        if (instance == null) {
            synchronized (BillService.class) {
                if (instance == null) {
                    instance = new BillService();
                }
            }
        }
        return instance;
    }
    
    public BillService() {
        billDAO = new BillDAO();
    }

    public boolean createBill(Bill bill) {
        return billDAO.createBill(bill);
    }

    public Bill getBillById(int billId) {
        return billDAO.getBillById(billId);
    }

    public List<Bill> getAllBills() {
        return billDAO.getAllBills();
    }
}
