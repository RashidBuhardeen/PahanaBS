 <%@ page import="java.sql.*, com.project.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<style>
/* Body and container */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding-top: 60px;
    color: #222;
    min-height: 100vh; /* full viewport height */
}

.container {
    max-width: 1200px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Heading */
.container h2 {
    color: #222;
    margin-bottom: 20px;
}

/* Buttons */
.btn {
    background-color: #ff9800;
    color: #fff;
    text-decoration: none;
    padding: 8px 16px;
    margin-right: 5px;
    border-radius: 6px;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #e68900;
}

.btn-danger {
    background-color: #d32f2f;
}

.btn-danger:hover {
    background-color: #b71c1c;
}

/* Table styling with borders and rounded corners */
.table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin-top: 10px;
    border: 1px solid #ddd;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.table th, .table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    border-right: 1px solid #ddd;
}

.table th:last-child,
.table td:last-child {
    border-right: none;
}

.table th {
    background-color: #222;
    color: #fff;
}

/* Table row hover */
.table tbody tr:hover {
    background-color: #ffecb3;
}

/* Rounded corners for table */
.table th:first-child {
    border-top-left-radius: 12px;
}

.table th:last-child {
    border-top-right-radius: 12px;
}

.table tbody tr:last-child td:first-child {
    border-bottom-left-radius: 12px;
}

.table tbody tr:last-child td:last-child {
    border-bottom-right-radius: 12px;
}

/* Responsive table */
@media (max-width: 768px) {
    .table thead {
        display: none;
    }
    .table, .table tbody, .table tr, .table td {
        display: block;
        width: 100%;
    }
    .table tr {
        margin-bottom: 15px;
        border-bottom: 2px solid #ff9800;
    }
    .table td {
        text-align: right;
        padding-left: 50%;
        position: relative;
        border-bottom: 1px solid #ddd;
    }
    .table td::before {
        content: attr(data-label);
        position: absolute;
        left: 15px;
        width: calc(50% - 15px);
        text-align: left;
        font-weight: bold;
        color: #222;
    }
}
</style>

<div class="container">
    <h2>Customer List</h2>

    <a href="CustomerController?action=addCustomer" class="btn">Add New Customer</a>
    <br /><br />

    <table class="table">
        <thead>
            <tr>
                <th>Account No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Telephone</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getInstance().getConnection();
                    st = conn.createStatement();
                    rs = st.executeQuery("SELECT account_no, name, address, telephone_number, email FROM customer");

                    while (rs.next()) {
                        String accountNo = rs.getString("account_no");
                        String name = rs.getString("name");
                        String address = rs.getString("address");
                        String tel = rs.getString("telephone_number");
                        String email = rs.getString("email");
            %>
                        <tr>
							<td data-label="Account No"><%= accountNo %></td>
							<td data-label="Name"><%= name %></td>
							<td data-label="Address"><%= address %></td>
							<td data-label="Telephone"><%= tel %></td>
							<td data-label="Email"><%= email %></td>
							<td data-label="Actions">
							    <a href="CustomerController?action=editCustomer&id=<%= accountNo %>" class="btn">Edit</a>
							    <a href="CustomerController?action=deleteCustomer&id=<%= accountNo %>" class="btn btn-danger"
							       onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
							</td>

                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                    if (st != null) try { st.close(); } catch (Exception ignore) {}
                    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
                }
            %>
        </tbody>
    </table>
</div>

