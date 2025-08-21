<%@ page import="java.sql.*, com.project.dao.DBConnection" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="common/header.jsp" %>
<%@ include file="common/navigation.jsp" %>

<%
    int totalUsers = 0;
    int totalItems = 0;
    int totalBills = 0;
    int totalBooksInStock = 0;
    BigDecimal totalRevenue = BigDecimal.ZERO;

    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getInstance().getConnection();
        st = conn.createStatement();

        // Total customers (users)
        rs = st.executeQuery("SELECT COUNT(*) FROM customer");
        if (rs.next()) totalUsers = rs.getInt(1);
        rs.close();

        // Total distinct items
        rs = st.executeQuery("SELECT COUNT(*) FROM items");
        if (rs.next()) totalItems = rs.getInt(1);
        rs.close();

        // Total bills
        rs = st.executeQuery("SELECT COUNT(*) FROM bills");
        if (rs.next()) totalBills = rs.getInt(1);
        rs.close();

        // Books in stock (sum of stock_quantity)
        rs = st.executeQuery("SELECT COALESCE(SUM(stock_quantity), 0) FROM items");
        if (rs.next()) totalBooksInStock = rs.getInt(1);
        rs.close();

        // Total revenue (sum of all bill totals)
        rs = st.executeQuery("SELECT COALESCE(SUM(total_amount), 0) FROM bills");
        if (rs.next()) totalRevenue = rs.getBigDecimal(1);
        rs.close();

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
    <p class="welcome-text">Welcome, <b><%= (session.getAttribute("username") != null ? session.getAttribute("username") : "Admin") %></b>!</p>

    <div class="cards">

        <div class="card">
            <h3>Total Revenue</h3>
            <p class="card-value">
                Rs. <%= totalRevenue.setScale(2, java.math.RoundingMode.HALF_UP).toPlainString() %>
            </p>
        </div>
        
                <div class="card">
            <h3>Books in Stock</h3>
            <p class="card-value"><%= totalBooksInStock %></p>
        </div>
        
                <div class="card">
            <h3>Total Users</h3>
            <p class="card-value"><%= totalUsers %></p>
        </div>
        
                <div class="card">
            <h3>Total Bills</h3>
            <p class="card-value"><%= totalBills %></p>
        </div>

        <div class="card">
            <h3>Total Book types</h3>
            <p class="card-value"><%= totalItems %></p>
        </div>
    </div>
</div>

<!-- Dashboard Styles -->
<style>
    :root{
      --accent: #ff9800;
      --bg: #fff;
      --text: #222;
      --card-bg: #222;
      --card-text: #fff;
      --muted: #bdbdbd;
    }

    body{
      margin:0;
      background: var(--bg);
      color: var(--text);
      font-family: Arial, Helvetica, sans-serif;
    }

    .container{
      max-width: 1100px;
      margin: 40px auto;
      padding: 0 20px 40px;
    }

    .dashboard-title{
      text-align: center;
      margin: 0 0 10px;
      letter-spacing: .5px;
    }

    .welcome-text{
      text-align: center;
      margin: 0 0 30px;
      color: var(--muted);
    }

    .cards{
      display: grid;
      gap: 20px;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    }

    .card{
      background: var(--card-bg);
      color: var(--card-text);
      border-radius: 14px;
      padding: 22px 20px;
      box-shadow: 0 8px 26px rgba(0,0,0,.18);
      position: relative;
      overflow: hidden;
      transition: transform .18s ease, box-shadow .18s ease;
      border: 1px solid rgba(255,255,255,.06);
    }

    .card::before{
      content: "";
      position: absolute;
      inset: 0;
      border-top: 6px solid var(--accent);
      border-radius: 14px 14px 0 0;
      pointer-events: none;
    }

    .card:hover{
      transform: translateY(-4px);
      box-shadow: 0 14px 30px rgba(0,0,0,.22);
    }

    .card h3{
      margin: 8px 0 10px;
      font-weight: 700;
      color: var(--accent);
      letter-spacing: .4px;
    }

    .card .card-value{
      font-size: 2.2rem;
      font-weight: 800;
      line-height: 1.1;
      word-break: break-word;
      color: var(--card-text);
    }

    /* Optional divider line under the header area */
    .divider{
      height: 2px;
      background: linear-gradient(90deg, var(--accent), rgba(255,152,0,0));
      margin: 24px 0 26px;
      border-radius: 2px;
    }
  </style>