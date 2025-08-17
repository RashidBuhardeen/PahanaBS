<%@ page import="java.sql.*, com.project.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="common/header.jsp" %>
<%@ include file="common/navigation.jsp" %>

<%
    int totalUsers = 0;
    int totalItems = 0;
    int totalBills = 0;

    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getInstance().getConnection();
        st = conn.createStatement();

        rs = st.executeQuery("SELECT COUNT(*) FROM customer");
        if (rs.next()) totalUsers = rs.getInt(1);

        rs = st.executeQuery("SELECT COUNT(*) FROM items");
        if (rs.next()) totalItems = rs.getInt(1);

        rs = st.executeQuery("SELECT COUNT(*) FROM bills");
        if (rs.next()) totalBills = rs.getInt(1);

    } catch (Exception e) {
        out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (st != null) try { st.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>

<div class="container">
    <h1 class="dashboard-title">Admin Dashboard</h1>
    <p class="welcome-text">Welcome, <b><%= session.getAttribute("username") %></b>!</p>

    <div class="dashboard-cards">
        <div class="card">
            <h3>Total Users</h3>
            <p class="card-value"><%= totalUsers %></p>
        </div>

        <div class="card">
            <h3>Total Items</h3>
            <p class="card-value"><%= totalItems %></p>
        </div>

        <div class="card">
            <h3>Total Bills</h3>
            <p class="card-value"><%= totalBills %></p>
        </div>
    </div>
</div>


<!-- Dashboard Styles -->
<style>
    .container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 0 20px;
        font-family: Arial, sans-serif;
    }

    .dashboard-title {
        text-align: center;
        color: #333;
        margin-bottom: 10px;
    }

    .welcome-text {
        text-align: center;
        font-size: 1.1em;
        margin-bottom: 30px;
        color: #555;
    }

    .dashboard-cards {
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
        gap: 20px;
    }

    .card {
        background-color: #fff;
        border-radius: 10px;
        padding: 30px 20px;
        width: 250px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        text-align: center;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }

    .card h3 {
        margin-bottom: 15px;
        color: #007BFF;
    }

    .card-value {
        font-size: 2em;
        font-weight: bold;
        color: #333;
    }
</style>
