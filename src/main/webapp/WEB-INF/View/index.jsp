<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/header.jsp" %>
<%@ include file="common/navigation.jsp" %>

<style>
    .container {
        max-width: 1200px;
        margin: 50px auto;
        padding: 0 20px;
    }

    .cards {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }

    .card {
        flex: 1 1 300px; /* grow, shrink, base width */
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        padding: 30px 20px;
        text-align: center;
        transition: transform 0.3s, box-shadow 0.3s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    }

    .card i {
        font-size: 50px;
        margin-bottom: 20px;
    }

    .card h3 {
        margin-bottom: 15px;
        font-size: 1.5rem;
    }

    .card p {
        margin-bottom: 20px;
        color: #555;
    }

    .card a {
        display: inline-block;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        color: #fff;
        background-color: #007bff;
        transition: background-color 0.3s;
    }

    .card a:hover {
        background-color: #0056b3;
    }

    .card.customers a { background-color: #007bff; }
    .card.items a { background-color: #28a745; }
    .card.bills a { background-color: #ffc107; color: #000; }

    .footer {
        text-align: center;
        margin-top: 50px;
        color: #888;
    }
</style>

<div class="container">
    <div class="text-center">
        <h1>Welcome to BahanaBS</h1>
        <p>Efficient Customer and Billing Management System</p>
    </div>

    <div class="cards">
        <!-- Customers Card -->
        <div class="card customers">
            <i class="fas fa-users"></i>
            <h3>Customers</h3>
            <p>Add, edit, and manage all your customers efficiently.</p>
            <a href="CustomerController?action=list">View Customers</a>
        </div>

        <!-- Items Card -->
        <div class="card items">
            <i class="fas fa-boxes"></i>
            <h3>Items</h3>
            <p>Manage your inventory with detailed item information.</p>
            <a href="items?action=list">View Items</a>
        </div>

        <!-- Bills Card -->
        <div class="card bills">
            <i class="fas fa-file-invoice-dollar"></i>
            <h3>Bills</h3>
            <p>Create new bills and track all transactions with ease.</p>
            <a href="view-bills.jsp">View Bills</a>
        </div>
    </div>

    <div class="footer">
        <p>BahanaBS © 2025. All rights reserved.</p>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
