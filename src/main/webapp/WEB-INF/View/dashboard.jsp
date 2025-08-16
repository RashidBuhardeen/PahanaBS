<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="common/header.jsp" %>
<%@ include file="common/navigation.jsp" %>

<div class="container">
    <h1 class="dashboard-title">Admin Dashboard</h1>
    <p class="welcome-text">Welcome, <b>${sessionScope.username}</b>!</p>

    <div class="dashboard-cards">
        <div class="card">
            <h3>Total Users</h3>
            <p class="card-value">${totalUsers}</p>
        </div>

        <div class="card">
            <h3>Total Items</h3>
            <p class="card-value">${totalItems}</p>
        </div>

        <div class="card">
            <h3>Total Bills</h3>
            <p class="card-value">${totalBills}</p>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>

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
