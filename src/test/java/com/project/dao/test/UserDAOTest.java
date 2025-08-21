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
import com.project.model.User;

public class UserDAOTest {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
    private MockedStatic<DBConnectionFactory> dbMock;

    @BeforeEach
    void setUp() throws Exception {
        conn = mock(Connection.class);
        ps = mock(PreparedStatement.class);
        rs = mock(ResultSet.class);
        dbMock = mockStatic(DBConnectionFactory.class);
        dbMock.when(DBConnectionFactory::getConnection).thenReturn(conn);
    }

    @AfterEach
    void tearDown() {
        if (dbMock != null) dbMock.close();
    }

    @Test
    void getUserByUsername_found() throws Exception {
        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeQuery()).thenReturn(rs);

        when(rs.next()).thenReturn(true);
        when(rs.getInt("user_id")).thenReturn(1);
        when(rs.getString("username")).thenReturn("admin");
        when(rs.getString("password")).thenReturn("secret");
        when(rs.getString("role")).thenReturn("ADMIN");

        UserDAO dao = new UserDAO();
        User u = dao.getUserByUsername("admin");

        assertNotNull(u);
    }

    @Test
    void addUser_success() throws Exception {
        User u = mock(User.class);
        when(u.getUsername()).thenReturn("tester");
        when(u.getPassword()).thenReturn("pwd");
        when(u.getRole()).thenReturn("USER");

        when(conn.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeUpdate()).thenReturn(1);

        UserDAO dao = new UserDAO();
        boolean ok = dao.addUser(u);

        assertTrue(ok);
        verify(ps).executeUpdate();
    }
}
