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
import com.project.model.Item;

public class ItemDAOTest {

    private Connection conn;
    private PreparedStatement ps;
    private Statement st;
    private ResultSet rs;
    private MockedStatic<DBConnectionFactory> dbMock;

    @BeforeEach
    void setUp() throws Exception {
        conn = mock(Connection.class);
        ps = mock(PreparedStatement.class);
        st = mock(Statement.class);
        rs = mock(ResultSet.class);
        dbMock = mockStatic(DBConnectionFactory.class);
        dbMock.when(DBConnectionFactory::getConnection).thenReturn(conn);
    }

    @AfterEach
    void tearDown() {
        if (dbMock != null) dbMock.close();
    }

    @Test
    void addItem_success() throws Exception {
        Item item = mock(Item.class);
        when(item.getItemCode()).thenReturn("B001");
        when(item.getItemName()).thenReturn("Book");
        when(item.getPrice()).thenReturn(250.0);
        when(item.getStockQuantity()).thenReturn(10);

        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        ItemDAO dao = new ItemDAO();
        dao.addItem(item);

        verify(ps).executeUpdate();
    }

    @Test
    void updateItem_success() throws Exception {
        Item item = mock(Item.class);
        when(item.getItemCode()).thenReturn("B001");
        when(item.getItemName()).thenReturn("Book");
        when(item.getPrice()).thenReturn(300.0);
        when(item.getStockQuantity()).thenReturn(7);
        when(item.getId()).thenReturn(42);

        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        ItemDAO dao = new ItemDAO();
        dao.updateItem(item);

        verify(ps).executeUpdate();
    }

    @Test
    void deleteItem_success() throws Exception {
        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        ItemDAO dao = new ItemDAO();
        dao.deleteItem(99);

        verify(ps).setInt(1, 99);
        verify(ps).executeUpdate();
    }

    @Test
    void getItemById_found() throws Exception {
        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeQuery()).thenReturn(rs);
        when(rs.next()).thenReturn(true);
        when(rs.getInt("id")).thenReturn(5);
        when(rs.getString("item_code")).thenReturn("B005");
        when(rs.getString("item_name")).thenReturn("Pen");
        when(rs.getDouble("price")).thenReturn(50.0);
        when(rs.getInt("stock_quantity")).thenReturn(100);

        ItemDAO dao = new ItemDAO();
        Item item = dao.getItemById(5);

        assertNotNull(item);
    }

    @Test
    void getAllItems_success() throws Exception {
        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeQuery()).thenReturn(rs);
        when(rs.next()).thenReturn(true, false);
        when(rs.getInt("id")).thenReturn(1);
        when(rs.getString("item_code")).thenReturn("B001");
        when(rs.getString("item_name")).thenReturn("Book");
        when(rs.getDouble("price")).thenReturn(250.0);
        when(rs.getInt("stock_quantity")).thenReturn(10);

        ItemDAO dao = new ItemDAO();
        List<Item> list = dao.getAllItems();

        assertNotNull(list);
        assertEquals(1, list.size());
    }
}
