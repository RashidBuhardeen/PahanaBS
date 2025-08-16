<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="dashboard.jsp">Watch Zone</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="CustomerController?action=list">Customers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="items?action=list">Items</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="view-bills.jsp">Bills</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
