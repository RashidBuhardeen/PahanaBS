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
import com.project.model.Customer;

public class CustomerDAOTest {

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
    void addCustomer_success() throws Exception {
        Customer c = mock(Customer.class);
        when(c.getAccount_number()).thenReturn("C001");
        when(c.getName()).thenReturn("Alice");
        when(c.getAddress()).thenReturn("Colombo");
        when(c.getTelephone_number()).thenReturn("0771234567");
        when(c.getEmail()).thenReturn("a@x.com");

        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        CustomerDAO dao = new CustomerDAO();
        dao.addCustomer(c);

        verify(ps, times(1)).executeUpdate();
    }

    @Test
    void viewCustomer_success() throws Exception {
        when(conn.createStatement()).thenReturn(st);
        when(st.executeQuery(anyString())).thenReturn(rs);

        when(rs.next()).thenReturn(true, false);
        when(rs.getString("account_no")).thenReturn("C001");
        when(rs.getString("name")).thenReturn("Alice");
        when(rs.getString("address")).thenReturn("Colombo");
        when(rs.getString("telephone_number")).thenReturn("0771234567");
        when(rs.getString("email")).thenReturn("a@x.com");

        CustomerDAO dao = new CustomerDAO();
        List<Customer> out = dao.viewCustomer();

        assertNotNull(out);
        assertEquals(1, out.size());
    }

    @Test
    void updateCustomer_success() throws Exception {
        Customer c = mock(Customer.class);
        when(c.getName()).thenReturn("Bob");
        when(c.getAddress()).thenReturn("Kandy");
        when(c.getTelephone_number()).thenReturn("0711111111");
        when(c.getEmail()).thenReturn("b@x.com");
        when(c.getAccount_number()).thenReturn("C009");

        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        CustomerDAO dao = new CustomerDAO();
        dao.updateCustomer(c);

        verify(ps).executeUpdate();
    }

    @Test
    void deleteCustomer_success() throws Exception {
        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        CustomerDAO dao = new CustomerDAO();
        dao.deleteCustomer("C001");

        verify(ps).setString(1, "C001");
        verify(ps).executeUpdate();
    }
}
