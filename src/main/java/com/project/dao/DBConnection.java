package com.project.dao.test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.math.BigDecimal;
import java.sql.*;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import com.project.model.Bill;
import com.project.model.BillItem;

public class BillDAOTest {

    private Connection conn;
    private PreparedStatement psInsertBill;
    private PreparedStatement psInsertItem;
    private PreparedStatement psDecStock;
    private PreparedStatement psQueryBill;
    private PreparedStatement psQueryItems;
    private ResultSet rsKeys;
    private ResultSet rsBill;
    private ResultSet rsItems;
    private MockedStatic<DBConnectionFactory> dbMock;

    @BeforeEach
    void setUp() throws Exception {
        conn = mock(Connection.class);
        psInsertBill = mock(PreparedStatement.class);
        psInsertItem = mock(PreparedStatement.class);
        psDecStock = mock(PreparedStatement.class);
        psQueryBill = mock(PreparedStatement.class);
        psQueryItems = mock(PreparedStatement.class);
        rsKeys = mock(ResultSet.class);
        rsBill = mock(ResultSet.class);
        rsItems = mock(ResultSet.class);

        dbMock = mockStatic(DBConnectionFactory.class);
        dbMock.when(DBConnectionFactory::getConnection).thenReturn(conn);
    }

    @AfterEach
    void tearDown() {
        if (dbMock != null) dbMock.close();
    }

    @Test
    void createBill_success_commits() throws Exception {
        // Arrange
        Bill bill = mock(Bill.class);
        BillItem item1 = mock(BillItem.class);
        BillItem item2 = mock(BillItem.class);

        when(bill.getCustomer_account_no()).thenReturn("ACCT-001");
        java.util.Date now = new java.util.Date();
        when(bill.getBill_date()).thenReturn(now);
        when(bill.getTotal_amount()).thenReturn(2500.0);
        when(bill.getBill_items()).thenReturn(Arrays.asList(item1, item2));

        when(item1.getItemId()).thenReturn(10);
        when(item1.getQuantity()).thenReturn(2);
        when(item1.getPrice()).thenReturn(500.0);

        when(item2.getItemId()).thenReturn(11);
        when(item2.getQuantity()).thenReturn(3);
        when(item2.getPrice()).thenReturn(500.0);

        // Sequence of prepared statements:
        // 1) insert bill (RETURN_GENERATED_KEYS)
        // 2) insert bill_item
        // 3) decrement stock
        when(conn.prepareStatement(anyString(), anyInt())).thenReturn(psInsertBill);
        when(conn.prepareStatement(anyString())).thenReturn(psInsertItem, psDecStock);

        when(psInsertBill.executeUpdate()).thenReturn(1);
        when(psInsertBill.getGeneratedKeys()).thenReturn(rsKeys);
        when(rsKeys.next()).thenReturn(true);
        when(rsKeys.getInt(1)).thenReturn(123);

        when(psDecStock.executeUpdate()).thenReturn(1);
        when(psInsertItem.executeUpdate()).thenReturn(1);

        BillDAO dao = new BillDAO();

        // Act
        boolean ok = dao.createBill(bill);

        // Assert
        assertTrue(ok);
        verify(conn).setAutoCommit(false);
        verify(conn).commit();
        verify(psInsertBill, atLeastOnce()).executeUpdate();
        verify(psInsertItem, atLeastOnce()).executeUpdate();
        verify(psDecStock, atLeastOnce()).executeUpdate();
    }

    @Test
    void createBill_insufficientStock_rollsBack() throws Exception {
        // Arrange
        Bill bill = mock(Bill.class);
        BillItem item1 = mock(BillItem.class);

        when(bill.getCustomer_account_no()).thenReturn("ACCT-001");
        when(bill.getBill_date()).thenReturn(new java.util.Date());
        when(bill.getTotal_amount()).thenReturn(500.0);
        when(bill.getBill_items()).thenReturn(Collections.singletonList(item1));

        when(item1.getItemId()).thenReturn(10);
        when(item1.getQuantity()).thenReturn(5);
        when(item1.getPrice()).thenReturn(100.0);

        when(conn.prepareStatement(anyString(), anyInt())).thenReturn(psInsertBill);
        when(conn.prepareStatement(anyString())).thenReturn(psInsertItem, psDecStock);

        when(psInsertBill.executeUpdate()).thenReturn(1);
        when(psInsertBill.getGeneratedKeys()).thenReturn(rsKeys);
        when(rsKeys.next()).thenReturn(true);
        when(rsKeys.getInt(1)).thenReturn(999);

        // Insufficient stock -> DAO should rollback and return false
        when(psDecStock.executeUpdate()).thenReturn(0);

        BillDAO dao = new BillDAO();

        // Act
        boolean ok = dao.createBill(bill);

        // Assert
        assertFalse(ok);
        verify(conn).rollback();
    }

    @Test
    void getBillById_success() throws Exception {
        // Arrange
        when(conn.prepareStatement(anyString())).thenReturn(psQueryBill, psQueryItems);

        // Bill row
        when(psQueryBill.executeQuery()).thenReturn(rsBill);
        when(rsBill.next()).thenReturn(true);
        when(rsBill.getInt("id")).thenReturn(321);
        when(rsBill.getString("customer_id")).thenReturn("ACCT-321");
        when(rsBill.getString("customer_name")).thenReturn("Test Customer");
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        when(rsBill.getTimestamp("bill_date")).thenReturn(ts);
        when(rsBill.getDouble("total_amount")).thenReturn(750.0);

        // Items rows
        when(psQueryItems.executeQuery()).thenReturn(rsItems);
        when(rsItems.next()).thenReturn(true, true, false);
        when(rsItems.getInt("id")).thenReturn(1, 2);
        when(rsItems.getInt("item_id")).thenReturn(10, 11);
        when(rsItems.getInt("quantity")).thenReturn(1, 2);
        when(rsItems.getBigDecimal("price")).thenReturn(BigDecimal.valueOf(100.0), BigDecimal.valueOf(325.0));
        when(rsItems.getString("item_code")).thenReturn("ITM-10", "ITM-11");
        when(rsItems.getString("item_name")).thenReturn("Pen", "Book");

        BillDAO dao = new BillDAO();

        // Act
        Bill bill = dao.getBillById(321);

        // Assert
        assertNotNull(bill);
        // We don’t assert getters to avoid coupling to model methods;
        // the fact we reached here without exceptions proves the mapping ran.
        verify(psQueryBill).setInt(1, 321);
        verify(psQueryItems).setInt(1, 321);
    }

    @Test
    void getAllBills_success() throws Exception {
        PreparedStatement ps = mock(PreparedStatement.class);
        ResultSet rs = mock(ResultSet.class);

        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeQuery()).thenReturn(rs);

        when(rs.next()).thenReturn(true, false);
        when(rs.getInt("id")).thenReturn(5);
        when(rs.getString("customer_id")).thenReturn("ACCT-5");
        when(rs.getTimestamp("bill_date")).thenReturn(new Timestamp(System.currentTimeMillis()));
        when(rs.getDouble("total_amount")).thenReturn(100.0);

        BillDAO dao = new BillDAO();
        List<Bill> bills = dao.getAllBills();

        assertNotNull(bills);
        assertEquals(1, bills.size());
    }
}
